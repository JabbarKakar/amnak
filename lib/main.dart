import 'package:amnak/features/make_personal_request/provider/make_personal_request_provider.dart';
import 'package:amnak/features/personal_request/provider/personal_request_provider.dart';
import 'package:amnak/features/personal_request_types/provider/pesonal_request_provider_types.dart';
import 'package:amnak/features/personal_request_detail/provider/personal_request_details_provider.dart';
import 'package:amnak/features/safety_check_store/provider/safety_check_store_provider.dart';
import 'package:amnak/features/safety_checks_project_details/provider/safety_checks_project_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:requests_inspector/requests_inspector.dart';

import 'core/injection_container.dart' as di;
import 'export.dart';
import 'features/safety_checks/provider/safety_check_items_provider.dart';
import 'features/employee_evaluation/provider/employee_evaluation_provider.dart';
import 'features/employee_permissions/provider/employee_permission_provider.dart';
import 'features/walki/provider/walkie_talkie_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Future.wait([
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]),
    di.init(),
  ]);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: kPrimaryColor),
  );

  runApp(
    RequestsInspector(
      navigatorKey: null,
      enabled: kDebugMode,
      showInspectorOn: ShowInspectorOn.LongPress,
      child: TranslationProvider(
        child: Builder(
          builder: (context) {
            // Initialize language after TranslationProvider is available
            WidgetsBinding.instance.addPostFrameCallback((_) {
              getInitialLanguage();
            });
            return const MyApp();
          },
        ),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  static ValueNotifier<bool> isDark =
      ValueNotifier<bool>(GetStorage().read(kTheme) ?? false);

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PersonalRequestTypesProvider()),
        ChangeNotifierProvider(create: (_) => PersonalRequestDetailProvider()),
        ChangeNotifierProvider(create: (_) => SafetyCheckItemsProvider()),
        ChangeNotifierProvider(create: (_) => EmployeeEvaluationProvider()),
        ChangeNotifierProvider(create: (_) => EmployeePermissionProvider()),
        ChangeNotifierProvider(create: (_) => WalkieTalkieProvider()),
        ChangeNotifierProvider(create: (_) => PersonalRequestProvider()),
        ChangeNotifierProvider(create: (_) => MakePersonalRequestProvider()),
        ChangeNotifierProvider(create: (_) => SafetyChecksProjectProvider()),
        ChangeNotifierProvider(create: (_) => SafetyCheckStoreProvider()),
        // Add more providers here as needed
      ],
      child: ScreenUtilInit(
          designSize: const Size(baseWidth, baseHeight),
          minTextAdapt: true,
          builder: (BuildContext context, Widget? child) {
            return ValueListenableBuilder<bool>(
                valueListenable: isDark,
                builder: (context, value, child) {
                  return MaterialApp.router(
                    locale: TranslationProvider.of(context).flutterLocale,
                    theme: decideOnTheme(lightTheme, darkTheme),
                    debugShowCheckedModeBanner: false,
                    routerConfig: AppRouter.routes,
                  );
                });
          }),
    );
  }
}
