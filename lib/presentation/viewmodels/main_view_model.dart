import 'package:core/contracts/repositories/chat_repository.dart';
import 'package:core/models/dtos/message/chat_message_dto.dart';
import 'package:surf_practice_chat_flutter/presentation/viewmodels/base_view_model.dart';
import 'package:surf_practice_chat_flutter/presentation/viewmodels/states/main_view_state.dart';

class MainViewModel extends BaseViewModel {
  late MainViewState _state;
  final ChatRepository _repository;

  MainViewModel(this._repository) {
    _state = MainViewState(items: [], isLoadingSendMessage: false);
  }

  List<ChatMessageDto> getItems() {
    return _state.items;
  }

  bool hasItems() {
    return _state.items.isNotEmpty;
  }

  bool inProgress() {
    return _state.isLoading;
  }

  bool sendMessageInProgress() {
    return _state.isLoadingSendMessage;
  }

  Future<void> updateChatListAsync() async {
    try {
      _state = _state.copyWith(items: _state.items, isLoading: true);
      notifyListeners();
      var messages = await _repository.messages;
      _state = _state.copyWith(items: messages, isLoading: false);
    } catch (e) {
      print(e);
      _state = _state.copyWith(items: _state.items, isLoading: false);
    } finally {
      notifyListeners();
    }
  }

  Future<void> sendMessage(String user, String message) async {
    try {
      _state = _state.copyWith(items: _state.items, isLoadingSendMessage: true);
      notifyListeners();
      var result = await _repository.sendMessage(user, message);
      _state = _state.copyWith(items: result, isLoadingSendMessage: false);
    } catch (e) {
      _state =
          _state.copyWith(items: _state.items, isLoadingSendMessage: false);
    } finally {
      _state =
          _state.copyWith(items: _state.items, isLoadingSendMessage: false);
      notifyListeners();
    }
  }
}
