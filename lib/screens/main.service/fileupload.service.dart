
import 'dart:developer';
import 'dart:io';

import 'package:dio/io.dart';
import 'package:http/http.dart'as http;
import 'package:admin/screens/main.service/file.upload.model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
part 'fileupload.service.g.dart';

@RestApi(baseUrl: "https://whale-app-9emyb.ondigitalocean.app")
abstract class FileUploadService{
  factory FileUploadService(Dio dio) = _FileUploadService;
  @POST('/upload')
  @MultiPart()
  Future<FileUploadResponse> upload({
  @Part() required Map<String, dynamic> data,
  });
}

// class FileUploadUsingHttp{
//   static fileUpload({required String myile, required String bucketName})async{
//     var request = http.MultipartRequest("POST", Uri.parse("https://whale-app-9emyb.ondigitalocean.app/upload"));
//     request.fields["bucketName"] = "ahec";
//     request.files.add(await http.MultipartFile.fromPath('images', myile));
//     request.send().then((value) {
//     http.Response.fromStream(value).then((data) {
//      log(data.body.toString());
//     });
//     });
//   }
// }