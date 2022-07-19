import 'package:flutter/material.dart';
import 'package:mi_libro_vecino/ui_utils/colors.dart';
import 'package:mi_libro_vecino/ui_utils/general_widgets/one_line_labels_list.dart';
import 'package:paulonia_cache_image/paulonia_cache_image.dart';
import 'package:paulonia_utils/paulonia_utils.dart';

class AdminLibraryCard extends StatefulWidget {
  const AdminLibraryCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.labels,
    required this.onTap,
    required this.gsUrl,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final String gsUrl;
  final List<String> labels;
  final VoidCallback onTap;

  @override
  State<AdminLibraryCard> createState() => _AdminLibraryCardState();
}

class _AdminLibraryCardState extends State<AdminLibraryCard> {
  bool isOnHover = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      child: Card(
        elevation: 1,
        child: InkWell(
          onHover: (value) {
            setState(() {
              isOnHover = value;
            });
          },
          onTap: widget.onTap,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: PColors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: PColors.gray3,
                  spreadRadius: isOnHover ? 10 : 0.5,
                  blurRadius: 5,
                ),
              ],
            ),
            height: 163,
            child: Row(
              children: [
                AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    width: 300,
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(14),
                      image: PUtils.isOnTest()
                          ? null
                          : DecorationImage(
                              image: PCacheImage(
                                widget.gsUrl,
                                enableInMemory: true,
                              ),
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 9),
                      Text(
                        widget.title,
                        style: Theme.of(context).textTheme.button!.copyWith(
                              fontSize: 18,
                              color: PColors.black,
                            ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 14),
                      Text(
                        widget.subtitle,
                        style: Theme.of(context).textTheme.button!.copyWith(
                              fontWeight: FontWeight.w500,
                              color: PColors.gray1,
                            ),
                      ),
                      const SizedBox(height: 14),
                      OneLineLabelsList(labelsList: widget.labels),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
