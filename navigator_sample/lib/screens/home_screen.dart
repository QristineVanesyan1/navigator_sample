import 'package:flutter/material.dart';
import 'package:navigator_sample/navigator/app_path.dart';
import 'package:navigator_sample/widgets/button_widget.dart';
import 'package:navigator_sample/styles/colors.dart';
import 'package:navigator_sample/data/topic_type.dart';
import 'package:navigator_sample/navigator/app_params.dart';

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
        backgroundColor: AppColors.darkGrey,
        appBar: AppBar(
          leading: const Icon(Icons.menu),
          backgroundColor: AppColors.grey,
          actions: const [_InfoWidget()],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 170, vertical: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _TitleWidget(),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.grey,
                    borderRadius: BorderRadius.circular(12),
                  ),
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
      padding: const EdgeInsets.only(bottom: 30),
      child: const Text(
        "Features",
        style: TextStyle(fontSize: 40, color: Color(0xFFE2E2E2)),
      ),
    );
  }
}

class _InfoWidget extends StatelessWidget {
  const _InfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(10),
        child: InkWell(
          onTap: _onTap,
          child: const Icon(Icons.info),
        ));
  }

  void _onTap() =>
      AppParams.delegate.setNewRoutePath(AppPathModel(path: 'info')); //todo: ??
}
