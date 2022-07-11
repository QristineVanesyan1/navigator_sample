import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';
import 'package:navigator_sample/constants/constants.dart';
import 'package:navigator_sample/domain/reports_repository.dart';
import 'package:navigator_sample/locator.dart';
import 'package:navigator_sample/models/report.dart';
import 'package:navigator_sample/models/topic_type.dart';
import 'package:navigator_sample/widgets/progress_widget.dart';
import 'package:navigator_sample/widgets/text_button_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen(
      {required this.id,
      required this.reportJson,
      required this.topicType,
      Key? key})
      : super(key: key);
  final String id;
  final TopicType topicType;
  final String? reportJson;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  ReportsRepository get _reportsRepository => locator.get<ReportsRepository>();

  @override
  void initState() {
    super.initState();
    debugPrint('detailsScreen: ${widget.reportJson}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(
              onPressed: () => Navigator.of(context).pop(widget.reportJson)),
        ),
        body: FutureBuilder<Report?>(
            future: _reportsRepository.getReport(widget.topicType, widget.id),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data != null) {
                  final Report report = snapshot.data!;
                  return Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.08,
                        vertical: 50),
                    child: Card(
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SelectableText(
                              report.title,
                              style: Theme.of(context).textTheme.headline2,
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: SelectableText(
                                _getFormattedDateTime(report.publishedAt),
                                style: Theme.of(context).textTheme.headline3,
                              ),
                            ),
                            _ImageWidget(
                              imageUrl: report.imageUrl,
                            ),
                            SelectableText(
                              report.summary,
                              style: Theme.of(context).textTheme.headline3,
                            ),
                            _ReadMoreButtonWidget(report: report)
                          ],
                        ),
                      ),
                    ),
                  );
                }
              }
              return const ProgressWidget();
            }));
  }

  String _getFormattedDateTime(DateTime dateTime) =>
      Constants.dateFormat.format(dateTime);
}

class _ReadMoreButtonWidget extends StatelessWidget {
  const _ReadMoreButtonWidget({required this.report, Key? key})
      : super(key: key);
  final Report report;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButtonWidget(
          title: 'Read more on ${report.newsSite}',
          onTap: () => _onTap(report.url)),
    );
  }

  void _onTap(String url) {
    var uri = Uri.parse(url);
    launchUrl(uri);
  }
}

class _ImageWidget extends StatelessWidget {
  const _ImageWidget({required this.imageUrl, Key? key}) : super(key: key);
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ImageNetwork(
        image: imageUrl,
        height: 200,
        width: MediaQuery.of(context).size.width,
      ),
    );
  }
}
