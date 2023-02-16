import 'package:flutter/material.dart';
import 'package:mi_libro_vecino/l10n/l10n.dart';
import 'package:mi_libro_vecino/ui_utils/colors.dart';
import 'package:mi_libro_vecino/ui_utils/constans/assets.dart';
import 'package:responsive_builder/responsive_builder.dart';

class QuotesPage extends StatelessWidget {
  const QuotesPage({
    Key? key,
    required this.imagesPath,
    this.index = 0,
    this.alignment = Alignment.center,
  }) : super(key: key);

  final List<String> imagesPath;
  final int index;
  final AlignmentGeometry alignment;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const SizedBox(width: 5),
            const Image(
              image: AssetImage(Assets.facebookLogo),
              height: 32,
            ),
            Expanded(
              child: Text(
                l10n.registerFacebookAccount,
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: PColors.white,
                    ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50),
        child: ResponsiveBuilder(
          builder: (BuildContext context, SizingInformation sizingInformation) {
            return Flex(
              direction:
                  sizingInformation.deviceScreenType == DeviceScreenType.desktop
                      ? Axis.vertical
                      : Axis.horizontal,
              children: [
                Expanded(
                  flex: sizingInformation.deviceScreenType ==
                          DeviceScreenType.desktop
                      ? 5
                      : 1,
                  child: Align(
                    alignment: alignment,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: (alignment == Alignment.center)
                            ? MediaQuery.of(context).size.width * 0.03
                            : 0.0,
                        vertical: 20,
                      ),
                      child: Image(
                        image: AssetImage(imagesPath[index]),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60),
                  child: Expanded(
                    child: Align(
                      alignment: sizingInformation.deviceScreenType ==
                              DeviceScreenType.desktop
                          ? Alignment.topRight
                          : Alignment.center,
                      child: Text(
                        '"Estamos habitados por libros y por amigos".\n '
                        'Daniel Pennac.',
                        style: sizingInformation.deviceScreenType ==
                                DeviceScreenType.desktop
                            ? Theme.of(context)
                                .textTheme
                                .headline3!
                                .copyWith(color: PColors.white)
                            : Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(color: PColors.white),
                        textAlign: TextAlign.right,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 5,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
