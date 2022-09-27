import 'package:cardio_ai/providers/patientProvider.dart';
import 'package:cardio_ai/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rulers/rulers.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class EcgMonitoring extends StatefulWidget {
  const EcgMonitoring({Key? key}) : super(key: key);

  @override
  State<EcgMonitoring> createState() => _EcgMonitoringState();
}

class _EcgMonitoringState extends State<EcgMonitoring> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    retrieveEcgVals();
  }

  retrieveEcgVals() async {
    List temp = await Provider.of<PatientProvider>(context, listen: false)
        .getCurrentReading();
  }

  bool _isSHown = true;
  // double dpi = _getDpi();

  @override
  Widget build(BuildContext context) {
    List vals = Provider.of<PatientProvider>(context).ecgValues;

    final DeviceOrientation = MediaQuery.of(context).orientation;
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceAspectRatio = MediaQuery.of(context).size.aspectRatio;
    final devicePixelRatio = MediaQuery.of(context).devicePixelRatio;

    // double dpi = 60;
    double pixelCountInCm = devicePixelRatio / 2.54;
    double widthInCm = deviceWidth / 2.54;

    return Scaffold(
      appBar: AppBar(
        foregroundColor: appColors.textDark,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Consumer<PatientProvider>(
        builder: (context, patientBase, child) => SafeArea(
          child: Stack(children: [
            patientBase.ecgValues.isNotEmpty
                ? SfCartesianChart(
                    primaryXAxis: CategoryAxis(),
                    title: ChartTitle(text: "Title of the chart"),
                    legend: Legend(isVisible: true),
                    series: [
                        LineSeries<dynamic, int>(
                            dataSource: patientBase.ecgValues,
                            xValueMapper: (data, _) => data["sample"],
                            yValueMapper: (data, _) => data["MLII"])
                      ])
                : GridPaper(
                    // Set the color of the lines
                    color: _isSHown ? Colors.red : Colors.transparent,
                    // The number of major divisions within each primary grid cell
                    divisions: 2,
                    // The number of minor divisions within each major division, including the major division itself
                    subdivisions: 5,
                    interval: 62.99,
                    // interval: 50,
                    // GridPaper's child
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: Colors.transparent,
                      child: const Center(
                          // child: Text(
                          //   'ABC',
                          //   style: TextStyle(fontSize: 150),
                          // ),
                          ),
                    ),
                  ),
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: []),
          ]),
        ),
      ),
    );
  }
}
