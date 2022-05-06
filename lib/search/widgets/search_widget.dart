import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mi_libro_vecino/l10n/l10n.dart';
import 'package:mi_libro_vecino/router/app_routes.dart';
import 'package:mi_libro_vecino/search/cubit/search_cubit.dart';
import 'package:mi_libro_vecino/ui_utils/colors.dart';
import 'package:mi_libro_vecino/ui_utils/functions.dart';

class SearchWidget extends StatefulWidget {
  SearchWidget({Key? key}) : super(key: key);

  final TextEditingController textEditControler = TextEditingController();

  @override
  SearchWidgetState createState() => SearchWidgetState();
}

class SearchWidgetState extends State<SearchWidget> {
  final double _searchHeight = 81;
  final double _suggestionHeight = 50.5;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        final _heightWithSuggestions =
            _searchHeight + _suggestionHeight * state.suggestions.length;

        return AnimatedContainer(
          width: 800,
          height: state is SearchQueryChanged
              ? _heightWithSuggestions
              : _searchHeight,
          constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width * 0.5,
            maxHeight: MediaQuery.of(context).size.height * 0.4,
          ),
          decoration: BoxDecoration(
            color: PColors.whiteBackground,
            borderRadius: BorderRadius.circular(40),
          ),
          duration: const Duration(milliseconds: 1000),
          curve: Curves.fastOutSlowIn,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    fit: FlexFit.tight,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(30, 15, 0, 15),
                      child: Material(
                        child: TextField(
                          controller: widget.textEditControler,
                          decoration: InputDecoration(
                            focusedBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            hintText: context.l10n.searchPageSearchBy,
                            hintStyle:
                                Theme.of(context).textTheme.bodyText2!.apply(
                                      color: PColors.gray2,
                                      fontSizeDelta: 2,
                                    ),
                          ),
                          style: Theme.of(context).textTheme.bodyText2!.apply(
                                color: PColors.black,
                                fontSizeDelta: 2,
                              ),
                          onChanged: (value) {
                            setState(() {
                              BlocProvider.of<SearchCubit>(context)
                                  .onSearchQueryChanged(value);
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    height: 61,
                    child: FloatingActionButton(
                      onPressed: () {
                        widget.textEditControler.clear();

                        if (state.isSearching) {
                          BlocProvider.of<SearchCubit>(context)
                              .onSearchQueryChanged('');
                        }
                      },
                      backgroundColor: (state.isSearching) ? PColors.red : null,
                      child: Icon(
                        (state.isSearching)
                            ? Icons.close
                            : Icons.search_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              if (state is SearchQueryChanged &&
                  state.suggestions.isNotEmpty) ...[
                const Divider(
                  color: PColors.gray1,
                  height: 0.1,
                  endIndent: 15,
                  indent: 15,
                ),
                Flexible(
                  fit: FlexFit.tight,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 17),
                    child: ListView.builder(
                      itemCount: state.suggestions.length,
                      itemBuilder: (context, index) {
                        /// Here only the searchKey will be in bold
                        /// So we need to separate from the rest
                        String before, searchKey, after;
                        final suggestionName =
                            getNameFromUbigeo(state.suggestions[index]);
                        final indexOfSubstr =
                            suggestionName.toLowerCase().indexOf(
                                  widget.textEditControler.text.toLowerCase(),
                                );
                        before = suggestionName.substring(0, indexOfSubstr);
                        searchKey = suggestionName.substring(
                          indexOfSubstr,
                          indexOfSubstr + widget.textEditControler.text.length,
                        );
                        after = suggestionName.substring(
                          indexOfSubstr + widget.textEditControler.text.length,
                        );
                        if (indexOfSubstr == -1) {
                          return const SizedBox();
                        }

                        return ListTile(
                          onTap: () {
                            final ubigeoCode = getUbigeoCodeFromUbigeo(
                              state.suggestions[index],
                            );
                            context.read<SearchCubit>().cleanSearchQuery();
                            context
                                .go('${Routes.libraries}?search=$ubigeoCode');
                          },
                          title: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: before,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .apply(
                                        color: PColors.gray2,
                                        fontSizeDelta: 2,
                                      ),
                                ),
                                TextSpan(
                                  text: searchKey,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .apply(
                                        color: PColors.black,
                                        fontSizeDelta: 2,
                                        fontWeightDelta: 3,
                                      ),
                                ),
                                TextSpan(
                                  text: after,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .apply(
                                        color: PColors.gray2,
                                        fontSizeDelta: 2,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ]
            ],
          ),
        );
      },
    );
  }
}
