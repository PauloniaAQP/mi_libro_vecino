import 'package:flutter/material.dart';
import 'package:mi_libro_vecino/l10n/l10n.dart';
import 'package:mi_libro_vecino/ui_utils/colors.dart';
import 'package:mi_libro_vecino/ui_utils/constans/assets.dart';

class AdminExpandMenu extends StatefulWidget {
  const AdminExpandMenu({
    Key? key,
  }) : super(key: key);

  static const double maxHeight = 120;

  @override
  State<AdminExpandMenu> createState() => _AdminExpandMenuState();
}

class _AdminExpandMenuState extends State<AdminExpandMenu>
    with SingleTickerProviderStateMixin {
  bool isExpanded = false;
  Tween<double> tween = Tween<double>(begin: 10, end: 60);
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void initState() {
    animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    animation = tween.animate(animationController)
      ..addListener(() {
        setState(() {});
      });
    super.initState();
    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return AnimatedContainer(
      height: isExpanded ? AdminExpandMenu.maxHeight : 70,
      width: 160,
      margin: const EdgeInsets.only(top: 15, right: 30),
      duration: const Duration(milliseconds: 600),
      curve: Curves.fastOutSlowIn,
      onEnd: () {
        animationController.stop();
      },
      child: Material(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: InkWell(
          hoverColor: Theme.of(context).scaffoldBackgroundColor,
          onTap: () {
            setState(() {
              isExpanded = !isExpanded;
              if (isExpanded) {
                animationController.forward();
              } else {
                animationController.reverse();
              }
            });
          },
          child: Column(
            children: [
              Flexible(
                child: Row(
                  children: [
                    const CircleAvatar(
                      backgroundImage: AssetImage(Assets.testImg),
                      radius: 20,
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Text(
                        'Josefina',
                        style: Theme.of(context).textTheme.button!.copyWith(
                              color: PColors.black,
                              fontSize: 14,
                            ),
                            overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Icon(
                      isExpanded ? Icons.expand_less : Icons.expand_more,
                      color: PColors.black,
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Visibility(
                visible: isExpanded,
                child: SizedBox(
                  width: double.infinity,
                  height: animation.value,
                  child: RawMaterialButton(
                    fillColor: const Color(0xFFF5F5F5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 0,
                    onPressed: () {},
                    child: Text(
                      l10n.adminPageLogoutButton,
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            color: Colors.black,
                          ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
