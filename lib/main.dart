import 'package:covid/widget/statview.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'model/Covid19all.dart';
import 'model/Covid19Province.dart';
import 'widget/statbox.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto',
        primarySwatch: Colors.blueGrey,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late List<Covid19all> _allcovidData;
  late List<Covid19Province> _provinceData;
  late TabController _tabController;
  String? mainValue;
  int mainIndex = -1;
  int newCase = 0;
  int totalCase = 0;
  int newDeath = 0;
  int totalDeath = 0;

  @override
  void initState() {
    super.initState();
    getAllCovid();
    // getProvinceCovid();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  Future<List<Covid19all>> getAllCovid() async {
    Uri url = Uri.https("covid19.ddc.moph.go.th", "/api/Cases/today-cases-all");
    Uri url2 = Uri.https(
        "covid19.ddc.moph.go.th", "/api/Cases/today-cases-by-provinces");
    var response = await http.get(url);
    var response2 = await http.get(url2);
    _allcovidData = covid19FromJson(response.body);
    _provinceData = covid19ProvinceFromJson(response2.body);
    return _allcovidData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      appBar: AppBar(
        backgroundColor: Color(0xff333333),
        title: Text(
          "Covid-19 Thailand",
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: FutureBuilder(
        future: getAllCovid(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            var _result = snapshot.data;
            var datetime = _result[0].updateDate.toString().split(' ');
            var date = datetime[0];
            var time = datetime[1].split('.');
            return Stack(children: [
              Container(
                width: MediaQuery.of(context).size.width,
                child: Image.asset(
                  "assets/images/banner.png",
                  fit: BoxFit.fitWidth,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 131, 10, 0),
                child: Column(
                  children: [
                    Container(
                      height: 60,
                      decoration: BoxDecoration(color: Colors.white),
                      child: TabBar(
                        controller: _tabController,
                        indicator: BoxDecoration(
                          border: Border(
                            top: BorderSide(
                                color: Color(0xff333333), width: 8.0),
                          ),
                        ),
                        labelColor: Colors.black,
                        unselectedLabelColor: Colors.grey,
                        tabs: [
                          Tab(
                            child: Text(
                              "ทั่วประเทศ",
                              style: TextStyle(
                                fontFamily: 'Sukhumvit',
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          Tab(
                            child: Text(
                              mainValue ?? "รายจังหวัด",
                              style: TextStyle(
                                fontFamily: 'Sukhumvit',
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 2.0,
                      decoration: BoxDecoration(color: Color(0xffF2F2F2)),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(color: Colors.white),
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            statview(
                                newCase: _result[0].newCase,
                                totalCase: _result[0].totalCase,
                                newDeath: _result[0].newDeath,
                                totalDeath: _result[0].totalDeath,
                                newRecover: _result[0].newRecovered,
                                totalRecover: _result[0].totalRecovered,
                                updateDate: _result[0].updateDate),
                            Column(
                              children: [
                                Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 10, 20, 0),
                                  child: Container(
                                    // Province
                                    margin: EdgeInsets.only(bottom: 5),
                                    padding:
                                        EdgeInsets.only(left: 20, right: 20),
                                    height: 50,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Color(0xff72b0e8)),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                          value: mainValue,
                                          dropdownColor: Color(0xff72b0e8),
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'Sukhumvit',
                                              color: Colors.white,
                                              fontWeight: FontWeight.w300),
                                          iconSize: 32,
                                          icon: Icon(Icons.arrow_drop_down, color: Colors.white,),
                                          isExpanded: true,
                                          items: getProvince(_provinceData)
                                              // provincelist
                                              .map(buildMenuItem)
                                              .toList(),
                                          hint: Text(
                                            "เลือกจังหวัด",
                                            style: TextStyle(
                                                fontFamily: 'Sukhumvit',
                                                fontSize: 18,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          onChanged: (value) {
                                            setState(() {
                                              this.mainValue = value!;
                                              this.newCase = _provinceData[
                                                      getIndex(
                                                          value, _provinceData)]
                                                  .newCase;
                                              this.totalCase = _provinceData[
                                                      getIndex(
                                                          value, _provinceData)]
                                                  .totalCase;
                                              this.newDeath = _provinceData[
                                                      getIndex(
                                                          value, _provinceData)]
                                                  .newDeath;
                                              this.totalDeath = _provinceData[
                                                      getIndex(
                                                          value, _provinceData)]
                                                  .totalDeath;
                                            });
                                          }),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: ListView(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    children: [
                                      Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(20, 5, 20, 0),
                                        child: Column(
                                          children: [
                                            Container(
                                              child: statbox(
                                                type: "case",
                                                num: newCase,
                                                num_2: totalCase,
                                                is_province: true,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 10, 0, 0),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Container(
                                                      child: statbox(
                                                        type: "death",
                                                        num: newDeath,
                                                        num_2: totalDeath,
                                                        is_province: true,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 15, 0, 15),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(Icons.refresh),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(date),
                                                  SizedBox(
                                                    width: 20,
                                                  ),
                                                  Text("|"),
                                                  SizedBox(
                                                    width: 20,
                                                  ),
                                                  Icon(Icons.access_time),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(time[0]),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ]);
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
    value: item,
    child: Text(
      item,
      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
    ));

List<String> getProvince(List<Covid19Province> data) {
  List<String> myList = [];
  for (var item in data) {
    myList.add(item.province);
  }
  return myList;
}

String getTitle(String? title) {
  if (title == null) {
    return "เลือกจังหวัด";
  }
  return title;
}

int getIndex(String word, List<Covid19Province> data) {
  var list = getProvince(data);
  var index = list.indexOf(word);
  // print(index);
  return index;
}
