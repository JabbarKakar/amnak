import 'package:amnak/core/feature/data/models/chat_persons_wrapper.dart';
import 'package:amnak/features/chats/domain/usecases/usecases.dart';

import '../../../../../../../export.dart';

class ChatPersonsCubit extends Cubit<BaseState<ChatPersonsWrapper>> {
  ChatPersonsCubit({
    required this.useCase,
  }) : super(const BaseState());
  final ChatsUseCase useCase;

  Future get({BuildContext? context}) async {
    emit(state.copyWith(status: RxStatus.loading));
    final response = await useCase.getPersons();

    return response.fold((l) {
      emit(state.copyWith(status: RxStatus.error, errorMessage: l.message));
      showSimpleDialog(text: l.message.toString());
    }, (r) {
      if (r.data != null) {
        if (context != null)
          getToken(context, r.data!.projectId.toString()).then((value) =>
              emit(state.copyWith(status: RxStatus.success, data: r)));
        else
          emit(state.copyWith(status: RxStatus.success, data: r));
      } else
        emit(state.copyWith(
            status: RxStatus.error, errorMessage: r.messages.toString()));
      return r;
    });
  }

  Future getToken(BuildContext context, String channelName) async {
    final response = await useCase.getChatToken(channelName);

    return response.fold((l) {}, (r) {
      if (r.data != null) {
        context.pushNamed(Routes.walki, extra: {
          'token': r.data!['token'],
          'channel': channelName,
        });
      } else {
        showSimpleDialog(text: r.message.toString());
      }
      return r;
    });
  }
}
