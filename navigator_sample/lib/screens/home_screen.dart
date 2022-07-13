import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:navigator_sample/navigator/app_path.dart';
import 'package:navigator_sample/widgets/button_widget.dart';
import 'package:navigator_sample/models/topic_type.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final buttons = [TopicType.articles, TopicType.blogs, TopicType.reports];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.menu),
          actions: const [_InfoWidget()],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.08,
                vertical: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _TitleWidget(),
                Card(
                  child: Column(
                      children: List.generate(buttons.length,
                          (index) => ButtonWidget(topicType: buttons[index]))),
                ),
              ],
            ),
          ),
        ));
  }
}

class _TitleWidget extends StatelessWidget {
  const _TitleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: kIsWeb
            ? const EdgeInsets.only(bottom: 30)
            : const EdgeInsets.only(bottom: 10),
        child: SelectableText("Features",
            style: Theme.of(context).textTheme.headline1));
  }
}

class _InfoWidget extends StatefulWidget {
  const _InfoWidget({Key? key}) : super(key: key);

  @override
  State<_InfoWidget> createState() => _InfoWidgetState();
}

class _InfoWidgetState extends State<_InfoWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(10),
        child: InkWell(
          onTap: _onTap,
          child: const Icon(Icons.info),
        ));
  }

  void _onTap() => Router.of(context)
      .routerDelegate
      .setNewRoutePath(AppPathModel(path: 'info'));
}
