import 'dart:developer';

import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MySearchapleDropDown extends StatefulWidget {
  final List<ItemClass> items;
  final String title;
  final Function callBack;
  final String id;
  const MySearchapleDropDown(
      {Key? key,
      required this.items,
      required this.callBack,
      required this.title,
      required this.id})
      : super(key: key);

  @override
  State<MySearchapleDropDown> createState() => _MySearchapleDropDownState();
}

class _MySearchapleDropDownState extends State<MySearchapleDropDown> {
  String? textformField;
  String? preValue;
  bool showDrop = false;
  final _textController = TextEditingController();
  List<ItemClass> _clientsList = [];
  List<ItemClass> clientsList = [];
  void initState() {
    super.initState();
    _clientsList = widget.items;
    clientsList = widget.items;
    logic();
  }

  logic() {
    for (int i = 0; i < _clientsList.length; i++) {
      if (widget.items[i].value == widget.id) {
        setState(() {
          _textController.text = _clientsList[i].title;
        });
        log("match");
      }else{
        log("not match");
      }
    }
  }

  void myLogic(String enterKeyword) {
    if (enterKeyword.isNotEmpty) {
      _clientsList = widget.items
          .where(
              (tag) => tag.title.toLowerCase().contains(enterKeyword.toLowerCase()))
          .toList();
    } else {
      _clientsList = widget.items;
    }
    setState(() {
      clientsList = _clientsList;
    });
    // final suggestions = _clientsList.where((element) {
    //   final statusValue = element.title.toLowerCase();
    //   final input = enterKeyword.toLowerCase();
    //   return statusValue.contains(input);
    // }).toList();
    // setState(() => _clientsList = suggestions);
    // if(_textController.text == ""){
    //   _clientsList = widget.items;
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: showDrop ? 200 : 40,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8, left: 15),
              child: TextFormField(
                onTap: () {
                  setState(() {
                    showDrop = true;
                  });
                },
                controller: _textController,
                style: TextStyle(
                  color: Colors.black
                ),

                decoration: InputDecoration.collapsed(
                  border: InputBorder.none,
                  hintText: widget.title,
                  hintStyle: GoogleFonts.montserrat(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                
                ),
                onChanged: (value) {
                  myLogic(value);
                },
              ),
            ),
            if (showDrop == true)
            SizedBox(
              height: 10,
            ),
            if (showDrop == true) ...[
              ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: clientsList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        widget.callBack(clientsList[index].value);
                        setState(() {
                          _textController.text =clientsList[index].title;
                          showDrop = false;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Text("${clientsList[index].title}",
                            style: GoogleFonts.montserrat(color: Colors.black)),
                      ),
                    );
                    // return GestureDetector(
                    //     onTap: () {
                    //       widget.callBack(widget.items[index].value);
                    //       setState(() {
                    //           preValue = widget.items[index].title;
                    //           showDrop = false;
                    //         });
                    //     },
                    //     child: Padding(
                    //       padding: const EdgeInsets.all(4.0),
                    //       child: Text("${widget.items[index].title}", style: GoogleFonts.montserrat(color: Colors.black),),
                    //     ),
                    //   );
                  })
            ],
          ],
        ),
      ),
    );
  }
}

class ItemClass {
  final String title;
  final String value;

  ItemClass({required this.title, required this.value});
}

class SearchDropdown extends StatefulWidget {
  @override
  _SearchDropdownState createState() => _SearchDropdownState();
}

class _SearchDropdownState extends State<SearchDropdown> {
  GlobalKey<AutoCompleteTextFieldState<String>> key = GlobalKey();
  List<String> suggestions = [
    'Apple',
    'Banana',
    'Cherry',
    'Date',
    'Elderberry',
    'Fig',
    'Grape',
    'Honeydew'
  ];
  String selected = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Container(
        height: 40,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: const Color.fromARGB(
            255,
            239,
            239,
            239,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 8, left: 15),
            child: AutoCompleteTextField<String>(
              key: key,
              clearOnSubmit: false,
              suggestions: suggestions,
              decoration: InputDecoration.collapsed(
                border: InputBorder.none,
                hintText: "Search Currency",
                hintStyle: GoogleFonts.montserrat(
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
              itemFilter: (item, query) {
                return item.toLowerCase().startsWith(query.toLowerCase());
              },
              itemSorter: (a, b) {
                return a.compareTo(b);
              },
              itemSubmitted: (item) {
                setState(() {
                  selected = item;
                });
              },
              itemBuilder: (context, item) {
                return ListTile(
                  title: Text(item),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
