import '../../../export.dart';

class CustomMultiselectDropDown extends StatefulWidget {
  final Function(List<String>) selectedList;
  final List<String> listOFStrings;

  const CustomMultiselectDropDown(
      {super.key, required this.selectedList, required this.listOFStrings});

  @override
  createState() {
    return _CustomMultiselectDropDownState();
  }
}

class _CustomMultiselectDropDownState extends State<CustomMultiselectDropDown> {
  List<String> listOFSelectedItem = [];
  String selectedText = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10.0),
      decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
      child: ExpansionTile(
        iconColor: Colors.grey,
        title: Text(
            (listOFSelectedItem.isEmpty ? "Select" : listOFSelectedItem[0])),
        children: <Widget>[
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: widget.listOFStrings.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: const EdgeInsets.only(bottom: 8.0),
                child: _ViewItem(
                    item: widget.listOFStrings[index],
                    selected: (val) {
                      selectedText = val;
                      if (listOFSelectedItem.contains(val)) {
                        listOFSelectedItem.remove(val);
                      } else {
                        listOFSelectedItem.add(val);
                      }
                      widget.selectedList(listOFSelectedItem);
                      setState(() {});
                    },
                    itemSelected: listOFSelectedItem
                        .contains(widget.listOFStrings[index])),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ViewItem extends StatelessWidget {
  final String item;
  final bool itemSelected;
  final Function(String) selected;

  const _ViewItem(
      {required this.item, required this.itemSelected, required this.selected});

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(item),
      value: itemSelected,
      dense: true,
      controlAffinity: ListTileControlAffinity.leading,
      onChanged: (val) {
        selected(item);
      },
      activeColor: Colors.blue,
    );
  }
}
