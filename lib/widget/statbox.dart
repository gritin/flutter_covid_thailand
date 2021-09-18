import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class statbox extends StatelessWidget {
  const statbox(
      {Key? key,
      required this.type,
      required this.num,
      required this.num_2,
      required this.is_province})
      : super(key: key);

  final int num;
  final int num_2;
  final String type;
  final bool is_province;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: getColor(type), borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.person_outline,
                  color: Colors.white,
                  size: 26,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  getTitlenNew(type),
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Sukhumvit',
                    fontWeight: FontWeight.w700,
                    fontSize: getTitleTextSize(type,is_province).toDouble(),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
            child: Text(
              "+${NumberFormat("#,###").format(num)}",
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Sukhumvit',
                  fontSize: getNumTextSize(type,is_province).toDouble(),
                  fontWeight: FontWeight.w700),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(13, 14, 13, 15),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: getalign(type,is_province),
                children: [
                  Padding(
                    padding: getSpace(type,is_province),
                    child: Text(
                      getTitlenTotal(type),
                      style: TextStyle(
                        fontFamily: 'Sukhumvit',
                        fontWeight: FontWeight.w700,
                        color: getColor(type),
                        fontSize: getTotalTitleTextSize(type,is_province).toDouble(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(19, 10, 19, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.call_made_outlined,
                            size: getTitleTextSize(type,is_province).toDouble()),
                        Text(
                          "${NumberFormat("#,###").format(num_2)}",
                          style: TextStyle(
                            fontFamily: 'Sukhumvit',
                            fontWeight: FontWeight.w700,
                            fontSize: getTotalNaumTextSize(type,is_province).toDouble(),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

int getNumTextSize(String type , bool is_province) {
  if (type == "case" || is_province) {
    return 72;
  } else {
    return 32;
  }
}

CrossAxisAlignment getalign(String type,bool is_province) {
  if (type == "case" || is_province) {
    return CrossAxisAlignment.start;
  } else {
    return CrossAxisAlignment.center;
  }
}

EdgeInsets getSpace(String type, bool is_province) {
  if (type == "case" || is_province) {
    return EdgeInsets.fromLTRB(20, 10, 0, 0);
  } else {
    
    return EdgeInsets.fromLTRB(0, 10, 0, 0);
  }
}

int getTitleTextSize(String type, bool is_province) {
  if (type == "case" || is_province) {
    return 24;
  } else {
    return 16;
  }
}

int getTotalTitleTextSize(String type,bool is_province) {
  if (type == "case" || is_province) {
    return 28;
  } else {
    return 16;
  }
}

int getTotalNaumTextSize(String type, bool is_province) {
  if (type == "case" || is_province) {
    return 28;
  } else {
    return 16;
  }
}

String getTitlenNew(String type) {
  if (type == "case") {
    return "ผู้ติดเชื้อใหม่";
  } else if (type == "recover") {
    return "รักษาหายใหม่";
  } else {
    return "เสียชีวิตใหม่";
  }
}

String getTitlenTotal(String type) {
  if (type == "case") {
    return "ผู้ติดเชื้อสะสม";
  } else if (type == "recover") {
    return "รักษาหายสะสม";
  } else {
    return "เสียชีวิตสะสม";
  }
}

Color getColor(String type) {
  if (type == "case") {
    return Color(0xffEB5757);
  } else if (type == "recover") {
    return Color(0xff27AE60);
  } else {
    return Color(0xff828282);
  }
}
