import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hcslzapp/components/top.bar.dart';
import 'package:hcslzapp/controllers/event.calendar.controller.dart';
import 'package:hcslzapp/models/dependent.dart';
import 'package:hcslzapp/pages/dependent/dependent.add.page.dart';
import 'package:table_calendar/table_calendar.dart';

// Example holidays
final Map<DateTime, List> _holidays = {
  DateTime(2019, 1, 1): ['New Year\'s Day'],
  DateTime(2019, 1, 6): ['Epiphany'],
  DateTime(2019, 2, 14): ['Valentine\'s Day'],
  DateTime(2019, 4, 21): ['Easter Sunday'],
  DateTime(2019, 4, 22): ['Easter Monday'],
};

class EventCalendarPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return EventCalendarPageState();
  }
}

class EventCalendarPageState extends State<EventCalendarPage>
    with SingleTickerProviderStateMixin {
  EventCalendarController _controller = EventCalendarController();

  @override
  void initState() {
    _controller.init;
    _controller.calController = CalendarController();
    _controller.animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _controller.animController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.animController.dispose();
    _controller.calController.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime day, List events) {
    _controller.setSelectedEvents(events);
  }

  void _onDayLongPressed(DateTime day, List events) {
    _controller.setSelectedEvents(events);
  }

  void _onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {}

  void _onCalendarCreated(
      DateTime first, DateTime last, CalendarFormat format) {}

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.white30, Colors.deepOrange],
              begin: FractionalOffset.topLeft,
              end: FractionalOffset.bottomRight,
            ),
          ),
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TopBar(),
                _buildTableCalendarWithBuilders(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.arrow_upward_rounded,
                      size: 12.0,
                    ),
                    Icon(
                      Icons.arrow_downward_rounded,
                      size: 12.0,
                    ),
                  ],
                ),
                SizedBox(
                  height: 8.0,
                ),
                Expanded(child: _buildEventList()),
              ],
            ),
          ),
        ),
      );

  Container buildAddEventButton() {
    return Container(
      child: FloatingActionButton(
        mini: true,
        backgroundColor: Colors.black,
        child: Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }

  Widget _buildEventList() => Container(
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.white12,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          children: [
            Text(
              "Eventos",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: Observer(
                builder: (_) => ListView.separated(
                  shrinkWrap: true,
                  itemCount: _controller.selectedEvents.length,
                  itemBuilder: (_, int i) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white30,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(8.0),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10.0,
                            offset: Offset(0.0, 5.0),
                          ),
                        ],
                      ),
                      child: ListTile(
                        leading: Container(
                          width: 48,
                          height: 48,
                          alignment: Alignment.center,
                          child: CircleAvatar(
                            child: Icon(Icons.event),
                            backgroundColor: Colors.white,
                          ),
                        ),
                        trailing: Wrap(
                          spacing: 10, // space between two icons
                          children: <Widget>[
                            GestureDetector(
                              child: Icon(
                                Icons.delete,
                              ),
                              onTap: () {
                                setState(() {
                                  _controller.removeSelectedEvent(i);
                                });
                              },
                            ),
                            GestureDetector(
                              child: Icon(
                                Icons.edit,
                              ),
                              onTap: () {
                                final Future<Dependent> future = Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        DependentAddPage(null),
                                  ),
                                );
/*                          future.then(
                                  (dependent) {
                                if (dependent != null) {
                                  _controller.dependents.removeAt(i);
                                  _controller.dependents.add(dependent);
                                }
                              },
                            );*/
                              },
                            ),
                          ],
                        ),
                        title: Text(_controller.selectedEvents[i].toString()),
                        //subtitle: Text(event.toString()),
                      ),
                    );
                  },
                  separatorBuilder: (_, int index) => const Divider(),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 20.0),
              child: FloatingActionButton(
                heroTag: "btnAdd",
                mini: true,
                backgroundColor: Colors.deepOrangeAccent[100],
                child: Icon(
                  Icons.add,
                  color: Colors.black,
                ),
                onPressed: () {
                  _showAddDialog();
                },
              ),
            ),
          ],
        ),
      );

  _showAddDialog() async {
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: Colors.white70,
              title: Text("Adicionar Evento"),
              content: TextField(
                controller: _controller.eventCtrl,
              ),
              actions: <Widget>[
                Row(
                  children: [
                    FlatButton(
                      child: Text(
                        'Cancelar',
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    FlatButton(
                      child: Text(
                        "Salvar",
                      ),
                      onPressed: () {
                        if (_controller.eventCtrl.text.isEmpty) return;
                        if (_controller.selectedEvents.isNotEmpty) {
                          _controller.selectedEvents
                              .add(_controller.eventCtrl.text);
                          _controller.events[_controller.calController
                              .selectedDay] = _controller.selectedEvents;
                        } else {
                          _controller
                              .events[_controller.calController.selectedDay] = [
                            _controller.eventCtrl.text
                          ].toList();
                        }
                        _controller.eventCtrl.clear();
                        Navigator.pop(context);
                      },
                    ),
                  ],
                )
              ],
            ));
  }

  Widget _buildTableCalendarWithBuilders() {
    return Observer(
      builder: (_) => TableCalendar(
        locale: 'pt_BR',
        calendarController: _controller.calController,
        events: _controller.events,
        holidays: _holidays,
        rowHeight: 40,
        initialCalendarFormat: CalendarFormat.month,
        formatAnimation: FormatAnimation.slide,
        startingDayOfWeek: StartingDayOfWeek.sunday,
        availableGestures: AvailableGestures.all,
        availableCalendarFormats: const {
          CalendarFormat.month: '',
          CalendarFormat.week: '',
        },
        calendarStyle: CalendarStyle(
          outsideDaysVisible: false,
          weekendStyle: TextStyle().copyWith(color: Colors.blue[800]),
          holidayStyle: TextStyle().copyWith(color: Colors.blue[800]),
        ),
        daysOfWeekStyle: DaysOfWeekStyle(
          weekendStyle: TextStyle().copyWith(color: Colors.blue[800]),
        ),
        headerStyle: HeaderStyle(
          centerHeaderTitle: true,
          formatButtonVisible: false,
        ),
        builders: CalendarBuilders(
          selectedDayBuilder: (context, date, _) {
            return FadeTransition(
              opacity: Tween(begin: 0.0, end: 1.0)
                  .animate(_controller.animController),
              child: Container(
                margin: const EdgeInsets.all(4.0),
                padding: const EdgeInsets.only(top: 5.0, left: 6.0),
                color: Colors.deepOrange[300],
                width: 100,
                height: 100,
                child: Text(
                  '${date.day}',
                  style: TextStyle().copyWith(fontSize: 16.0),
                ),
              ),
            );
          },
          todayDayBuilder: (context, date, _) {
            return Container(
              margin: const EdgeInsets.all(4.0),
              padding: const EdgeInsets.only(top: 5.0, left: 6.0),
              color: Colors.amber[400],
              width: 100,
              height: 100,
              child: Text(
                '${date.day}',
                style: TextStyle().copyWith(fontSize: 16.0),
              ),
            );
          },
          markersBuilder: (context, date, events, holidays) {
            final children = <Widget>[];

            if (events.isNotEmpty) {
              children.add(
                Positioned(
                  right: 1,
                  bottom: 1,
                  child: _buildEventsMarker(date, events),
                ),
              );
            }

            if (holidays.isNotEmpty) {
              children.add(
                Positioned(
                  right: -2,
                  top: -2,
                  child: _buildHolidaysMarker(),
                ),
              );
            }

            return children;
          },
        ),
        onDaySelected: (date, events) {
          _onDaySelected(date, events);
          _controller.animController.forward(from: 0.0);
        },
        onVisibleDaysChanged: _onVisibleDaysChanged,
        onCalendarCreated: _onCalendarCreated,
      ),
    );
  }

  Widget _buildEventsMarker(DateTime date, List events) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: _controller.calController.isSelected(date)
            ? Colors.brown[500]
            : _controller.calController.isToday(date)
                ? Colors.brown[300]
                : Colors.blue[400],
      ),
      width: 16.0,
      height: 16.0,
      child: Center(
        child: Text(
          '${events.length}',
          style: TextStyle().copyWith(
            color: Colors.white,
            fontSize: 12.0,
          ),
        ),
      ),
    );
  }

  Widget _buildHolidaysMarker() {
    return Icon(
      Icons.add_box,
      size: 20.0,
      color: Colors.blueGrey[800],
    );
  }
}
