import 'package:flutter/material.dart';
import 'package:mi_libro_vecino/libraries/components/library_card.dart';
import 'package:mi_libro_vecino/ui_utils/constans/assets.dart';

class LibrariesList extends StatelessWidget {
  const LibrariesList({
    Key? key,
    this.searchQuery,
  }) : super(key: key);

  final String? searchQuery ;

  @override
  Widget build(BuildContext context) {
    return Column(
      key: const Key('librariesListKey'),
      children: [
        /// This space is for the search bar
        const SizedBox(height: 90),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '100 resultados',
              style: Theme.of(context).textTheme.button!.copyWith(
                    fontSize: 20,
                  ),
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: List.generate(
                2,
                (index) => LibraryCard(
                  imgPath: Assets.testImg,
                  subtitle: 'Dirección física',
                  title: 'La librería que tiene todo, centro de Arequipa...',
                  labels: const ['Etiquetas propias', 'Etiquetas propias'],
                  onTap: () {},
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
