import 'package:amnak/core/feature/data/models/instructions_wrapper.dart';
import 'package:amnak/core/view/widgets/custom_cubit_builder.dart';
import 'package:amnak/core/view/widgets/language_direction.dart';
import 'package:amnak/export.dart';
import 'package:amnak/features/notifications/presentation/instructions_cubit.dart';

class InstructionsPage extends StatefulWidget {
  const InstructionsPage({super.key});

  @override
  State<InstructionsPage> createState() => _InstructionsPageState();
}

class _InstructionsPageState extends State<InstructionsPage> {
  final InstructionsCubit cubit = sl<InstructionsCubit>()..get();
  @override
  Widget build(BuildContext context) {
    return LanguageDirection(
      child: Scaffold(
        appBar: AppBar(title: Text(context.t.instructions), centerTitle: true),
        body: CustomCubitBuilder<InstructionsWrapper>(
          cubit: cubit,
          tryAgain: () => cubit.get(),
          onSuccess: (context, state) {
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Text(
                      state.data!.data?.companyInstructions.toString() ?? "",
                      style: Theme.of(context).textTheme.displaySmall),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
