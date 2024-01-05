import 'package:admin/screens/Task.add/model/TaskModel.dart';
import 'package:admin/screens/Task.add/model/task.by.user.model.dart';
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
