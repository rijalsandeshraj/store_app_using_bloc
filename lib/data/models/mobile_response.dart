class MobileResponse<t> {
  int? status;
  String? message;
  t? data;

  MobileResponse.fromJson(
      Map<String, dynamic> json, Function(dynamic json) parseData) {
    status = json['Status'];
    message = json['Message'];
    try {
      data = parseData(json["Data"]);
    } catch (e) {
      data = json["Data"];
    } finally {}
  }
}
