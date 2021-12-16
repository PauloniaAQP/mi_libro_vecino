import 'package:flutter/material.dart';
import 'package:mi_libro_vecino/search/widgets/search_widget.dart';
import 'package:mi_libro_vecino/ui_utils/colors.dart';
import 'package:mi_libro_vecino/ui_utils/constans/assets.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PColors.purple,
      appBar: AppBar(
        leadingWidth: 120,
        leading: const Padding(
          padding: EdgeInsets.symmetric(vertical: 22),
          child: Image(
            image: AssetImage(Assets.logo),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              'Soy biblioteca',
              style: Theme.of(context).textTheme.subtitle1!.apply(
                    color: PColors.white,
                    fontWeightDelta: 1,
                  ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
            child: Container(
              width: 158,
              height: 40,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: ElevatedButton(
                onPressed: () {},
                child: Text(
                  'Siguenos',
                  style: Theme.of(context).textTheme.subtitle1!.apply(
                        color: PColors.white,
                        fontWeightDelta: 1,
                      ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Amet minim mollit non deserunt est sit aliqua.',
                style: Theme.of(context).textTheme.button!.apply(
                      color: PColors.white,
                      fontSizeDelta: 4,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                '¿Donde quieres buscar librerías?',
                style: Theme.of(context).textTheme.headline1!.apply(
                      color: PColors.white,
                      fontSizeDelta: 2,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              Text(
                'Amet minim mollit non deserunt est sit aliqua.',
                style: Theme.of(context).textTheme.subtitle1!.apply(
                      color: PColors.white,
                      fontWeightDelta: 1,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              SearchWidget()
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        height: 55,
        color: const Color(0xFF1D1A3F),
        child: Stack(
          children: [
            Center(
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width - 180,
                ),
                child: Text(
                  'Copyright 2021 Mi Libro Vecino. Todos los derechos reservados',
                  style: Theme.of(context).textTheme.subtitle1!.apply(
                        color: PColors.white,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'Admin',
                    style: Theme.of(context).textTheme.subtitle1!.apply(
                          color: PColors.white,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
