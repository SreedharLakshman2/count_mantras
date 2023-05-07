import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'boxes.dart';
import 'count_info_model.dart';
import 'history_item.dart';

class History extends StatefulWidget {
  History({super.key, required this.countInfoList});
  List<CounterInfo> countInfoList;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HistoryState();
  }
}

class HistoryState extends State<History> {
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Padding(
          padding: EdgeInsets.all(10.0),
          child: Text('Count History',
              style:
                  const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
        ),
        actions: [
          Row(
            children: [
              Text("Clear All"),
              SizedBox(
                width: 1,
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    final items = Boxes.getCounterInfo();
                    items.deleteAll(Boxes.getCounterInfo().keys);
                    //Hive.box('CounterInfo').close();
                  });
                },
                icon: Icon(Icons.delete_forever),
                alignment: Alignment.centerLeft,
              ),
            ],
          )
        ],
      ),
      body: ValueListenableBuilder<Box<CounterInfo>>(
          valueListenable: Boxes.getCounterInfo().listenable(),
          builder: (context, box, _) {
            final counterInfo = box.values.toList().cast<CounterInfo>();
            print(counterInfo.length.toString());
            widget.countInfoList = counterInfo;
            return counterInfo.length > 0
                ? ListView.builder(
                    // Let the ListView know how many items it needs to build.
                    itemCount: widget.countInfoList.length,
                    // Provide a builder function. This is where the magic happens.
                    // Convert each item into a widget based on the type of item it is.
                    itemBuilder: (context, index) {
                      final item = widget.countInfoList[index];

                      return HistoryItem(
                        item: item,
                      );
                    },
                  )
                : Container(
                    alignment: Alignment.center,
                    child: Text(
                      'No data found',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  );
          }),
    );
  }
}
