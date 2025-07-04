import 'package:amnak/core/feature/data/models/chat_persons_wrapper.dart';
import 'package:amnak/export.dart';
import 'package:amnak/features/chats/domain/usecases/usecases.dart';

class ChatConversationsCubit extends Cubit<BaseState<ChatPersonsWrapper>> {
  ChatConversationsCubit({
    required this.useCase,
  }) : super(const BaseState());
  final ChatsUseCase useCase;

  Future get() async {
    emit(state.copyWith(status: RxStatus.loading));
    final response = await useCase.getConversations();

    return response.fold((l) {
      emit(state.copyWith(status: RxStatus.error, errorMessage: l.message));
      showSimpleDialog(text: l.message.toString());
    }, (r) {
      if (r.data != null) {
        emit(state.copyWith(status: RxStatus.success, data: r));
      } else
        emit(state.copyWith(
            status: RxStatus.error, errorMessage: r.messages.toString()));
      return r;
    });
  }
}
