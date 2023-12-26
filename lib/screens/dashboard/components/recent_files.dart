import 'package:admin/models/RecentFile.dart';

import 'package:flutter/material.dart';
import 'package:flutter_date_range_picker/flutter_date_range_picker.dart';

import 'package:collection/collection.dart';

import '../../../constants.dart';

class RecentFiles extends StatefulWidget {
  const RecentFiles({
    Key? key,
  }) : super(key: key);

  @override
  State<RecentFiles> createState() => _RecentFilesState();
}

class _RecentFilesState extends State<RecentFiles> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 380,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: secondaryColor, borderRadius: BorderRadius.circular(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white60,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 100,
                          color: Colors.transparent,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ListTile(
                                title: Text(
                                  "Total Achived",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                  "\$ 1,000",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 18),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          height: 1,
                          color: Colors.black,
                        ),
                        Container(
                          height: 100,
                          color: Colors.transparent,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ListTile(
                                title: Text(
                                  "Total Recovered",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                  "\$ 1,000",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 18),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          height: 1,
                          color: Colors.black,
                        ),
                        Container(
                          height: 100,
                          color: Colors.transparent,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ListTile(
                                title: Text(
                                  "Total Word Count",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                  "\$ 1,000",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 18),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          height: 1,
                          color: Colors.black,
                        )
                      ],
                    ),
                  ),
                )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 400,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: DateRangePickerWidget(
                        theme: CalendarTheme(
                            selectedColor: Colors.blue,
                            inRangeColor: Colors.blue.shade300,
                            inRangeTextStyle: TextStyle(color: Colors.black),
                            selectedTextStyle: TextStyle(color: Colors.white),
                            dayNameTextStyle: TextStyle(color: Colors.black),
                            todayTextStyle: TextStyle(color: Colors.black),
                            defaultTextStyle: TextStyle(color: Colors.black),
                            disabledTextStyle: TextStyle(color: Colors.black),
                            monthTextStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            radius: 12,
                            tileSize: 42),
                        height: 380,
                        doubleMonth: false,
                        maximumDateRangeLength: 200,
                        minimumDateRangeLength: 3,
                        initialDateRange:
                            DateRange(DateTime(2023), DateTime(2023)),
                        disabledDates: [DateTime(2023, 11, 20)],
                        initialDisplayedDate: DateTime(2023, 11, 20),
                        onDateRangeChanged: (value) {},
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: defaultPadding,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Container(
              height: 300,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.circular(10)),
          //         child: SfCartesianChart(

          //   primaryXAxis: CategoryAxis(),
          //   // Chart title
          //   title: ChartTitle(text: 'Half yearly sales analysis'),
          //   // Enable legend
          //   legend: Legend(isVisible: true),
          //   // Enable tooltip
          //   tooltipBehavior: _tooltipBehavior,

          //   series: <LineSeries<SalesData, String>>[
          //     LineSeries<SalesData, String>(
          //       dataSource:  <SalesData>[
          //         SalesData('Jan', 35),
          //         SalesData('Feb', 28),
          //         SalesData('Mar', 34),
          //         SalesData('Apr', 32),
          //         SalesData('May', 40)
          //       ],
          //       xValueMapper: (SalesData sales, _) => sales.year,
          //       yValueMapper: (SalesData sales, _) => sales.sales,
          //       // Enable data label
          //       dataLabelSettings: DataLabelSettings(isVisible: true)
          //     )
          //   ]
          // ),
            ),
          ),
        ],
      ),
    );
  }
}

DataRow recentFileDataRow(RecentFile fileInfo, int index) {
  return DataRow(
    cells: [
      DataCell(
        Row(
          children: [
            Text(index.toString()),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Text(fileInfo.title!),
            ),
          ],
        ),
      ),
      DataCell(Text(fileInfo.date!)),
      DataCell(Text(fileInfo.date!)),
      DataCell(Text(fileInfo.date!)),
    ],
  );
}

class OrderPointLineData{
  final double x;
  final double y;

  OrderPointLineData({required this.x, required this.y});
  
}

List<OrderPointLineData> get orderPointList{
  final data = <double>[10,30,23,41,581,23];
  return data.mapIndexed(((index, element)=> OrderPointLineData(x: index.toDouble(), y: element))).toList();
}

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}