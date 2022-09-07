import './chart_bar.dart';

import '../classe/transc.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class graph extends StatelessWidget {
  List<Trans> recent;
  graph(this.recent);

  List<Map<String, Object>> get bar {
    return List.generate(7, (index) {
      final weekday = DateTime.now().subtract(Duration(days: index));
      var tamount = 0.0;

      for (int i = 0; i < recent.length; i++) {
        if (recent[i].dt.day == weekday.day &&
            recent[i].dt.month == weekday.month &&
            recent[i].dt.year == weekday.year) {
          tamount += recent[i].price;
        }
      }
      print(DateFormat.E().format(weekday));
      print(tamount);
      return {'day': DateFormat.E().format(weekday), 'amount': tamount};
    }).reversed.toList();
  }

  double get maxi {
    return bar.fold(0.0, (sum, ele) {
      return sum + (ele['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    print(bar);
    return Card(
      elevation: 10,
      margin: EdgeInsets.all(5),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: bar.map((e) {
              return Flexible(
                fit: FlexFit.tight,
                child: draw((e['amount'] as double), (e['day'] as String),
                    maxi == 0.0 ? 0.0 : (e['amount'] as double) / maxi),
              );
            }).toList()),
      ),
    );
  }
}
