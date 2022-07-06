import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';
import 'package:navigator_sample/constants/constants.dart';
import 'package:navigator_sample/domain/reports_repository.dart';
import 'package:navigator_sample/locator.dart';
import 'package:navigator_sample/models/report.dart';
import 'package:navigator_sample/widgets/progress_widget.dart';
import 'package:navigator_sample/widgets/text_button_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen(
      {required this.id, required this.reportJson, required this.valueKey})
      : super(key: valueKey);
  final String id;
  final ValueKey<String> valueKey;
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
            future:
                _reportsRepository.getReport(widget.valueKey.value, widget.id),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data != null) {
                  final Report report = snapshot.data!;
                  return Container(
                    padding: kIsWeb
                        ? const EdgeInsets.symmetric(
                            horizontal: 170, vertical: 50)
                        : const EdgeInsets.all(20),
                    child: Card(
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              report.title,
                              style: Theme.of(context).textTheme.headline2,
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                _getFormattedDateTime(report.publishedAt),
                                style: Theme.of(context).textTheme.headline3,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ImageNetwork(
                                image: report.imageUrl,
                                height: 200,
                                width: MediaQuery.of(context).size.width,
                              ),
                            ),
                            Text(
                              report.summary,
                              style: Theme.of(context).textTheme.headline3,
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButtonWidget(
                                  title: 'Read more on ${report.newsSite}',
                                  onTap: () => _onTap(report.url)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ); //todo check null
                }
              }
              return const ProgressWidget();
            }));
  }

  void _onTap(String url) {
    var uri = Uri.parse(url);
    launchUrl(uri);
  }

  String _getFormattedDateTime(DateTime dateTime) =>
      Constants.dateFormat.format(dateTime);
}
