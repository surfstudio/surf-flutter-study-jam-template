class InvalidMessageException implements Exception {
  final String message;

  const InvalidMessageException(this.message);

  @override
  String toString() => 'InvalidMessageException(message: $message)';
}
