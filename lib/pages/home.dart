// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:notes/model/product_model.dart';
import 'package:notes/pages/intropage2.dart';
import 'package:notes/pages/update.dart';
import 'dart:math';

import 'package:notes/services/api.dart';

class Home extends StatefulWidget {
  
  Home({super.key,});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  
  TextEditingController _searchController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _dataController = TextEditingController();
  

  Future<List<Note>>? _notesFuture;

  @override
  void initState() {
    super.initState();
     API.get_product();
  }

  void _refreshNotes() {
    setState(() {
       API.get_product();
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Row(
            children: [
              Column(
                children: [
                  Container(
            margin: EdgeInsets.fromLTRB(15, 50, 0,0),
            child: Text("Good Morning,", style: TextStyle(
              color: Colors.white,
              fontSize: 31,
              fontFamily: 'MuktaB',
              fontWeight: FontWeight.bold
            ),),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 95,0),
            child: Text("Nikhil !", style: TextStyle(
              color: Colors.orange[400],
              fontSize: 31,
              fontFamily: 'MuktaB',
              fontWeight: FontWeight.bold
            ),),
          ),
                ],
              ),
              SizedBox(width: 95,),
         Container(
          width: 65,
          height: 65,
          margin: EdgeInsets.fromLTRB(0, 45, 0,0),
          child:   CircleAvatar(
        child: user != null && user!.photoURL != null ? Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white!,
                width: 3,
              ),
              borderRadius: BorderRadius.circular(30.0),
              image: DecorationImage(
                image: NetworkImage(user!.photoURL!),
              ),
            ),
          ): Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white!,
                width: 3,
              ),
              borderRadius: BorderRadius.circular(30.0),
              image: DecorationImage(
                image: AssetImage('assets/boy.png'),
              ),
            ),
          ),
      ),
        )
            ],
          ),
          SizedBox(height: 25,),
          Container(
            margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child:  TextField(
              style: TextStyle(color: Colors.white),
              controller: _searchController,
          decoration: InputDecoration(
            
            focusColor: Colors.white,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0)
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: Colors.orange[400]!,
                width: 2.0
              )
            ),
            filled: true,
            fillColor: Colors.grey[850],
            labelText:"Search",
            labelStyle: TextStyle(
              fontSize: 18,
              color: Colors.white
            ),
            prefixIcon: Icon(Icons.search, color: Colors.white,),
            floatingLabelBehavior: FloatingLabelBehavior.never,
          ),
          ),
          ),
          SizedBox(height: 20,),
          Container(
            margin: EdgeInsets.fromLTRB(10, 0, 255, 0),
            child: Text("All Notes", style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontFamily: 'MuktaM'
            ),),
          ),
          SizedBox(height: 5,),
          Container(
             margin: EdgeInsets.fromLTRB(10, 0, 255, 0),
            width: 117,
            height: 3,
            color: Colors.yellow,
          ),



           FutureBuilder(
                future: API.get_product(),
                 builder: (context, snapshot){

                  if(!snapshot.hasData)
                 {
                        return Center(
                          // child: Text("No Data Present", style: TextStyle(
                          //   color: Colors.white,
                          //   fontSize: 24
                          // ),),
                        );
                 }
                else
                {
                   List<Note> data = snapshot.data! as List<Note>;
                 
                   
                   return Expanded(
                    
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 1,
                mainAxisSpacing: 2,
              ),
              itemCount: data.length,
              
              itemBuilder: (context, index) {
                 
                List<Color> cardColors = [Colors.yellow[400]!, Colors.grey[100]!];


                Color randomColor = cardColors[Random().nextInt(cardColors.length)];

                
                return Container(
                 
        width: 100,
        height: 100,
        child: Card(
          color: randomColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(9.0),
          ),
          child: Stack(
            children: [
              //for displaying data
             Column(
              children: [
                SizedBox(height: 15,),
                Padding(
                  padding: EdgeInsets.fromLTRB(14, 4, 14, 0),
                  child: Center(
                    child: Text(data[index].data, style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Radio',
                      fontWeight: FontWeight.w200
                    ),),
                  ),
                )
                ,
                SizedBox(height: 10,),
                 Padding(
                   padding: EdgeInsets.fromLTRB(10, 2, 20, 0),
                   child: Center(
                   
                    child: Text(data[index].date, style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'Radio',
                      fontWeight: FontWeight.w500
                    ),),
                                   ),
                 )
                   
              ],
             )
              ,
              Positioned(
                top: 150,
                right: 8,
                bottom: 0,
                child: IconButton(
                  icon: Icon(Icons.delete, color: Colors.black, size: 20,),
                  onPressed: () async {
  await API.delete(data[index].id);
  _refreshNotes();
},
                ),
              ),
              Positioned(
                top: 150,
                left: 8,
                bottom: 0,
                child: IconButton(
                  icon: Icon(Icons.edit, color: Colors.black, size: 20,),
                  onPressed: () async{
                   await  showDialog(context: context,
                     builder: (context){
                     return Update(Data: data[index],);
                     });
                     _refreshNotes();

                  },
                ),
              ),
            ],
          ),
        ),
      );
              },
            ),
          );
                        //  return ListView.builder(
                        //   itemCount: data.length,
                        //   itemBuilder:(context,index){
                        //   return Container(
                           
                        //   );
                        //   }
                        //   );
                }
                 
                 })

        ],
      ),
      bottomNavigationBar:BottomAppBar(
        color: Colors.black,
        height: 80,
        child: 
           Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.grey[850],
              child:  IconButton(
              // Set the icon size here
              color:  Colors.white ,
              icon: Icon(Icons.add, size:40,),
              onPressed: () {
               showDialog(
                context: context, builder: (context){
                return Dialog(
                  
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                    
                  ),
                  
                  backgroundColor: Colors.grey[900],
                  child: Container(
                     margin: EdgeInsets.fromLTRB(10, 80, 10, 0),
                    width: 800,
                    height: 500,
                    child: Column(
                    children: [
                      SizedBox(height: 5,),
                       Text(
                                "Add Mini Note",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 36,
                                  fontFamily: 'Radio',
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 10,),
                              Container(
             margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
            width: 240,
            height: 3,
            color: Colors.yellow,
          ),
          SizedBox(height: 20,),
                   Container(
                  child:  TextField(
                maxLength: 200,
                    style: TextStyle(color: Colors.white),
              controller: _dataController,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0)
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: Colors.orange[400]!,
                width: 2.0
              )
            ),
            filled: true,
            fillColor: Colors.grey[850],
            labelText:"Text",
            
            labelStyle: TextStyle(
              fontSize: 18,
              color: Colors.white
            ),
            prefixIcon: Icon(Icons.wrap_text, color: Colors.white,),
            floatingLabelBehavior: FloatingLabelBehavior.never,
          ),
          ),
                   ),
     SizedBox(height: 20,),
     Container(
                  child:  TextField(
                    style: TextStyle(color: Colors.white),
                    readOnly: true,
                    onTap: (){
                      _Date();
                    },
              controller: _dateController,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0)
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: Colors.orange[400]!,
                width: 2.0
              )
            ),
            filled: true,
            fillColor: Colors.grey[850],
            labelText:"Select Date",
            
            labelStyle: TextStyle(
              fontSize: 18,
              color: Colors.white
            ),
            prefixIcon: Icon(Icons.date_range, color: Colors.white,),
            floatingLabelBehavior: FloatingLabelBehavior.never,
          ),
          ),
                   ),
                   SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
          ElevatedButton(onPressed: ()
              async{
               Map data ={
                "data" : _dataController.text,
                "date" :  _dateController.text,
               };

               await API.add_product(data);
               _refreshNotes();

                Navigator.of(context).pop();
                _dataController.text = "";
                _dateController.text ="";
              }, child:  Text('Done', style: TextStyle(
                  color: Colors.yellow[400]
                ),),
                style:  ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Colors.black),

                ),
                ),
                ElevatedButton(onPressed: ()
              {
              
                Navigator.of(context).pop();
                _dataController.text = "";
                _dateController.text ="";



              }, child:  Text('Cancel', style: TextStyle(
                  color: Colors.yellow[400]
                ),),
                style:  ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Colors.black),

                ),
                ),
              ],
            ),
          
                    ],
                  ),
                  )

                 );
                });
              },
            ),
            ),
             CircleAvatar(
              radius: 40,
              backgroundColor: Colors.grey[850],
              child:  IconButton(
              // Set the icon size here
              color:  Colors.white ,
              icon: Icon(Icons.arrow_back_ios_new, size:38,),
              onPressed: () {
                Navigator.pop(context, MaterialPageRoute(builder: (context){
                  return Intropage2();
                }));
              },
            ),
            ),
           
            
          ],
        ),
        )
      );

  }
  //DatePicker
  Future<void> _Date() async{
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
       firstDate: DateTime(2000), 
       lastDate: DateTime(2100)
       );

       if(picked!=null)
       {
        setState(() {
          _dateController.text = picked.toString().split(" ")[0];
        });
       }
       else{
         setState(() {
          _dateController.text = "No Date Selected";
        });
       }
  }
}









 // body: Center(
      //   child: CircleAvatar(
      //   child: Container(
      //       height: 100,
      //       width: 100,
      //       decoration: BoxDecoration(
      //         border: Border.all(
      //           color: Colors.yellow[400]!,
      //           width: 3,
      //         ),
      //         image: DecorationImage(
      //           image: NetworkImage(user!.photoURL!),
      //         ),
      //       ),
      //     ),
      // ),
      // )