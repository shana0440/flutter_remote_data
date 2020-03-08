class NotMatchedStateException implements Exception {
  final String message;

  NotMatchedStateException([this.message]);

  @override
  String toString() => "NotMatchedResultError: $message";
}
