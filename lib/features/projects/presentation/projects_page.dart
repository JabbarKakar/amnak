import 'package:amnak/core/feature/data/models/projects_wrapper.dart';
import 'package:amnak/core/view/widgets/custom_cubit_builder.dart';
import 'package:amnak/core/view/widgets/language_direction.dart';
import 'package:amnak/core/view/widgets/my_list_tile.dart';
import 'package:amnak/export.dart';
import 'package:amnak/features/projects/presentation/projects_cubit.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({super.key});

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  final ProjectsCubit cubit = sl<ProjectsCubit>()..get();

  @override
  Widget build(BuildContext context) {
    return LanguageDirection(
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: const CustomAppBar(),
        body: CustomCubitBuilder<ProjectsWrapper>(
          cubit: cubit,
          tryAgain: () => cubit.get(),
          onSuccess: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: ListView.separated(
                separatorBuilder: (context, index) => 10.heightBox,
                itemCount: state.data?.data?.length ?? 0,
                itemBuilder: (context, index) {
                  final value = state.data!.data![index];
                  return Card(
                    color: context.theme.cardColor,
                    child: Column(
                      children: [
                        10.heightBox,
                        MyListTile(
                          leading: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: FadeImage(
                                fit: BoxFit.fill,
                                height: 100,
                                width: 140,
                                imageUrl: value.company?.logo ?? '',
                              )),
                          children: [
                            Text(value.projectDetails?.name ?? '',
                                style: context.textTheme.headlineMedium),
                            Text('${(value.company?.address)}',
                                style: context.textTheme.bodyLarge),
                          ],
                        ),
                        10.heightBox,
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: RoundedCornerLoadingButton(
                                  text: context.t.callAmbulance,
                                  onPressed: () async {
                                    final phone =
                                        await cubit.getAmbulancePhone();
                                    final url = 'tel:$phone';
                                    if (await canLaunchUrlString(url)) {
                                      await launchUrlString(url);
                                    } else {
                                      showFailSnack(
                                          message: 'Could not launch $url');
                                    }
                                  },
                                  height: 40,
                                ),
                              ),
                              10.widthBox,
                              Expanded(
                                child: RoundedCornerLoadingButton(
                                  text: context.t.report,
                                  onPressed: () {
                                    context.pushNamed(Routes.addReport,
                                        extra: value);
                                  },
                                  height: 40,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
