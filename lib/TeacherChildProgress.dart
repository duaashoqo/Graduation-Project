import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import "package:collection/collection.dart";

class TeacherChildProgress extends StatefulWidget {
  String title;
  List<dynamic> childsName;
  List<dynamic> childsFlag1;
  List<dynamic> childsFlag2;
  List<dynamic> childsFlag3;

  TeacherChildProgress(
      {key,
      this.title,
      this.childsName,
      this.childsFlag1,
      this.childsFlag2,
      this.childsFlag3})
      : super(key: key);

  @override
  _TeacherChildProgressState createState() => _TeacherChildProgressState();
}

class _TeacherChildProgressState extends State<TeacherChildProgress> {
  List<Employee> employees = <Employee>[];
  EmployeeDataSource employeeDataSource;

  @override
  void initState() {
    print("1111111");
    print("222");
    employees = getEmployeeData(widget.childsName, widget.childsFlag1,
        widget.childsFlag2, widget.childsFlag3);
    print("Eeee");

    employeeDataSource = EmployeeDataSource(employeeData: employees);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // 0099cb
        // backgroundColor: Colors.green[100],

        backgroundColor: Color.fromRGBO(128, 204, 230, 1),
        appBar: AppBar(
          leading: new IconButton(
              icon: new Icon(
                Icons.arrow_back_ios_new_outlined,
                color: Colors.black,
                size: 18,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              }),
          backgroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  widget.title,
                  style: GoogleFonts.amiri(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                  textDirection: TextDirection.rtl,
                ),
              ),
            ],
          ),
        ),
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              child: widget.childsName.length == 0
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05),
                        Container(
                          color: Colors.green,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 1,
                            height: MediaQuery.of(context).size.height * 0.1,
                            child: Center(
                              child: DefaultTextStyle(
                                style: GoogleFonts.amiri(
                                  // decoration: TextDecoration.underline,
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                                child: AnimatedTextKit(
                                  animatedTexts: [
                                    TypewriterAnimatedText(
                                        '  لـم يـتـم حـل تـمـارين الحـرف من قـبل أي طـالب .. ')
                                  ],
                                  onTap: () {
                                    print("Tap Event");
                                  },
                                ),
                              ),
                            ),
                          ),
                        )
                        // SizedBox(
                        //   width: MediaQuery.of(context).size.width * 1,
                        //   child: Text(
                        //     "لـم يـتـم حـل تـمـارين الحـرف من قـبل أي طـالب     ",
                        //     style: GoogleFonts.amiri(
                        //       // decoration: TextDecoration.underline,
                        //       color: Colors.red,
                        //       fontSize: 17,
                        //       fontWeight: FontWeight.bold,
                        //     ),
                        //     textAlign: TextAlign.center,
                        //   ),
                        // ),
                      ],
                    )
                  : SfDataGrid(
                      // gridLinesVisibility: GridLinesVisibility.both,
                      // headerGridLinesVisibility: GridLinesVisibility.both,
                      columnWidthMode: ColumnWidthMode.fill,
                      source: employeeDataSource,
                      frozenColumnsCount: 1,
                      isScrollbarAlwaysShown: true,
                      columns: <GridColumn>[
                        GridColumn(
                            width: 200,
                            columnName: 'اسـم الطـالب',
                            label: Container(
                                color: Color.fromRGBO(0, 153, 203, 1),
                                // 0099cb

                                // padding: EdgeInsets.all(16.0),
                                alignment: Alignment.center,
                                child: Text('اسـم الطـالب',
                                    style: GoogleFonts.amiri(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17)))),
                        GridColumn(
                            width: 100,
                            columnName: 'التمرين الأول',
                            label: Container(

                                // padding: EdgeInsets.all(8.0),
                                alignment: Alignment.center,
                                child: Text('التـمرين الأول',
                                    style: GoogleFonts.amiri(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17)))),
                        GridColumn(
                            width: 100,
                            columnName: 'التمرين الثاني',
                            label: Container(
                                padding: EdgeInsets.all(8.0),
                                alignment: Alignment.center,
                                child: Text('التـمرين الثاني',
                                    style: GoogleFonts.amiri(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17)
                                    // overflow: TextOverflow.ellipsis,
                                    ))),
                        GridColumn(
                            width: 100,
                            columnName: 'التمرين الثالث',
                            label: Container(
                                padding: EdgeInsets.all(8.0),
                                alignment: Alignment.center,
                                child: Text('التـمرين الثالث',
                                    style: GoogleFonts.amiri(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17)))),
                      ],
                    ),
            ),
          ),
        ));
  }
}

List<Employee> getEmployeeData(
    List<dynamic> childName,
    List<dynamic> childFlag1,
    List<dynamic> childFlag2,
    List<dynamic> childFlag3) {
  List<Employee> e = [];

  print("childName.length");
  print(childName.length);
  for (int i = 0; i < childName.length; i++) {
    e.add(Employee(childName[i], childFlag1[i], childFlag2[i], childFlag3[i]));
  }
  return e;
}

class Employee {
  /// Creates the employee class with required details.
  Employee(this.name, this.flag1, this.flag2, this.flag3);

  String name;
  String flag1;
  String flag2;
  String flag3;
}

/// An object to set the employee collection data source to the datagrid. This
/// is used to map the employee data to the datagrid widget.
class EmployeeDataSource extends DataGridSource {
  /// Creates the employee data source class with required details.
  EmployeeDataSource({List<Employee> employeeData}) {
    employeeData.sort((a, b) {
      return compareAsciiUpperCase(a.name, b.name);
    });
    _employeeData = employeeData
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'اسم الطالب', value: e.name),
              DataGridCell<String>(
                  columnName: 'التمرين الأول',
                  value: e.flag1 == 'true' ? "✔️" : "❌"),
              DataGridCell<String>(
                  columnName: 'التمرين الثاني',
                  value: e.flag2 == 'true' ? "✔️" : "❌"),
              DataGridCell<String>(
                  columnName: 'التمرين الثالث',
                  value: e.flag3 == 'true' ? "✔️" : "❌"),
            ]))
        .toList();
  }

  List<DataGridRow> _employeeData = [];

  @override
  List<DataGridRow> get rows => _employeeData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(8.0),
        child: Text(
          e.value.toString(),
          style: GoogleFonts.amiri(color: Colors.blueGrey[900], fontSize: 16),
        ),
      );
    }).toList());
  }
}
