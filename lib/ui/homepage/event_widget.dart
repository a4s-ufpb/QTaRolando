import 'package:flutter/material.dart';
import 'package:local_events/models/event.dart';
import 'package:local_events/styleguide.dart';

class EventWidget extends StatelessWidget {
  final Evento evento;

  const EventWidget({Key key, this.evento}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 15),
      elevation: 5,
      shadowColor: Colors.black,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: Hero(
                tag: evento,
                child: Container(
                  color: Colors.grey,
                  child: Image.network(
                    evento.imagePath,
                    height: 70,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 8),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          evento.title,
                          style: eventTitleTextStyle,
                        ),
                        SizedBox(height: 10),
                        FittedBox(
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.location_on,
                                size: 20,
                              ),
                              SizedBox(width: 5),
                              Text(
                                evento.location,
                                style: eventLocationTextStyle,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      evento.duration.toUpperCase(),
                      textAlign: TextAlign.right,
                      style: eventLocationTextStyle.copyWith(
                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
