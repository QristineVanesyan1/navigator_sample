import 'package:flutter/material.dart';
import 'package:navigator_sample/styles/colors.dart';
import 'package:navigator_sample/data/data_source.dart';
import 'package:navigator_sample/models/report.dart';
import 'package:navigator_sample/widgets/progress_widget.dart';

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
          backgroundColor: AppColors.grey,
          // leading: BackButton(onPressed: () => Navigator.of(context).pop()),
        ),
        body: Center(
            child: FutureBuilder<Report?>(
          future: DataSource().getReport(widget.valueKey.value, widget.id),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data!.summary); //todo check null
            } else {
              return const ProgressWidget();
            }
          },
        )));
  }
}
