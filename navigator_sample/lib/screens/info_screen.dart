import 'package:flutter/material.dart';
import 'package:navigator_sample/domain/reports_repository.dart';
import 'package:navigator_sample/locator.dart';
import 'package:navigator_sample/models/info.dart';
import 'package:navigator_sample/widgets/progress_widget.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({Key? key}) : super(key: key);

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  ReportsRepository get _reportsRepository => locator.get<ReportsRepository>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const SelectableText('Info'),
        leading: BackButton(onPressed: () => Navigator.of(context).pop()),
      ),
      body: FutureBuilder<Info>(
        future: _reportsRepository.fetchInfo(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data;
            if (data != null) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: _SourcesListWidget(sources: data.newsSites),
                  ),
                  _ApiVersionWidget(
                    version: data.version,
                  ),
                ],
              );
            }
          }
          return const ProgressWidget();
        },
      ),
    );
  }
}

class _SourcesListWidget extends StatelessWidget {
  const _SourcesListWidget({required this.sources, Key? key}) : super(key: key);
  final List sources;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.only(top: 10.0),
        itemCount: sources.length,
        itemBuilder: (context, index) => SelectableText(
              sources[index],
              textAlign: TextAlign.center,
            ));
  }
}

class _ApiVersionWidget extends StatelessWidget {
  const _ApiVersionWidget({required this.version, Key? key}) : super(key: key);
  final String version;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SelectableText(
        'v: $version',
        style: Theme.of(context).textTheme.bodyText2,
      ),
    );
  }
}
