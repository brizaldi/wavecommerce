import 'package:flutter/material.dart';

import '../constants/strings.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(Strings.errorMessage),
      ),
    );
  }
}
