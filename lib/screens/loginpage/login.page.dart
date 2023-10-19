import 'dart:convert';
import 'dart:math';

import 'package:admin/screens/loginpage/model/login_model.dart';
import 'package:admin/screens/loginpage/service/api_service.dart';
import 'package:beamer/beamer.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool obsecure = true;
  bool loding = false;
  bool nextpage = false;
  bool nextpageAnimation = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if(nextpage == false)
            Container(
             height: 150,
             width: 150,
             decoration: BoxDecoration(
              color: Colors.transparent,
              
             ),
             child: Center(child: Image.asset('assets/icons/A2G.png'),),
            ),
            if(nextpage == false)
            SizedBox(
              height: 50,
            ),
            if(nextpage == false)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 400,
                  child: TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      label: Text(
                        "Email",
                        style: GoogleFonts.montserrat(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    validator: (value){
                      if(value!.isEmpty || value ==null){
                       return "Email Is required";
                      }
                    },
                  ),
                )
              ],
            ),
            if(nextpage == false)
            SizedBox(
              height: 25,
            ),
            if(nextpage == false)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if(nextpage == false)
                SizedBox(
                  width: 400,
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: obsecure,
                    decoration: InputDecoration(
                        label: Text(
                          "Password",
                          style: GoogleFonts.montserrat(
                            color: Colors.white,
                          ),
                        ),
                        suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                obsecure = !obsecure;
                              });
                            },
                            child: Icon(obsecure
                                ? Icons.visibility_off
                                : Icons.visibility))),
                                validator: (value){
                      if(value!.isEmpty || value ==null){
                       return "Password Is required";
                      }
                    },
                  ),
                )
              ],
            ),
            Center(
              child: AnimatedContainer(
                duration: Duration(milliseconds: 500),
                height: nextpageAnimation? (MediaQuery.of(context).size.height): 0,
                width: nextpageAnimation? MediaQuery.of(context).size.width:0,
                decoration: BoxDecoration(
                  color:  Color.fromARGB(255, 255, 0, 81),
                  borderRadius: BorderRadius.circular(nextpageAnimation? 0: 500)
                ),
                ),
            ),
            if(nextpage == false)
            SizedBox(
              height: 50,
            ),
            if(nextpage == false)
            GestureDetector(
              onTap: () async {
                if(_formKey.currentState!.validate()) {
                  setState(() {
                  
                  loding = !loding;
                });
                Future.delayed(Duration(seconds: 2),(){
                 setState(() {
                   nextpage = true;
                 });
                });
                Future.delayed(Duration(seconds: 3),(){
                  setState(() {
                  nextpageAnimation = true;
                });
                });
                Future.delayed(Duration(seconds: 4),(){
                  Beamer.of(context).beamToNamed('/dashboard');
                });
                // final data = LoginService(Dio(BaseOptions(contentType: "application/json")));
                // LoginResponse response = await data.login(LoginModel(email: _emailController.text, password: _passwordController.text));
                // print(response.message);
                }
              },
              child: AnimatedContainer(
                duration: Duration(seconds: 1),
                height: 50,
                width: loding? 50:320,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(500),
                    color: Colors.black38,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.white10,
                          spreadRadius: 1,
                          blurRadius: 4,
                          offset: Offset(3, 3))
                    ]),
                child: loding
                    ? Center(
                        child: LoadingAnimationWidget.fourRotatingDots(
                            color: Color.fromARGB(255, 255, 0, 81), size: 30),
                      )
                    : Center(
                        child: Text(
                          "LOGIN",
                          style: GoogleFonts.montserrat(
                            color: Colors.white,
                          ),
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
