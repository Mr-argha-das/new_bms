
import 'package:admin/screens/writer/model/qc.writer.add.model.dart';
import 'package:admin/screens/writer/model/qc.writer.list.model.dart';
import 'package:admin/screens/writer/model/qc.writer.res.model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

part 'qc.writer.service.g.dart';
@RestApi(baseUrl: "https://squid-app-3-s689g.ondigitalocean.app")
abstract class QcWriterService{
  factory QcWriterService(Dio dio) = _QcWriterService;

  @GET('/qc-writer-list')
  Future<QcwritterListModel> getQcWriterData();
  @POST('/qc-writer-user-create')
  Future<QcwritterResModel> adQcWriter(@Body() QcwritteraddModel body);
  @PUT('/qc-writer-user-update/{id}')
  Future<QcwritterResModel> updateQcWrite(@Path('id') String id, @Body() QcwritterUpdateModel body);
}


class QcwritterUpdateModel {
    String roles;
    String allocationId;
    String name;
    String email;
    String number;
 

    QcwritterUpdateModel({
        required this.roles,
        required this.allocationId,
        required this.name,
        required this.email,
        required this.number,

    });

    factory QcwritterUpdateModel.fromJson(Map<String, dynamic> json) => QcwritterUpdateModel(
        roles: json["roles"],
        allocationId: json["allocationId"],
        name: json["name"],
        email: json["email"],
        number: json["number"],

    );

    Map<String, dynamic> toJson() => {
        "roles": roles,
        "allocationId": allocationId,
        "name": name,
        "email": email,
        "number": number,

    };
}
