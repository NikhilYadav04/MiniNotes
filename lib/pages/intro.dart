import 'package:flutter/material.dart';
import 'package:notes/pages/home.dart';
import 'package:notes/pages/intropage1.dart';
import 'package:notes/pages/intropage2.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Intro extends StatefulWidget {
   const Intro({super.key});

  @override
  State<Intro> createState() => _IntroState();
}

class _IntroState extends State<Intro> {

  //controller for keeping track of current page
  PageController _controller = PageController();

  //track of lastpage
  bool _lastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
           PageView(
            controller: _controller,
            onPageChanged: (index){
              setState(() {
                 _lastPage = (index == 1);
              });
              
            },
        children: [
          Intropage1(),
          Intropage2()
         
        ],
      ),


           //dot indicator
       Container(
        alignment: Alignment(0, 0.88),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(onPressed: (){
              _controller.previousPage(
               duration: Duration(milliseconds: 500), 
                  curve: Curves.easeIn
                );
                }, 
                child: Text('Skip', style: TextStyle(
                  color: Colors.yellow[400]
                ),),
                style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Colors.black),

                ),),
              SmoothPageIndicator(
            controller: _controller,
             count: 2),
             
             _lastPage ? 
              ElevatedButton(onPressed: ()
              {
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return Home();
                }));
              }, child:  Text('Done', style: TextStyle(
                  color: Colors.yellow[400]
                ),),
                style:  ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Colors.black),

                ),
                ) : 
                 ElevatedButton(onPressed: ()
              {
                _controller.nextPage(
                  duration: Duration(milliseconds: 500), 
                  curve: Curves.easeIn
                  );
              }, child:  Text('Next', style: TextStyle(
                  color: Colors.yellow[400]
                ),),
                style:  ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Colors.black),

                ),
                ),
              ],
            ) 
          )

        ],
      )
    );
  }
}