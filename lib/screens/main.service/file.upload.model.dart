import 'dart:convert';

FileUploadResponse fileUploadResponseFromJson(String str) => FileUploadResponse.fromJson(json.decode(str));

String fileUploadResponseToJson(FileUploadResponse data) => json.encode(data.toJson());

class FileUploadResponse {
    String data;

    FileUploadResponse({
        required this.data,
    });

    factory FileUploadResponse.fromJson(Map<String, dynamic> json) => FileUploadResponse(
        data: json["data"],
    );

    Map<String, dynamic> toJson() => {
        "data": data,
    };
}
