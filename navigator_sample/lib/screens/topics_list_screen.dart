import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:navigator_sample/navigator/app_path.dart';
import 'package:navigator_sample/data/topic_type.dart';
import 'package:navigator_sample/data/data_source.dart';
import 'package:navigator_sample/navigator/app_params.dart';
import 'package:navigator_sample/models/report.dart';
import 'package:navigator_sample/widgets/progress_widget.dart';
import 'package:intl/intl.dart';

class TopicsListScreen extends StatefulWidget {
  const TopicsListScreen({required this.valueKey}) : super(key: valueKey);
  final ValueKey<String> valueKey;

  @override
  State<TopicsListScreen> createState() => _TopicsListScreenState();
}

class _TopicsListScreenState extends State<TopicsListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(onPressed: () => Navigator.of(context).pop()),
        ),
        body: FutureBuilder<List<Report>>(
          future:
              DataSource().fetchData(TopicType.getType(widget.valueKey.value)),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                  child: Padding(
                padding: kIsWeb
                    ? const EdgeInsets.symmetric(horizontal: 170, vertical: 50)
                    : const EdgeInsets.all(20),
                child: Card(
                    child: Column(
                  children: List.generate(
                      snapshot.data.length,
                      (index) => CustomListTile(
                            title: snapshot.data[index].title,
                            subtitle: snapshot.data[index].summary,
                            url: snapshot.data[index].imageUrl,
                            dateTime: snapshot.data[index].publishedAt,
                            onTap: () => AppParams.delegate.setNewRoutePath(
                                AppPathModel(
                                    path:
                                        '${widget.valueKey.value}/${snapshot.data[index].id.toString()}')),
                          )),
                )),
              ));
            } else {
              return const ProgressWidget();
            }
          },
        ));
  }
}

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
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          _getFormatted(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                              fontStyle: FontStyle.italic),
                        ),
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

  String _getFormatted() {
    final formatter = DateFormat('yyyy-MM-dd hh:mm');
    final String formatted = formatter.format(dateTime);
    return formatted;
  }
}
