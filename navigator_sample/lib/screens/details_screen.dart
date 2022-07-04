import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';
import 'package:intl/intl.dart';
import 'package:navigator_sample/data/data_source.dart';
import 'package:navigator_sample/models/report.dart';
import 'package:navigator_sample/widgets/progress_widget.dart';
import 'package:navigator_sample/widgets/topic_button_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({required this.id, required this.valueKey})
      : super(key: valueKey);
  final String id;
  final ValueKey<String> valueKey;
  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(onPressed: () => Navigator.of(context).pop()),
        ),
        body: FutureBuilder<Report?>(
            future: DataSource().getReport(widget.valueKey.value, widget.id),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data != null) {
                  final Report report = snapshot.data!;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        report.title,
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          _getFormatted(report.publishedAt),
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

  // duplicated code
  String _getFormatted(DateTime dateTime) {
    final formatter = DateFormat('yyyy-MM-dd hh:mm');
    final String formatted = formatter.format(dateTime);
    return formatted;
  }
}
