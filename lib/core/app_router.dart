import 'package:amnak/core/feature/data/models/chat_persons_wrapper.dart';
import 'package:amnak/core/feature/data/models/projects_wrapper.dart';
import 'package:amnak/core/feature/data/models/visitors_wrapper.dart';
import 'package:amnak/core/view/widgets/language_direction.dart';
import 'package:amnak/features/animated_splash/views/animated_splash_page.dart';
import 'package:amnak/features/auth/presentation/landing_page.dart';
import 'package:amnak/features/auth/presentation/login/login_page.dart';
import 'package:amnak/features/auth/presentation/pass/confirm_page.dart';
import 'package:amnak/features/auth/presentation/pass/reset_pass_phone_page.dart';
import 'package:amnak/features/auth/presentation/settings/profile/profile_page.dart';
import 'package:amnak/features/auth/presentation/settings/profile/update_pass/send_code_page.dart';
import 'package:amnak/features/auth/presentation/settings/profile/update_pass/update_pass_page.dart';
import 'package:amnak/features/auth/presentation/settings/settings_page.dart';
import 'package:amnak/features/auth/presentation/signup/signup_page.dart';
import 'package:amnak/features/chats/presentation/chat_details_page.dart';
import 'package:amnak/features/chats/presentation/chat_persons_page.dart';
import 'package:amnak/features/chats/presentation/walki_persons_page.dart';
import 'package:amnak/features/courses/presentation/lectures_page.dart';
import 'package:amnak/features/courses/presentation/page.dart';
import 'package:amnak/features/home/presentation/home_page.dart';
import 'package:amnak/features/home/presentation/nav_page.dart';
import 'package:amnak/features/notifications/presentation/instructions_page.dart';
import 'package:amnak/features/notifications/presentation/page.dart';
import 'package:amnak/features/personal_request/view/personal_request_view.dart';
import 'package:amnak/features/projects/presentation/projects_page.dart';
import 'package:amnak/features/report/add_report_page.dart';
import 'package:amnak/features/safety_check_store/view/safety_check_store_view.dart';
import 'package:amnak/features/safety_checks/view/safety_check_items_view.dart';
import 'package:amnak/features/safety_checks_project_details/view/safety_checks_project_details_view.dart';
import 'package:amnak/features/terms_privacy/presentation/page.dart';
import 'package:amnak/features/visitors/presentation/visitor_details_page.dart';
import 'package:amnak/features/visitors/presentation/visitors_page.dart';
import 'package:amnak/features/walki/projects_page.dart';
import 'package:amnak/features/walki/walki_page.dart';
import 'package:amnak/features/walki/view/walkie_talkie_contacts_page.dart';
import 'package:amnak/features/walki/view/walkie_talkie_messages_page.dart';
import 'package:amnak/features/employee_evaluation/view/employee_evaluation_page.dart';
import 'package:amnak/features/employee_permissions/view/employee_permissions_page.dart';

import '../../export.dart';
import '../features/make_personal_request/view/make_personal_request_view.dart';

/// don't use for navigate without context
final GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

