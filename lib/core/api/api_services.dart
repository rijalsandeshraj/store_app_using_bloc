import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;

class ApiServices {
  var client = http.Client();

  Future<dynamic> get(String url, {var headers}) async {
    try {
      var response = await client.get(Uri.parse(url), headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept-Encoding': 'gzip',
      }).timeout(
        const Duration(seconds: 15),
        onTimeout: () async {
          var result = await InternetAddress.lookup(url);
          if (result.isEmpty || result[0].rawAddress.isEmpty) {
            throw SocketException;
          }
          throw TimeoutException;
        },
      );
      if (response.statusCode == HttpStatus.ok) {
        return jsonDecode(response.body);
      }
    } on SocketException {
      // showCustomSnackBar('Server Connection Failed!', taskSuccess: false);
    } on TimeoutException {
      // showCustomSnackBar('Timeout Exception', 'Connection Timed Out',
      //     taskSuccess: false);
    } catch (e) {
      log('Error: ${e.toString()}');
    }
  }

  Future<Map<String, dynamic>> post(String url, Map<String, dynamic> json,
      {var headers, var token}) async {
    try {
      var response = await client.post(Uri.parse(url),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Accept-Encoding': 'gzip',
          },
          body: jsonEncode(json));
      if (response.statusCode == HttpStatus.ok) {
        return jsonDecode(response.body);
      }
    } on SocketException {
      // showCustomSnackBar('Connection Error',
      //     'Server Connection Failed! Connect to the Internet',
      //     taskSuccess: false);
    } on TimeoutException {
      // showCustomSnackBar('Timeout Exception', 'Connection Timed Out',
      //     taskSuccess: false);
    } catch (e) {
      log('Error: ${e.toString()}');
    }
    return {};
  }
}
