import 'package:flutter/material.dart';
import 'package:navigator_sample/styles/colors.dart';
import 'package:navigator_sample/navigator/app_path.dart';
import 'package:navigator_sample/data/topic_type.dart';
import 'package:navigator_sample/data/data_source.dart';
import 'package:navigator_sample/navigator/app_params.dart';
import 'package:navigator_sample/models/report.dart';
import 'package:navigator_sample/widgets/progress_widget.dart';

class TopicsListScreen extends StatefulWidget {
  const TopicsListScreen({required this.valueKey}) : super(key: valueKey);
  final ValueKey<String> valueKey;

  @override
  State<TopicsListScreen> createState() => _TopicsListScreenState();
}

class _TopicsListScreenState extends State<TopicsListScreen> {
  late ScrollController _controller;
  @override
  void initState() {
    _controller = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.grey,
          //  leading: BackButton(onPressed: () => Navigator.of(context).pop()),
        ),
        body: FutureBuilder<List<Report>>(
          future:
              DataSource().fetchData(TopicType.getType(widget.valueKey.value)),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              return Scrollbar(
                controller: _controller,
                child: ListView.builder(
                    controller: _controller,
                    itemBuilder: (context, index) {
                      final Report report = snapshot.data[index];
                      return CustomListTile(
                        title: report.title,
                        subtitle: report.summary,
                        url: report.imageUrl,
                        onTap: () => AppParams.delegate.setNewRoutePath(
                            AppPathModel(
                                path:
                                    '${widget.valueKey.value}/${report.id.toString()}')),
                      );
                    },
                    itemCount: snapshot.data.length),
              );
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
      required this.url,
      required this.onTap,
      Key? key})
      : super(key: key);
  final String title;
  final String subtitle;
  final String url;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 2,
        margin: const EdgeInsets.all(8),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
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
                    Text(
                      subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
