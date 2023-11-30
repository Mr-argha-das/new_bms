import 'package:flutter/material.dart';

class Pagination extends StatefulWidget {
  const Pagination({Key? key}) : super(key: key);

  @override
  State<Pagination> createState() => _PaginationState();
}

class _PaginationState extends State<Pagination> {
  int currentPage = 1;
  int itemsPerPage = 6; // Number of items per page
  int totalItems = 30;

  @override
  Widget build(BuildContext context) {
    int totalPages = (totalItems / itemsPerPage).ceil();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: currentPage > 1
              ? () {
                  setState(() {
                    currentPage--;
                  });
                }
              : null,
        ),
        for (int i = 1; i <= totalPages; i++)
          TextButton(
            onPressed: () {
              setState(() {
                currentPage = i;
              });
            },
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.pressed)) {
                    // Set your custom tap color here
                    return Colors.blue
                        .withOpacity(0.5); // Change to your desired color
                  }
                  return null; // Use the default overlay color
                },
              ),
            ),
            child: Text(
              '$i',
              style: TextStyle(
                color: currentPage == i
                    ? Colors.blue
                    : Colors.black, // Change the color based on selection
              ),
            ),
          ),
        IconButton(
          icon: Icon(Icons.arrow_forward),
          onPressed: currentPage < totalPages
              ? () {
                  setState(() {
                    currentPage++;
                  });
                }
              : null,
        ),
      ],
    );
  }
}
