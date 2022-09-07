import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class usreinpu extends StatefulWidget {
  Function addn;

  usreinpu(this.addn);

  @override
  State<usreinpu> createState() => _usreinpuState();
}

class _usreinpuState extends State<usreinpu> {
  final pricecontrol = TextEditingController();

  final titcontrol = TextEditingController();
  DateTime? selecteddt;

  void submit() {
    if (pricecontrol.text.isEmpty) return;
    final sprice = double.parse(pricecontrol.text);
    final stitle = titcontrol.text;

    if (sprice < 0 || stitle.isEmpty || selecteddt == null) {
      return;
    }
    widget.addn(sprice, stitle, selecteddt);
    Navigator.of(context).pop();
  }

  void viewdate() {
    showDatePicker(
            context: context,
            initialDate: DateTime(2022),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((dat) {
      if (dat == null) return;
      setState(() {
        selecteddt = dat;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 10,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.only(
              left: 10,
              right: 10,
              top: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'price'),
                controller: pricecontrol,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => submit(),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'title'),
                controller: titcontrol,
                onSubmitted: (_) => submit(),
              ),
              Row(
                children: [
                  Text(
                    selecteddt == null
                        ? 'choose date'
                        : 'pickeddate  ${DateFormat.yMd().format(selecteddt!)}',
                  ),
                  FlatButton(
                    child: Text(
                      'choose date',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.purple),
                    ),
                    onPressed: viewdate,
                  )
                ],
              ),
              RaisedButton(
                onPressed: () {
                  print(pricecontrol.text);
                  submit();
                },
                color: Theme.of(context).primaryColor,
                child: Text(
                  'submit',
                  style: TextStyle(
                      color: Theme.of(context).textTheme.button!.color),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
