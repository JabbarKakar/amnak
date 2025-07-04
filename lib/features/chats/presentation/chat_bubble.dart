import 'package:amnak/core/feature/data/models/chat_details_wrapper.dart';
import 'package:amnak/core/feature/data/models/login_wrapper.dart';
import 'package:amnak/core/view/widgets/avatar.dart';
import 'package:amnak/export.dart';

class ChatBubble extends StatefulWidget {
  final MessageModel message;

  const ChatBubble({
    super.key,
    required this.message,
  });

  @override
  State<ChatBubble> createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  late bool isSender;
  @override
  void initState() {
    super.initState();
    isSender = UserModel.fromJson(sl<GetStorage>().read(kUser)!).id ==
        widget.message.senderId;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: isSender ? Alignment.bottomRight : Alignment.bottomLeft,
      children: [
        Align(
          alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            decoration: BoxDecoration(
              color: isSender ? kPrimaryColor : kGreyShade,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(15),
                topRight: const Radius.circular(15),
                bottomLeft: isSender
                    ? const Radius.circular(15)
                    : const Radius.circular(0),
                bottomRight: isSender
                    ? const Radius.circular(0)
                    : const Radius.circular(15),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.message.content.toString(),
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                Text(
                  widget.message.createdAt.toFormattedDateTime(),
                  style: const TextStyle(
                    color: Colors.white54,
                  ),
                ),
              ],
            ),
          ),
        ),
        // Align(
        //   alignment: isSender ? Alignment.bottomRight : Alignment.bottomLeft,
        //   child: Avatar(
        //     item: widget.message.senderId.toString(),
        //     radius: 12,
        //     fontSize: 16,
        //   ),
        // ),
      ],
    );
  }
}
