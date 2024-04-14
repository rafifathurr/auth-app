import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

// LOGGER PRINT
var logger = Logger();

// DIO VARIABLE
BaseOptions options = BaseOptions(
  connectTimeout: const Duration(seconds: 30),
  receiveTimeout: const Duration(seconds: 30),
);
final Dio dio = Dio(options);
Response? response;

// BASE URL VARIABLES
String baseUrl = "https://absen.maxxima-products.id/attendance-service/api/";

// SIZE GLOBAL
double heightWidget = 0.0;
double widthWidget = 0.0;

// JSON ARRAY USER DATA
Map<String, dynamic> userData = {};
