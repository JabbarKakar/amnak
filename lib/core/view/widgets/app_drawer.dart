import 'package:amnak/core/view/widgets/language_direction.dart';
import 'package:amnak/features/auth/presentation/cubit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../export.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return LanguageDirection(
      child: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            SwitchTile(
              value: isEn(),
              title: context.t.language,
              onChanged: (value) async => await toggleLanguage(),
            ),
            ListTile(
              onTap: () {
                Navigator.pop(context);
                context.pushNamed(Routes.termsPrivacy, extra: 'terms');
              },
              title: Text(context.t.terms),
              leading: const FaIcon(FontAwesomeIcons.notesMedical,
                  color: kPrimaryColor),
            ),
            ListTile(
              onTap: () {
                Navigator.pop(context);
                context.pushNamed(Routes.termsPrivacy, extra: 'policy');
              },
              title: Text(context.t.privacy),
              leading: const FaIcon(FontAwesomeIcons.noteSticky,
                  color: kPrimaryColor),
            ),
            ListTile(
              onTap: () {
                Navigator.pop(context);
                context.pushNamed(Routes.instructions);
              },
              title: Text(context.t.instructions),
              leading:
                  const FaIcon(FontAwesomeIcons.book, color: kPrimaryColor),
            ),
            sl<GetStorage>().hasData(kToken)
                ? ListTile(
                    onTap: () async {
                      await sl<AuthCubit>().logout();
                    },
                    title: Text(context.t.logOut),
                    leading:
                        const Icon(Icons.exit_to_app, color: kPrimaryColor),
                  )
                : ListTile(
                    onTap: () {
                      Navigator.pop(context);
                      context.goNamed(Routes.login);
                    },
                    title: Text(context.t.logInFirst),
                    leading: const Icon(Icons.login, color: kPrimaryColor),
                  ),
            const Spacer(),
            ListTile(
              onTap: () {
                showOptionsDialog(
                    yesFunction: () => sl<AuthCubit>().deleteAccount());
              },
              title: Text(context.t.delete_account,
                  style: const TextStyle(color: kRed)),
              leading: const Icon(Icons.delete_forever, color: kRed),
            ),
          ],
        ),
      ),
    );
  }
}
