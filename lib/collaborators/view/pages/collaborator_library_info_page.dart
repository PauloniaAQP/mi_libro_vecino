import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mi_libro_vecino/collaborators/components/collaborators_library_form.dart';
import 'package:mi_libro_vecino/collaborators/cubit/collaborator_cubit.dart';
import 'package:responsive_builder/responsive_builder.dart';

class CollaboratorLibraryInfoPage extends StatelessWidget {
  const CollaboratorLibraryInfoPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width * 0.05;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(_width, 106, 0, 0),
        child: ScreenTypeLayout(
          mobile: Expanded(
            flex: 2,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.fromLTRB(_width, 0, _width * 3, 0),
                child: Column(
                  children: [
                    AspectRatio(
                      aspectRatio: 2,
                      child: BlocBuilder<CollaboratorCubit, CollaboratorState>(
                        builder: (context, state) {
                          return Container(
                            height: _width,
                            width: _width,
                            decoration: BoxDecoration(
                              image: (state.libraryImage == null)
                                  ? null
                                  : DecorationImage(
                                      image: MemoryImage(state.libraryImage!),
                                      fit: BoxFit.cover,
                                    ),
                              color: Colors.black12,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          );
                        },
                      ),
                    ),
                    const CollaboratorsLibraryForm(),
                  ],
                ),
              ),
            ),
          ),
          desktop: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: AspectRatio(
                  aspectRatio: 1 / 1,
                  child: BlocBuilder<CollaboratorCubit, CollaboratorState>(
                    builder: (context, state) {
                      return Container(
                        height: 232,
                        width: 232,
                        decoration: BoxDecoration(
                          image: (state.libraryImage == null)
                              ? null
                              : DecorationImage(
                                  image: MemoryImage(state.libraryImage!),
                                  fit: BoxFit.cover,
                                ),
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(_width, 0, _width * 3, 0),
                    child: const CollaboratorsLibraryForm(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
