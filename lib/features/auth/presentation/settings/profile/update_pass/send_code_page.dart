import 'package:amnak/core/view/widgets/language_direction.dart';
import 'package:amnak/export.dart';
import 'package:amnak/features/auth/presentation/settings/profile/update_pass/update_pass_cubit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SendCodePage extends StatefulWidget {
  const SendCodePage({super.key});

  @override
  State<SendCodePage> createState() => _SendCodePageState();
}

class _SendCodePageState extends State<SendCodePage> {
  final controller = sl<UpdatePassCubit>();

  final GlobalKey<FormState> formKey = GlobalKey();
  final emailTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return LanguageDirection(
      child: Scaffold(
        appBar: const CustomAppBar(hasNotifications: false),
        body: Stack(
          children: [
            Positioned(
              top: 70,
              left: 0,
              right: 0,
              child: Container(
                decoration: ShapeDecoration(
                  color: decideOnTheme(kLight, kDark),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        124.h.heightBox,
                        const FaIcon(
                          FontAwesomeIcons.key,
                          size: 64,
                          color: kPrimaryColor,
                        ),
                        Text(
                          context.t.newPassword,
                          style: context.textTheme.headlineMedium,
                        ),
                        60.h.heightBox,
                        TextInput(
                          hint: context.t.email,
                          controller: emailTextController,
                          inputType: TextInputType.emailAddress,
                          autofillHints: const [AutofillHints.email],
                          validate: (value) =>
                              isEmail(value) ? null : context.t.enterEmail,
                        ),
                        20.h.heightBox,
                        RoundedCornerLoadingButton(
                          text: context.t.save,
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              await controller.sendCode(
                                {'email': emailTextController.text},
                                context,
                              );
                            }
                          },
                        ),
                        400.h.heightBox,
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
