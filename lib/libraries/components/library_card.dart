import 'package:flutter/material.dart';
import 'package:mi_libro_vecino/ui_utils/colors.dart';
import 'package:mi_libro_vecino/ui_utils/general_widgets/one_line_labels_list.dart';
import 'package:paulonia_cache_image/paulonia_cache_image.dart';
import 'package:paulonia_utils/paulonia_utils.dart';

class LibraryCard extends StatefulWidget {
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
  State<LibraryCard> createState() => _LibraryCardState();
}

class _LibraryCardState extends State<LibraryCard> {
  bool _isHovering = false;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        key: const Key('libraryCardInkwellKey'),
        onTap: widget.onTap,
        onHover: (value) {
          setState(() => _isHovering = value);
        },
        hoverColor: Colors.white,
        child: Container(
          height: 163,
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.fromLTRB(8, 8, 14, 8),
          decoration: BoxDecoration(
            color: PColors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(.5),
                blurRadius: _isHovering ? 8.0 : 1.0,
                spreadRadius: _isHovering ? 1.0 : 0.0,
              )
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 128,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  image: PUtils.isOnTest()
                      ? null
                      : DecorationImage(
                          image:
                              PCacheImage(widget.gsUrl, enableInMemory: true),
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
                      widget.title,
                      style: Theme.of(context).textTheme.headline4!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: PColors.black,
                            fontSize: 18,
                          ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 14),
                    Text(
                      widget.subtitle,
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            fontWeight: FontWeight.w500,
                            color: PColors.gray1,
                          ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 18),
                    OneLineLabelsList(labelsList: widget.labels),
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
