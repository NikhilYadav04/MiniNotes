import 'package:flutter/material.dart';

class Intropage1 extends StatefulWidget {
  const Intropage1({super.key});

  @override
  State<Intropage1> createState() => _Intropage1State();
}

class _Intropage1State extends State<Intropage1> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[850],
      child: Container(
        margin: EdgeInsets.fromLTRB(0, 170, 0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Column(
                children: [
                  Image1(),
                  SizedBox(
                    height: 10,
                  ),
                  RowImagesWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget Image1() {
    return SizedBox(
        height: 390,
        child: Image.asset(
          "assets/logobg.png",
        ));
  }

  Widget RowImagesWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        RImage1(),
        RImage2(),
        RImage3()
      ],
    );
  }

  Widget RImage1() {
    return Column(
      children: [
        SizedBox(
          height: 18,
        ),
        Image.asset(
          "assets/note.png",
          width: 40,
          height: 40,
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          "Create",
          style: TextStyle(color: Colors.white, fontFamily: 'Radio'),
        ),
        Text(
          "Mini Notes",
          style: TextStyle(color: Colors.white, fontFamily: 'Radio'),
        ),
      ],
    );
  }

  Widget RImage2() {
    return Column(
      children: [
        SizedBox(
          height: 15,
        ),
        Image.asset(
          "assets/manage.png",
          width: 50,
          height: 50,
        ),
        SizedBox(
          height: 3,
        ),
        Text(
          "Manage Notes",
          style: TextStyle(color: Colors.white, fontFamily: 'Radio'),
        ),
        Text(
          "Efficiently",
          style: TextStyle(color: Colors.white, fontFamily: 'Radio'),
        ),
      ],
    );
  }

  Widget RImage3() {
    return Column(
      children: [
        SizedBox(
          height: 15,
        ),
        Image.asset(
          "assets/app.png",
          width: 50,
          height: 50,
        ),
        SizedBox(
          height: 4,
        ),
        Text(
          "App",
          style: TextStyle(color: Colors.white, fontFamily: 'Radio'),
        ),
        Text(
          "By Nikhil",
          style: TextStyle(color: Colors.white, fontFamily: 'Radio'),
        ),
      ],
    );
  }
}
