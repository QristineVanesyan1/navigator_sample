import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:navigator_sample/navigator/app_path.dart';
import 'package:navigator_sample/models/topic_type.dart';
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
        InkWell(onTap: _onTap, child: _renderResizableContent()),
        const DividerWidget()
      ],
    );
  }

  Widget _renderResizableContent() {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    if (screenWidth > 800) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: CircularImageWidget(
              url: widget.topicType.getImage(),
              size: CircularImageSize.big,
            ),
          ),
          Expanded(
            child: Padding(
              padding: MediaQuery.of(context).size.width > 800
                  ? const EdgeInsets.fromLTRB(10, 20, 40, 20)
                  : const EdgeInsets.fromLTRB(0, 10, 20, 10),
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
      );
    } else {
      return Column(
        children: [
          CircularImageWidget(
            url: widget.topicType.getImage(),
            size: CircularImageSize.big,
          ),
          _TopicSummaryWidget(
            topicType: widget.topicType,
          ),
        ],
      );
    }
  }

  void _onTap() =>
      Router.of(context).routerDelegate.setNewRoutePath(AppPathModel(
            path: widget.topicType.name,
          ));
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
    return kIsWeb && MediaQuery.of(context).size.width > 800
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
