import 'package:amnak/core/authenticate.dart';
import 'package:amnak/core/feature/data/models/login_wrapper.dart';
import 'package:amnak/core/location_manager.dart';
import 'package:amnak/core/view/widgets/language_direction.dart';
import 'package:amnak/core/view/widgets/my_list_tile.dart';
import 'package:amnak/core/view/widgets/profile_img_picker.dart';
import 'package:amnak/export.dart';
import 'package:amnak/features/employee_permissions/view/employee_permissions_page.dart';
import 'package:amnak/features/home/presentation/home_card.dart';
import 'package:amnak/features/home/presentation/home_cubit.dart';

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
                              showSuccessSnack(
                                  message: context.t.authenticated);
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
                        tooltip: context.t.useFingerprint,
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
                      HomeCard(
                        title: context.t.myPersonalRequest,
                        imagePath: Assets.imagesGuests,
                        onTap: () =>
                            context.pushNamed(Routes.personalRequestScreen),
                      ),
                    ],
                  ),
                  10.heightBox,
                  Row(
                    children: [
                      HomeCard(
                        title: context.t.personalRequestTypes,
                        imagePath: Assets.imagesGuests,
                        onTap: () => context
                            .pushNamed(Routes.personalRequestTypesScreen),
                      ),
                      HomeCard(
                        title: context.t.makePersonalRequest,
                        imagePath: Assets.imagesGuests,
                        onTap: () =>
                            context.pushNamed(Routes.employeePermissions),
                      ),
                    ],
                  ),
                  10.heightBox,
                  Row(
                    children: [
                      HomeCard(
                        title: context.t.employeeEvaluation,
                        imagePath: Assets.imagesGuests,
                        onTap: () =>
                            context.pushNamed(Routes.employeeEvaluation),
                      ),
                      HomeCard(
                        title: context.t.employeePermissions,
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
