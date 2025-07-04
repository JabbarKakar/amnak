import 'package:amnak/core/feature/data/models/chat_details_wrapper.dart';
import 'package:amnak/core/feature/data/models/chat_persons_wrapper.dart';
import 'package:amnak/core/view/widgets/custom_cubit_builder.dart';
import 'package:amnak/core/view/widgets/language_direction.dart';
import 'package:amnak/export.dart';
import 'package:amnak/features/chats/presentation/chat_bubble.dart';
import 'package:amnak/features/chats/presentation/chat_details_cubit.dart';

class ChatDetailsPage extends StatefulWidget {
  const ChatDetailsPage({super.key, required this.personModel});
  final PersonModel personModel;

  @override
  State<ChatDetailsPage> createState() => _ChatDetailsPageState();
}

class _ChatDetailsPageState extends State<ChatDetailsPage> {
  final ChatDetailsCubit detailsCubit = sl<ChatDetailsCubit>();
  final textController = TextEditingController();
  @override
  void initState() {
    super.initState();
    detailsCubit.get(
        widget.personModel.id!.toString(), widget.personModel.type ?? 'Person');
  }

  @override
  Widget build(BuildContext context) {
    return LanguageDirection(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.personModel.personFirstName ?? '',
              style: Theme.of(context).textTheme.labelLarge),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: CustomCubitBuilder<List<MessageModel>>(
                  tryAgain: () => detailsCubit.get(
                      widget.personModel.id!.toString(),
                      widget.personModel.type ?? 'Person'),
                  cubit: detailsCubit,
                  onSuccess: (context, state) {
                    return ListView.separated(
                      itemCount: state.data?.length ?? 0,
                      separatorBuilder: (BuildContext context, int index) =>
                          16.heightBox,
                      itemBuilder: (context, index) {
                        final item = state.data?[index];
                        return item == null
                            ? Container()
                            : ChatBubble(message: item);
                      },
                    );
                  },
                ),
              ),
              Container(
                color: kBGGreyColor,
                height: 80,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: TextInput(
                            controller: textController,
                            hint: 'Type a message',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: IconButton(
                          icon: const Icon(Icons.send),
                          onPressed: () async {
                            await detailsCubit.sendMessage({
                              'content': textController.text,
                              'recipient_id': widget.personModel.id!.toString(),
                              'recipient_type':
                                  widget.personModel.type ?? 'Person'
                            });
                            textController.clear();
                          },
                        ),
                      ),
                      16.widthBox,
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
