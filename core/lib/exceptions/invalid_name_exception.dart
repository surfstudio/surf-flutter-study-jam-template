class InvalidNameException implements Exception {
  final String message;

  const InvalidNameException(this.message);

  @override
  String toString() => 'InvalidNameException(message: $message)';
}
