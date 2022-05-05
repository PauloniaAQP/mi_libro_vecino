import 'package:flutter/material.dart';
import 'package:mi_libro_vecino/ui_utils/colors.dart';
import 'package:paulonia_cache_image/paulonia_cache_image.dart';
import 'package:paulonia_utils/paulonia_utils.dart';

class LibraryCard extends StatelessWidget {
  const LibraryCard({
    Key? key,
    required this.gsUrl,
    required this.title,
    required this.subtitle,
    required this.labels,
    required this.onTap,
  }) : super(key: key);

  final String gsUrl;
  final String title;
  final String subtitle;
  final List<String> labels;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        key: const Key('libraryCardInkwellKey'),
        onTap: onTap,
        child: Container(
          height: 163,
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 128,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  image: PUtils.isOnTest()
                      ? null
                      : DecorationImage(
                          image: PCacheImage(gsUrl),
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.headline4!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: PColors.black,
                            fontSize: 18,
                          ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 14),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            fontWeight: FontWeight.w500,
                            color: PColors.gray1,
                          ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 18),
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(
                            labels.length,
                            (index) => Chip(
                              label: Text(labels[index]),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
