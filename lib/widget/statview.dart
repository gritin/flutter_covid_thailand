import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'statbox.dart';

class statview extends StatelessWidget {
  const statview({
    Key? key,
    required this.newCase,
    required this.totalCase,
    required this.newDeath,
    required this.totalDeath,
    required this.newRecover,
    required this.totalRecover,
    required this.updateDate,
  }) : super(key: key);

  final int newCase;
  final int totalCase;
  final int newDeath;
  final int totalDeath;
  final int newRecover;
  final int totalRecover;
  final DateTime updateDate;

  @override
  Widget build(BuildContext context) {
    var datetime = updateDate.toString().split(' ');
    var date = datetime[0];
    var time = datetime[1].split('.');
    return ListView(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
          child: Column(
            children: [
              Container(
                child: statbox(
                    type: "case",
                    num: newCase,
                    num_2: totalCase,
                    is_province: false,),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Row(
                  children: [
                    Container(
                      child: statbox(
                          type: "recover",
                          num: newRecover,
                          num_2: totalRecover,
                          is_province: false,),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Container(
                        child: statbox(
                            type: "death",
                            num: newDeath,
                            num_2: totalDeath,
                            is_province: false,),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.refresh),
                    SizedBox(
                      width: 10 ,
                    ),
                    Text(date),
                    SizedBox(
                      width: 20 ,
                    ),
                    Text("|"),
                    SizedBox(
                      width: 20 ,
                    ),
                    Icon(Icons.access_time),
                    SizedBox(
                      width: 10 ,
                    ),
                    Text(time[0]),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
