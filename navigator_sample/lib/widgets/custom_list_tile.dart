import 'package:flutter/material.dart';
import 'package:navigator_sample/constants/constants.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile(
      {required this.title,
      required this.subtitle,
      required this.publishedAt,
      required this.url,
      required this.onTap,
      Key? key})
      : super(key: key);
  final String title;
  final String subtitle;
  final DateTime publishedAt;
  final String url;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              const _LeadingWidget(),
              _ContentWidget(
                  title: title, subtitle: subtitle, publishedAt: publishedAt),
            ],
          ),
        ),
      ),
    );
  }
}

class _ContentWidget extends StatelessWidget {
  const _ContentWidget(
      {required this.title,
      required this.subtitle,
      required this.publishedAt,
      Key? key})
      : super(key: key);
  final String title;
  final String subtitle;
  final DateTime publishedAt;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 16),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Text(
              subtitle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ),
          _PublicationDateWidget(
            publishedAt: publishedAt,
          )
        ],
      ),
    );
  }
}

class _LeadingWidget extends StatelessWidget {
  const _LeadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15.0),
      child: CircleAvatar(
        backgroundColor: Colors.grey[300],
      ),
    );
  }
}

class _PublicationDateWidget extends StatelessWidget {
  const _PublicationDateWidget({required this.publishedAt, Key? key})
      : super(key: key);
  final DateTime publishedAt;

  String get _getFormattedDateTime => Constants.dateFormat.format(publishedAt);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 8.0),
      alignment: Alignment.bottomRight,
      child: Text(
        _getFormattedDateTime,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
            fontSize: 12, color: Colors.grey, fontStyle: FontStyle.italic),
      ),
    );
  }
}
