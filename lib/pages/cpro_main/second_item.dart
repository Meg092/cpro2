import 'dart:async';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../main.dart';

class SecondItem extends StatefulWidget {
  const SecondItem(this.bg,
      {this.showWeekDay = true,
      this.showAPM = true,
      this.orientation = Orientation.portrait,
        required this.hourTextColor,
        required this.minutesTextColor,
        required this.fontFamily,
      Key? key})
      : super(key: key);
  final Uint8List bg;
  final bool? showWeekDay;
  final bool? showAPM;
  final Orientation? orientation;
  final Color hourTextColor;
  final Color minutesTextColor;
  final int fontFamily;

  @override
  State<SecondItem> createState() => _SecondItemState();
}

class _SecondItemState extends State<SecondItem>
    with AutomaticKeepAliveClientMixin {
  Timer? _timer;

  var weekDayStr = ''.obs;
  var hourStr = ''.obs;
  var minutesStr = ''.obs;
  var apmStr = ''.obs;

  void _startTimer() {
    getDate();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      getDate();
    });
  }

  String _formatDate(DateTime date) {
    final weekday = DateFormat('EEEE').format(date);
    final day = date.day.toString();
    final month = DateFormat('MMM').format(date).toLowerCase();
    return '$weekday $day $month';
  }

  void getDate() {
    final now = DateTime.now();
    weekDayStr.value = _formatDate(now);
    hourStr.value = DateFormat('hh').format(now);
   minutesStr.value = DateFormat('mm').format(now);
    apmStr.value = DateFormat('a').format(now).toUpperCase();
  }

  void _stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  @override
  void initState() {
    // TODO: implement initState
    _startTimer();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _stopTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return <Widget>[
      Image.memory(
        widget.bg,
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.fill,
      ),
      Transform(
        transform: widget.orientation == Orientation.portrait
            ? (Matrix4.identity()..rotateZ(pi * 3 / 2))
            : Matrix4.identity(),
        alignment: Alignment.center,
        child: <Widget>[
          SizedBox(
            width: 250,
            height: widget.orientation == Orientation.portrait ? 290 : 190,
          ),
          Transform(
            transform: widget.orientation == Orientation.portrait ? (Matrix4.identity()..rotateZ(pi / 2)) : Matrix4.identity(),
            alignment: Alignment.center,
            child: widget.orientation == Orientation.portrait ? Container(
                width: 250,
                height: 290,
                child: <Widget>[
                  Obx(() {
                    return Text(
                      hourStr.value,
                      style: TextStyle(
                          color: widget.hourTextColor,
                          fontSize: 100,
                          fontFamily: clockFamilyList[widget.fontFamily],
                          fontWeight: FontWeight.bold),
                    );
                  }),
                  Obx(() {
                    return Text(
                      minutesStr.value,
                      style: TextStyle(
                          color: widget.minutesTextColor,
                          fontSize: 100,
                          fontFamily: clockFamilyList[widget.fontFamily],
                          fontWeight: FontWeight.bold),
                    );
                  }),
                ].toColumn(mainAxisAlignment: MainAxisAlignment.center)) : Container(
                width: 550,
                height: 180,
                child: <Widget>[
                  Obx(() {
                    return Text(
                      hourStr.value,
                      style: TextStyle(
                          color: widget.hourTextColor,
                          fontSize: 100,
                          fontFamily: clockFamilyList[widget.fontFamily],
                          fontWeight: FontWeight.bold),
                    );
                  }),
                  Text(
                    ':',
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 100,
                        fontFamily: clockFamilyList[widget.fontFamily],
                        fontWeight: FontWeight.bold),
                  ),
                  Obx(() {
                    return Text(
                      minutesStr.value,
                      style: TextStyle(
                          color: widget.minutesTextColor,
                          fontSize: 100,
                          fontFamily: clockFamilyList[widget.fontFamily],
                          fontWeight: FontWeight.bold),
                    );
                  }),
                ].toRow(mainAxisAlignment: MainAxisAlignment.center)),
          ),
          Positioned(
              top: 0,
              left: 0,
              child: Visibility(
                  visible: widget.showWeekDay == true,
                  child: Obx(() {
                    return Text(
                      weekDayStr.value,
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 20,
                          fontFamily: clockFamilyList[widget.fontFamily],
                          fontWeight: FontWeight.bold),
                    );
                  }))),
          Positioned(
              bottom: 0,
              right: 0,
              child: Visibility(
                visible: widget.showAPM == true,
                child: Obx(() {
                  return Text(
                    apmStr.value,
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 20,
                        fontFamily: clockFamilyList[widget.fontFamily],
                        fontWeight: FontWeight.bold),
                  );
                }),
              ))
        ].toStack(alignment: Alignment.center),
      ).marginOnly(top: widget.orientation == Orientation.portrait ? 250 : 100)
    ].toStack(alignment: Alignment.center);
  }

  @override
  bool get wantKeepAlive => true;
}
