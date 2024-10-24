class ApiResponse<T> {
  final String message;
  final String error;
  final T result; // Campo genérico que puede ser cualquier clase
  final int statusCode;

  ApiResponse({
    required this.message,
    required this.error,
    required this.result,
    required this.statusCode,
  });

  // Método para convertir JSON en una instancia de ApiResponse
  factory ApiResponse.fromJson(
      Map<String, dynamic> json, T Function(Map<String, dynamic>) fromJsonT) {
    return ApiResponse(
      message: json['message'],
      error: json['error'],
      result: fromJsonT(
          json['result']), // Usa la función genérica para mapear el 'result'
      statusCode: json['statusCode'],
    );
  }
}
