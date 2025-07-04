import 'package:amnak/core/feature/data/models/chat_details_wrapper.dart';
import 'package:amnak/core/feature/data/models/chat_persons_wrapper.dart';
import 'package:amnak/core/feature/domain/repositories/repositories.dart';

import '../../../../export.dart';

class ChatsUseCase {
  final Repository repository;

  ChatsUseCase({required this.repository});

  Future<Either<Failure, ChatPersonsWrapper>> getPersons(
      {int pageNum = 1}) async {
    return (repository.get('persons_in_same_project')).then((value) =>
        value.map((r) =>
            r == null ? ChatPersonsWrapper() : ChatPersonsWrapper.fromJson(r)));
  }

  Future<Either<Failure, ChatDetailsWrapper>> getChatDetails(
      String senderId, String type) async {
    return (repository
            .get('Specific_conversation?sender_id=$senderId&sender_type=$type'))
        .then((value) => value.map((r) =>
            r == null ? ChatDetailsWrapper() : ChatDetailsWrapper.fromJson(r)));
  }

  Future<Either<Failure, ServerResponse>> sendMessage(Map data) async {
    return (repository.post('send_message', data)).then((value) => value
        .map((r) => r == null ? ServerResponse() : ServerResponse.fromJson(r)));
  }

  Future<Either<Failure, ChatPersonsWrapper>> getConversations(
      {int pageNum = 1}) async {
    return (repository.get('conversations')).then((value) => value.map((r) =>
        r == null ? ChatPersonsWrapper() : ChatPersonsWrapper.fromJson(r)));
  }

  Future<Either<Failure, ServerResponse>> getChatToken(String channelId) async {
    return (repository.get('generate_agora_token?channel_name=$channelId'))
        .then((value) => value.map(
            (r) => r == null ? ServerResponse() : ServerResponse.fromJson(r)));
  }
}
