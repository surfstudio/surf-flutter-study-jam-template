import 'package:cloud_firestore/cloud_firestore.dart';

class MessageFirebaseDto {
  static const String authorNameKey = 'authorName';
  static const String messageKey = 'message';
  static const String createdKey = 'created';
  static const String geolocationKey = 'geolocation';

  final String authorName;
  final String message;
  final DateTime created;
  final GeoPoint? geolocation;

  MessageFirebaseDto({
    required this.authorName,
    required this.message,
    required this.created,
    required this.geolocation,
  });

  Map<String, dynamic> toMap() {
    return {
      authorNameKey: authorName,
      messageKey: message,
      createdKey: created.millisecondsSinceEpoch,
    };
  }

  factory MessageFirebaseDto.fromMap(Map<String, dynamic> map) {
    return MessageFirebaseDto(
      authorName: map[authorNameKey] as String,
      message: map[messageKey] as String,
      created: (map[createdKey] as Timestamp).toDate(),
      geolocation: map[geolocationKey] as GeoPoint?,
    );
  }

  @override
  String toString() {
    return 'MessageFirebaseDto(authorName: $authorName, message: $message, created: $created, geolocation: $geolocation)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MessageFirebaseDto &&
        other.authorName == authorName &&
        other.message == message &&
        other.created == created;
  }

  @override
  int get hashCode => authorName.hashCode ^ message.hashCode ^ created.hashCode;

  MessageFirebaseDto copyWith({
    String? authorName,
    String? message,
    DateTime? created,
    GeoPoint? geolocation,
  }) {
    return MessageFirebaseDto(
      authorName: authorName ?? this.authorName,
      message: message ?? this.message,
      created: created ?? this.created,
      geolocation: geolocation ?? this.geolocation,
    );
  }
}
