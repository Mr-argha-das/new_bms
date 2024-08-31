import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:admin/config/get.user.data.dart';
import 'package:admin/config/pretty.dio.dart';
import 'package:admin/screens/allocation/service/allocation.service.dart';
import 'package:admin/screens/main.service/file.upload.model.dart';
import 'package:admin/screens/main.service/fileupload.service.dart';
import 'package:admin/screens/orders/components/searchdrop.dart';
import 'package:admin/screens/orders/model/allocation.model.dart';
import 'package:admin/screens/orders/model/sharmodel.dart';
import 'package:admin/screens/orders/service/order_api_service.dart';
import 'package:beamer/beamer.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quill_html_editor/quill_html_editor.dart';
import 'dart:html' as html;

class EditorView extends StatefulWidget {
  final String statusType;
  final String orderid;
  final String orderNo;
  final String wordcount;
  final String topic;
  final String deadline;
  const EditorView(
      {super.key,
      required this.orderid,
      required this.statusType,
      required this.orderNo,
      required this.deadline,
      required this.topic,
      required this.wordcount});

  @override
  State<EditorView> createState() => _EditorViewState();
}

class _EditorViewState extends State<EditorView> {
  late QuillEditorController controller;
  final customToolBarList = [
    ToolBarStyle.bold,
    ToolBarStyle.italic,
    ToolBarStyle.align,
    ToolBarStyle.color,
    ToolBarStyle.background,
    ToolBarStyle.listBullet,
    ToolBarStyle.listOrdered,
    ToolBarStyle.clean,
    ToolBarStyle.addTable,
    ToolBarStyle.editTable,
  ];

  final _toolbarColor = Colors.grey.shade200;
  final _backgroundColor = Colors.white70;
  final _toolbarIconColor = Colors.black87;
  final _editorTextStyle = const TextStyle(
      fontSize: 18,
      color: Colors.black,
      fontWeight: FontWeight.normal,
      fontFamily: 'Roboto');
  final _hintTextStyle = const TextStyle(
      fontSize: 18, color: Colors.black38, fontWeight: FontWeight.normal);

  bool _hasFocus = false;
  final topicController = TextEditingController();
  final deadLineController = TextEditingController();
  final wordcountController = TextEditingController();
  @override
  void initState() {
    controller = QuillEditorController();
    controller.onTextChanged((text) {
      debugPrint('listening to $text');
    });
    controller.onEditorLoaded(() {
      debugPrint('Editor Loaded :)');
    });
    
    super.initState();

    topicController.text = widget.topic;
    deadLineController.text = widget.deadline;
    wordcountController.text = widget.wordcount;
  }

  @override
  void dispose() {
    /// please do not forget to dispose the controller
    controller.dispose();
    super.dispose();
  }

  String? message;

  List<ItemClass> writerlist = [];

  filePicker() async {
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.multiple = false;
    uploadInput.draggable = true;
    uploadInput.click();

    uploadInput.onChange.listen((event) {
      final files = uploadInput.files;
      final file = files![0];
      final reader = html.FileReader();
      log("///////////////////////////");

      reader.onLoadEnd.listen((event) {
        setState(() async {
          _images =
              Base64Decoder().convert(reader.result.toString().split(',').last);
          _selectFiles = _bytesData;
          // _pickedImage = File.;
          imagepath = file.name;
          log("====================");
          // log(_pickedImage!.path.toString());
          final multipartFile =
              MultipartFile.fromBytes(_images!, filename: "${file.name}");
          final fileUploadService = FileUploadService(createDio());
          FileUploadResponse response = await fileUploadService
              .upload(data: {"images": multipartFile, "bucketName": "ahec"});
          imagepath = response.data;
        });
      });
      reader.readAsDataUrl(file);
    });
  }

  String? writerId;

