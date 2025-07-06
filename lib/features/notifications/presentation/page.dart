import 'package:amnak/core/feature/data/models/notifications_wrapper.dart';
import 'package:amnak/core/view/widgets/custom_cubit_builder.dart';
import 'package:amnak/core/view/widgets/language_direction.dart';
import 'package:amnak/export.dart';
import 'package:amnak/features/notifications/presentation/cubit.dart';
import 'package:amnak/features/notifications/provider/accept_reject_provider.dart';
import 'package:provider/provider.dart';

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
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomCubitBuilder<NotificationsWrapper>(
            cubit: cubit,
            tryAgain: () => cubit.get(),
            onSuccess: (context, state) {
              return Consumer<AcceptRejectProvider>(
                builder: (context, provider, child) {
                  return ListView.builder(
                    itemCount: state.data?.data?.length ?? 0,
                    itemBuilder: (context, index) {
                      final value = state.data!.data![index];
                      final isAcceptLoading = provider.isAcceptLoading && value.id == provider.currentId; // Assuming id is available
                      final isRejectLoading = provider.isRejectLoading && value.id == provider.currentId; // Assuming id is available

                      return Card(
                        color: state.data!.data![index].isRead == 0
                            ? Colors.white
                            : Colors.grey.shade200,
                        child: ListTile(
                          onTap: () {},
                          title: Text(value.title ?? ''),
                          subtitle: Text(
                            value.body ?? '',
                            maxLines: 2,
                          ),
                          trailing: value.extraData != null && value.extraData!.type == 'hiring_request'
                              ? Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              GestureDetector(
                                onTap: isAcceptLoading || isRejectLoading
                                    ? null // Disable tap during loading
                                    : () async {
                                  await provider.accept(id: value.id.toString()); // Call accept with the request ID
                                  if (provider.errorMessage != null) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(provider.errorMessage!)),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Request accepted successfully')),
                                    );
                                  }
                                },
                                child: isAcceptLoading
                                    ? CircularProgressIndicator(strokeWidth: 2)
                                    : Text(
                                  "Accept",
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              SizedBox(width: 8),
                              GestureDetector(
                                onTap: isAcceptLoading || isRejectLoading
                                    ? null // Disable tap during loading
                                    : () async {
                                  await provider.reject(id: value.id.toString()); // Call reject with the request ID
                                  if (provider.rejectErrorMessage != null) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(provider.rejectErrorMessage!)),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Request rejected successfully')),
                                    );
                                  }
                                },
                                child: isRejectLoading
                                    ? CircularProgressIndicator(strokeWidth: 2)
                                    : Text(
                                  "Reject",
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          )
                              : SizedBox(),
                        ),
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
