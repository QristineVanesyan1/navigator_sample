import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:navigator_sample/domain/reports_repository.dart';
import 'package:navigator_sample/locator.dart';
import 'package:navigator_sample/navigator/app_path.dart';
import 'package:navigator_sample/models/topic_type.dart';
import 'package:navigator_sample/constants/app_params.dart';
import 'package:navigator_sample/models/report.dart';
import 'package:navigator_sample/widgets/custom_list_tile.dart';
import 'package:navigator_sample/widgets/progress_widget.dart';

class TopicsListScreen extends StatefulWidget {
  const TopicsListScreen({required this.valueKey}) : super(key: valueKey);
  final ValueKey<String> valueKey;

  @override
  State<TopicsListScreen> createState() => _TopicsListScreenState();
}

class _TopicsListScreenState extends State<TopicsListScreen> {
  ReportsRepository get _reportsRepository => locator.get<ReportsRepository>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(onPressed: () => Navigator.of(context).pop()),
        ),
        body: FutureBuilder<List<Report>>(
          future: _reportsRepository
              .fetchData(TopicType.getType(widget.valueKey.value)),
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
                                        '${widget.valueKey.value}/${snapshot.data[index].id.toString()}',
                                    data: snapshot.data[index].toJson())),
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
