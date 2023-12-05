import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Writing extends StatefulWidget {
  const Writing({Key? key}) : super(key: key);

  @override
  State<Writing> createState() => _WritingState();
}

class _WritingState extends State<Writing> {
  final emailController = TextEditingController();
  final mobileNumberController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Form(
            key: _formKey,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                      child: Container(
                          height: 550,
                          width: 1050,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30)),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                    child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Writer",
                                      style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 20),
                                    ),
                                    Stack(
                                      children: [
                                        Container(
                                          height: 500,
                                          width: 600,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                        ),
                                        Positioned.fill(
                                          child: Image(
                                            image: AssetImage(
                                                "assets/images/Hand holding pen.gif"),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                )),
                                Expanded(
                                    child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Please fill all field",
                                                style: GoogleFonts.montserrat(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                    fontSize: 20),
                                              ),
                                              SizedBox(height: 40),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                    height: 80,
                                                    width: 300,
                                                    decoration: BoxDecoration(
                                                        color: const Color
                                                            .fromARGB(
                                                            255, 239, 239, 239),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(25)),
                                                    child: Center(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Expanded(
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Container(
                                                                height: 35,
                                                                width: 50,
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .transparent),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Icon(
                                                                      Icons
                                                                          .file_upload_outlined,
                                                                      color: const Color
                                                                          .fromARGB(
                                                                          255,
                                                                          24,
                                                                          102,
                                                                          179),
                                                                    ),
                                                                    Text(
                                                                      "Upload File",
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          color: const Color
                                                                              .fromARGB(
                                                                              255,
                                                                              24,
                                                                              102,
                                                                              179)),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                              child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Text(
                                                              "Add Images",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                          ))
                                                        ],
                                                      ),
                                                    )),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Container(
                                                        height: 35,
                                                        width: 300,
                                                        decoration: BoxDecoration(
                                                            color: const Color
                                                                .fromARGB(255,
                                                                239, 239, 239),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Center(
                                                              child:
                                                                  TextFormField(
                                                                controller:
                                                                    nameController,
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        13),
                                                                decoration: InputDecoration.collapsed(
                                                                    border:
                                                                        InputBorder
                                                                            .none,
                                                                    hintText:
                                                                        'Name',
                                                                    hintStyle: TextStyle(
                                                                        fontSize:
                                                                            13,
                                                                        color: Colors
                                                                            .black,
                                                                        fontWeight:
                                                                            FontWeight.w300)),
                                                              ),
                                                            )),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Container(
                                                        height: 35,
                                                        width: 300,
                                                        decoration: BoxDecoration(
                                                            color: const Color
                                                                .fromARGB(255,
                                                                239, 239, 239),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Center(
                                                              child:
                                                                  TextFormField(
                                                                controller:
                                                                    emailController,
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        13),
                                                                decoration: InputDecoration.collapsed(
                                                                    border:
                                                                        InputBorder
                                                                            .none,
                                                                    hintText:
                                                                        'Email',
                                                                    hintStyle: TextStyle(
                                                                        fontSize:
                                                                            13,
                                                                        color: Colors
                                                                            .black,
                                                                        fontWeight:
                                                                            FontWeight.w300)),
                                                              ),
                                                            )),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    height: 35,
                                                    width: 350,
                                                    decoration: BoxDecoration(
                                                        color: const Color
                                                            .fromARGB(
                                                            255, 239, 239, 239),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Center(
                                                          child: TextFormField(
                                                            controller:
                                                                mobileNumberController,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 13),
                                                            decoration: InputDecoration.collapsed(
                                                                border:
                                                                    InputBorder
                                                                        .none,
                                                                hintText:
                                                                    'Mobile phone',
                                                                hintStyle: TextStyle(
                                                                    fontSize:
                                                                        13,
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w300)),
                                                          ),
                                                        )),
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      height: 35,
                                                      width: 300,
                                                      decoration: BoxDecoration(
                                                          color: const Color
                                                              .fromARGB(255,
                                                              239, 239, 239),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                      child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Center(
                                                            child:
                                                                TextFormField(
                                                              controller:
                                                                  passwordController,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 13),
                                                              decoration: InputDecoration.collapsed(
                                                                  border:
                                                                      InputBorder
                                                                          .none,
                                                                  hintText:
                                                                      'Password',
                                                                  hintStyle: TextStyle(
                                                                      fontSize:
                                                                          13,
                                                                      color: Colors
                                                                          .black,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w300)),
                                                            ),
                                                          )),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Center(
                                                child: Container(
                                                  height: 35,
                                                  width: 200,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: Color.fromARGB(
                                                          255, 41, 41, 41)),
                                                  child: Center(
                                                    child: Text(
                                                      "Submit",
                                                      style: GoogleFonts
                                                          .montserrat(
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ])))
                              ]))),
                ])));
  }
}
