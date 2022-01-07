import 'package:flutter/material.dart';
import 'package:mi_libro_vecino/l10n/l10n.dart';
import 'package:mi_libro_vecino/libraries/components/libraries_appbar.dart';
import 'package:mi_libro_vecino/search/widgets/search_widget.dart';

class LibrariesPage extends StatelessWidget {
  const LibrariesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: const LibrariesAppBar(),
      body: Row(
        children: [
          Expanded(
            child: Stack(
              children: [
                const SizedBox(height: 16),
                Column(
                  children: [
                    const SizedBox(height: 16),
                    Text('test'),
                  ],
                ),
                SearchWidget(),
                FlutterLogo(size: 200,),
              ],
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
