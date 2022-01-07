import 'package:flutter/material.dart';
import 'package:mi_libro_vecino/l10n/l10n.dart';
import 'package:mi_libro_vecino/libraries/components/libraries_appbar.dart';
import 'package:mi_libro_vecino/search/widgets/search_widget.dart';
import 'package:mi_libro_vecino/ui_utils/constans/assets.dart';

class LibrariesPage extends StatelessWidget {
  const LibrariesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    const imgPath = 'assets/images/library.jpeg';
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
                    const SizedBox(height: 100),
                    Text('test'),
                    FlutterLogo(
                      size: 200,
                    ),
                    Container(
                      height: 163,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          Container( /// CUBIT AND STATE FOR LIBRERY LIST AND INFORMATION LIBRARY
                            width: 128,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              image: DecorationImage(
                                image: AssetImage(imgPath),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              Text('aasdasdasd'),
                              Text('aasdasdasd'),
                              Chip(label: Text('asdasdasd')),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
                SearchWidget(),
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
