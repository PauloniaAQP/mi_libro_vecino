import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mi_libro_vecino/l10n/l10n.dart';
import 'package:mi_libro_vecino/libraries/cubit/libraries_cubit.dart';
import 'package:mi_libro_vecino/ui_utils/colors.dart';
import 'package:mi_libro_vecino/ui_utils/constans/assets.dart';
import 'package:mi_libro_vecino/ui_utils/functions.dart';
import 'package:mi_libro_vecino_api/models/library_model.dart';
import 'package:mi_libro_vecino_api/models/user_model.dart';
import 'package:mi_libro_vecino_api/utils/utils.dart';
import 'package:paulonia_cache_image/paulonia_cache_image.dart';
import 'package:paulonia_utils/paulonia_utils.dart';
import 'package:url_launcher/url_launcher.dart';

class InfomationLibrary extends StatelessWidget {
  const InfomationLibrary({
    Key? key,
    this.library,
  }) : super(key: key);

  final LibraryModel? library;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    if (library == null) {
      return Center(
        key: const Key('notFoundResultsKey'),
        child: Text(l10n.librariesListPageNotFoundResults),
      );
    }
    final openHourString = ApiUtils.timeOfDayToString(library!.openingHour);
    final closeHourString = ApiUtils.timeOfDayToString(library!.closingHour);
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
                    decoration: BoxDecoration(
                      image: PUtils.isOnTest()
                          ? null
                          : DecorationImage(
                              image: PCacheImage(library!.gsUrl),
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                          library!.services.length,
                          (index) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Chip(
                              label: Text(library!.services[index]),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    library!.name,
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        const Icon(Icons.location_on),
                        const SizedBox(width: 14),
                        Text(
                          library!.address,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.caption!.copyWith(
                                fontSize: 16,
                                color: PColors.gray1,
                              ),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: library!.website != null,
                    child: SizedBox(
                      width: double.infinity,
                      child: Row(
                        children: [
                          const Icon(Icons.language_outlined),
                          const SizedBox(width: 6),
                          Flexible(
                            child: TextButton(
                              onPressed: () {
                                try {
                                  launchUrl(
                                    Uri.parse(library!.website!),
                                    webOnlyWindowName: '_blank',
                                    mode: LaunchMode.externalApplication,
                                  );
                                } catch (e) {
                                  log(e.toString());
                                }
                              },
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
                  ),
                  const SizedBox(height: 18),
                  Text(
                    library!.description,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 8,
                    style: Theme.of(context).textTheme.caption!.copyWith(
                          fontSize: 16,
                          color: PColors.black,
                        ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 30),
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
                                    '$openHourString - $closeHourString',
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
                                    getStringRolByType(library!.type, l10n),
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
                          library!.services.join(', '),
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
                    padding: EdgeInsets.symmetric(vertical: 30),
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
                  FutureBuilder<UserModel?>(
                    future: context
                        .read<LibrariesCubit>()
                        .getOwner(library!.ownerId),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState != ConnectionState.done) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (snapshot.hasError || snapshot.data == null) {
                        return const Center(
                          child: Text('No se encontro el usuario'),
                        );
                      }
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 93,
                              height: 93,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: PUtils.isOnTest()
                                    ? null
                                    : DecorationImage(
                                        image: PCacheImage(
                                          snapshot.data?.gsUrl ?? '',
                                        ),
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
                                    snapshot.data?.name ?? '',
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
                                          snapshot.data?.phone ?? '',
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
                      );
                    },
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
