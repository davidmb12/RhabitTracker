import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:group_button/group_button.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:rhabit_habit_tracker/widgets/custom_spacer.dart';



class AddHabit extends StatefulWidget {
  const AddHabit({Key? key}) : super(key: key);

  @override
  _AddHabitState createState() => _AddHabitState();
}

class _AddHabitState extends State<AddHabit> with TickerProviderStateMixin{
  bool _remind=false;
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  //Habit parameters
  Color _selectedColor=Colors.red;
  String _habitName='';
  List<int> _days=[0,0,0,0,0,0,0];
  List<TimeOfDay> _reminders=[];
  late DateTime _selectedDate=DateTime.now();
  bool isDateSelected=false;



  double elevation=4;
  final Map<ColorSwatch<Object>, String> customSwatches =
  <ColorSwatch<Object>, String>{
    ColorTools.createPrimarySwatch(Colors.purple):"Purple",
    ColorTools.createPrimarySwatch(Colors.cyan):"Cyan",
    ColorTools.createPrimarySwatch(Colors.greenAccent):"GreenAccent",
    ColorTools.createPrimarySwatch(Colors.orange):"Orange",
    ColorTools.createPrimarySwatch(Colors.red):"Red",
    ColorTools.createPrimarySwatch(Colors.yellow):"Yellow",
  };

  Tween<Offset> insertItem = Tween(begin: Offset(-1,0),end: Offset(0,0));
  deleteReminder(int index) async {
    var reminderString=_reminders[index].toString().substring(_reminders[index].toString().indexOf("(")+1,_reminders[index].toString().indexOf(")"));
    _listKey.currentState?.removeItem(index, (context, animation) => SlideTransition(
        position: animation.drive(insertItem),
        child:Card(
            child:ListTile(title: Text(reminderString),)
        )
    ),duration: Duration(milliseconds: 200));
    _reminders.removeAt(index);



  }

