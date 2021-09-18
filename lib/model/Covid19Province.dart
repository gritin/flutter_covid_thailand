// To parse this JSON data, do
//
//     final covid19Province = covid19ProvinceFromJson(jsonString);

import 'dart:convert';

List<Covid19Province> covid19ProvinceFromJson(String str) => List<Covid19Province>.from(json.decode(str).map((x) => Covid19Province.fromJson(x)));

String covid19ProvinceToJson(List<Covid19Province> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Covid19Province {
    Covid19Province({
      required this.txnDate,
      required this.province,
      required this.newCase,
      required this.totalCase,
      required this.newCaseExcludeabroad,
      required this.totalCaseExcludeabroad,
      required this.newDeath,
      required this.totalDeath,
      required this.updateDate,
    });

    DateTime txnDate;
    String province;
    int newCase;
    int totalCase;
    int newCaseExcludeabroad;
    int totalCaseExcludeabroad;
    int newDeath;
    int totalDeath;
    DateTime updateDate;

    factory Covid19Province.fromJson(Map<String, dynamic> json) => Covid19Province(
        txnDate: DateTime.parse(json["txn_date"]),
        province: json["province"],
        newCase: json["new_case"],
        totalCase: json["total_case"],
        newCaseExcludeabroad: json["new_case_excludeabroad"],
        totalCaseExcludeabroad: json["total_case_excludeabroad"],
        newDeath: json["new_death"],
        totalDeath: json["total_death"],
        updateDate: DateTime.parse(json["update_date"]),
    );

    Map<String, dynamic> toJson() => {
        "txn_date": "${txnDate.year.toString().padLeft(4, '0')}-${txnDate.month.toString().padLeft(2, '0')}-${txnDate.day.toString().padLeft(2, '0')}",
        "province": province,
        "new_case": newCase,
        "total_case": totalCase,
        "new_case_excludeabroad": newCaseExcludeabroad,
        "total_case_excludeabroad": totalCaseExcludeabroad,
        "new_death": newDeath,
        "total_death": totalDeath,
        "update_date": updateDate.toIso8601String(),
    };
}
