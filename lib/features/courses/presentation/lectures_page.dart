import 'package:amnak/core/feature/data/models/lectures_wrapper.dart';
import 'package:amnak/core/view/widgets/custom_cubit_builder.dart';
import 'package:amnak/core/view/widgets/language_direction.dart';
import 'package:amnak/export.dart';
import 'package:amnak/features/courses/presentation/lecturess_cubit.dart';
import 'package:url_launcher/url_launcher_string.dart';

class LecturesPage extends StatefulWidget {
  const LecturesPage({super.key, required this.courseId});
  final String courseId;

  @override
  State<LecturesPage> createState() => _LecturesPageState();
}

class _LecturesPageState extends State<LecturesPage> {
  final LecturesCubit cubit = sl<LecturesCubit>();

  @override
  void initState() {
    cubit.get(widget.courseId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LanguageDirection(
      child: Scaffold(
        appBar: AppBar(title: Text(context.t.lectures), centerTitle: true),
        body: CustomCubitBuilder<LecturesWrapper>(
          cubit: cubit,
          tryAgain: () => cubit.get(widget.courseId),
          onSuccess: (context, state) {
            return ListView.builder(
              itemCount: state.data?.data?.length ?? 0,
              itemBuilder: (context, index) {
                final value = state.data!.data![index];
                return Card(
                  child: ListTile(
                    onTap: () {
                      launchUrlString(value.videoUrl ?? '');
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
