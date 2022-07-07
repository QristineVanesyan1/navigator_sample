import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const widgets = [_NotFoundWidget(), _MessageWidget()];
    return Scaffold(
        body: Center(
      child: kIsWeb
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: widgets,
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center, children: widgets),
    ));
  }
}

class _NotFoundWidget extends StatelessWidget {
  const _NotFoundWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(right: kIsWeb ? 20 : 0, bottom: kIsWeb ? 0 : 20),
      child: Image(
          image: AssetImage('assets/icons/error_404.png'),
          height: kIsWeb ? 180 : 100,
          color: Colors.grey),
    );
  }
}

class _MessageWidget extends StatelessWidget {
  const _MessageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SelectableText('Oops!',
            style: kIsWeb
                ? Theme.of(context).textTheme.headline1
                : Theme.of(context).textTheme.headline2),
        Flexible(
          child: Text("The page you were looking for \ndoes not exist",
              overflow: TextOverflow.ellipsis,
              style: kIsWeb
                  ? Theme.of(context).textTheme.headline2
                  : Theme.of(context).textTheme.headline3),
        ),
      ],
    );
  }
}
