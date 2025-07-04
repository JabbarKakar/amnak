import 'package:amnak/export.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class CustomPagedListView<T, Y> extends StatelessWidget {
  const CustomPagedListView({
    super.key,
    required this.pagingController,
    required this.itemBuilder,
    this.shrinkWrap = true,
    this.tryAgainEvent,
    this.padding,
    this.scrollDirection = Axis.vertical,
  });

  final PagingController<T, Y> pagingController;
  final ItemWidgetBuilder<Y> itemBuilder;
  final GestureTapCallback? tryAgainEvent;
  final Axis scrollDirection;
  final bool shrinkWrap;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return PagedListView<T, Y>(
      key: Key(pagingController.hashCode.toString()),
      pagingController: pagingController,
      scrollDirection: scrollDirection,
      padding: padding,
      builderDelegate: PagedChildBuilderDelegate<Y>(
        itemBuilder: itemBuilder,
        noItemsFoundIndicatorBuilder: (context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Text("Nothing is here..",
                    style: Theme.of(context).textTheme.labelSmall),
              ),
            ],
          );
        },
        firstPageErrorIndicatorBuilder: (context) {
          return RoundedCornerLoadingButton(
            onPressed: () => tryAgainEvent!(),
            text: 'Reload',
          );
        },
        newPageErrorIndicatorBuilder: (context) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                    "Something went wrong, please try refreshing the page again.",
                    style: Theme.of(context).textTheme.labelSmall),
              ),
              const SizedBox(
                height: 32,
              ),
              RoundedCornerLoadingButton(
                onPressed: () => tryAgainEvent!(),
                text: 'Reload',
              ),
            ],
          );
        },
        firstPageProgressIndicatorBuilder: (context) =>
            const LinearProgressIndicator(),
        newPageProgressIndicatorBuilder: (context) =>
            const LinearProgressIndicator(),
      ),
      shrinkWrap: shrinkWrap,
    );
  }
}
