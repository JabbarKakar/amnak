import '../../../export.dart';

class PasswordInput extends StatefulWidget {
  const PasswordInput({
    super.key,
    required this.controller,
    required this.hint,
    this.validate,
    this.isUnderline = true,
  });

  final TextEditingController controller;
  final String hint;
  final bool isUnderline;
  final String? Function(String?)? validate;

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  final isShow = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
        valueListenable: isShow,
        builder: (context, value, _) {
          return TextInput(
            controller: widget.controller,
            autofillHints: const [AutofillHints.password],
            hint: widget.hint,
            showUnderline: widget.isUnderline,
            suffixIcon: GestureDetector(
              onTap: () => isShow.value = !value,
              child: Padding(
                padding: const EdgeInsets.only(right: 24.0),
                child: Icon(value ? Icons.visibility_off : Icons.visibility,
                    color: kPurple),
              ),
            ),
            isPass: !value,
            maxLines: 1,
            validate: widget.validate ??
                (value) => value!.length > 5 ? null : context.t.enterValidPass,
          );
        });
  }
}
