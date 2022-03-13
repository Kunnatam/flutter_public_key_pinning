import 'dart:convert';

Evaluation evaluationFromJson(String str) => Evaluation.fromJson(json.decode(str));

String evaluationToJson(Evaluation data) => json.encode(data.toJson());

/// An evaluation pairing [fileName].der to the evaluating host server with the given [hostName].
class Evaluation {
  Evaluation({
    required this.hostName,
    required this.fileName,
  });

  String hostName;
  String fileName;

  factory Evaluation.fromJson(Map<String, dynamic> json) => Evaluation(
        hostName: json["hostName"],
        fileName: json["fileName"],
      );

  Map<String, dynamic> toJson() => {
        "hostName": hostName,
        "fileName": fileName,
      };
}
