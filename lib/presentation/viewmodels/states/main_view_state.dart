import 'package:core/models/dtos/message/chat_message_dto.dart';
import 'package:surf_practice_chat_flutter/presentation/viewmodels/states/base_state.dart';

class MainViewState extends BaseState {
  final List<ChatMessageDto> items;
  final bool isLoadingSendMessage;

  MainViewState({
    required this.items,
    bool isLoading = false,
    required this.isLoadingSendMessage,
    String error = "",
  }) : super(isLoading: isLoading, error: error);

  MainViewState copyWith({
    List<ChatMessageDto>? items,
    String? error,
    bool? isLoading,
    bool? isLoadingSendMessage,
  }) {
    return MainViewState(
        items: items ?? this.items,
        error: error ?? this.error,
        isLoadingSendMessage: isLoadingSendMessage ?? this.isLoadingSendMessage,
        isLoading: isLoading ?? this.isLoading);
  }
}
