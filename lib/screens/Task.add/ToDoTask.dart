import 'package:admin/config/get.user.data.dart';
import 'package:admin/screens/Task.add/model/TaskModel.dart';
import 'package:admin/screens/Task.add/model/task.by.user.model.dart';
import 'package:admin/screens/Task.add/model/taskaddmodelres.dart';
import 'package:admin/screens/Task.add/service/TaskApiService.dart';
import 'package:beamer/beamer.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ToDoTask extends StatefulWidget {
  const ToDoTask({Key? key}) : super(key: key);

  @override
  State<ToDoTask> createState() => _ToDoTaskState();
}

class _ToDoTaskState extends State<ToDoTask> {
  Future<TaskListModel>? model;
  Future<TaskByUserModel>? taskbyUsermodel;

  @override
  Widget build(BuildContext context) {
    final taskApiService = Provider.of<TaskApiService>(context);
    final data = UserDataGet();
    data.getUserLocalData();
    model = taskApiService.getTasks();
    taskbyUsermodel = taskApiService.getTasksByUserId(data.id);

    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<TaskListModel>(
        future: model,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 30,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "TODO Task",
                                style: GoogleFonts.poppins(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w500,
                                    color:
                                        const Color.fromARGB(255, 42, 46, 62)),
                              ),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            ListView.builder(
                                itemCount: snapshot.data!.data.length,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: ToDotaskcard(
                                        index: "${index + 1}",
                                        gitSource: snapshot
                                            .data!.data[index].gitSource,
                                        description: snapshot
                                            .data!.data[index].description,
                                        projectToDO: snapshot
                                            .data!.data[index].projectTudo,
                                        taskId: snapshot.data!.data[index].id,
                                        onSubmit: () {
                                          setState(() {
                                            model = taskApiService.getTasks();
                                            taskbyUsermodel = taskApiService
                                                .getTasksByUserId(data.id);
                                          });
                                        },
                                      ),
                                    ),
                                  );
                                })
                          ],
                        ),
                      ),
                      Expanded(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          // SizedBox(
                          //   height: 35,
                          // ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 65,
                              width: 280,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color.fromARGB(255, 42, 46, 62)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            image: DecorationImage(image: NetworkImage('https://squid-app-3-s689g.ondigitalocean.app/${data.image}')),
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "${data.name}",
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 400,
                              decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 42, 46, 62),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "My TODO Task",
                                      style: GoogleFonts.inter(
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  // CompleatTask(),
                                  FutureBuilder<TaskByUserModel>(
                                    future: taskbyUsermodel,
                                    builder: (context, snapshot2) {
                                      if (snapshot.hasData) {
                                        return ListView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            itemCount:
                                                snapshot2.data!.data.length,
                                            itemBuilder: (context, index) {
                                              return CompleatTask(
                                                gitlink: snapshot2
                                                    .data!
                                                    .data[index]
                                                    .taskId
                                                    .gitSource,
                                                id: snapshot2.data!.data[index]
                                                    .taskId.id,
                                                projectName: snapshot2
                                                    .data!
                                                    .data[index]
                                                    .taskId
                                                    .projectTudo, hours: snapshot2.data!.data[index].points.toString(),
                                              );
                                            });
                                      } else if (snapshot.hasError) {
                                        return Text('${snapshot.error}');
                                      }

                                      // By default, show a loading spinner.
                                      return Center(
                                          child:
                                              const CircularProgressIndicator());
                                    },
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ))
                    ],
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }

          // By default, show a loading spinner.
          return Center(child: const CircularProgressIndicator());
        },
      ),
    );
  }
}

class CompleatTask extends StatefulWidget {
  final String id;
  final String projectName;
  final String gitlink;
  final String hours;
  const CompleatTask(
      {Key? key,
      required this.gitlink,
      required this.id,
      required this.hours,
      required this.projectName})
      : super(key: key);

  @override
  State<CompleatTask> createState() => _CompleatTaskState();
}

class _CompleatTaskState extends State<CompleatTask> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 380,
        decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.white)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "${widget.projectName}",
                style: GoogleFonts.inter(fontSize: 14, color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Github source |",
                style: GoogleFonts.inter(fontSize: 14, color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "${widget.gitlink}",
                overflow: TextOverflow.clip,
                style: GoogleFonts.inter(fontSize: 14, color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Hours: ${widget.hours}",
                overflow: TextOverflow.clip,
                style: GoogleFonts.inter(fontSize: 14, color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ToDotaskcard extends StatefulWidget {
  final String index;
  final String gitSource;
  final String projectToDO;
  final String description;
  final String taskId;
  final Function onSubmit;
  const ToDotaskcard(
      {Key? key,
      required this.index,
      required this.onSubmit,
      required this.gitSource,
      required this.description,
      required this.projectToDO,
      required this.taskId})
      : super(key: key);

  @override
  State<ToDotaskcard> createState() => _ToDotaskcardState();
}

class _ToDotaskcardState extends State<ToDotaskcard> {
  final List<String> items = [
    '1',
    '2',
    '3',
    '4',
    '5',
  ];
  String? selectedValue = "1";
  @override
  Widget build(BuildContext context) {
    final taskApiService = Provider.of<TaskApiService>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 200,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color.fromARGB(255, 42, 46, 62),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4),
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.black),
                        child: Center(
                          child: Text(
                            "${widget.index}",
                            style: GoogleFonts.inter(
                                fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  flex: 4,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 30,
                          width: 350,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color.fromARGB(24, 255, 255, 255)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8),
                                      child: Text(
                                        "Hours|",
                                        style: GoogleFonts.inter(
                                            fontSize: 16, color: Colors.white),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: Colors.amber.shade500,
                                    ),
                                    DropdownButtonHideUnderline(
                                      child: DropdownButton2<String>(
                                        isExpanded: true,
                                        hint: Text(
                                          "1",
                                          style: GoogleFonts.inter(
                                              fontSize: 14,
                                              color: Colors.white),
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
                                        buttonStyleData: const ButtonStyleData(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 16),
                                          height: 40,
                                          width: 80,
                                        ),
                                        menuItemStyleData:
                                            const MenuItemStyleData(
                                          height: 40,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                  child: Padding(
                                padding: const EdgeInsets.all(4),
                                child: GestureDetector(
                                  onTap: () async {
                                    final userData = UserDataGet();
                                    userData.getUserLocalData();
                                    TaskAddResponseModel response =
                                        await taskApiService.taskAccept(
                                            TaskAcceptBody(
                                                userId: userData.id,
                                                taskId: widget.taskId,
                                                points: selectedValue!));
                                    widget.onSubmit();
                                  },
                                  child: Container(
                                    height: 25,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.red),
                                    child: Center(
                                      child: Text(
                                        "Accept",
                                        style: GoogleFonts.inter(
                                            fontSize: 12, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ))
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Project Name"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Github Source"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Description"),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("|"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("|"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("|"),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("${widget.projectToDO}"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("${widget.gitSource}"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("${widget.description}"),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
