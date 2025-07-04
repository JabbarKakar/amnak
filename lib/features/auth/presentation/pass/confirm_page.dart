import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:amnak/core/view/widgets/language_direction.dart';
import 'package:amnak/features/auth/presentation/cubit.dart';

import '../../../../../export.dart';

class ConfirmPage extends HookWidget {
  ConfirmPage({
    super.key,
    required this.phone,
  });
  final String phone;
  final controller = sl<AuthCubit>();
  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final phoneTextController = useTextEditingController(text: phone);
    final codeTextController = useTextEditingController();
    return LanguageDirection(
      child: Scaffold(
          body: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            'Enter Activation Code'.text,
            Image.asset(Assets.imagesLogo),
            20.h.heightBox,
            TextInput(
              autofillHints: const [AutofillHints.telephoneNumber],
              controller: phoneTextController,
              textColor: kBlack,
              inputType: TextInputType.phone,
              hint: phone,
              prefixIcon: const Icon(Icons.phone),
              validate: (value) => value!.length == 11 ? null : 'phoneWar',
            ),
            PasswordInput(
              controller: codeTextController,
              hint: 'pass',
            ),
            'forgetPass'.text,
            20.heightBox,
            RoundedCornerLoadingButton(
              color: kBlack,
              onPressed: () async {
                // final res = await controller.confirmUser({
                //   "phone": phoneTextController.text,
                //   "activation_code": codeTextController.text,
                // });
                // if (res?.data?.confirmed == true) {
                //   context.router.popUntilRoot();
                //   showSimpleDialog(
                //       text: 'You have successfully confirmed your account');
                // }
              },
              child: 'confirm'.text,
            ),
            20.heightBox,
            'dontHaveAccount'.text,
          ],
        ),
      )),
    );
  }
}
