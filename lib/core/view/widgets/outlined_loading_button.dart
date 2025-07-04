import '../../../export.dart';

class OutlinedLoadingButton extends StatefulWidget {
  const OutlinedLoadingButton({
    super.key,
    required this.onPressed,
    this.child,
    this.text,
    this.color,
    this.width,
    this.height,
  });

  final Function()? onPressed;
  final Color? color;
  final Widget? child;
  final String? text;
  final double? width;
  final double? height;

  @override
  State<OutlinedLoadingButton> createState() => _OutlinedLoadingButtonState();
}

class _OutlinedLoadingButtonState extends State<OutlinedLoadingButton> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width ?? double.infinity,
      height: widget.height ?? 48.h,
      child: OutlinedButton(
        onPressed: widget.onPressed == null
            ? null
            : isLoading
                ? null
                : () async {
                    if (mounted) {
                      setState(() {
                        isLoading = true;
                      });
                    }
                    try {
                      await widget.onPressed!();
                    } catch (e, stackTrace) {
                      Logger().e(e);
                      Logger().e(stackTrace);
                    }
                    if (mounted) {
                      setState(() {
                        isLoading = false;
                      });
                    }
                  },
        child: (isLoading
            ? Center(
                child: CircularProgressIndicator(
                    color: decideOnTheme(kTextGreyColor, kWhite)))
            : widget.child ??
                Text(
                  (widget.text ?? 'a').toTitleCase(),
                  style: context.textTheme.titleLarge?.copyWith(
                    color: decideOnTheme(kTextGreyColor, kWhite),
                  ),
                )),
      ),
    );
  }
}
