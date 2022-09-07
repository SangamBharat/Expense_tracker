import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './widgets/userinput.dart';
import './widgets/transactlist.dart';
import '../classe/transc.dart';
import './widgets/chart.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(Real_App_1());
}

class Real_App_1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Real_App_1',
      theme: ThemeData(
        primarySwatch: Colors.green,
        accentColor: Colors.cyanAccent,
        fontFamily: 'Gruppo',
        appBarTheme: AppBarTheme(
          textTheme:
              // headline6: TextStyle(fontFamily: 'Caveat', fontSize: 20))
              ThemeData.light().textTheme.copyWith(
                    headline6: TextStyle(
                      fontFamily: 'Caveat',
                      fontSize: 28,
                    ),
                  ),
        ),
        textTheme: ThemeData.light().textTheme.copyWith(
            headline6: TextStyle(fontFamily: 'Gruppo', fontSize: 25),
            button: TextStyle(color: Colors.white)),
      ),
      home: App_1(),
    );
  }
}

class App_1 extends StatefulWidget {
  @override
  State<App_1> createState() => _App_1State();
}

class _App_1State extends State<App_1> {
  final List<Trans> _transction = [
    // Trans(
    //     dt: DateTime.now().subtract(Duration(days: 5)),
    //     id: '101',
    //     price: 5.99,
    //     title: 'chocolate'),
    // Trans(
    //     dt: DateTime.now().subtract(Duration(days: 3)),
    //     id: '102',
    //     price: 25.99,
    //     title: 'cake'),
  ];

  List<Trans> get recentT {
    return _transction.where((ty) {
      return ty.dt.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _adde(double txamount, String txtitle, DateTime changed) {
    final newtx = Trans(
      dt: changed,
      id: DateTime.now().toString(),
      price: txamount,
      title: txtitle,
    );

    setState(() {
      _transction.add(newtx);
    });
  }

  bool showhart = false;
  void deleteTran(String ide) {
    setState(() {
      _transction.removeWhere((ele) => ele.id == ide);
    });
  }

  void _showAddTrans(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        constraints: BoxConstraints(),
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: usreinpu(_adde),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final islandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final media = MediaQuery.of(context);
    final dynamic appBare = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text(
              'RApp_1',
              style: Theme.of(context).appBarTheme.textTheme!.headline6,
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  child: Icon(CupertinoIcons.add),
                  onTap: () {
                    _showAddTrans(context);
                  },
                )
              ],
            ),
          )
        : AppBar(
            title: Text(
              'RApp_1',
              style: Theme.of(context).appBarTheme.textTheme!.headline6,
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    _showAddTrans(context);
                  },
                  icon: Icon(Icons.add))
            ],
          );
    final bodypager = SingleChildScrollView(
      child: Column(
        children: [
          // Container(
          //   width: double.infinity,
          //   height: 80,
          //   child: Card(
          //     //color: Color.fromARGB(155, 65, 75, 15),
          //     color: Theme.of(context).dividerColor,
          //     child: Text(
          //       'Graph',
          //       textAlign: TextAlign.center,
          //     ),
          //   ),
          // ),

          if (islandscape)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('show_chart'),
                Switch.adaptive(
                    value: showhart,
                    onChanged: (vf) {
                      setState(() {
                        showhart = vf;
                      });
                    })
              ],
            ),
          if (!islandscape)
            Container(
                height:
                    (media.size.height - (media.padding.top + kToolbarHeight)) *
                        0.35,
                child: graph(recentT)),

          if (!islandscape)
            Container(
                height:
                    (media.size.height - (media.padding.top + kToolbarHeight)) *
                        0.65,
                child: transcli(_transction, deleteTran)),
          if (islandscape)
            showhart
                ? Container(
                    height: (media.size.height -
                            (media.padding.top + kToolbarHeight)) *
                        0.75,
                    // height: (MediaQuery.of(context).size.height -
                    //         appBar.preferredSize.height -
                    //         MediaQuery.of(context).padding.top) *
                    //     0.45,
                    child: graph(recentT))
                : Container(
                    height: (media.size.height -
                            (media.padding.top + kToolbarHeight)) *
                        0.75,
                    // height: (MediaQuery.of(context).size.height -
                    //         appBar.preferredSize.height -
                    //         MediaQuery.of(context).padding.top) *
                    //     0.65,
                    child: transcli(_transction, deleteTran)),
        ],
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: bodypager,
            navigationBar: appBare,
          )
        : Scaffold(
            appBar: appBare,
            body: bodypager,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    onPressed: () {
                      _showAddTrans(context);
                    },
                    child: Icon(
                      Icons.add,
                      color: Colors.pinkAccent[750],
                    ),
                  ),
          );
  }
}
