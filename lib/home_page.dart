import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_database/data/db_helper.dart';

class homePage extends StatefulWidget {
  @override
  State<homePage> createState() => homePageState();
}

class homePageState extends State<homePage> {
  List<Map<String, dynamic>> alNotes = [];
  dbHelper? dbRef;

  @override
  void initState() {
    super.initState();
    dbRef = dbHelper.getInstance;

    getNotes();
  }

  void getNotes() async {
    alNotes = await dbRef!.getAllNotes();
    setState(() {});
  }

  //controllers
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // all notes viewed here
      body: alNotes.isNotEmpty
          ? ListView.builder(
              itemCount: alNotes.length,
              itemBuilder: (_, index) {
                return ListTile(
                  title: Text(alNotes[index][dbHelper.COLUMN_NOTE_TITLE]),
                  subtitle: Text(alNotes[index][dbHelper.COLUMN_NOTE_DESC]),
                  leading: Text('${index+1}'),
                  trailing: SizedBox(
                    width: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () async{
                            showModalBottomSheet(context: context, builder: (context){

                              titleController.text = alNotes[index][dbHelper.COLUMN_NOTE_TITLE];
                              descController.text = alNotes[index][dbHelper.COLUMN_NOTE_DESC];
                              return getBottomSheetWidget(isUpdate: true, sno: alNotes[index][dbHelper.COLUMN_NOTE_SNO]);
                            });
                          },
                            child: Icon(Icons.edit)),
                        InkWell(
                          onTap: () async{
                            bool check = await dbRef!.deleteNote(sno: alNotes[index][dbHelper.COLUMN_NOTE_SNO]);

                            if(check){
                              getNotes();
                            }
                          },
                            child: Icon(Icons.delete, color: Colors.red,))
                      ],
                    ),
                  ),
                );
              },
            )
          : Center(child: Text("No notes yet")),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          String errorMsg = "";

          // notes added from here

          // shows static data
          /*bool check = await dbRef!.addNote(mTitle: "My note", mDesc: "Do what you love.");
            if (check){
              getNotes();
            }*/

          // show user input data
          showModalBottomSheet(
            context: context,
            builder: (context) {
              titleController.clear();
              descController.clear();
              return getBottomSheetWidget();
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
    throw UnimplementedError();
  }


  Widget getBottomSheetWidget({bool isUpdate = false, int sno = 0}){
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Text( isUpdate ? "Update Note" :
            "Add Note",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          TextField(
            controller: titleController,
            decoration: InputDecoration(
              label: Text("*Title"),
              hint: Text("Enter title"),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(11),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(11),
              ),
            ),
          ),
          SizedBox(height: 20),
          TextField(
            controller: descController,
            maxLines: 4,
            decoration: InputDecoration(
              label: Text("*Description"),
              hint: Text("Enter description"),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(11),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(11),
              ),
            ),
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(width: 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(11),
                    ),
                  ),
                  onPressed: () async {
                    var title = titleController.text;
                    var desc = descController.text;

                    if (title.isNotEmpty && desc.isNotEmpty) {
                      bool check = isUpdate
                          ? await dbRef!.updateNote(mTitle: title, mDesc: desc, sno: sno)
                          : await dbRef!.addNote(
                        mTitle: title,
                        mDesc: desc,
                      );

                      if (check) {
                        getNotes();
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "Please fill all the fields!!",
                          ),
                        ),
                      );
                      //errorMsg = "*please fill all the fields";
                      // setState(() {
                      //
                      // });
                    }

                    titleController.clear();
                    descController.clear();

                    Navigator.pop(context);
                  },
                  child: Text(isUpdate ? "Update note" : "Add note"),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(width: 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(11),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancel"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

}
