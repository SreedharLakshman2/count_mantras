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
              IconButton(
                onPressed: () {
                  if (widget.countInfoList.length > 0) {
                    showDialog(
                      context: context,
                      builder: (cxt) => AlertDialog(
                        backgroundColor: Color.fromARGB(255, 240, 125, 233),
                        title: const Text(
                          'Delete Alert',
                          style: TextStyle(
                              color: Color.fromARGB(255, 251, 51, 51),
                              fontWeight: FontWeight.normal),
                          textAlign: TextAlign.center,
                        ),
                        content: const Text(
                            'You can delete each event by swipe towards left.\n \n Are you sure, You want to delete all the event data?',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15)),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(cxt);
                              },
                              child: const Text('Cancel',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15))),
                          TextButton(
                              onPressed: () {
                                setState(() {
                                  final items = Boxes.getCounterInfo();
                                  items.deleteAll(Boxes.getCounterInfo().keys);
                                  Navigator.pop(cxt);
                                });
                              },
                              child: const Text('Delete All',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 251, 51, 51),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15)))
                        ],
                      ),
                    );
                  }
                },
                icon: Icon(Icons.delete_forever_rounded),
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

                      return Dismissible(
                        // Specify the direction to swipe and delete
                        direction: DismissDirection.endToStart,
                        key: Key(item.title),
                        onDismissed: (direction) {
                          // Removes that item the list on swipwe
                          setState(() {
                            //items.removeAt(index);
                            final items = Boxes.getCounterInfo();
                            items.deleteAt(index);
                          });
                          // Shows the information on Snackbar
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Event deleted from list.')));
                        },
                        background: Container(
                          color: Colors.red,
                          padding: EdgeInsets.all(20),
                        ),
                        child: HistoryItem(
                          item: item,
                        ),
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
