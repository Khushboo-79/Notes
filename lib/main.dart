import 'package:flutter/material.dart';
import 'package:flutter_database/data/db_helper.dart';
import 'package:flutter_database/db_provider.dart';
import 'package:flutter_database/home_page.dart';
import 'package:flutter_database/theme_provider.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => dbProvider(dBHelper: dbHelper.getInstance)),
        ChangeNotifierProvider(create: (context) => themeProvider())
      ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    dbHelper db = dbHelper.getInstance;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "notes",
      themeMode: context.watch<themeProvider>().getThemeValue()
          ? ThemeMode.dark : ThemeMode.light,
      darkTheme: ThemeData.dark(),
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Notes'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      //   title: Text(widget.title),
      // ),
      body: homePage()
    );
  }
}
