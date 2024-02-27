import 'dart:math';

class Source {
  int get count => _count;
  int _count = 0;
  set count(int value) {
    if (_count != value) {
      _count = value;
      data = <List<ChartSampleData>?>[]..length = count;
    }
  }

  late List<List<ChartSampleData>?> data;
  final Random _random = Random();

  Source.dateTimeDatas({required int count}) {
    this.count = count;
    for (int i = 0; i < count; i++) {
      data[i] = <ChartSampleData>[];
      DateTime date = DateTime(2000, 01, 01);
      for (int j = 0; j < 1000; j++) {
        data[i]!.add(
          ChartSampleData(
            date,
            _random.nextDouble(),
            _random.nextDouble(),
            _random.nextDouble(),
            _random.nextDouble(),
          ),
        );
        date = date.add(const Duration(days: 1));
      }
    }
  }
}

class ChartSampleData {
  ChartSampleData(this.dateX, this.high, this.low, this.open, this.close);

  DateTime? dateX;
  num? high;
  num? low;
  num? open;
  num? close;
}

class Candle {
  Candle(this.open, this.high, this.low, this.close, this.volume, this.date);

  num open;
  num high;
  num low;
  num close;
  num volume;
  DateTime date;

  Candle.fromJson(Map<String, dynamic> json)
      : open = json['open'],
        high = json['high'],
        low = json['low'],
        close = json['close'],
        volume = json['volume'],
        date = DateTime.fromMillisecondsSinceEpoch(json['date']);
}
