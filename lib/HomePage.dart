

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
          backgroundColor: Colors.amber.shade100,
          title: Center(child: Text("Notes"))


        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.amber.shade200,
          child: ListView.builder(
            itemCount: 25,
              itemBuilder: (_,index){
            return Card(
              margin: EdgeInsets.all(7),
              child: ListTile(
                title: Text("title"),
                subtitle: Text("description"),
              ),
            );
          })
        ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        showModalBottomSheet(context: context, builder: (_){
          return Container(
            color: Colors.amber.shade50,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text("Add Notes",style: TextStyle(fontSize: 21),),
                  SizedBox(height: 20,),
                  TextField(
                    decoration: InputDecoration(label: Text("title",style:
                    TextStyle(fontSize: 21))
                        ,hint: Text("Enter Title", style: TextStyle(fontSize:
                      17,),),
                      filled: true,
                      fillColor: Colors.white,
                      border:
                      OutlineInputBorder(borderRadius: BorderRadius.circular(21),),
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(21),
                          borderSide: BorderSide(color: Colors.amber.shade800)),
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(21),
                          borderSide: BorderSide(width: 2, color: Colors.amber
                              .shade800),)

                    ),

                  ),
                  SizedBox(height: 20,),
                  TextField(
                    maxLines: 4,
                    decoration: InputDecoration(label: Text("description",style:
                    TextStyle(fontSize: 21),)
                      ,hint: Text("Enter Description", style: TextStyle
                        (fontSize:
                      17),),
                      filled: true,
                      fillColor: Colors.white,
                      border:
                      OutlineInputBorder(borderRadius: BorderRadius.circular(21),),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(21),
                            borderSide: BorderSide(color: Colors.amber.shade800)),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(21),
                          borderSide: BorderSide(width: 2, color: Colors.amber
                              .shade800),),
                    ),


                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(onPressed: (){}, child: Icon(Icons.save,
                        color: Colors.lightGreen.shade900,size: 31,)),
                      SizedBox(width: 20),
                      ElevatedButton(onPressed: (){
                        Navigator.pop(context);
                      }, child: Icon(Icons.close,color: Colors.red.shade900,
                        size: 31,))
                    ],
                  )
                ],
              ),
            ),
          );
        });
        },
        child: Icon(Icons.add),
      ),

    );
  }
}
