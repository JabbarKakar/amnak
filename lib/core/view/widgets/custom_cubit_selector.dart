import 'package:amnak/core/extensions/num_extension.dart';

import '../../../export.dart';

class CustomCubitSelector<T> extends StatelessWidget {
  const CustomCubitSelector({
    super.key,
    required this.cubit,
    required this.onSuccess,
    required this.tryAgain,
    this.onLoading,
    this.onError,
    this.onEmpty,
    required this.selector,
  });
  final Widget Function(BuildContext, BaseState<T>)? onLoading;
  final Widget Function(BuildContext, BaseState<T>)? onEmpty;
  final Widget Function(BuildContext, BaseState<T>)? onError;
  final Widget Function(BuildContext, BaseState<T>) onSuccess;
  final Cubit<BaseState<T>> cubit;
  final Function tryAgain;
  final BaseState<T> Function(BaseState<T>) selector;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<Cubit<BaseState<T>>, BaseState<T>, BaseState<T>>(
        bloc: cubit,
        selector: selector,
        builder: (ctx, state) {
          switch (state.status) {
            case RxStatus.loading:
              return onLoading != null
                  ? onLoading!(context, state)
                  : const Center(child: CircularProgressIndicator());
            case RxStatus.error:
              return onError != null
                  ? onError!(context, state)
                  : Center(
                      child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(state.errorMessage ?? 'error occurred'),
                        10.heightBox,
                        RoundedCornerLoadingButton(
                            text: 'try again',
                            onPressed: () async {
                              await tryAgain();
                            })
                      ],
                    ));
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
