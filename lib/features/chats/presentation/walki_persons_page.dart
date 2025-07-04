import 'package:amnak/core/feature/data/models/chat_persons_wrapper.dart';
import 'package:amnak/core/view/widgets/custom_cubit_builder.dart';
import 'package:amnak/core/view/widgets/language_direction.dart';
import 'package:amnak/export.dart';
import 'package:amnak/features/chats/presentation/chat_persons_cubit.dart';

class WalkiPersonsPage extends StatefulWidget {
  const WalkiPersonsPage({super.key});

  @override
  State<WalkiPersonsPage> createState() => _WalkiPersonsPageState();
}

class _WalkiPersonsPageState extends State<WalkiPersonsPage> {
  final ChatPersonsCubit personsCubit = sl<ChatPersonsCubit>();
  @override
  void initState() {
    super.initState();
    personsCubit.get(context: context);
  }

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
              return Center(
                child: RoundedCornerLoadingButton(
                  text: context.t.startCall,
                  onPressed: () => personsCubit.get(context: context),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
