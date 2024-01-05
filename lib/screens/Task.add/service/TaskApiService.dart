import 'package:admin/screens/Task.add/model/TaskModel.dart';
import 'package:admin/screens/Task.add/model/task.by.user.model.dart';
import 'package:admin/screens/Task.add/model/task.creat.model.dart';
import 'package:admin/screens/Task.add/model/taskaddmodelres.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:retrofit/retrofit.dart';
part 'TaskApiService.g.dart';

@RestApi(baseUrl: 'https://squid-app-3-s689g.ondigitalocean.app')
abstract class TaskApiService {
  factory TaskApiService(Dio dio) = _TaskApiService;

  @GET('/task-get-list')
  Future<TaskListModel> getTasks();
  @POST('/user-task-Assign')
  Future<TaskAddResponseModel> taskAccept(
      @Body() TaskAcceptBody taskAcceptBody);
  @GET('/task-get-by/userId/{id}')
  Future<TaskByUserModel> getTasksByUserId(@Path('id') String id);
  @POST('/task-create')
  Future<TaskCreateResponseModel> creatTask(@Body() TaskCreatBody body);
}


// To parse this JSON data, do
//
//     final taskCreatBody = taskCreatBodyFromJson(jsonString);



TaskCreatBody taskCreatBodyFromJson(String str) => TaskCreatBody.fromJson(json.decode(str));

String taskCreatBodyToJson(TaskCreatBody data) => json.encode(data.toJson());

class TaskCreatBody {
    String gitSource;
    String projectTudo;
    String teamId;
    String description;

    TaskCreatBody({
        required this.gitSource,
        required this.projectTudo,
        required this.teamId,
        required this.description,
    });

    factory TaskCreatBody.fromJson(Map<String, dynamic> json) => TaskCreatBody(
        gitSource: json["gitSource"],
        projectTudo: json["projectTudo"],
        teamId: json["teamId"],
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "gitSource": gitSource,
        "projectTudo": projectTudo,
        "teamId": teamId,
        "description": description,
    };
}



TaskAcceptBody taskAcceptBodyFromJson(String str) =>
    TaskAcceptBody.fromJson(json.decode(str));

String taskAcceptBodyToJson(TaskAcceptBody data) => json.encode(data.toJson());

class TaskAcceptBody {
  String userId;
  String taskId;
  String points;

  TaskAcceptBody({
    required this.userId,
    required this.taskId,
    required this.points,
  });

  factory TaskAcceptBody.fromJson(Map<String, dynamic> json) => TaskAcceptBody(
        userId: json["userId"],
        taskId: json["taskId"],
        points: json["Points"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "taskId": taskId,
        "Points": points,
      };
}
