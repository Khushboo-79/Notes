import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_database/theme_provider.dart';
import 'package:provider/provider.dart';

class settingPage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Setting"),
      ),
      body: Consumer<themeProvider>(
          builder: (ctx, provider, __){
            return SwitchListTile.adaptive(
              title: Text('Dark Mode'),
              subtitle: Text('Change theme mode here'),
              onChanged: (value){
                provider.updateTheme(value: value);
              },
              value: provider.getThemeValue(),
            );
          })
    );
  }
}