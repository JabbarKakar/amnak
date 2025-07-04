import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:amnak/core/view/widgets/language_direction.dart';
import 'package:amnak/features/auth/presentation/reset_pass_cubit.dart';

import '../../../../../export.dart';

class ResetPassPhonePage extends HookWidget {
  ResetPassPhonePage({
    super.key,
    this.phoneArg,
  });
  final String? phoneArg;
  final controller = sl<ResetPassCubit>();

  final GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final phoneTextController = useTextEditingController(text: phoneArg);
    final passTextController = useTextEditingController();
    final codeTextController = useTextEditingController();
    final isCodeOrPassword = useState(true);
    return LanguageDirection(
      child: Scaffold(
          body: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(Assets.imagesLogo),
            'Send Activation Code'.text,
            20.h.heightBox,
            TextInput(
              autofillHints: const [AutofillHints.telephoneNumber],
              controller: phoneTextController,
              textColor: kBlack,
              inputType: TextInputType.phone,
              hint: 'phone',
              prefixIcon: const Icon(Icons.phone),
              validate: (value) => value!.length == 11 ? null : 'phoneWar',
            ),
            if (!isCodeOrPassword.value) ...[
              TextInput(
                controller: codeTextController,
                textColor: kBlack,
                inputType: TextInputType.phone,
                hint: 'code',
                prefixIcon: const Icon(Icons.code),
                validate: (value) => value!.isNotEmpty ? null : 'war',
              ),
              PasswordInput(
                controller: passTextController,
                hint: 'pass',
              )
            ],
            20.heightBox,
            RoundedCornerLoadingButton(
              color: kBlack,
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  String? token;
                  if (isCodeOrPassword.value) {
                    final res =
                        await controller.sendCode(phoneTextController.text);
                    if (res != null) {
                      token = res['token'];
                      isCodeOrPassword.value = false;
                    }
                  } else {
                    final res = await controller.resetPass({
                      "phone": phoneTextController.text,
                      "reset_code": passTextController.text,
                      "token": token,
                      "password": passTextController.text,
                      "password_confirmation": passTextController.text,
                    });
                    if (res != null) {}
                  }
                }
              },
              child:
                  (isCodeOrPassword.value ? 'send code' : 'resetPassword').text,
            ),
            20.heightBox,
          ],
        ),
      )),
    );
  }
}
