import 'package:flutter/material.dart';
import 'package:msf/data/constant.dart';
import 'package:msf/widgets/back_button.dart';

class MsfAppBar extends PreferredSize {
  MsfAppBar({
    Key? key,
    this.canGoBack = true,
    this.title = AppConstants.app_name,
  }) : super(
          child: _MsfAppBarContent(canGoBack, title),
          preferredSize: Size.fromHeight(58),
        );

  final bool canGoBack;
  final String title;
}

class _MsfAppBarContent extends StatelessWidget {
  _MsfAppBarContent(this.canGoBack, this.title);

  final bool canGoBack;
  final String title;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        height: 58,
        child: Stack(
          children: [
            Positioned(
              child: Align(
                alignment: Alignment.center,
                child: Text(title, style: _getTitleStyle(context)),
              ),
            ),
            if (canGoBack) Positioned(left: 0, top: 10, child: MsfBackButton()),
          ],
        ),
      ),
    );
  }

  TextStyle? _getTitleStyle(BuildContext context) => Theme.of(context)
      .textTheme
      .headline6
      ?.copyWith(fontWeight: FontWeight.bold);
}
