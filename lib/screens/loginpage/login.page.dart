import 'dart:developer';
import 'package:admin/config/get.user.data.dart';

import 'package:admin/constants.dart';
import 'package:admin/screens/main/main_screen.dart';
import 'package:beamer/beamer.dart';
import 'package:connectivity/connectivity.dart';

import 'package:admin/screens/loginpage/model/login_model.dart';
import 'package:admin/screens/loginpage/service/api_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

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
  void initState() {
    // TODO: implement initState
    super.initState();
    final data = UserDataGet();
    data.getUserLocalData();
    if (data.id == null) {
      
    }
  }
  
  @override
  Widget build(BuildContext context) {
    final loginService = Provider.of<LoginService>(context);
    return Scaffold(
        backgroundColor: Colors.white,
        // appBar: AppBar(),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                // color: Colors.blue,

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/loginpageimage.png'),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.transparent,
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (nextpage == false)
                        Container(
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                          ),
                          child: Center(
                            child: Image.asset('assets/icons/A2G.png'),
                          ),
                        ),
                      if (nextpage == false)
                        SizedBox(
                          height: 50,
                        ),
                      if (nextpage == false)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 400,
                              child: TextFormField(
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                                // cursorColor: Colors.black,
                                controller: _emailController,
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                  hoverColor: Colors.black,
                                  label: Text(
                                    "Email",
                                    style: GoogleFonts.montserrat(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),

                                validator: (value) {
                                  if (value!.isEmpty || value == null) {
                                    return "Email Is required";
                                  }
                                },
                              ),
                            )
                          ],
                        ),
                      if (nextpage == false)
                        SizedBox(
                          height: 25,
                        ),
                      if (nextpage == false)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            if (nextpage == false)
                              SizedBox(
                                width: 400,
                                child: TextFormField(
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15),
                                  // cursorColor: Colors.black,
                                  controller: _passwordController,
                                  obscureText: obsecure,
                                  decoration: InputDecoration(
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                      ),
                                      hoverColor: Colors.black,
                                      label: Text(
                                        "Password",
                                        style: GoogleFonts.montserrat(
                                          color: Colors.black,
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
                                  validator: (value) {
                                    if (value!.isEmpty || value == null) {
                                      return "Password Is required";
                                    }
                                  },
                                ),
                              )
                          ],
                        ),
                      if (nextpage == false)
                        SizedBox(
                          height: 50,
                        ),
                      if (nextpage == false)
                        GestureDetector(
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                loding = !loding;
                              });

                              Future.delayed(Duration(seconds: 1), () async {
                                var connectivityResult =
                                    await Connectivity().checkConnectivity();

                                if (connectivityResult ==
                                    ConnectivityResult.none) {
                                  log("Check Internet connection");
                                } else {
                                  try {
                                    log(" Internet connection");
                                    final LoginResponse data =
                                        await loginService.login(LoginModel(
                                            email: _emailController.text,
                                            password:
                                                _passwordController.text));
                                    log(data.userData!.toString());
                                    log(data.message.toLowerCase());

                                    if (data.status == true) {
                                      Future.delayed(Duration(seconds: 3), () {
                                        setState(() {
                                          nextpageAnimation = true;
                                        });
                                      });
                                      final setUserData = UserDataGet();
                                      setState(() {
                                        setUserData.setData( 
                                            id: data.userData!.id,
                                            name: data.userData!.name,
                                            number: data.userData!.number
                                                .toString(),
                                            email: data.userData!.email,
                                            image: data.userData!.image,
                                            roleId: data.userData!.roles.id
                                                .toString());
                                      });
                                      Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                              builder: (context) =>
                                                  MainScreen()));
                                    } else {
                                      setState(() {
                                        loding = false;
                                        nextpage = false;
                                      });
                                      _showMyDialog(
                                          "User not found. Please check your credentials.");
                                    }
                                  } catch (e) {
                                    setState(() {
                                      loding = false;
                                      nextpage = false;
                                    });
                                    _showMyDialog(
                                        "User not found. Please check your credentials.");
                                  }
                                }
                              });
                            }
                          },
                          child: AnimatedContainer(
                            duration: Duration(seconds: 1),
                            height: 50,
                            width: loding ? 50 : 320,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(500),
                                color: Colors.black,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.white10,
                                      spreadRadius: 1,
                                      blurRadius: 4,
                                      offset: Offset(3, 3))
                                ]),
                            child: loding
                                ? Center(
                                    child:
                                        LoadingAnimationWidget.fourRotatingDots(
                                            color:
                                                Color.fromARGB(255, 255, 0, 81),
                                            size: 30),
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
              ),
            ),
          ],
        ));
  }

  Future<void> _showMyDialog(String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: bgColor,
          title: const Text(''),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      image: DecorationImage(
                          image: AssetImage('assets/icons/ithink.png'))),
                ),
                SizedBox(
                  height: 50,
                ),
                Text('${message}'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
