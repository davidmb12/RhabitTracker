import 'package:flutter/cupertino.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {

  @override
  Widget build(BuildContext context) {
    var queryData=MediaQuery.of(context);
    return Padding(
      padding: EdgeInsets.fromLTRB(queryData.size.width/20, queryData.size.height/15, 0, 0),
      child: Container(
          child:Text('Calendario')
      ),
    );
  }
}