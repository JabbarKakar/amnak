import '../../../export.dart';

class CustomCubitListener<T> extends StatelessWidget {
  const CustomCubitListener({
    super.key,
    required this.cubit,
    required this.child,
    required this.tryAgain,
    this.onSuccess,
    this.onError,
    this.onEmpty,
    this.listenWhen,
  });
  final Function(BuildContext, BaseState<T>)? onSuccess;
  final Function(BuildContext, BaseState<T>)? onEmpty;
  final Function(BuildContext, BaseState<T>)? onError;
  final Widget child;
  final Cubit<BaseState<T>> cubit;
  final Function tryAgain;

  final bool Function(BaseState<T>, BaseState<T>)? listenWhen;

  @override
  Widget build(BuildContext context) {
    return BlocListener<Cubit<BaseState<T>>, BaseState<T>>(
      listenWhen: listenWhen,
      bloc: cubit,
      listener: (ctx, state) {
        switch (state.status) {
          case RxStatus.error:
            return onError != null
                ? onError!(ctx, state)
                : showFailSnack(message: state.errorMessage!);
          case RxStatus.success:
            return onSuccess != null
                ? onSuccess!(ctx, state)
                : showSuccessSnack(message: state.data.toString());
          case RxStatus.empty:
          case RxStatus.loading:
            break;
        }
      },
      child: child,
    );
  }
}
