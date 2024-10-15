import 'dart:developer';

import 'package:admin/config/get.user.data.dart';
import 'package:admin/config/pretty.dio.dart';
import 'package:admin/screens/allocation/service/allocation.service.dart';
import 'package:admin/screens/orders/model/add.order.body.model.dart';
import 'package:admin/screens/orders/model/allocation.model.dart';
import 'package:admin/screens/orders/model/order.add.response.dart';
import 'package:admin/screens/orders/model/payment.body.dart';
import 'package:admin/screens/orders/model/payment.create.res.dart';
import 'package:admin/screens/orders/model/sharmodel.dart';
import 'package:admin/screens/orders/service/order_api_service.dart';
import 'package:beamer/beamer.dart';
import 'package:cell_calendar/cell_calendar.dart';
import 'package:flutter/material.dart';
import 'package:quill_html_editor/quill_html_editor.dart';

class ComposePAgeForAddOrder extends StatefulWidget {
  final String topic;
  final String currentWordcout;
  final String clientId;
  final String currencyId;
  final String servicId;
  final int inrAmmount;
  final int audAmmount;
  final int clientAmmount;
  final int totalAmmount;
  final String ppt;
  final String moduleName;
  final String moduleCode;
  final String deadline;
  final String wordCount;
  final String paymentType;
  final String stram;
  final String images;
  final String file;
  final String clientPaidAmmountInr;
  final String totalInrAmmount;
  final String userid;
  final String allocationId;
  final String trnx;
  const ComposePAgeForAddOrder({
    super.key,
    required this.trnx,
    required this.stram,
    required this.topic,
    required this.clientAmmount,
    required this.currencyId,
    required this.clientId,
    required this.servicId,
    required this.inrAmmount,
    required this.audAmmount,
    required this.totalAmmount,
    required this.ppt,
    required this.moduleCode,
    required this.moduleName,
    required this.deadline,
    required this.wordCount,
    required this.paymentType,
    required this.images,
    required this.file,
    required this.clientPaidAmmountInr,
    required this.totalInrAmmount,
    required this.userid,
    required this.allocationId,
    required this.currentWordcout,
  });

  @override
  State<ComposePAgeForAddOrder> createState() => _ComposePAgeForAddOrderState();
}

class _ComposePAgeForAddOrderState extends State<ComposePAgeForAddOrder> {
  late QuillEditorController controller;

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
  }

  String message = "";
  bool _hasFocus = false;
  bool lodar = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.back_hand,
          color: Colors.black,
        ),
        title: Text(
          "Write Message",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: lodar == false
          ? Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color: Colors.white),
              child: Column(
                children: [
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
                            var selectedText =
                                await controller.getSelectedText();
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
                      text:
                          "<h1>Hello</h1>This is a quill html editor example 😊",
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
                      onEditingComplete: (s) =>
                          debugPrint('Editing completed $s'),
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
                          // _hasFocus = focus;
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
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
      floatingActionButton: GestureDetector(
        onTap: () async {
          setState(() {
            lodar = true;
          });
          final orderService = OrderService(createDio());
          final getUserData = UserDataGet();
          getUserData.getUserLocalData();
          final allocationService = AllocationSerive(createDio());
          AllocationListmodel allocationListmodel =
              await allocationService.getAllocationList();
          OrderAddResponse orderData = await orderService.addOrder(AddOrderBody(
              stream: widget.stram,
              correntWordCount: widget.currentWordcout,
              clientId: widget.clientId!,
              currencyId: widget.currencyId,
              serviceId: widget.servicId!,
              inrAmmount: widget.inrAmmount,
              audAmmount: widget.audAmmount,
              clientAmmount: widget.clientAmmount,
              totalAmmount: widget.totalAmmount,
              ppt: widget.ppt,
              moduleCode: widget.moduleCode,
              moduleName: widget.moduleName,
              deadline: widget.deadline,
              wordCount: widget.wordCount,
              paymentType: widget.paymentType!,
              shortNote: "${message}",
              image: widget.images!,
              file: widget.file!,
              clientPaidAmmountInr: widget.clientPaidAmmountInr,
              userId: getUserData.id,
              total_inrAmmount: widget.totalInrAmmount));
          CreateSharReseModel createSharReseModel =
              await orderService.shareOrder(CreateShareModel(
                  correntWordCount: widget.currentWordcout,
                  oderId: orderData.data.oderDetails.id,
                sendar: getUserData.id,
                  receiver: allocationListmodel.data[0].id,
                  status: "Unassigned",
                  message: "${message}",
                  file: widget.file!,
                  deadline: widget.deadline,
                  topic: widget.topic,
                  word_count: widget.wordCount));
          PaymentResponseModel createpaymentrees =
              await orderService.createPayment(PaymentBodyModel(
                  orderId: orderData.data.oderDetails.id,
                  userId: getUserData.id,
                  clientId: widget.clientId,
                  paymentType: widget.paymentType!,
                  transactionId: widget.trnx,
                  amount: widget.clientPaidAmmountInr));
          Beamer.of(context).beamToNamed('/orders-list');
          log(createSharReseModel.message.toString());
        },
        child: Container(
          height: 50,
          width: 160,
          decoration: BoxDecoration(
              color: Colors.blue, borderRadius: BorderRadius.circular(150)),
          child: Center(
            child: Text(
              "SUBMIT",
              style: TextStyle(color: Colors.white, fontSize: 22),
            ),
          ),
        ),
      ),
    );
  }

  void unFocusEditor() => controller.unFocus();
  void setHtmlText(String text) async {
    await controller.setText(text);
  }
}
