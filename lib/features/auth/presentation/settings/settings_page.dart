import 'package:amnak/core/view/widgets/language_direction.dart';
import '../../../../../../export.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return LanguageDirection(
      child: Scaffold(
        appBar: const CustomAppBar(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                20.heightBox,
                SwitchTile(
                  value: isEn(),
                  title: context.t.language,
                  onChanged: (value) async => await toggleLanguage(),
                ),
                // SwitchTile(
                //   hasBottomDivider: false,
                //   title: context.t.theme,
                //   value: isDark(),
                //   onChanged: (value) async {
                //     await toggleTheme();
                //     setState(() {});
                //   },
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
