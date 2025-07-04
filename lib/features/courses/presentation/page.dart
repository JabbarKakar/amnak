import 'package:amnak/core/feature/data/models/courses_wrapper.dart';
import 'package:amnak/core/view/widgets/custom_cubit_builder.dart';
import 'package:amnak/core/view/widgets/language_direction.dart';
import 'package:amnak/export.dart';
import 'package:amnak/features/courses/presentation/cubit.dart';
import 'package:url_launcher/url_launcher_string.dart';

class CoursesPage extends StatefulWidget {
  const CoursesPage({super.key});

  @override
  State<CoursesPage> createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  final CoursesCubit cubit = sl<CoursesCubit>()..get();
  @override
  Widget build(BuildContext context) {
    return LanguageDirection(
      child: Scaffold(
        appBar: AppBar(title: Text(context.t.courses), centerTitle: true),
        body: CustomCubitBuilder<CoursesWrapper>(
          cubit: cubit,
          tryAgain: () => cubit.get(),
          onSuccess: (context, state) {
            return ListView.builder(
              itemCount: state.data?.data?.length ?? 0,
              itemBuilder: (context, index) {
                final value = state.data!.data![index];
                return Card(
                  child: ListTile(
                    onTap: () {
                      context.pushNamed(Routes.lectures,
                          extra: value.id.toString());
                    },
                    title: Text(value.title ?? ''),
                    subtitle: Text(
                      value.description ?? '',
                      maxLines: 2,
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () => launchUrlString(value.pdfUrl ?? ''),
                          icon: const Icon(Icons.list_alt),
                        ),
                        IconButton(
                          onPressed: () =>
                              launchUrlString(value.videoUrl ?? ''),
                          icon: const Icon(Icons.play_arrow),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
