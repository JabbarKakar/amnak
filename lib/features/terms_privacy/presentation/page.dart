import 'package:flutter_html/flutter_html.dart';
import 'package:amnak/core/view/widgets/custom_cubit_builder.dart';
import 'package:amnak/core/view/widgets/language_direction.dart';
import 'package:amnak/export.dart';
import 'package:amnak/features/terms_privacy/presentation/cubit.dart';

class TermsPrivacyPage extends StatefulWidget {
  const TermsPrivacyPage({super.key, required this.type});
  final String type;

  @override
  State<TermsPrivacyPage> createState() => _TermsPrivacyPageState();
}

class _TermsPrivacyPageState extends State<TermsPrivacyPage> {
  final TermsCubit cubit = sl<TermsCubit>();
  @override
  void initState() {
    super.initState();
    cubit.get(widget.type);
  }

  @override
  Widget build(BuildContext context) {
    return LanguageDirection(
      child: Scaffold(
        appBar: const CustomAppBar(),
        body: CustomCubitBuilder<String>(
          cubit: cubit,
          tryAgain: () => cubit.get(widget.type),
          onSuccess: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(0),
              child: SingleChildScrollView(
                child: Html(
                  data: state.data,
                  style: {
                    "body": Style(
                      fontSize: FontSize(20),
                      padding: HtmlPaddings.all(16),
                      lineHeight: const LineHeight(1.5),
                      fontWeight: FontWeight.w600,
                    ),
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
