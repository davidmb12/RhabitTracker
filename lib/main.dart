import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rhabit_habit_tracker/pages/calendar_page.dart';
import 'package:rhabit_habit_tracker/pages/habits_page.dart';
import 'package:rhabit_habit_tracker/pages/stats_page.dart';
import 'package:rhabit_habit_tracker/widgets/add_habit.dart';
import 'package:rhabit_habit_tracker/widgets/nav_drawer.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    bool isDarkModeEnabled=true;

    return MaterialApp(
      title: '',
      debugShowCheckedModeBanner: true,
      theme: isDarkModeEnabled? ThemeData.dark().copyWith(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.green,

        )
      ):ThemeData.light().copyWith(
        colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.green),
        primaryColor:Color(0xFF9cd371),
        backgroundColor: Color(0xFFFFFFFF)
      ),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('es','MX')
      ],
      locale: Locale('es'),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  StreamController<String> streamController =new StreamController();


  @override
  void initState(){
    super.initState();
    streamController.stream.listen((data) {
      print("Data received: "+ data);
    },onDone: (){

    },onError:(error){
    }

    );
    getData();
  }

  @override
  void dispose(){
    streamController.close();
    super.dispose();
  }
  getData() async{
    SharedPreferences prefs=await SharedPreferences.getInstance();

  }

  List<Widget> pages= [
    CalendarPage(),
    HabitsPage(),
    StatisticsPage(),
  ];

  var _currentPage=0;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      drawer: NavDrawer(),
      body: pages[_currentPage],
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _currentPage,
        onTap: (i)=> setState(()=> _currentPage=i),
        items:[
          SalomonBottomBarItem(
            icon: Icon(Icons.calendar_today),
            title: Text("Cale ndario"),
            selectedColor: Colors.green,
          ),

          /// Likes
          SalomonBottomBarItem(
            icon: Icon(Icons.list),
            title: Text("Hábitos"),
            selectedColor: Colors.green,
          ),

          /// Search
          SalomonBottomBarItem(
            icon: Icon(Icons.bar_chart),
            title: Text("Estadísticas"),
            selectedColor: Colors.green,
          ),        ]
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          goToCreateHabitPage(context);

        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void goToCreateHabitPage(BuildContext context){
    Navigator.of(context).push(PageRouteBuilder(pageBuilder: (context,animation,secondaryAnimation)=> const AddHabit(),
      transitionsBuilder: (context,animation,secondaryAnimation,child){
        const begin = Offset(0.0,1.0);
        const end = Offset.zero;
        final tween = Tween(begin:begin,end:end);
        final offsetAnimation = animation.drive(tween);

        return SlideTransition(
            position: offsetAnimation,
            child:child
        );
      },
      )
    );
  }

}




