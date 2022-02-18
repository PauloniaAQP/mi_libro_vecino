
import 'package:flutter/material.dart';
import 'package:mi_libro_vecino/l10n/l10n.dart';
import 'package:mi_libro_vecino/ui_utils/colors.dart';
import 'package:mi_libro_vecino/ui_utils/constans/assets.dart';

class AdminLibraryCard extends StatelessWidget {
  const AdminLibraryCard({
    Key? key,
    required this.title,
    required this.name,
    required this.labels,
    required this.onContact,
    required this.onTap,
  }) : super(key: key);

  final String title;
  final String name;
  final List<String> labels;
  final VoidCallback onContact;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(16),
          height: 163,
          child: Row(
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: Container(
                  width: 300,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(14),
                    image: const DecorationImage(
                      image: AssetImage(Assets.testImg),
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
                      title,
                      style: Theme.of(context).textTheme.button!.copyWith(
                            fontSize: 18,
                            color: PColors.black,
                          ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      name,
                      style: Theme.of(context).textTheme.button!.copyWith(
                            fontWeight: FontWeight.w500,
                            color: PColors.gray1,
                          ),
                    ),
                    const SizedBox(height: 14),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
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
                        TextButton(
                          onPressed: onContact,
                          child: Text(l10n.adminPageContactButton),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
