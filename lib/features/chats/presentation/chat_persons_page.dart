import 'package:amnak/core/feature/data/models/chat_persons_wrapper.dart';
import 'package:amnak/core/view/widgets/custom_cubit_builder.dart';
import 'package:amnak/core/view/widgets/language_direction.dart';
import 'package:amnak/export.dart';
import 'package:amnak/features/chats/presentation/chat_persons_cubit.dart';

class ChatPersonsPage extends StatefulWidget {
  const ChatPersonsPage({super.key});

  @override
  State<ChatPersonsPage> createState() => _ChatPersonsPageState();
}

class _ChatPersonsPageState extends State<ChatPersonsPage> {
  final ChatPersonsCubit personsCubit = sl<ChatPersonsCubit>()..get();

  @override
  Widget build(BuildContext context) {
    return LanguageDirection(
      child: Scaffold(
        appBar: const CustomAppBar(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomCubitBuilder<ChatPersonsWrapper>(
            cubit: personsCubit,
            tryAgain: () => personsCubit.get(),
            onSuccess: (context, state) {
              return ListView.builder(
                itemCount: state.data?.data?.persons?.length ?? 0,
                itemBuilder: (context, index) {
                  final value = state.data!.data!.persons![index];
                  return Card(
                    child: ListTile(
                      onTap: () {
                        context.pushNamed(Routes.chatDetails, extra: {
                          'person': value,
                        });
                      },
                      title: Text(value.name ??
                          '${value.personFirstName} ${value.personLastName}'),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
