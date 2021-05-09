// import 'package:http_interceptor/http_interceptor.dart';
// import 'package:water_alliance/providers/app_state_provider.dart';

// class NetworkInterceptor implements InterceptorContract {
//   @override
//   Future<RequestData> interceptRequest({RequestData data}) async {
//     print(data.url);
//     AuthState _authState = AuthState();
//     print(_authState?.token?.token);
//     if (_authState.token != null) {
//       data.headers['Authorization'] = "Bearer ${_authState.token.token}";
//     }
//     // int shouldRefresh =
//     //     DateTime.parse("time to expire").compareTo(DateTime.now());
//     // if (shouldRefresh > 0) {
//     //   print("Still Acive");
//     //   data.headers['Authorization'] = "Bearer old access token";
//     //   return data;
//     // } else {
//     //   String newToekn = "";
//     //   newToekn = 'get new token';
//     //   print("New token Updated");
//     //   data.headers['Authorization'] = "Bearer $newToekn";
//     //   return data;
//     // }

//     return data;
//   }

//   @override
//   Future<ResponseData> interceptResponse({ResponseData data}) async {
//     print("Response Code => ${data.statusCode}");
//     // print("Response body => ${data.body}");
//     return data;
//   }
// }
