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
  final TextEditingController controller;
  final bool isExpanded;

  @override
  State<PDropdownButton> createState() => _PDropdownButtonState();
}

class _PDropdownButtonState extends State<PDropdownButton> {
  String? currentValue;

  String getValue() {
    if (currentValue == null) {
      if (widget.valuesList.isEmpty) {
        widget.controller.text = '';
        return '';
      }
      widget.controller.text = widget.valuesList[widget.defaultValueIndex];
      return widget.valuesList[widget.defaultValueIndex];
    }

    widget.controller.text = currentValue ?? '';
    return currentValue ?? '';
  }

  @override
  Widget build(BuildContext context) {
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
            currentValue = value;
          });
          widget.onTap?.call();
        },
        borderRadius: BorderRadius.circular(10),
        elevation: 0,
      ),
    );
  }
}
