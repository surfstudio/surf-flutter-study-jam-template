/// Data transfer object representing geolocation point.
class ChatGeolocationDto {
  /// Latitude, in degrees.
  final double latitude;

  /// Longitude, in degrees.
  final double longitude;

  ChatGeolocationDto({
    required this.latitude,
    required this.longitude,
  });

  @override
  String toString() =>
      'ChatGeolocationDto(latitude: $latitude, longitude: $longitude)';
}
