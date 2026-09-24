

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note_editor_flutter/db_Helper.dart';

class MyHomePage extends StatefulWidget {


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DbHelper? dbHelper;
  List<Map<String, dynamic>> notes=[];
  var titleController = TextEditingController();
  var descController = TextEditingController();
  @override
  void initState() {
    super.initState();
    dbHelper = DbHelper.getInstance();
    getAllNotes();
  }
  Future<void>getAllNotes() async {
    notes = await dbHelper!.getAllNotes();
    setState((){});
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber.shade100,
          title: Center(child: Text("Notes",style: TextStyle(fontSize: 31,
            fontWeight: FontWeight(600),)))


        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.amber.shade200,
          child: ListView.builder(
            itemCount: notes.length,
              itemBuilder: (_,index){
            return Card(
              margin: EdgeInsets.all(7),
              color: index.isEven ? Colors.amber.shade50 : Colors.amber
                  .shade100,
              child: ListTile(
                leading: Icon(Icons.note_alt_outlined,size: 31,),
                title: Text(notes[index][DbHelper.columnTitle]),
                subtitle: Text(notes[index][DbHelper.columnDesc]),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(onPressed: (){
                      titleController.text = notes[index][DbHelper.columnTitle];
                      descController.text = notes[index][DbHelper.columnDesc];
                      showModalBottomSheet(context: context, builder: (_){

                        return getBottomSheet(isUpdate: true, id: notes[index][DbHelper.columnId]);
                      });
                    }, child: Icon(Icons.edit,
                      color: Colors.amber.shade900,),),
                    SizedBox(width: 10,),
                    ElevatedButton(onPressed: () async {
                      showModalBottomSheet(context: context, builder:
                          (_){
                        return Container(
                          color: Colors.amber.shade200,
                          width: double.infinity,
                          height: 200,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text("Are you sure you want to Delete Note",
                                    style: TextStyle(fontSize: 31,fontWeight:
                                    FontWeight(400))),
                                SizedBox(height: 20,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    ElevatedButton(onPressed: (){
                                      Navigator.pop(context);
                                    }, child: Text("No",style: TextStyle
                                      (fontSize: 21,fontWeight: FontWeight
                                      (600),color: Colors.green.shade700)),),
                                    SizedBox(width: 20,),
                                    ElevatedButton(onPressed: () async{
                                      bool isDeleted = await dbHelper!.deleteNote(id: notes[index][DbHelper.columnId]);
                                      Navigator.pop(context);
                                      getAllNotes();
                                      }, child: Text("Yes",style: TextStyle
                                      (fontSize: 21,fontWeight: FontWeight
                                      (600),color: Colors.red.shade800)))
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      });
                    }, child: Icon(Icons.delete,
                      color: Colors.amber.shade900,),),
                  ],

                ),
              ),
            );
          })
        ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        titleController.clear();
        descController.clear();
        showModalBottomSheet(context: context, builder: (_){

          return getBottomSheet();
        });
        },
        child: Icon(Icons.add,size: 51,),
        backgroundColor: Colors.amber.shade900,
        foregroundColor: Colors.amber.shade100,
      ),

    );
  }
  Widget getBottomSheet({bool isUpdate=false, int? id}){
    return Container(
      color: Colors.amber.shade200,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text("${isUpdate ? "Update" : "Add"} Note",style: TextStyle
              (fontSize: 31,fontWeight:
            FontWeight(1000)),),
            SizedBox(height: 20,),
            TextField(
              controller: titleController,
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
              controller: descController,
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
                ElevatedButton(onPressed: () async {
                  bool? isChanged ;
                  if(isUpdate){
                    isChanged = await dbHelper!.updateNote(id: id!,
                        title: titleController.text, desc: descController.text);
                  }
                  else{
                    isChanged = await dbHelper!.addNote(title:
                    titleController
                        .text, desc: descController.text);
                  }

                  if(isChanged){
                    titleController.clear();
                    descController.clear();
                    Navigator.pop(context);
                    getAllNotes();
                  }

                }, child: Icon(Icons.save,
                  color: Colors.lightGreen.shade900,size: 31,)),
                SizedBox(width: 20),
                ElevatedButton(onPressed: (){
                  Navigator.pop(context);
                }, child: Icon(Icons.close,color: Colors.orange.shade900,
                  size: 31,))
              ],
            )
          ],
        ),
      ),
    );
  }
}