  String? filepath = "NONE";
  String imagepath = "NONE";
  Uint8List? _bytesData;
  Uint8List? _images;
  List<int>? _selectFiles;
  DateTime pickDate = DateTime.now();
  TextEditingController _deadLineController = TextEditingController();
  
  
  final _currentWordcountController =TextEditingController();
  Map<String, dynamic>? savedUserData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      
      appBar: AppBar(
        leading: Icon(Icons.arrow_back, color: Colors.black,),
        title: Text('Text Editor : ${widget.orderNo}'),
        actions: [
          IconButton(
              onPressed: () {
                filePicker();
              },
              icon: Icon(imagepath == "NONE"
                  ? Icons.attach_file_outlined
                  : Icons.done)),
          IconButton(
              onPressed: () async {
                final allocationService = AllocationSerive(createDio());
                AllocationListmodel allocationListmodel =
                    await allocationService.getAllocationList();
                final setUserData = UserDataGet();
                setUserData.getUserLocalData();
                print("============::::::::::==========");
                final createShareService = OrderService(createDio());
                CreateSharReseModel createSharReseModel =
                    await createShareService.shareOrder(CreateShareModel(
                      correntWordCount: _currentWordcountController.text,
                        oderId: widget.orderid,
                        sendar: "${setUserData.id}",
                        receiver: allocationListmodel.data[0].id,
                        status: "${widget.statusType}",
                        message: """${message}""",
                        file: imagepath!,
                        deadline: '${deadLineController.text}',
                        topic: '${topicController.text}',
                        word_count: '${wordcountController.text}'));
                Beamer.of(context).beamToNamed(
                    "/order-status/${widget.orderid}/${widget.orderNo}");
              },
              icon: Icon(Icons.send))
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 2, left: 15, right: 15),
            child: TextFormField(
              controller: topicController,
              style: TextStyle(color: Colors.black, fontSize: 15),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey.shade300,
                label: Text(
                  "Topic / Company",
                  style: TextStyle(color: Colors.black),
                ),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                hintText: "Topic / Company",
                hintStyle: GoogleFonts.montserrat(
                  color: Colors.black,
                  fontSize: 15,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 100,
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 2, left: 15),
                    child: TextFormField(
                      controller: wordcountController,
                      style: TextStyle(color: Colors.black, fontSize: 15),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey.shade300,
                        label: Text(
                          "Total Word count",
                          style: TextStyle(color: Colors.black),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        hintText: "Total Word count",
                        hintStyle: GoogleFonts.montserrat(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 2, left: 15),
                    child: TextFormField(
                      controller: _currentWordcountController,
                      style: TextStyle(color: Colors.black, fontSize: 15),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey.shade300,
                        label: Text(
                          "Current Word count",
                          style: TextStyle(color: Colors.black),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        hintText: "Current Word count",
                        hintStyle: GoogleFonts.montserrat(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 2, left: 15),
                    child: TextFormField(
                      controller: deadLineController,
                      style: TextStyle(color: Colors.black, fontSize: 15),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey.shade300,
                        label: Text(
                          "Deadline",
                          style: TextStyle(color: Colors.black),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        hintText: "Deadline",
                        hintStyle: GoogleFonts.montserrat(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 2,
          ),
          ToolBar(
            toolBarColor: _toolbarColor,
            padding: const EdgeInsets.all(8),
            iconSize: 25,
            iconColor: _toolbarIconColor,
            activeIconColor: Colors.greenAccent.shade400,
            controller: controller,
            crossAxisAlignment: WrapCrossAlignment.start,
            direction: Axis.horizontal,
            customButtons: [
              Container(
                width: 25,
                height: 25,
                decoration: BoxDecoration(
                    color: _hasFocus ? Colors.green : Colors.grey,
                    borderRadius: BorderRadius.circular(15)),
              ),
              InkWell(
                  onTap: () => unFocusEditor(),
                  child: const Icon(
                    Icons.favorite,
                    color: Colors.black,
                  )),
              InkWell(
                  onTap: () async {
                    var selectedText = await controller.getSelectedText();
                    debugPrint('selectedText $selectedText');
                    var selectedHtmlText =
                        await controller.getSelectedHtmlText();
                    debugPrint('selectedHtmlText $selectedHtmlText');
                  },
                  child: const Icon(
                    Icons.add_circle,
                    color: Colors.black,
                  )),
            ],
          ),
          Expanded(
            child: QuillHtmlEditor(
              text: "<h1>Hello</h1>This is a quill html editor example 😊",
              hintText: 'Hint text goes here',
              controller: controller,
              isEnabled: true,
              ensureVisible: false,
              minHeight: 500,
              autoFocus: false,
              textStyle: _editorTextStyle,
              hintTextStyle: _hintTextStyle,
              hintTextAlign: TextAlign.start,
              padding: const EdgeInsets.only(left: 10, top: 10),
              hintTextPadding: const EdgeInsets.only(left: 20),
              backgroundColor: _backgroundColor,
              inputAction: InputAction.newline,
              onEditingComplete: (s) => debugPrint('Editing completed $s'),
              loadingBuilder: (context) {
                return const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 1,
                    color: Colors.white,
                  ),
                );
              },
              onFocusChanged: (focus) {
                debugPrint('has focus $focus');
                setState(() {
                  _hasFocus = focus;
                });
              },
              onTextChanged: (text) {
                print("=============");
                print(text.toString());
                setState(() {
                  message = text;
                });
              },
              onEditorCreated: () {
                // debugPrint('Editor has been loaded');
                setHtmlText('Testing text on load');
              },
              // onEditorResized: (height) => debugPrint('Editor resized $height'),
              // onSelectionChanged: (sel) =>
              //     debugPrint('index ${sel.index}, range ${sel.length}'),
            ),
          ),
        ],
      ),
    );
  }

  void unFocusEditor() => controller.unFocus();
  void setHtmlText(String text) async {
    setState(() async {
      await controller.setText(text);
    });
  }
}
