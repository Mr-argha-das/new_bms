import 'package:flutter/material.dart';

import '../../../constants.dart';
import 'chart.dart';
import 'storage_info_card.dart';

class StorageDetails extends StatelessWidget {
  const StorageDetails({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Recent Updates",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: defaultPadding),
          // Chart(),
          StorageInfoCard(
            svgSrc: "assets/icons/Documents.svg",
            title: "JPNP-18-8-2023_01",
            numOfFiles: "Check this order.....",
          ),
          StorageInfoCard(
            svgSrc: "assets/icons/media.svg",
            title: "Message",
            numOfFiles: "Review.....",
          ),
          StorageInfoCard(
            svgSrc: "assets/icons/folder.svg",
            title: "Deliver",
            numOfFiles: "File Deliver",
          ),
          StorageInfoCard(
            svgSrc: "assets/icons/unknown.svg",
            title: "Resent File",
            numOfFiles: "New Update",
          ),
        ],
      ),
    );
  }
}
