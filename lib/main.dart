import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dataSource.dart';

void main() {
  return runApp(_App());
}

class _App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const _HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class _HomePage extends StatefulWidget {
  const _HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<_HomePage> {
  late Source _dataSource;

  @override
  void initState() {
    _dataSource = Source.dateTimeDatas(count: 1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SfCartesianChart(
        zoomPanBehavior: ZoomPanBehavior(
          enablePanning: true,
        ),
        primaryXAxis: DateTimeAxis(
          // you can adjust the value to view the data initially
          autoScrollingDelta: 200,

          // The data points with 200 days of values will be displayed
          autoScrollingDeltaType: DateTimeIntervalType.days,

          // Determines whether the axis be scrolled from the start or end position.
          autoScrollingMode: AutoScrollingMode.start,
        ),
        primaryYAxis: NumericAxis(),
        series: <CartesianSeries<ChartSampleData, DateTime>>[
          CandleSeries(
            dataSource: _dataSource.data[0]!,
            xValueMapper: (ChartSampleData sales, int index) => sales.dateX,
            lowValueMapper: (ChartSampleData sales, int index) => sales.low,
            highValueMapper: (ChartSampleData sales, int index) => sales.high,
            openValueMapper: (ChartSampleData sales, int index) => sales.open,
            closeValueMapper: (ChartSampleData sales, int index) => sales.close,
          ),
        ],
      ),
    );
  }
}
