import 'package:flutter/material.dart';
import 'package:msf/widgets/back_button.dart';

class MsfAppBar extends StatelessWidget {
  const MsfAppBar({Key? key, this.canGoBack = true}) : super(key: key);

  final bool canGoBack;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 58,
      child: Stack(
        children: [
          Positioned(
            child: Align(
              alignment: Alignment.center,
              child: Text("Post for Blood Request",
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      ?.copyWith(fontWeight: FontWeight.bold)),
            ),
          ),
          if (canGoBack) Positioned(left: 0, top: 10, child: MsfBackButton()),
        ],
      ),
    );
  }
}
