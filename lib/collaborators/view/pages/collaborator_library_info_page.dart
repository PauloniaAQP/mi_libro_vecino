import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mi_libro_vecino/collaborators/components/collaborators_library_form.dart';
import 'package:mi_libro_vecino/collaborators/cubit/collaborator_cubit.dart';

class CollaboratorLibraryInfoPage extends StatelessWidget {
  const CollaboratorLibraryInfoPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width * 0.05;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(_width, 106, _width, 0),
        child: Row(
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
            SizedBox(width: _width),
            const Expanded(
              flex: 2,
              child: CollaboratorsLibraryForm(),
            ),
            SizedBox(width: _width * 2),
          ],
        ),
      ),
    );
  }
}
