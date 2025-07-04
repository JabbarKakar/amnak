import 'package:amnak/export.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BackImageScaffold(
      hasBack: false,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                SafeArea(
                  child: SwitchTile(
                    titleColor: kWhite,
                    value: isEn(),
                    title: context.t.language,
                    onChanged: (value) async => await toggleLanguage(),
                  ),
                ),
                Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          child: Image.asset(
                            decideOnTheme(
                                Assets.imagesLogo, Assets.imagesLogoDark),
                            width: .45.sw,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      context.t.WelcomeIn,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: decideOnTheme(k001142Color, kPurple),
                          ),
                    ),
                  ],
                ),
                .01.sh.heightBox,
                OutlinedLoadingButton(
                  onPressed: () => context.pushNamed(Routes.signup),
                  text: context.t.registerNew,
                ),
                16.h.heightBox,
                TextButton(
                  onPressed: () =>
                      context.pushNamed(Routes.login, extra: "email"),
                  child: Text(context.t.loginByEmail),
                ),
                TextButton(
                  onPressed: () =>
                      context.pushNamed(Routes.login, extra: "phone"),
                  child: Text(context.t.loginByPhone),
                ),
                TextButton(
                  onPressed: () =>
                      context.pushNamed(Routes.login, extra: "identity"),
                  child: Text(context.t.loginByIdentifier),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
