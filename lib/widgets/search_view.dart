import 'package:flutter/material.dart';

class SearchView extends StatelessWidget {
  final void Function(String) onTextChange;

  SearchView({required this.onTextChange});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 16, right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 64,
            width: size.width * 0.9,
            child: Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        child: TextFormField(
                          onChanged: onTextChange,
                          style: TextStyle(
                            fontFamily: 'WorkSans',
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          //keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            filled: true,
                            labelText: 'For Search ',
                            border: InputBorder.none,
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              letterSpacing: 0.2,
                            ),
                          ),
                          //onEditingComplete: () {},
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 50,
                      height: 60,
                      child: Icon(Icons.search),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
