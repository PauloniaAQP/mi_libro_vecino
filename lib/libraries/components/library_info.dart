import 'package:flutter/material.dart';
import 'package:mi_libro_vecino/l10n/l10n.dart';
import 'package:mi_libro_vecino/ui_utils/colors.dart';
import 'package:mi_libro_vecino/ui_utils/constans/assets.dart';

class InfomationLibrary extends StatelessWidget {
  const InfomationLibrary({
    Key? key,
    required this.libraryId,
  }) : super(key: key);

  final String libraryId;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      body: Column(
        children: [
          /// This space is for the search bar
          const SizedBox(height: 90),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 280,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          Assets.testImg,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: IconButton(
                          icon: Image.asset(
                            Assets.backIcon,
                            color: Colors.white,
                          ),
                          iconSize: 45,
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                          3,
                          (index) => const Chip(
                            label: Text('Etiquetas propias'),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    'La librería que tiene todo, en el centro de Arequipa',
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        const Icon(Icons.location_on),
                        const SizedBox(width: 14),
                        Text(
                          'Avenida Arequipa 40041',
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.caption!.copyWith(
                                fontSize: 16,
                                color: PColors.gray1,
                              ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Row(
                      children: [
                        const Icon(Icons.language_outlined),
                        const SizedBox(width: 6),
                        Flexible(
                          child: TextButton(
                            onPressed: () {},
                            child: Text(
                              l10n.libraryInformationWebsite,
                              style: const TextStyle(
                                color: PColors.blue,
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.w300,
                                height: 1.5,
                                fontSize: 16,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.north_east_outlined,
                          color: PColors.blue,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet.',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 8,
                    style: Theme.of(context).textTheme.caption!.copyWith(
                          fontSize: 16,
                          color: PColors.black,
                        ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 40),
                    child: Divider(),
                  ),
                  Row(
                    children: [
                      Container(
                        color: PColors.green,
                        height: 20,
                        width: 5,
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          l10n.libraryInfoAdtionalInformation,
                          style: Theme.of(context).textTheme.button,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              l10n.libraryInfoTimetable,
                              style: Theme.of(context).textTheme.button,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 13),
                            Row(
                              children: [
                                const Icon(
                                  Icons.schedule,
                                  color: PColors.gray1,
                                ),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    '9:00 a.m. - 10:00 p.m.',
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption!
                                        .copyWith(
                                          color: PColors.gray1,
                                          fontSize: 16,
                                        ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              l10n.libraryInfoRol,
                              style: Theme.of(context).textTheme.button,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 13),
                            Row(
                              children: [
                                const Icon(
                                  Icons.bookmark_border,
                                  color: PColors.gray1,
                                ),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    '9:00 a.m. - 10:00 p.m.',
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption!
                                        .copyWith(
                                          color: PColors.gray1,
                                          fontSize: 16,
                                        ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Text(
                    l10n.libraryInfoAditionalServices,
                    style: Theme.of(context).textTheme.button,
                  ),
                  const SizedBox(height: 13),
                  Row(
                    children: [
                      Image.asset(
                        Assets.handIcon,
                        width: 18,
                        height: 18,
                        color: PColors.gray1,
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          'Presto libros - Vendo libros - Edito libros - Recomiendo libros',
                          style: Theme.of(context).textTheme.caption!.copyWith(
                                color: PColors.gray1,
                                fontSize: 16,
                              ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 40),
                    child: Divider(),
                  ),
                  Row(
                    children: [
                      Container(
                        color: PColors.blue,
                        height: 20,
                        width: 5,
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          l10n.libraryInfoPersonalInformation,
                          style: Theme.of(context).textTheme.button,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 93,
                          height: 93,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: const DecorationImage(
                              image: AssetImage(Assets.testImg),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 17),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Jessica Robles',
                                style: Theme.of(context).textTheme.button,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  Image.asset(
                                    Assets.phoneIcon,
                                    width: 18,
                                    height: 18,
                                    color: PColors.gray1,
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      '+51 999 999 999',
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption!
                                          .copyWith(
                                            color: PColors.gray1,
                                            fontSize: 16,
                                          ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
