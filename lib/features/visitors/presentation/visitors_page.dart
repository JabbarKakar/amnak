import 'package:amnak/core/feature/data/models/visitors_wrapper.dart';
import 'package:amnak/core/view/widgets/custom_cubit_builder.dart';
import 'package:amnak/core/view/widgets/language_direction.dart';
import 'package:amnak/export.dart';
import 'package:amnak/features/visitors/presentation/visitor_details_page.dart';
import 'package:amnak/features/visitors/presentation/visitors_cubit.dart';

class VisitorsPage extends StatefulWidget {
  const VisitorsPage({super.key});

  @override
  State<VisitorsPage> createState() => _VisitorsPageState();
}

class _VisitorsPageState extends State<VisitorsPage> {
  final VisitorsCubit cubit = sl<VisitorsCubit>()..get();
  @override
  Widget build(BuildContext context) {
    return LanguageDirection(
      child: Scaffold(
        appBar: const CustomAppBar(),
        body: CustomCubitBuilder<VisitorsWrapper>(
          cubit: cubit,
          tryAgain: () => cubit.get(),
          onSuccess: (context, state) {
            return ListView.builder(
              itemCount: state.data?.data?.length ?? 0,
              itemBuilder: (context, index) {
                final value = state.data!.data![index];
                return Card(
                  child: ListTile(
                    // leading: ClipRRect(
                    //     borderRadius: BorderRadius.circular(10),
                    //     child: SizedBox(
                    //       height: 80,
                    //       width: 140,
                    //       child: FadeInImage(
                    //         fit: BoxFit.cover,
                    //         placeholder:
                    //             const AssetImage('assets/images/logo.png'),
                    //         image: NetworkImage(value.image ?? ''),
                    //       ),
                    //     )),
                    onTap: () => showDialog(
                        context: context,
                        builder: (context) {
                          return VisitorDetailsPage(visitor: value);
                        }),
                    title: Text(value.name ?? ''),
                    subtitle: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${(value.carNumber)} '),
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
