import 'package:flutter/material.dart';
import 'package:mi_libro_vecino/ui_utils/colors.dart';

class SuffixTime extends StatelessWidget {
  const SuffixTime({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Container(
            height: 24,
            width: 1,
            color: PColors.gray2,
          ),
        ),
        DropdownButton<String>(
          icon: const Icon(Icons.arrow_drop_down_rounded),
          value: 'AM',
          items: <String>[
            'AM',
            'PM',
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (value) {},
        )
      ],
    );
  }
}
