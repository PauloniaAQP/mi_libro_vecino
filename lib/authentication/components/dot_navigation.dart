import 'package:flutter/material.dart';
import 'package:mi_libro_vecino/authentication/components/dot_counter.dart';
import 'package:mi_libro_vecino/ui_utils/constans/assets.dart';

class DotNavigation extends StatelessWidget {
  const DotNavigation({
    Key? key,
    required this.index,
    required this.length,
    required this.onTapNext,
    required this.onTapBack,
  }) : super(key: key);

  final int length;
  final int index;
  final Function() onTapNext; 
  final Function() onTapBack; 

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 55,
          width: 55,
          child: IconButton(
            onPressed: onTapBack,
            icon: Image.asset(
              Assets.backIcon,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DotCounter(
                index: index,
                length: length,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 55,
          width: 55,
          child: IconButton(
            onPressed: onTapNext,
            icon: Image.asset(
              Assets.nextIcon,
            ),
          ),
        ),
      ],
    );
  }
}
