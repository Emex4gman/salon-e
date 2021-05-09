// import 'dart:convert';
// import 'dart:io';

// import 'package:http/http.dart';
// import 'package:http_interceptor/http_interceptor.dart';
// import 'package:water_alliance/model/api_response.dart';
// import 'interceptor.dart';

// class NetworkService {
//   Client _appCLient;

//   //  = HttpClientWithInterceptor.build(
//   //   interceptors: [NetworkInterceptor()],
//   // );

//   NetworkService({Client client})
//       : _appCLient = client ??
//             HttpClientWithInterceptor.build(
//               interceptors: [NetworkInterceptor()],
//             );

//   final String baseUrl = "https://wah20.prodevs.io/api/";
//   static String _formartErrorTxt =
//       "Apologies, someone forgot to fix a bug, rest assured, we will get to bottom of this";
//   Future<ApiResponse> getUrl(
//     String uri, {
//     Map<String, String> header,
//   }) async {
//     try {
//        final res = await _appCLient.get(baseUrl + uri, headers: header);

//       return returnResponse(res);
//     } on SocketException catch (e) {
//       return ApiResponse(data: null, message: e.message, success: false);
//     } on FormatException {
//       return ApiResponse(data: null, message: _formartErrorTxt, success: false);
//     } catch (e) {
//       return ApiResponse(data: null, message: e.toString(), success: false);
//     }
//   }

//   Future<ApiResponse> post(
//     String uri, {
//     Map<String, String> header,
//     Map<String, dynamic> body,
//   }) async {
//     try {
//       //  final _body = jsonEncode(body);
//        final res =
//           await _appCLient.post(baseUrl + uri, headers: header, body: body);
//       return returnResponse(res);
//     } on SocketException catch (e) {
//       return ApiResponse(data: null, message: e.message, success: false);
//     } on FormatException {
//       return ApiResponse(data: null, message: _formartErrorTxt, success: false);
//     } catch (e) {
//       return ApiResponse(data: null, message: e.toString(), success: false);
//     }
//   }

//   Future<ApiResponse> delete(
//     String uri, {
//     Map<String, String> header,
//   }) async {
//     try {
//        final res = await _appCLient.delete(baseUrl + uri, headers: header);
//       return returnResponse(res);
//     } on SocketException catch (e) {
//       return ApiResponse(data: null, message: e.message, success: false);
//     } on FormatException {
//       return ApiResponse(data: null, message: _formartErrorTxt, success: false);
//     } catch (e) {
//       return ApiResponse(data: null, message: e.toString(), success: false);
//     }
//   }

//   Future<ApiResponse> patch(
//     String uri, {
//     Map<String, String> header,
//     Map<String, dynamic> body,
//   }) async {
//     try {
//        final _body = jsonEncode(body);

//        final res =
//           await _appCLient.patch(baseUrl + uri, headers: header, body: _body);
//       return returnResponse(res);
//     } on SocketException catch (e) {
//       return ApiResponse(data: null, message: e.message, success: false);
//     } on FormatException {
//       return ApiResponse(data: null, message: _formartErrorTxt, success: false);
//     } catch (e) {
//       return ApiResponse(data: null, message: e.toString(), success: false);
//     }
//   }

//   Future<ApiResponse> put(
//     String uri, {
//     Map<String, String> header,
//     Map<String, dynamic> body,
//   }) async {
//     try {
//        final _body = jsonEncode(body);
//        final res =
//           await _appCLient.put(baseUrl + uri, headers: header, body: _body);
//       return returnResponse(res);
//     } on SocketException catch (e) {
//       return ApiResponse(data: null, message: e.message, success: false);
//     } on FormatException {
//       return ApiResponse(data: null, message: _formartErrorTxt, success: false);
//     } catch (e) {
//       return ApiResponse(data: null, message: e.toString(), success: false);
//     }
//   }
// }
