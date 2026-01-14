import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_database/data/db_helper.dart';
import 'package:flutter_database/db_provider.dart';
import 'package:flutter_database/theme_provider.dart';
import 'package:provider/provider.dart';

class addNotePage extends StatelessWidget{

  String title;
  String desc;
  int sno;

  bool isUpdate;

  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  //dbHelper? dbRef = dbHelper.getInstance;

  addNotePage({this.isUpdate = false, this.title = "", this.sno = 0, this.desc = ""});

  @override
  Widget build(BuildContext context) {

    if(isUpdate){
      titleController.text = title;
      descController.text = desc;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(isUpdate ? "Update note" : "Add note"),
        actions: [
          Consumer<themeProvider>(
              builder: (_, provider, __){
                return Switch.adaptive(
                    value: provider.getThemeValue(),
                    onChanged: (newValue){
                      provider.updateTheme(value: newValue);
                    });
              })
        ],
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
           /* Text( isUpdate ? "Update Note" :
            "Add Note",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ), */
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

                        if(isUpdate){
                          context.read<dbProvider>().updateNote(title, desc, sno);
                        }
                        else{
                          context.read<dbProvider>().addNote(title, desc);
                        }

                        Navigator.pop(context);

                        /* bool check = isUpdate
                            ? await dbRef!.updateNote(mTitle: title, mDesc: desc, sno: sno)
                            : await dbRef!.addNote(
                          mTitle: title,
                          mDesc: desc,
                        );

                        if (check) {
                          Navigator.pop(context);
                          //getNotes();
                        }  */
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
      )
    );
  }
  
}