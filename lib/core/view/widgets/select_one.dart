import '../../../export.dart';

//has 3 states buy & rent & not selected('')
class SelectOne extends StatefulWidget {
  SelectOne(
      {super.key,
      required this.onChange,
      this.selected = '',
      required this.choices,
      required this.titles,
      this.endPadding = 8.0});

  final Function(String selected) onChange;
  String selected;
  final List<String?> choices;
  final List<String?> titles;
  final double endPadding;

  @override
  State<SelectOne> createState() => _SelectOneState();
}

class _SelectOneState extends State<SelectOne> {
  @override
  void initState() {
    super.initState();
  }

  void updateValueLogic(String selected) =>
      widget.selected = widget.selected == selected ? '' : selected;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var index = 0; index < widget.titles.length; index++)
          Expanded(
            child: Padding(
              padding: EdgeInsetsDirectional.only(
                  end: index != widget.titles.length ? widget.endPadding : 0),
              child: ChoiceChip(
                onSelected: (isSelected) {
                  // update logic
                  updateValueLogic(widget.choices[index]!);
                  // Notify parent
                  widget.onChange(widget.selected);
                },
                selected: widget.selected == widget.choices[index],
                label: widget.titles[index].toString().text,
              ),
            ),
          ),
      ],
    );
  }
}
