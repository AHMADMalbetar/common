import 'dart:convert';

CommonModel commonResponseFromJson(str) => CommonModel.fromJson(str);

String commonResponseToJson(CommonModel data) => json.encode(data.toJson());

class CommonModel {
  CommonModel({
    this.result,
    this.message,
  });

  bool? result;
  String? message;

  factory CommonModel.fromJson(Map<String, dynamic> json) => CommonModel(
    result: json["result"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "result": result,
    "message": message,
  };
}