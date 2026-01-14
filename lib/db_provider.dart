import 'package:flutter/cupertino.dart';
import 'package:flutter_database/data/db_helper.dart';

import 'data/db_helper.dart';

class dbProvider extends ChangeNotifier{

  dbHelper dBHelper;
  dbProvider({required this.dBHelper});

  List<Map<String, dynamic>> _mData = [];

  //events
  void addNote(String title, String desc) async{
    bool check = await dBHelper.addNote(mTitle: title, mDesc: desc);
    if(check){
      _mData = await dBHelper.getAllNotes();
      notifyListeners();
    }
  }

  void updateNote(String title, String desc, int sno) async{
    bool check = await dBHelper.updateNote(mTitle: title, mDesc: desc, sno: sno);
    if(check){
      _mData = await dBHelper.getAllNotes();
      notifyListeners();
    }
  }

  void deleteNote(int sno) async{
    bool check = await dBHelper.deleteNote(sno: sno);
    if(check){
      _mData = await dBHelper.getAllNotes();
      notifyListeners();
    }
  }

  List<Map<String, dynamic>> getNotes() => _mData;

  void getInitialNotes() async{
    _mData = await dBHelper.getAllNotes();
    notifyListeners();
  }

}