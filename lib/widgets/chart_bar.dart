import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class draw extends StatelessWidget {
  final String day;
  final double amt;
  final double percent;

  draw(this.amt, this.day, this.percent);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constrats) {
      return Column(
        children: [
          Container(
            height: constrats.maxHeight * 0.15,
            child: FittedBox(
              child: Text(
                '\$${amt.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
          ),
          SizedBox(
            height: constrats.maxHeight * 0.05,
          ),
          Container(
            height: constrats.maxHeight * 0.6,
            width: 10,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.red, width: 1),
                    color: Color.fromARGB(3, 220, 220, 220),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                FractionallySizedBox(
                  heightFactor: percent,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: constrats.maxHeight * 0.05,
          ),
          Container(
            height: constrats.maxHeight * 0.15,
            child: FittedBox(
              child: Text(
                '${day}',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
          ),
        ],
      );
    });
  }
}
