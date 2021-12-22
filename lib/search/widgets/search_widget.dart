import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mi_libro_vecino/search/cubit/search_cubit.dart';
import 'package:mi_libro_vecino/ui_utils/colors.dart';

class SearchWidget extends StatefulWidget {
  SearchWidget({Key? key}) : super(key: key);

  final TextEditingController textEditControler = TextEditingController();

  @override
  SearchWidgetState createState() => SearchWidgetState();
}

class SearchWidgetState extends State<SearchWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        return AnimatedContainer(
          width: 800,
          height: state is SearchQueryChanged
              ? 85 + 50.5 * state.suggestions.length - 1
              : 80,
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
                      padding: const EdgeInsets.fromLTRB(35, 15, 0, 15),
                      child: Material(
                        child: TextField(
                          controller: widget.textEditControler,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText:
                                'Buscar por distrito, provincia o departamento',
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
                    child: Expanded(
                      child: ListView.builder(
                        itemCount: state.suggestions.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            onTap: () {},
                            title: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: state.suggestions[index].substring(
                                      0,
                                      widget.textEditControler.text.length,
                                    ),
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
                                    text: state.suggestions[index].substring(
                                      widget.textEditControler.text.length,
                                    ),
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
                ),
              ]
            ],
          ),
        );
      },
    );
  }
}
