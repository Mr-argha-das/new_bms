import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MySearchapleDropDown extends StatefulWidget {
  final List<ItemClass> items;
  final String title;
  final Function callBack;
  const MySearchapleDropDown(
      {Key? key,
      required this.items,
      required this.callBack,
      required this.title})
      : super(key: key);

  @override
  State<MySearchapleDropDown> createState() => _MySearchapleDropDownState();
}

class _MySearchapleDropDownState extends State<MySearchapleDropDown> {
  String? textformField;
  String? preValue;
  bool showDrop = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              onTap: () {
                setState(() {
                  showDrop = true;
                });
              },
              initialValue: preValue ?? "",
              decoration: InputDecoration(hintText: widget.title),
              onChanged: (value) {
                setState(() {
                  textformField = value;
                });
              },
            ),
            if (showDrop == true) ...[
              ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: widget.items.length,
                  itemBuilder: (context, index) {
                    if (textformField != null &&
                        widget.items[index].title.contains(textformField!)) {
                      return GestureDetector(
                        onTap: () {
                          widget.callBack(widget.items[index].value);
                          setState(() {
                            preValue = widget.items[index].title;
                            showDrop = false;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text("${widget.items[index].title}",
                              style:
                                  GoogleFonts.montserrat(color: Colors.black)),
                        ),
                      );
                    } else {
                      return GestureDetector(
                        onTap: () {
                          widget.callBack(widget.items[index].value);
                          setState(() {
                            preValue = widget.items[index].title;
                            showDrop = false;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            "${widget.items[index].title}",
                            style: GoogleFonts.montserrat(color: Colors.black),
                          ),
                        ),
                      );
                    }
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