  @override
  void initState() {
    // TODO: implement initState
    initList();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    var queryData =  MediaQuery.of(context);

    return Scaffold(
        appBar: AppBar(
          backgroundColor:Colors.transparent,
          elevation: 0,

        ),
        body: SingleChildScrollView(
          child:Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:EdgeInsets.fromLTRB(queryData.size.width/25, queryData.size.height/60, 0, 0),
                child: Container(
                    child:Text('Nuevo hábito',style: TextStyle(fontSize:queryData.textScaleFactor*26 ),)
                ),
              ),
              CustomSpacer(height: queryData.size.height/25),
              Padding(
                padding: EdgeInsets.fromLTRB(queryData.size.width/25, 0,queryData.size.width/25, 0),
                child: Form(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        TextFormField(
                          initialValue: _habitName,
                          onFieldSubmitted: (text){
                            setState(() {
                              _habitName=text;
                            });
                          },
                          decoration: const InputDecoration(
                            labelText:'Nombre',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        CustomSpacer(height: queryData.size.height/40),
                        Text('Color',style: TextStyle(fontSize: queryData.textScaleFactor*17),),
                        SizedBox(
                          width: queryData.size.width,
                          child: ColorPicker(
                            // Use the screenPickerColor as start color.
                            color: _selectedColor,
                            // Update the screenPickerColor using the callback.
                            onColorChanged: (Color color) =>
                                setState(() {
                                  _selectedColor = color;
                                }
                                ),
                            width: 40,
                            height: 40,
                            spacing: queryData.size.width/32,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            borderRadius: 22,
                            enableShadesSelection: false,
                            pickersEnabled: const <ColorPickerType,bool>{
                              ColorPickerType.both: false,
                              ColorPickerType.primary: false,
                              ColorPickerType.accent: false,
                              ColorPickerType.bw: false,
                              ColorPickerType.custom: true,
                              ColorPickerType.wheel: false,
                            },
                            customColorSwatchesAndNames: customSwatches,
                          ),


                        ),
                        Text('Inicio',style: TextStyle(fontSize: queryData.textScaleFactor*17),),
                        CustomSpacer(height: queryData.size.height/80),
                        GroupButton.radio(
                          buttons: [
                            'Hoy',
                            'Mañana',
                            isDateSelected?
                            (_selectedDate.day.toString()+"-"+(_selectedDate.month.toString().length<=1?'0'+_selectedDate.month.toString():_selectedDate.month.toString())+"-"+_selectedDate.year.toString()):'Fecha'],
                          elevation: elevation,
                          selectedTextStyle: TextStyle(
                              color:Colors.white
                          ),
                          unselectedTextStyle: TextStyle(
                              color:Colors.grey
                          ),
                          selectedColor: Colors.green,
                          borderRadius: BorderRadius.circular(5.0),
                          onSelected: (i)  async {
                            if(i == 2){
                              _selectedDate= await (showDatePicker(
                                  context: context,
                                  initialDate: _selectedDate,
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2501),
                              )) as DateTime;
                              setState(() {
                                isDateSelected=true;
                              });


                            }else{
                              _selectedDate=i==0? DateTime.now():DateTime.now().add(const Duration(days:1));
                              setState(() {
                                isDateSelected=false;
                              });
                            }
                          },
                        ),
                        CustomSpacer(height: queryData.size.height/80),
                        Text('Días',style: TextStyle(fontSize: queryData.textScaleFactor*17),),
                        CustomSpacer(height: queryData.size.height/80),
                        GroupButton(
                          isRadio: false,
                          buttons: ['D', 'L', 'M','M','J','V','S'],
                          elevation: elevation,
                          buttonWidth: queryData.size.width/10,
                          buttonHeight: queryData.size.height/15,
                          selectedTextStyle: const TextStyle(
                              color:Colors.white
                          ),
                          unselectedTextStyle: const TextStyle(
                              color:Colors.grey
                          ),
                          selectedColor: Colors.green,
                          borderRadius: BorderRadius.circular(5.0),
                          onSelected: (int index, bool selected) {
                            setState(() {
                              _days[index]=selected? 1:0;

                            });
                          },
                        ),
                        CustomSpacer(height: queryData.size.height/80),
                        Row(
                          children: [
                            Text('Recordatorios',style: TextStyle(fontSize: queryData.textScaleFactor*17),),
                            Spacer(),
                            Switch(
                              value: _remind,
                              onChanged: (bool value) {
                                setState(() {
                                  _remind=value;
                                });
                              },
                              activeColor: Colors.primaries[9],
                            )
                          ],
                        ),
                        CustomSpacer(height: queryData.size.height/80),
                        _remind?
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AnimatedList(
                              key: _listKey,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              initialItemCount: _reminders.length,
                              itemBuilder: (BuildContext context, int index, Animation<double> animation) {
                                return SlideTransition(
                                    position: animation.drive(insertItem),
                                    child:Card(
                                        child:ListTile(title: Text(_reminders[index].toString().substring(_reminders[index].toString().indexOf("(")+1,_reminders[index].toString().indexOf(")"))),trailing: IconButton(icon: Icon(Icons.close), onPressed: () { deleteReminder(index); },),)
                                    )
                                );
                              },
                            ),
                            CustomSpacer(height: queryData.size.height/80),
                            ElevatedButton.icon(
                              style: ButtonStyle(
                                  elevation: MaterialStateProperty.all<double>(0),
                                  backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent)
                              ),
                              onPressed: () async {
                                var newReminder= await showTimePicker(context: context, initialTime: TimeOfDay(hour: 12, minute: 00));
                                setState(() {
                                  _reminders.add(newReminder!);
                                  var currentIndex=_reminders.isEmpty?0:_reminders.length-1;
                                  print(currentIndex);
                                  _listKey.currentState?.insertItem(currentIndex);
                                });
                              }, icon: Icon(Icons.add), label: Text(''),)
                          ],
                        ):Container(),



                      ]

                  ),

                ),
              ),
            ],
          ),
        )
    );


  }


  void initList(){
    for(int i=0; i<_reminders.length;i++){
      _listKey.currentState?.insertItem(i);
    }
  }
  void goBack(BuildContext context){
    Navigator.pop(context);
  }
}
