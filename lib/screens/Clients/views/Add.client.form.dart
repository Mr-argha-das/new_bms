import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class AddClientForm extends StatefulWidget {
  const AddClientForm({Key? key}) : super(key: key);

  @override
  State<AddClientForm> createState() => _AddClientFormState();
}

class _AddClientFormState extends State<AddClientForm> {
  final emailController = TextEditingController();
  final firstnameController = TextEditingController();
  final mobileController = TextEditingController();
  final lastnameController = TextEditingController();
  final universityController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                            "Add Client",
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 20),
                          ),
                          Container(
                              height: 500,
                              width: 600,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  image: DecorationImage(
                                    image: AssetImage(
                                        "assets/images/Customer relationship management.gif"),
                                    fit: BoxFit.cover,
                                  ))),
                        ],
                      ),
                    ),
                    Expanded(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(
                            "Please fill all field",
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 20),
                          ),
                        ),
                        SizedBox(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 35,
                                  width: 300,
                                  decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 239, 239, 239),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                        child: TextFormField(
                                          controller: firstnameController,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 13),
                                          decoration: InputDecoration.collapsed(
                                              border: InputBorder.none,
                                              hintText: 'First name',
                                              hintStyle: TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w300)),
                                        ),
                                      )),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 35,
                                  width: 300,
                                  decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 239, 239, 239),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                        child: TextFormField(
                                          controller: lastnameController,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 13),
                                          decoration: InputDecoration.collapsed(
                                              border: InputBorder.none,
                                              hintText: 'Last name',
                                              hintStyle: TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w300)),
                                        ),
                                      )),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 35,
                                  width: 300,
                                  decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 239, 239, 239),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                        child: TextFormField(
                                          controller: emailController,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 13),
                                          decoration: InputDecoration.collapsed(
                                              border: InputBorder.none,
                                              hintText: 'Email',
                                              hintStyle: TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w300)),
                                        ),
                                      )),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 35,
                                  width: 300,
                                  decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 239, 239, 239),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                        child: TextFormField(
                                          controller: universityController,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 13),
                                          decoration: InputDecoration.collapsed(
                                              border: InputBorder.none,
                                              hintText: 'University name',
                                              hintStyle: TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w300)),
                                        ),
                                      )),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 35,
                            width: 300,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 239, 239, 239),
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    controller: mobileController,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 13),
                                    decoration: InputDecoration.collapsed(
                                        border: InputBorder.none,
                                        hintText: 'Mobile number',
                                        hintStyle: TextStyle(
                                            fontSize: 13,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w300)),
                                  ),
                                )),
                          ),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: Container(
                        //     height: 40,
                        //     width: 300,
                        //     decoration: BoxDecoration(
                        //         color: const Color.fromARGB(255, 239, 239, 239),
                        //         borderRadius: BorderRadius.circular(10)),
                        //     child: Phonenumber(),
                        //   ),
                        // ),
                        SizedBox(
                          height: 40,
                        ),
                        Container(
                          height: 40,
                          width: 150,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(15)),
                          child: Center(
                            child: Text("Submit",
                                style: GoogleFonts.montserrat(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                          ),
                        )
                      ],
                    ))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Phonenumber extends StatefulWidget {
  @override
  _PhonenumberState createState() => _PhonenumberState();
}

class _PhonenumberState extends State<Phonenumber> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController controller = TextEditingController();
  String initialCountry = 'IN';
  var number = PhoneNumber(isoCode: 'IN');

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InternationalPhoneNumberInput(
              inputDecoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
              ),
              textStyle: const TextStyle(color: Colors.black),
              onInputChanged: (number) {
                print(number.phoneNumber);
              },
              onInputValidated: (bool value) {
                print(value);
              },
              selectorConfig: const SelectorConfig(
                selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
              ),
              ignoreBlank: false,
              autoValidateMode: AutovalidateMode.disabled,
              selectorTextStyle: const TextStyle(color: Colors.black),
              initialValue: number,
              textFieldController: controller,
              formatInput: true,
              keyboardType: const TextInputType.numberWithOptions(
                  signed: true, decimal: true),
              inputBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              onSaved: (number) {
                print('On Saved: $number');
              },
            ),
          ],
        ),
      ),
    );
  }

  void getPhoneNumber(String phoneNumber) async {
    var number =
        await PhoneNumber.getRegionInfoFromPhoneNumber(phoneNumber, 'IN');

    setState(() {
      this.number = number;
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
