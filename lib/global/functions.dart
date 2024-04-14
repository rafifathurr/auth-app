import 'package:authentication_app/global/variables.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Response?> doLogin(
  String email,
  String password,
) async {
  response = await dio.post(
    "${baseUrl}login",
    data: {
      'email_or_username': email,
      'password': password,
    },
  );

  return response;
}

Future<Response?> sessionCheck() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString("token") ?? '';
  userData = {};
  response = await dio.post(
    "${baseUrl}user",
    options: Options(
      headers: {
        "Authorization": "Bearer $token",
      },
    ),
  );
  return response;
}

Future<Response?> doLogout() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString("token") ?? '';
  userData = {};
  response = await dio.post(
    "${baseUrl}logout",
    options: Options(
      headers: {
        "Authorization": "Bearer $token",
      },
    ),
  );
  return response;
}

Future<void> clearToken() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('token');
}

Future<void> saveToken(String token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('token', token);
}
