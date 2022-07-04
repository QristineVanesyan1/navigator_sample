import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:navigator_sample/navigator/app_path.dart';
import 'package:navigator_sample/data/topic_type.dart';
import 'package:navigator_sample/navigator/app_params.dart';
import 'package:navigator_sample/widgets/circular_image_widget.dart';
import 'package:navigator_sample/widgets/divider_widget.dart';
import 'package:navigator_sample/widgets/text_button_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class ButtonWidget extends StatefulWidget {
  final TopicType topicType;

  const ButtonWidget({required this.topicType, Key? key}) : super(key: key);

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
            onTap: _onTap,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircularImageWidget(),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(10, 20, 40, 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _TopicSummaryWidget(
                          topicType: widget.topicType,
                        ),
                        _ApiDetailsButtonWidget(
                          topicType: widget.topicType,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )),
        const DividerWidget()
      ],
    );
  }

  void _onTap() => AppParams.delegate
      .setNewRoutePath(AppPathModel(path: widget.topicType.name));
}

class _ApiDetailsButtonWidget extends StatelessWidget {
  const _ApiDetailsButtonWidget({required this.topicType, Key? key})
      : super(key: key);
  final TopicType topicType;

  @override
  Widget build(BuildContext context) {
    final buttons = <Widget>[
      TextButtonWidget(
          title: 'Documentation'.toUpperCase(),
          onTap: () => _onTopicButtonTap(topicType.getDocLink())),
      TextButtonWidget(
        title: 'API Endpoint'.toUpperCase(),
        onTap: () => _onTopicButtonTap(topicType.getEndPoint()),
      )
    ];
    return kIsWeb
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: buttons,
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: buttons,
          );
  }

  void _onTopicButtonTap(String link) {
    var uri = Uri.parse(link);
    launchUrl(uri);
  }
}

class _TopicSummaryWidget extends StatelessWidget {
  const _TopicSummaryWidget({required this.topicType, Key? key})
      : super(key: key);
  final TopicType topicType;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Text(
            topicType.getTitle(),
            style: Theme.of(context).textTheme.headline2,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: Text(
            topicType.getDesc(),
            style: Theme.of(context).textTheme.bodyText1,
            maxLines: kIsWeb ? null : 3,
          ),
        ),
      ],
    );
  }
}
