class BasicResponse {
  final bool status;
  final String message;

  BasicResponse({
    this.status,
    this.message,
  });

  factory BasicResponse.fromJson(Map<String, dynamic> json) {
    return BasicResponse(
      status: json['status'],
      message: json['message'],
    );
  }
}
