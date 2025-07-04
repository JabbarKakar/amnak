import 'package:amnak/core/feature/data/models/login_wrapper.dart';
import 'package:amnak/core/view/widgets/language_direction.dart';
import 'package:amnak/features/auth/presentation/cubit.dart';

import '../../../../../export.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.loginType});
  final String loginType;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final cubit = sl<AuthCubit>();
  final identifierTextController = TextEditingController();
  final passTextController = TextEditingController();
  final isValid = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return LanguageDirection(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                .08.sh.heightBox,
                Row(
                  children: [
                    IconButton(
                      onPressed: () => context.pop(),
                      icon: const Icon(Icons.arrow_back),
                    ),
                  ],
                ),
                Image.asset(
                  Assets.imagesLogo,
                  height: 150.h,
                ),
                Text(
                  context.t.loginToYourAccount,
                  style: context.textTheme.headlineMedium,
                ),
                .08.sh.heightBox,
                TextInput(
                  controller: identifierTextController,
                  inputType: getInputType,
                  hint: getHint(context),
                  validate: (value) {
                    Future.delayed(const Duration(milliseconds: 100))
                        .then((value) {
                      if (validateIdentifier() &&
                          passTextController.text.length > 5) {
                        isValid.value = true;
                      } else {
                        isValid.value = false;
                      }
                    });
                    return validateIdentifier() ? null : context.t.msErrorEmail;
                  },
                ),
                20.h.heightBox,
                PasswordInput(
                  controller: passTextController,
                  hint: context.t.password,
                  validate: (value) {
                    Future.delayed(const Duration(milliseconds: 100))
                        .then((value) {
                      if (validateIdentifier() &&
                          passTextController.text.length > 5) {
                        isValid.value = true;
                      } else {
                        isValid.value = false;
                      }
                    });
                    return passTextController.text.length > 5
                        ? null
                        : context.t.enterValidPass;
                  },
                ),
                20.h.heightBox,
                ValidButton(
                  isValid: isValid,
                  onPressed: () async {
                    final res = await cubit.login({
                      "login_by": widget.loginType,
                      "identifier": identifierTextController.text,
                      "password": passTextController.text,
                      "device_token": "123",
                    });
                    if (res is LoginWrapper) {
                      context.goNamed(Routes.home);
                    }
                  },
                  text: context.t.login,
                ),
                8.h.heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyTextButton(
                      onTap: () => context.pushNamed(Routes.signup),
                      text: context.t.register,
                    ),
                    MyTextButton(
                      text: context.t.forgetPass,
                      onTap: () => context.pushNamed(Routes.sendCode),
                    ),
                  ],
                ),
                32.h.heightBox,
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool validateIdentifier() => widget.loginType == 'phone'
      ? identifierTextController.text.length > 9
      : widget.loginType == 'email'
          ? isEmail(identifierTextController.text.trim())
          : identifierTextController.text.length > 6;

  TextInputType get getInputType => widget.loginType == 'phone'
      ? TextInputType.phone
      : widget.loginType == 'email'
          ? TextInputType.emailAddress
          : TextInputType.number;

  String getHint(BuildContext context) => widget.loginType == 'phone'
      ? context.t.phone
      : widget.loginType == 'email'
          ? context.t.email
          : context.t.id;
}