class AppRouter {
  /// use for navigate without context
  static final GoRouter routes = GoRouter(
      navigatorKey: navKey,
      initialLocation: Routes.animatedSplash,
      routes: [
        GoRoute(
          name: Routes.animatedSplash,
          path: Routes.animatedSplash,
          builder: (context, state) => AnimatedSplash(
            home:
                sl<GetStorage>().hasData(kToken) ? Routes.home : Routes.landing,
            title: '',
            duration: Duration.hoursPerDay,
            type: AnimatedSplashType.StaticDuration,
          ),
        ),
        GoRoute(
          name: Routes.landing,
          path: Routes.landing,
          builder: (context, state) => const LandingPage(),
        ),
        GoRoute(
          name: Routes.login,
          path: Routes.login,
          builder: (context, state) =>
              LoginPage(loginType: state.extra as String),
        ),
        GoRoute(
          name: Routes.signup,
          path: Routes.signup,
          builder: (context, state) => const SignUpPage(),
        ),
        GoRoute(
          name: Routes.sendCode,
          path: Routes.sendCode,
          builder: (context, state) => const SendCodePage(),
        ),
        GoRoute(
          name: Routes.updatePass,
          path: Routes.updatePass,
          builder: (context, state) => UpdatePassPage(
            email: state.extra as String,
          ),
        ),
        GoRoute(
          name: Routes.settings,
          path: Routes.settings,
          builder: (context, state) => const SettingsPage(),
        ),
        GoRoute(
          name: Routes.resetPassPhone,
          path: Routes.resetPassPhone,
          builder: (context, state) => ResetPassPhonePage(),
        ),
        GoRoute(
          name: Routes.courses,
          path: Routes.courses,
          builder: (context, state) => CoursesPage(),
        ),
        GoRoute(
          name: Routes.lectures,
          path: Routes.lectures,
          builder: (context, state) => LecturesPage(
            courseId: state.extra as String,
          ),
        ),
        GoRoute(
          name: Routes.addReport,
          path: Routes.addReport,
          builder: (context, state) => AddReportPage(
            project: state.extra as ProjectModel,
          ),
        ),
        GoRoute(
          name: Routes.termsPrivacy,
          path: Routes.termsPrivacy,
          builder: (context, state) => TermsPrivacyPage(
            type: state.extra as String,
          ),
        ),
        GoRoute(
          name: Routes.projects,
          path: Routes.projects,
          builder: (context, state) => const ProjectsPage(),
        ),
        GoRoute(
          name: Routes.instructions,
          path: Routes.instructions,
          builder: (context, state) => const InstructionsPage(),
        ),
        GoRoute(
          name: Routes.chatDetails,
          path: Routes.chatDetails,
          builder: (context, state) => ChatDetailsPage(
            personModel:
                (state.extra as Map<String, dynamic>)['person'] as PersonModel,
          ),
        ),
        GoRoute(
          name: Routes.notifications,
          path: Routes.notifications,
          builder: (context, state) => const NotificationsPage(),
        ),
        GoRoute(
          name: Routes.employeeEvaluation,
          path: Routes.employeeEvaluation,
          builder: (context, state) => const EmployeeEvaluationPage(),
        ),
        GoRoute(
          name: Routes.employeePermissions,
          path: Routes.employeePermissions,
          builder: (context, state) => const EmployeePermissionsPage(),
        ),
        GoRoute(
          name: Routes.visitors,
          path: Routes.visitors,
          builder: (context, state) => const VisitorsPage(),
        ),
        GoRoute(
          name: Routes.confirm,
          path: Routes.confirm,
          builder: (context, state) =>
              ConfirmPage(phone: state.extra as String),
        ),
        GoRoute(
          name: Routes.walki,
          path: Routes.walki,
          builder: (context, state) {
            final args = state.extra as Map<String, dynamic>;
            return WalkiPage(
              token: args['token'] as String,
              channel: args['channel'] as String,
            );
          },
        ),
        GoRoute(
          name: Routes.walkieProjects,
          path: Routes.walkieProjects,
          builder: (context, state) {
            return WalkieTalkieProjectsPage();
          },
        ),
        GoRoute(
          name: Routes.walkiContacts,
          path: Routes.walkiContacts,
          builder: (context, state) {
            final args = state.extra as Map<String, dynamic>;
            return WalkieTalkieContactsPage(
                projectId: args['projectId'] as int);
          },
        ),
        GoRoute(
          name: Routes.walkiMessages,
          path: Routes.walkiMessages,
          builder: (context, state) {
            final args = state.extra as Map<String, dynamic>;
            return WalkieTalkieMessagesPage(
              token: args['token'] as String,
              channel: args['channel'] as String,
              id: args['id'] as int,
              type: args['type'] as String,
            );
          },
        ),
        GoRoute(
          name: Routes.visitorDetails,
          path: Routes.visitorDetails,
          builder: (context, state) =>
              VisitorDetailsPage(visitor: state.extra as VisitorModel),
        ),
        GoRoute(
          name: Routes.safetyCheckProjectDetails,
          path: Routes.safetyCheckProjectDetails,
          builder: (context, state) =>
              SafetyCheckProjectDetailsScreen(safetyCheckId: state.extra as String),
        ),
        GoRoute(
          name: Routes.personalRequestScreen,
          path: Routes.personalRequestScreen,
          builder: (context, state) => PersonalRequestScreen(),
        ),
        GoRoute(
          name: Routes.safetyCheckItemsScreen,
          path: Routes.safetyCheckItemsScreen,
          builder: (context, state) => SafetyCheckItemsScreen(),
        ),
        GoRoute(
          name: Routes.safetyCheckStoreScreen,
          path: Routes.safetyCheckStoreScreen,
          builder: (context, state) => SafetyCheckStoreScreen(),
        ),
        GoRoute(
          name: Routes.makePersonalRequestScreen,
          path: Routes.makePersonalRequestScreen,
          builder: (context, state) => MakePersonalRequestScreen(),
        ),
        StatefulShellRoute.indexedStack(
          builder: (BuildContext context, GoRouterState state,
              StatefulNavigationShell navigationShell) {
            return NavPage(navigationShell: navigationShell);
          },
          branches: <StatefulShellBranch>[
            // The route branch for the first tab of the bottom navigation bar.
            StatefulShellBranch(
              routes: <RouteBase>[
                GoRoute(
                  name: Routes.home,
                  path: Routes.home,
                  builder: (context, state) => const HomePage(),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: <RouteBase>[
                GoRoute(
                  name: Routes.chatPersons,
                  path: Routes.chatPersons,
                  builder: (context, state) => const ChatPersonsPage(),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: <RouteBase>[
                GoRoute(
                  name: Routes.walkiPersons,
                  path: Routes.walkiPersons,
                  builder: (context, state) => const WalkieTalkieProjectsPage(),
                  // builder: (context, state) => const WalkiPersonsPage(),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: <RouteBase>[
                GoRoute(
                  name: Routes.profile,
                  path: Routes.profile,
                  builder: (context, state) =>
                      const LanguageDirection(child: ProfilePage()),
                ),
              ],
            ),
          ],
        ),
      ]);
}
