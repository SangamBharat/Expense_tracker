import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../classe/transc.dart';

class transcli extends StatelessWidget {
  final List<Trans> trangf;
  Function deleter;
  transcli(this.trangf, this.deleter);

  Widget build(BuildContext context) {
    return Container(
      // height: 500,
      child: trangf.isEmpty
          ? LayoutBuilder(builder: (context, constrats) {
              return Column(
                children: [
                  Text(
                    "wow you have spent nothing",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(
                    height: constrats.maxHeight * 0.1,
                  ),
                  SizedBox(
                    height: constrats.maxHeight * 0.6,
                    width: constrats.maxWidth * 0.7,
                    child: Image.network(
                      "https://www.nicepng.com/png/full/554-5548602_media-no-convenience-fees-no-hidden-fees-icon.png",
                      fit: BoxFit.fill,
                    ),
                  )
                ],
              );
            })
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  elevation: 10,
                  margin: EdgeInsets.symmetric(vertical: 6, horizontal: 5),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 70,
                      child: Padding(
                        padding: EdgeInsets.all(6),
                        child: FittedBox(
                          child: Text('\$${trangf[index].price}'),
                        ),
                      ),
                    ),
                    title: Text(
                      trangf[index].title,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    subtitle: Text(DateFormat.yMd().format(trangf[index].dt)),
                    trailing: MediaQuery.of(context).size.width > 400
                        ? FlatButton.icon(
                            label: Text('delete'),
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              deleter(trangf[index].id);
                            },
                          )
                        : IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              deleter(trangf[index].id);
                            },
                          ),
                  ),
                )
                    // return Card(
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       Container(
                    //         padding:
                    //             EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    //         margin: EdgeInsets.all(10),
                    //         decoration: BoxDecoration(
                    //           border: Border.all(
                    //               color: Color.fromARGB(90, 10, 20, 40), width: 5),
                    //         ),
                    //         child: Column(
                    //           children: [
                    //             Text(
                    //               '\$${trangf[index].price.toStringAsFixed(2)}',
                    //               style: Theme.of(context).textTheme.headline6,
                    //             ),
                    //             Text(trangf[index].id),
                    //           ],
                    //         ),
                    //       ),
                    //       Container(
                    //         padding:
                    //             EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    //         margin: EdgeInsets.all(10),
                    //         decoration: BoxDecoration(
                    //           border: Border.all(
                    //               color: Color.fromARGB(90, 10, 20, 40), width: 5),
                    //         ),
                    //         child: Column(
                    //           crossAxisAlignment: CrossAxisAlignment.start,
                    //           children: [
                    //             Text(
                    //               trangf[index].title,
                    //               style: Theme.of(context).textTheme.headline6,
                    //             ),
                    //             Text(
                    //               DateFormat.yMd().format(trangf[index].dt),
                    //               style: Theme.of(context).textTheme.headline6,
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // );
                    ;
              },
              itemCount: trangf.length,
            ),
    );
  }
}
