import 'package:flutter/material.dart';
import 'package:navigator_sample/data/data_source.dart';
import 'package:navigator_sample/models/info.dart';
import 'package:navigator_sample/widgets/progress_widget.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({Key? key}) : super(key: key);

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Info'),
        // leading: BackButton(onPressed: () => Navigator.of(context).pop()),//todo: check on pop page func
      ),
      body: FutureBuilder<Info>(
        future: DataSource().fetchInfo(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: ListView.builder(
                      itemCount: snapshot.data?.newsSites.length,
                      itemBuilder: (context, index) => Text(
                            snapshot.data?.newsSites[index] ?? '',
                            textAlign: TextAlign.center,
                          )),
                ),
                Text('v: ${snapshot.data!.version.toString()}'),
              ],
            );
          } else {
            return const ProgressWidget();
          }
        },
      ),
    );
  }
}
