import 'package:flutter/material.dart';

class DocumentsPage extends StatefulWidget {
  const DocumentsPage({Key? key}) : super(key: key);
  @override
  State<DocumentsPage> createState() => _DocumentsPageState();
}

class _DocumentsPageState extends State<DocumentsPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 80,
                width: 220,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 235, 235, 235),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 8, bottom: 6),
                                  child: Text(
                                    "Offer/Joining Letter",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Icon(
                                    Icons.file_download_outlined,
                                    color: Colors.black,
                                    size: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Icon(
                                Icons.sticky_note_2_outlined,
                                color: const Color.fromARGB(115, 124, 124, 124),
                                size: 50,
                              )
                            ],
                          )),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 80,
                width: 220,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 235, 235, 235),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 8, bottom: 6),
                                  child: Text(
                                    "Offer/Joining Letter",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Icon(
                                    Icons.file_download_outlined,
                                    color: Colors.black,
                                    size: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Icon(
                                Icons.sticky_note_2_outlined,
                                color: const Color.fromARGB(115, 124, 124, 124),
                                size: 50,
                              )
                            ],
                          )),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 80,
                width: 220,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 235, 235, 235),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 8, bottom: 6),
                                  child: Text(
                                    "Offer/Joining Letter",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Icon(
                                    Icons.file_download_outlined,
                                    color: Colors.black,
                                    size: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Icon(
                                Icons.sticky_note_2_outlined,
                                color: const Color.fromARGB(115, 124, 124, 124),
                                size: 50,
                              )
                            ],
                          )),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
