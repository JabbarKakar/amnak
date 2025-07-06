import 'dart:convert';

import 'package:amnak/core/authenticate.dart';
import 'package:amnak/core/feature/data/models/login_wrapper.dart';
import 'package:amnak/core/location_manager.dart';
import 'package:amnak/core/view/widgets/language_direction.dart';
import 'package:amnak/core/view/widgets/my_list_tile.dart';
import 'package:amnak/core/view/widgets/profile_img_picker.dart';
import 'package:amnak/export.dart';
import 'package:amnak/features/employee_evaluation/view/employee_evaluation_page.dart';
import 'package:amnak/features/employee_permissions/view/employee_permissions_page.dart';
import 'package:amnak/features/home/presentation/home_card.dart';
import 'package:amnak/features/home/presentation/home_cubit.dart';
import 'package:amnak/features/make_personal_request/view/make_personal_request_view.dart';
import 'package:amnak/features/personal_request/view/personal_request_view.dart';
import 'package:amnak/features/personal_request_types/view/personal_request_type_view.dart';
import 'package:amnak/features/safety_check_store/view/safety_check_store_view.dart';
import 'package:amnak/features/safety_checks/view/safety_check_items_view.dart';
import 'package:amnak/features/walki/view/walkie_talkie_contacts_page.dart';
import 'package:provider/provider.dart';

import '../../personal_request_types/provider/pesonal_request_provider_types.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UserModel? user;
  final cubit = sl<HomeCubit>();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final userData = sl<GetStorage>().read(kUser);
    if (userData != null) {
      setState(() {
        user = UserModel.fromJson(userData);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('Evaluation text: ${context.t.employeeEvaluation}');
    debugPrint('Evaluation text: ${context.t.employeePermissions}');

    return LanguageDirection(
      child: Scaffold(
        appBar: const CustomAppBar(),
        drawer: const AppDrawer(),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SafetyCheckStoreScreen(),
                            ));
                      },
                      child: Text("Goooo")),

                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WalkieTalkieContactsPage(),
                            ));
                      },
                      child: Text("Walkie Talkie")),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EmployeeEvaluationPage(),
                            ));
                      },
                      child: Text('Employee Evaluation',)),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EmployeePermissionsPage(),
                            ));
                      },
                      child: Text(
                        'Employee Permissions',
                        // context.t.employeePermissions,
                      )),
                  10.heightBox,
                  if (user != null)
                    MyListTile(
                      leading: ProfileImgPicker(
                        radius: 50,
                        onChange: (url) {},
                        isEditable: false,
                        url: user!.profileImage,
                      ),
                      trailing: IconButton(
                        onPressed: () async {
                          await Authenticate.authenticate(
                            context: context,
                            onSuccess: () async {
                              showSuccessSnack(message: 'Authenticated');
                              var myLocation = await getLocationPermission();
                              final res = await cubit.attend({
                                "longitude": myLocation?.longitude.toString(),
                                "latitude": myLocation?.latitude.toString(),
                              });
                              Logger().i(res);
                            },
                          );
                        },
                        icon: const Icon(Icons.fingerprint),
                      ),
                      children: [
                        Text(
                          '${user!.firstName} ${user!.lastName}',
                          style: context.textTheme.titleLarge,
                        ),
                        Text(
                          '${user!.nationalId}',
                          style: context.textTheme.titleSmall,
                        ),
                      ],
                    ),
                  .1.sh.heightBox,
                  Row(
                    children: [
                      HomeCard(
                        title: context.t.visitors,
                        imagePath: Assets.imagesGuests,
                        onTap: () => context.pushNamed(Routes.visitors),
                      ),
                      HomeCard(
                        title: context.t.projects,
                        imagePath: Assets.imagesCab,
                        onTap: () => context.pushNamed(Routes.projects),
                      ),
                    ],
                  ),
                  10.heightBox,
                  Row(
                    children: [
                      HomeCard(
                        title: context.t.courses,
                        imagePath: Assets.imagesGuests,
                        onTap: () => context.pushNamed(Routes.courses),
                      ),
                    ],
                  ),
                  10.heightBox,
                  Row(
                    children: [
                      HomeCard(
                        title: context.t.employeeEvaluation.isNotEmpty
                            ? context.t.employeeEvaluation
                            : 'Employee Evaluation',
                        imagePath: Assets.imagesGuests,
                        onTap: () =>
                            context.pushNamed(Routes.employeeEvaluation),
                      ),
                      HomeCard(
                        title: context.t.employeePermissions.isNotEmpty
                            ? context.t.employeePermissions
                            : 'Employee Permissions',
                        imagePath: Assets.imagesGuests,
                        onTap: () =>
                            context.pushNamed(Routes.employeePermissions),
                      ),
                    ],
                  ),
                  10.heightBox,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
