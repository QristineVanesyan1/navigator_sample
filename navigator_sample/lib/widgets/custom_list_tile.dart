import 'package:flutter/material.dart';
import 'package:navigator_sample/constants/constants.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile(
      {required this.title,
      required this.subtitle,
      required this.dateTime,
      required this.url,
      required this.onTap,
      Key? key})
      : super(key: key);
  final String title;
  final String subtitle;
  final DateTime dateTime;
  final String url;
  final VoidCallback onTap;

  String get _getFormattedDateTime => Constants.dateFormat.format(dateTime);

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
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: CircleAvatar(
                  backgroundColor: Colors.grey[300],
                ),
              ),
              Expanded(
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
                        style:
                            const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 8.0),
                      alignment: Alignment.bottomRight,
                      child: Text(
                        _getFormattedDateTime,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            fontStyle: FontStyle.italic),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
