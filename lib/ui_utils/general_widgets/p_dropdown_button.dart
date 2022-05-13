import 'package:flutter/material.dart';

/// This widget is used to display a dropdown menu
/// and store the selected value in the [controller].
/// For default value, the widget takes the firts value
/// of [valuesList] but you can change it by passing
/// [defaultValueIndex] and finally you can call a function
/// by passing [onTap]
class PDropdownButton extends StatefulWidget {
  const PDropdownButton({
    Key? key,
    required this.valuesList,
    this.defaultValueIndex = 0,
    this.onTap,
    required this.controller,
    this.isExpanded = false,
  }) : super(key: key);

  final List<String> valuesList;
  final int defaultValueIndex;
  final VoidCallback? onTap;

  /// The controller stores the selected value
  final TextEditingController controller;
  final bool isExpanded;

  @override
  State<PDropdownButton> createState() => _PDropdownButtonState();
}

class _PDropdownButtonState extends State<PDropdownButton> {
  int? currentValue;

  String getValue() {
    if (currentValue == null) {
      if (widget.valuesList.isEmpty) {
        widget.controller.text = '-1';
        return '';
      }
      widget.controller.text = widget.defaultValueIndex.toString();
      return widget.valuesList[widget.defaultValueIndex];
    }

    widget.controller.text = currentValue.toString();
    return widget.valuesList[currentValue ?? widget.defaultValueIndex];
  }

  @override
  Widget build(BuildContext context) {
    currentValue = int.tryParse(widget.controller.text);
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        isExpanded: widget.isExpanded,
        icon: const Icon(Icons.arrow_drop_down_rounded),
        value: getValue(),
        items: widget.valuesList.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            currentValue = widget.valuesList.indexOf(value!);
            widget.controller.text =
                widget.valuesList.indexOf(value).toString();
          });
          widget.onTap?.call();
        },
        borderRadius: BorderRadius.circular(10),
        elevation: 0,
      ),
    );
  }
}
