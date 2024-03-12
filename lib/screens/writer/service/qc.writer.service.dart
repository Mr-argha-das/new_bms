
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
}