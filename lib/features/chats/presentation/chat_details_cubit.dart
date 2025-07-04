import 'package:amnak/core/feature/data/models/chat_details_wrapper.dart';
import 'package:amnak/features/chats/domain/usecases/usecases.dart';

import '../../../../../../../export.dart';

class ChatDetailsCubit extends Cubit<BaseState<List<MessageModel>>> {
  ChatDetailsCubit({
    required this.useCase,
  }) : super(const BaseState());
  final ChatsUseCase useCase;

  Future get(String senderId, String type) async {
    emit(state.copyWith(status: RxStatus.loading));
    final response = await useCase.getChatDetails(senderId, type);
    return response.fold((l) {
      emit(state.copyWith(status: RxStatus.error, errorMessage: l.message));
      showSimpleDialog(text: l.message.toString());
    }, (r) {
      if (r.data != null) {
        if (r.data!.isNotEmpty) {
          emit(state.copyWith(status: RxStatus.success, data: r.data));
        } else
          emit(state.copyWith(status: RxStatus.empty, data: []));
      } else
        emit(state.copyWith(
            status: RxStatus.error, errorMessage: r.messages.toString()));
      return r;
    });
  }

  Future sendMessage(Map data) async {
    emit(state.copyWith(status: RxStatus.loading));
    final response = await useCase.sendMessage(data);
    return response.fold((l) {
      emit(state.copyWith(status: RxStatus.error, errorMessage: l.message));
      showSimpleDialog(text: l.message.toString());
    }, (r) {
      if (r.data != null) {
        get(data['recipient_id'], 'recipient_type');
      }
      return r;
    });
  }
}
