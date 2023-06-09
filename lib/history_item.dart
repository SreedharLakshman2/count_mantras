import 'package:count_mantras/count_info_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HistoryItem extends StatefulWidget {
  HistoryItem({super.key, required this.item});
  CounterInfo item = CounterInfo();
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HistoryItemState();
  }
}

class HistoryItemState extends State<HistoryItem> {
  DateFormat dateFormat = DateFormat("dd-MMM-yyyy hh:mm a");

  Widget build(context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 242, 162, 228),
            border: Border.all(
              color: Color.fromARGB(255, 242, 6, 222),
            ),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Icon(
                  Icons.event_note_rounded,
                  color: Colors.white,
                  size: 20,
                ),
                Text(
                  (widget.item.count.toString() != "0"
                          ? " Event Title: "
                          : " ToDo: ") +
                      widget.item.title,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                  maxLines: 4,
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            if (widget.item.count.toString() != "0")
              Row(
                children: [
                  Icon(
                    Icons.format_list_numbered_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                  Text(
                    " Counts Achieved: " + widget.item.count.toString(),
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ],
              ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Icon(
                  Icons.calendar_month,
                  color: Colors.white,
                  size: 20,
                ),
                Text(
                    " Created Date: " +
                        dateFormat.format(widget.item.createdDate),
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ],
            ),
            SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    );
  }
}
