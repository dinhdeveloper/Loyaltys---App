class ApiResponse<T> {
  final int resultCode;
  final int codeStatus;
  final String description;
  final T body;

  ApiResponse({
    required this.resultCode,
    required this.codeStatus,
    required this.description,
    required this.body,
  });

  factory ApiResponse.fromJson(
      Map<String, dynamic> json,
      T Function(dynamic) fromJsonT,
      ) {
    return ApiResponse(
      resultCode: json['resultCode'] as int,
      codeStatus: json['codeStatus'] as int,
      description: json['description'] as String,
      body: fromJsonT(json['body']),
    );
  }
}