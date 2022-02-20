import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/contracts/repositories/chat_repository.dart';
import 'package:core/exceptions/invalid_message_exception.dart';
import 'package:core/exceptions/invalid_name_exception.dart';
import 'package:core/models/dtos/firebase/message_firebase_dto.dart';
import 'package:core/models/dtos/geolocation.dart';
import 'package:core/models/dtos/message/chat_message_dto.dart';
import 'package:core/models/dtos/message/chat_message_geolocation_dto.dart';
import 'package:core/models/dtos/user/chat_user_dto.dart';
import 'package:core/models/dtos/user/chat_user_local_dto.dart';

class ChatRepositoryFirebase implements ChatRepository {
  static const String _messagesCollectionKey = 'messages';
  static const int _messagesLimit = 200;

  final FirebaseFirestore _firebaseClient;

  ChatRepositoryFirebase(this._firebaseClient);

  var _savedLocalName = '';

  @override
  Future<List<ChatMessageDto>> get messages async {
    final result = await _firebaseClient
        .collection(_messagesCollectionKey)
        .limit(_messagesLimit)
        .orderBy('created')
        .get();

    return result.docs.map(_parseFirebaseDataToLocal).toList();
  }

  @override
  Future<List<ChatMessageDto>> sendMessage(
    String nickname,
    String message,
  ) async {
    _validateName(nickname);
    _validateMessage(message);

    _savedLocalName = nickname;

    await _firebaseClient.collection(_messagesCollectionKey).add({
      MessageFirebaseDto.authorNameKey: nickname,
      MessageFirebaseDto.messageKey: message,
      MessageFirebaseDto.createdKey: FieldValue.serverTimestamp(),
    });

    return messages;
  }

  @override
  Future<List<ChatMessageDto>> sendGeolocationMessage({
    required String nickname,
    required ChatGeolocationDto location,
    String? message,
  }) async {
    _validateName(nickname);
    if (message != null) _validateMessage(message);

    _savedLocalName = nickname;

    await _firebaseClient.collection(_messagesCollectionKey).add({
      MessageFirebaseDto.authorNameKey: nickname,
      MessageFirebaseDto.messageKey: message ?? '',
      MessageFirebaseDto.createdKey: FieldValue.serverTimestamp(),
      MessageFirebaseDto.geolocationKey: GeoPoint(
        location.latitude,
        location.longitude,
      ),
    });

    return messages;
  }

  void _validateName(String name) {
    if (name.isEmpty) {
      throw const InvalidNameException('Name cannot be empty!');
    }

    if (name.length > ChatRepository.maxNameLength) {
      throw const InvalidNameException(
          'Name cannot contain more than ${ChatRepository.maxNameLength} symbols');
    }
  }

  void _validateMessage(String message) {
    if (message.isEmpty) {
      throw const InvalidMessageException('Message cannot be empty!');
    }

    if (message.length > ChatRepository.maxMessageLength) {
      throw const InvalidNameException(
          'Message cannot contain more than ${ChatRepository.maxMessageLength} symbols');
    }
  }

  ChatMessageDto _parseFirebaseDataToLocal(
    QueryDocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final parsedData = MessageFirebaseDto.fromMap(snapshot.data());

    final ChatUserDto author;
    if (parsedData.authorName == _savedLocalName) {
      author = ChatUserLocalDto(name: parsedData.authorName);
    } else {
      author = ChatUserDto(name: parsedData.authorName);
    }

    final geolocation = parsedData.geolocation;
    if (geolocation != null) {
      return ChatMessageGeolocationDto(
        author: author,
        location: ChatGeolocationDto(
          latitude: geolocation.latitude,
          longitude: geolocation.longitude,
        ),
        message: parsedData.message,
        createdDate: parsedData.created,
      );
    }

    return ChatMessageDto(
      author: author,
      message: parsedData.message,
      createdDateTime: parsedData.created,
    );
  }
}
