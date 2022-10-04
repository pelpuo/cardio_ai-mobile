import 'package:cardio_ai/models/Patient.dart';
import 'package:cardio_ai/providers/patientProvider.dart';
import 'package:cardio_ai/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rulers/rulers.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class EcgDisplay extends StatefulWidget {
  const EcgDisplay({Key? key}) : super(key: key);

  @override
  State<EcgDisplay> createState() => _EcgDisplayState();
}

class _EcgDisplayState extends State<EcgDisplay> {
  late ZoomPanBehavior _zoomPanBehavior;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _zoomPanBehavior = ZoomPanBehavior(
        enablePanning: true,
        // enablePinching: true,
        // enableDoubleTapZooming: true,
        // enableSelectionZooming: true,
        selectionRectBorderColor: appColors.blue);
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

    String splitTime = Provider.of<PatientProvider>(context)
        .currentReading!
        .createdAt
        .substring(11, 19);
    List<String> dateParts = Provider.of<PatientProvider>(context)
        .currentReading!
        .createdAt
        .substring(0, 10)
        .split("-");

    return Scaffold(
      appBar: AppBar(
        foregroundColor: appColors.textDark,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Consumer<PatientProvider>(
        builder: (context, patientBase, child) => SafeArea(
          child: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${patientBase.currentPatient?.firstName ?? ""} ${patientBase.currentPatient?.lastName ?? ""}",
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${dateParts[2]}/${dateParts[1]}/${dateParts[0]}",
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          splitTime,
                          style: const TextStyle(fontSize: 16),
                        )
                      ],
                    ),
                  ),
                  deviceWidth < deviceHeight
                      ? const Text(
                          "For best experiences, tilt your phone to landscape mode")
                      : const SizedBox(),
                  SfCartesianChart(

                      // backgroundColor: Colors.amber,
                      zoomPanBehavior: ZoomPanBehavior(
                          enablePanning: true,
                          // enablePinching: true,
                          // enableDoubleTapZooming: true,
                          // enableSelectionZooming: true,
                          selectionRectBorderColor: appColors.blue),
                      // plotAreaBorderWidth: 2,
                      plotAreaBorderColor: appColors.textBlack,
                      title: ChartTitle(
                          text: 'ECG DATA', alignment: ChartAlignment.center),
                      primaryXAxis: NumericAxis(
                          autoScrollingDelta: 4,
                          visibleMinimum: 0,
                          visibleMaximum: 1000,
                          isVisible: false,
                          interval: 100,
                          rangePadding: ChartRangePadding.additional,
                          axisLine: const AxisLine(color: Colors.black38),
                          majorGridLines: const MajorGridLines(width: 2),
                          minorGridLines: const MinorGridLines(width: 1),
                          edgeLabelPlacement: EdgeLabelPlacement.hide),
                      primaryYAxis: NumericAxis(
                          isVisible: false,
                          minimum: -20,
                          maximum: 20,
                          interval: 5,
                          rangePadding: ChartRangePadding.additional,
                          axisLine: const AxisLine(color: Colors.black38),
                          majorGridLines: const MajorGridLines(width: 0),
                          minorGridLines: const MinorGridLines(width: 0),
                          edgeLabelPlacement: EdgeLabelPlacement.hide),
                      annotations: <CartesianChartAnnotation>[
                        CartesianChartAnnotation(
                            x: 355,
                            y: 22,
                            coordinateUnit: CoordinateUnit.point,
                            widget: Container(
                              child: const Text(
                                'High',
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                            region: AnnotationRegion.chart),
                        CartesianChartAnnotation(
                            x: 390,
                            y: 0,
                            coordinateUnit: CoordinateUnit.point,
                            widget: Container(
                              child: const Text(
                                '',
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                            region: AnnotationRegion.chart)
                      ],
                      series: [
                        LineSeries<dynamic, dynamic>(
                            dataSource: patientBase.ecgValues,
                            xValueMapper: (data, _) => _,
                            yValueMapper: (data, _) => data["MLII"] * 10)
                      ]),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text(
                    "Prediction:",
                    style: TextStyle(fontSize: 14, color: appColors.blue),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    patientBase.currentReading?.prediction ?? "Normal",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
