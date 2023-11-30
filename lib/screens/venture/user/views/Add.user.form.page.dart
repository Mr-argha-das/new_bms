import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class AddUserForm extends StatefulWidget {
  const AddUserForm({Key? key}) : super(key: key);

  @override
  State<AddUserForm> createState() => _AddUserFormState();
}

class _AddUserFormState extends State<AddUserForm> {
  final emailController = TextEditingController();
  final mobileController = TextEditingController();
  final nameController = TextEditingController();
  final rmidController = TextEditingController();
  final symbolController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final List<String> items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
  ];
  String? selectedValue;
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
                          "Add Users",
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
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            Positioned.fill(
                              child: Image(
                                image: AssetImage("assets/images/Add User.gif"),
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Please fill all field",
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 20),
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
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Center(
                                          child: TextFormField(
                                            controller: nameController,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 13),
                                            decoration:
                                                InputDecoration.collapsed(
                                                    border: InputBorder.none,
                                                    hintText: 'Name',
                                                    hintStyle: TextStyle(
                                                        fontSize: 13,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w300)),
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
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Center(
                                          child: TextFormField(
                                            controller: emailController,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 13),
                                            decoration:
                                                InputDecoration.collapsed(
                                                    border: InputBorder.none,
                                                    hintText: 'Email',
                                                    hintStyle: TextStyle(
                                                        fontSize: 13,
                                                        color: Colors.black,
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
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Center(
                                          child: TextFormField(
                                            controller: rmidController,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 13),
                                            decoration:
                                                InputDecoration.collapsed(
                                                    border: InputBorder.none,
                                                    hintText: 'RMID',
                                                    hintStyle: TextStyle(
                                                        fontSize: 13,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w300)),
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
                                    // width: 300,
                                    decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            255, 239, 239, 239),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Center(
                                          child: TextFormField(
                                            controller: symbolController,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 13),
                                            decoration:
                                                InputDecoration.collapsed(
                                                    border: InputBorder.none,
                                                    hintText: 'Symbol',
                                                    hintStyle: TextStyle(
                                                        fontSize: 13,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w300)),
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
                                  color:
                                      const Color.fromARGB(255, 239, 239, 239),
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
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                height: 35,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 239, 239, 239),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    DropdownButtonHideUnderline(
                                      child: DropdownButton2<String>(
                                        isExpanded: true,
                                        hint: Text(
                                          'Venture',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black,
                                          ),
                                        ),
                                        items: items
                                            .map((String item) =>
                                                DropdownMenuItem<String>(
                                                  value: item,
                                                  child: Text(
                                                    item,
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ))
                                            .toList(),
                                        value: selectedValue,
                                        onChanged: (String? value) {
                                          setState(() {
                                            selectedValue = value;
                                          });
                                        },
                                        buttonStyleData: ButtonStyleData(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 16),
                                            height: 35,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20))),
                                        iconStyleData: IconStyleData(
                                            iconEnabledColor: Colors.black),
                                        menuItemStyleData:
                                            const MenuItemStyleData(
                                          height: 35,
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                height: 35,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 239, 239, 239),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    DropdownButtonHideUnderline(
                                      child: DropdownButton2<String>(
                                        isExpanded: true,
                                        hint: Text(
                                          'Team',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black,
                                          ),
                                        ),
                                        items: items
                                            .map((String item) =>
                                                DropdownMenuItem<String>(
                                                  value: item,
                                                  child: Text(
                                                    item,
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ))
                                            .toList(),
                                        value: selectedValue,
                                        onChanged: (String? value) {
                                          setState(() {
                                            selectedValue = value;
                                          });
                                        },
                                        buttonStyleData: ButtonStyleData(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 16),
                                            height: 35,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20))),
                                        iconStyleData: IconStyleData(
                                            iconEnabledColor: Colors.black),
                                        menuItemStyleData:
                                            const MenuItemStyleData(
                                          height: 35,
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                          ),
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
                      ),
                    )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class PhoneNumber extends StatefulWidget {
//   const PhoneNumber({Key? key}) : super(key: key);

//   @override
//   State<PhoneNumber> createState() => _PhoneNumberState();
// }

// class _PhoneNumberState extends State<PhoneNumber> {
//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();

//   final TextEditingController controller = TextEditingController();
//   String initialCountry = 'NG';
//   PhoneNumber number = PhoneNumber(isoCode: 'NG');

//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: formKey,
//       child: Container(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             InternationalPhoneNumberInput(
//               onInputChanged: (PhoneNumber number) {
//                 print(number.phoneNumber);
//               },
//               onInputValidated: (bool value) {
//                 print(value);
//               },
//               selectorConfig: SelectorConfig(
//                 selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
//               ),
//               ignoreBlank: false,
//               autoValidateMode: AutovalidateMode.disabled,
//               selectorTextStyle: TextStyle(color: Colors.black),
//               initialValue: number,
//               textFieldController: controller,
//               formatInput: true,
//               keyboardType:
//                   TextInputType.numberWithOptions(signed: true, decimal: true),
//               inputBorder: OutlineInputBorder(),
//               onSaved: (PhoneNumber number) {
//                 print('On Saved: $number');
//               },
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 formKey.currentState?.validate();
//               },
//               child: Text('Validate'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 getPhoneNumber('+15417543010');
//               },
//               child: Text('Update'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 formKey.currentState?.save();
//               },
//               child: Text('Save'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void getPhoneNumber(String phoneNumber) async {
//     PhoneNumber number =
//         await PhoneNumber.getRegionInfoFromPhoneNumber(phoneNumber, 'US');

//     setState(() {
//       this.number = number;
//     });
//   }

//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }
// }
