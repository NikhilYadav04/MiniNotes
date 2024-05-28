import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sign_in_button/sign_in_button.dart';

User? user;

class Intropage2 extends StatefulWidget {
  const Intropage2({super.key});

  @override
  State<Intropage2> createState() => _Intropage2State();
}

class _Intropage2State extends State<Intropage2> {


 final FirebaseAuth _auth = FirebaseAuth.instance;
 late StreamSubscription<User?> _authStateSubscription;

  

   @override
  void initState() {
    super.initState();
    _authStateSubscription = _auth.authStateChanges().listen((event) {
      if (mounted) {
        setState(() {
          user = event;
        });
      }
    });
  }

 @override
  void dispose() {
    _authStateSubscription.cancel(); // Cancel the auth state change listener
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: Text("Introduce Yourself", style: TextStyle(
          color: Colors.orange[400],
          fontSize: 28,
          fontFamily: 'MuktaB'
        ),),
        toolbarHeight: 65, 
        centerTitle: true,
        leading: Icon(Icons.face_6, size: 34, color: Colors.orange[400],),
      ),
     backgroundColor: Colors.grey[800],
     body: Container(
      child: Column(
        children: [
          Center(
            child: Image.asset('assets/no.png', width:280, height:280),

          ),

           Stack(
              children: [
                Container(

                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.grey[900]!,
                        Colors.grey[850]!,
                      ]),
                    color: Colors.deepPurple[800],
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                      width: 2,
                    color:  Colors.grey[900]!
                    ),
                  ),


                  width: 420,
                  height: 380,
                ),
                
               
                   Positioned(
                    left:170,
                    top: 10,
                    bottom: 310,
                    
                  child: Image.asset('assets/g.png'),)
                  ,
                  Positioned(
                     bottom: 100,
                     left: 20,
                     right: 10,
                     top: 70,
                    child: Text("Login,", style: TextStyle(
                      color: Colors.orange[400],
                      fontSize: 46,
                      fontFamily: 'MuktaB'
                    )),),

                    Positioned(
                     bottom: 110,
                     left: 20,
                     right: 10,
                     top: 138,
                    child: Text("To Continue To MemoMagic,", style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontFamily: 'MuktaB'
                    )),),
                    Positioned(
                      bottom: 0,
                     left: 20,
                     right: 10,
                     top: 190,
                      child:  Center(
                    child: user != null ? userInfo() : google(),
                  ),
                    )
              ],
           ),


        ],
      )
     ),

    );
  }

  Widget google() {
    return Center(
      child: SizedBox(
        height: 60,
        child: SignInButton(
          Buttons.google,
          text: "Sign up with Google" ,
          onPressed: (){
            SignIn();

          },
        ),
      ),
    );
    
  }

  Widget userInfo() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Container(

        child: Column(

        children: [
          // Container(
          //   height: 100,
          //   width: 100,
          //   decoration: BoxDecoration(
          //     border: Border.all(
          //       color: Colors.yellow[400]!,
          //       width: 3,
          //     ),
          //     image: DecorationImage(
          //       image: NetworkImage(user!.photoURL!),
          //     ),
          //   ),
          // ),
          
          //  Text("Logged In As", style: TextStyle(
          //   fontSize: 22,
          //   color: Colors.white,
          //   fontFamily: 'Radio',
          // ),),
          Text(user!.email!, style: TextStyle(
            fontSize: 22,
            color: Colors.white,
            fontFamily: 'Radio',
            
          ),),
          Text(user!.displayName ?? ""),

          ElevatedButton(onPressed: ()
              {
                _auth.signOut();

              }, child:  Text('Sign Out', style: TextStyle(
                  color: Colors.yellow[400]
                ),),
                style:  ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Colors.black),
              
                ),
                ),
        ],
      ),
      )
       
    );
  }

  void SignIn() async{
    try {
       GoogleAuthProvider _googleAuthProvider = GoogleAuthProvider();
      await _auth.signInWithProvider(_googleAuthProvider);
    } catch (error) {
      print(error);
    }
  }
}