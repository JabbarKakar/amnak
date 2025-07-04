import 'package:amnak/core/feature/data/models/notifications_wrapper.dart';
import 'package:amnak/core/view/widgets/custom_cubit_builder.dart';
import 'package:amnak/core/view/widgets/language_direction.dart';
import 'package:amnak/export.dart';
import 'package:amnak/features/notifications/presentation/cubit.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final NotificationsCubit cubit = sl<NotificationsCubit>()..get();
  @override
  Widget build(BuildContext context) {
    return LanguageDirection(
      child: Scaffold(
        appBar: AppBar(title: Text(context.t.notifications), centerTitle: true),
        body: CustomCubitBuilder<NotificationsWrapper>(
          cubit: cubit,
          tryAgain: () => cubit.get(),
          onSuccess: (context, state) {
            return ListView.builder(
              itemCount: state.data?.data?.length ?? 0,
              itemBuilder: (context, index) {
                final value = state.data!.data![index];
                return Card(
                  child: ListTile(
                    onTap: () {},
                    title: Text(value.title ?? ''),
                    subtitle: Text(
                      value.body ?? '',
                      maxLines: 2,
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
