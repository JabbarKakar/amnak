import '../../../export.dart';

class CustomBlocBuilder<T> extends StatelessWidget {
  const CustomBlocBuilder(
      {super.key,
      required this.cubit,
      required this.onSuccess,
      this.onLoading,
      this.onError,
      this.onEmpty,
      this.buildWhen});
  final Widget Function(BuildContext, BaseState<T>)? onLoading;
  final Widget Function(BuildContext, BaseState<T>)? onEmpty;
  final Widget Function(BuildContext, BaseState<T>)? onError;
  final Widget Function(BuildContext, BaseState<T>) onSuccess;
  final bool Function(BaseState<T>, BaseState<T>)? buildWhen;
  final Cubit<BaseState<T>> cubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<Cubit<BaseState<T>>, BaseState<T>>(
        bloc: cubit,
        builder: (ctx, state) {
          switch (state.status) {
            case RxStatus.loading:
              return onLoading != null
                  ? onLoading!(context, state)
                  : const Center(child: CircularProgressIndicator());
            case RxStatus.error:
              return onError != null
                  ? onError!(context, state)
                  : Center(child: Text(state.errorMessage!));
            case RxStatus.empty:
              return onEmpty != null
                  ? onEmpty!(context, state)
                  : const Center(child: Text('no data'));
            default:
              return onSuccess(context, state);
          }
        });
  }
}
