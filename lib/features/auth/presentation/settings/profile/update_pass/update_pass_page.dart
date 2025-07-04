import 'package:amnak/core/view/widgets/language_direction.dart';
import 'package:amnak/features/auth/presentation/settings/profile/update_pass/update_pass_cubit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../../../export.dart';

class UpdatePassPage extends StatefulWidget {
  const UpdatePassPage({super.key, required this.email});
  final String email;

  @override
  State<UpdatePassPage> createState() => _UpdatePassPageState();
}

class _UpdatePassPageState extends State<UpdatePassPage> {
  final controller = sl<UpdatePassCubit>();

  final GlobalKey<FormState> formKey = GlobalKey();
  final newPassTextController = TextEditingController();
  final codeTextController = TextEditingController();

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
                        Text(context.t.enterCode,
                            style: Theme.of(context).textTheme.displaySmall),
                        20.h.heightBox,
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
                        PasswordInput(
                          controller: newPassTextController,
                          hint: context.t.newPassword,
                        ),
                        20.h.heightBox,
                        TextInput(
                          hint: context.t.verificationCode,
                          controller: codeTextController,
                          inputType: TextInputType.number,
                        ),
                        20.h.heightBox,
                        RoundedCornerLoadingButton(
                          text: context.t.save,
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              await controller.changePass(
                                {
                                  'email': widget.email,
                                  "verification_code": codeTextController.text,
                                  "password": newPassTextController.text
                                },
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
