import 'package:flutter/material.dart';
import 'package:mi_libro_vecino/ui_utils/colors.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: Container(
              // color: Colors.red,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    'https://media.baamboozle.com/uploads/images/134328/1622428133_284548.jpeg',
                  ),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    PColors.purple,
                    BlendMode.darken,
                  ),
                ),
              ),
              child: Center(
                child: Text('jelou'),
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}
