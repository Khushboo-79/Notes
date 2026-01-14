import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_database/add_note_page.dart';
import 'package:flutter_database/data/db_helper.dart';
import 'package:flutter_database/db_provider.dart';
import 'package:flutter_database/setting_page.dart';
import 'package:provider/provider.dart';

class homePage extends StatefulWidget {
  @override
  State<homePage> createState() => homePageState();
}

class homePageState extends State<homePage> {
  //List<Map<String, dynamic>> alNotes = [];
  //dbHelper? dbRef;

  @override
  void initState() {
    super.initState();

    context.read<dbProvider>().getInitialNotes();
    /*dbRef = dbHelper.getInstance;

    getNotes(); */
  }

 /* void getNotes() async {
    alNotes = await dbRef!.getAllNotes();
    setState(() {});
  } */

  //controllers
  // TextEditingController titleController = TextEditingController();
  // TextEditingController descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notes"),
        actions: [
          PopupMenuButton(
              itemBuilder: (_){
                return [
                  PopupMenuItem(child: Row(
                    children: [
                      Icon(Icons.settings),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Setting")
                    ],
                  ),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => settingPage()));
                    },
                  )
                ];
              })
        ],
      ),
      // all notes viewed here
      body: Consumer<dbProvider>(
          builder: (ctx, provider, __){

            List<Map<String, dynamic>> alNotes = provider.getNotes();
            return alNotes.isNotEmpty
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

                              Navigator.push(context, MaterialPageRoute(builder: (context) => addNotePage(
                                isUpdate: true,
                                title: alNotes[index][dbHelper.COLUMN_NOTE_TITLE],
                                desc: alNotes[index][dbHelper.COLUMN_NOTE_DESC],
                                sno: alNotes[index][dbHelper.COLUMN_NOTE_SNO],
                              )));

                              /* showModalBottomSheet(context: context, builder: (context){

                              titleController.text = alNotes[index][dbHelper.COLUMN_NOTE_TITLE];
                              descController.text = alNotes[index][dbHelper.COLUMN_NOTE_DESC];
                              return getBottomSheetWidget(isUpdate: true, sno: alNotes[index][dbHelper.COLUMN_NOTE_SNO]);
                            }); */
                            },
                            child: Icon(Icons.edit)),
                        InkWell(
                            onTap: () async{

                              provider.deleteNote(alNotes[index][dbHelper.COLUMN_NOTE_SNO]);

                              /* bool check = await dbRef!.deleteNote(sno: alNotes[index][dbHelper.COLUMN_NOTE_SNO]);

                              if(check){
                                getNotes();
                              } */
                            },
                            child: Icon(Icons.delete, color: Colors.red,))
                      ],
                    ),
                  ),
                );
              },
            )
                : Center(child: Text("No notes yet"));
          }),



      /*  alNotes.isNotEmpty
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
                            
                            Navigator.push(context, MaterialPageRoute(builder: (context) => addNotePage(
                              isUpdate: true,
                              title: alNotes[index][dbHelper.COLUMN_NOTE_TITLE],
                              desc: alNotes[index][dbHelper.COLUMN_NOTE_DESC],
                              sno: alNotes[index][dbHelper.COLUMN_NOTE_SNO],
                            )));
                            
                            /* showModalBottomSheet(context: context, builder: (context){

                              titleController.text = alNotes[index][dbHelper.COLUMN_NOTE_TITLE];
                              descController.text = alNotes[index][dbHelper.COLUMN_NOTE_DESC];
                              return getBottomSheetWidget(isUpdate: true, sno: alNotes[index][dbHelper.COLUMN_NOTE_SNO]);
                            }); */
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
          : Center(child: Text("No notes yet")), */
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          String errorMsg = "";
          
          Navigator.push(context, MaterialPageRoute(builder: (context) => addNotePage()));

          // notes added from here

          // shows static data
          /*bool check = await dbRef!.addNote(mTitle: "My note", mDesc: "Do what you love.");
            if (check){
              getNotes();
            }*/

          // show user input data
         /* showModalBottomSheet(
            context: context,
            builder: (context) {
              titleController.clear();
              descController.clear();
              return getBottomSheetWidget();
            },
          ); */
        },
        child: Icon(Icons.add),
      ),
    );
    throw UnimplementedError();
  }


 /* Widget getBottomSheetWidget({bool isUpdate = false, int sno = 0}){
    return 
  } */

}
