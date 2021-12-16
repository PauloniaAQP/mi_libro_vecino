import 'package:flutter/material.dart';
import 'package:mi_libro_vecino/ui_utils/colors.dart';

class SearchWidget extends StatefulWidget {
  SearchWidget({Key? key}) : super(key: key);

  bool isSearching = false;
  int items = 3;
  TextEditingController textEditControler =TextEditingController();

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: 800,
      height: widget.isSearching ? 75.5 * widget.items : 80,
      constraints: BoxConstraints(
        minWidth: MediaQuery.of(context).size.width * 0.5,
      ),
      decoration: BoxDecoration(
        color: PColors.whiteBackground,
        borderRadius: BorderRadius.circular(40),
      ),
      duration: const Duration(milliseconds: 1000),
      curve: Curves.fastOutSlowIn,
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                fit: FlexFit.tight,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(35, 15, 0, 15),
                  child: TextField(
                    controller: widget.textEditControler,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Buscar por distrito, provincia o departamento',
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
                      if (value != '') {
                        setState(() {
                          widget.isSearching = true;
                        });
                      } else {
                        setState(() {
                          widget.isSearching = false;
                          widget.textEditControler.clear();
                        });
                      }
                    },
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                height: 61,
                child: FloatingActionButton(
                  onPressed: () {
                    if (widget.isSearching) {
                      setState(() {
                        widget.isSearching = false;
                      });
                    }
                  },
                  child: Icon(
                    (widget.isSearching) ? Icons.close : Icons.search_outlined,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          if (widget.isSearching) ...[
            const Divider(
              color: PColors.gray1,
              height: 0.1,
              endIndent: 15,
              indent: 15,
            ),
            Flexible(
              fit: FlexFit.tight,
              child: ListView.builder(
                itemCount: widget.items,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('Resultado $index'),
                  );
                },
              ),
            ),
          ]
        ],
      ),
    );
  }
}
