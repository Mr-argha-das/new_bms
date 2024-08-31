import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class CustomButton extends StatefulWidget {
  final String path;
  final String title;
  const CustomButton({super.key, required this.path, required this.title});

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
      Beamer.of(context).beamToNamed('${widget.path}');
      },
      child: Container(
        height: 40,
        width: 140,
        decoration: BoxDecoration(
          color: Colors.grey.shade800,
          borderRadius: BorderRadius.circular(15)
      
        ),
       child: Center(
        child: Text("${widget.title}", style: TextStyle(
          color: Colors.white
        ),),
       ),
      ),
    );
  }
}