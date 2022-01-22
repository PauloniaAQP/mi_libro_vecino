import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mi_libro_vecino/admin/cubit/admin_cubit.dart';
import 'package:mi_libro_vecino/ui_utils/colors.dart';

class AdminSearchWidget extends StatelessWidget {
  const AdminSearchWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminCubit, AdminState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF9F9F9),
            borderRadius: BorderRadius.circular(100),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                fit: FlexFit.tight,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 15, 0, 15),
                  child: Material(
                    child: TextField(
                      controller: state.textEditControler,
                      decoration: InputDecoration(
                        focusedBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        hintText: 'Buscar',
                        hintStyle: Theme.of(context).textTheme.bodyText2!.apply(
                              color: PColors.gray2,
                              fontSizeDelta: 2,
                            ),
                      ),
                      style: Theme.of(context).textTheme.bodyText2!.apply(
                            color: PColors.black,
                            fontSizeDelta: 2,
                          ),
                      onChanged: (value) {
                        BlocProvider.of<AdminCubit>(context)
                            .onSearchQueryChanged(value);
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
                    state.textEditControler.clear();
                    if (state.isSearching) {
                      BlocProvider.of<AdminCubit>(context)
                          .onSearchQueryChanged('');
                    }
                  },
                  backgroundColor: (state.isSearching) ? PColors.red : null,
                  child: Icon(
                    (state.isSearching) ? Icons.close : Icons.search_outlined,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
