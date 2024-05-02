import 'package:chart_531619_cnadlechart/week_candle_list.dart';
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
  List<Candle> candles = [];
  TrackballBehavior? _trackballBehavior;
  ZoomPanBehavior? _zoomPanBehavior;
  List<TechnicalIndicator<dynamic, dynamic>> indicators = [
    // BollingerBandIndicator<dynamic, dynamic>(period: 3),
    // EmaIndicator<dynamic, dynamic>(valueField: 'high')
  ];

  @override
  void initState() {
    for (var element in oneWeekCandleList) {
      Map<String, dynamic> c = element;
      candles.add(Candle.fromJson(c));
    }
    _trackballBehavior = TrackballBehavior(
        // enable: true,
        // activationMode: ActivationMode.singleTap,
        // tooltipSettings: const InteractiveTooltip(enable: true),
        // shouldAlwaysShow: true,
        );
    _zoomPanBehavior = ZoomPanBehavior(
      enablePanning: true,
      enableDoubleTapZooming: true,
      enableMouseWheelZooming: true,
      maximumZoomLevel: 0,
      zoomMode: ZoomMode.x,
      enablePinching: true,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Candle Chart'),
        actions: [
          IconButton(
            onPressed: () {
              _zoomPanBehavior!.zoomIn();
            },
            icon: const Icon(Icons.add),
            color: Colors.orange,
          ),
          IconButton(
            onPressed: () {
              _zoomPanBehavior!.zoomOut();
            },
            icon: const Icon(Icons.remove, color: Colors.orange),
          ),
        ],
      ),
      body: rebuildChart(),
    );
  }

  Widget rebuildChart() {
    return SfCartesianChart(
      indicators: indicators,
      primaryXAxis: const DateTimeCategoryAxis(
        autoScrollingDelta: 100,
        autoScrollingDeltaType: DateTimeIntervalType.auto,
        // Determines whether the axis be scrolled from the start or end position.
        autoScrollingMode: AutoScrollingMode.end,
      ),
      primaryYAxis: const NumericAxis(
        rangePadding: ChartRangePadding.round,
        opposedPosition: true,
        anchorRangeToVisiblePoints: true,
      ),
      series: <CartesianSeries<Candle, DateTime>>[
        CandleSeries(
          enableSolidCandles: true,
          // showIndicationForSameValues: true,
          dataSource: candles,
          xValueMapper: (Candle candle, int index) => candle.date,
          lowValueMapper: (Candle candle, int index) => candle.low,
          highValueMapper: (Candle candle, int index) => candle.high,
          openValueMapper: (Candle candle, int index) => candle.open,
          closeValueMapper: (Candle candle, int index) => candle.close,
          trendlines: <Trendline>[
            Trendline(
                type: TrendlineType.movingAverage,
                color: Colors.purpleAccent,
                enableTooltip: true),
          ],
        ),
      ],
      trackballBehavior: _trackballBehavior,
      zoomPanBehavior: _zoomPanBehavior,
      tooltipBehavior: TooltipBehavior(enable: true, shared: true),
    );
  }
}
