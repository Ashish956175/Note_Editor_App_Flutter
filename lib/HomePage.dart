import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note_editor_flutter/db_Helper.dart';

class MyHomePage extends StatefulWidget {


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  DbHelper dbHelper = DbHelper.getInstance();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(

        ),
        body: Center(
            child: Container(
              child: Text("Hello",style: TextStyle(fontSize: 91),),
              color: Colors.amber,
            )
        )

    );
  }
}
