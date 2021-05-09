class ApiResponse<T> {
  T? data;
  final String message;
  final bool success;
  final Exception? errors;

  ApiResponse({this.data, this.message = '', this.success = false, this.errors});

  @override
  String toString() {
    return "Success : $success\nMessage : $message\nData : $data";
  }
}
