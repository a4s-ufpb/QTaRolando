import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:local_events/app_state.dart';
import 'package:local_events/models/event.dart';
import 'package:local_events/styleguide.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class EventDetailsContent extends StatefulWidget {
  final AppState appState;
  final bool themeIsDark;

  const EventDetailsContent({Key key, this.appState, this.themeIsDark})
      : super(key: key);

  @override
  _EventDetailsContentState createState() => _EventDetailsContentState();
}

class _EventDetailsContentState extends State<EventDetailsContent> {
  String capitalize(String string) {
    if (string == null) {
      throw ArgumentError("string: $string");
    }

    if (string.isEmpty) {
      return string;
    }

    return string[0] +
        string[1] +
        " " +
        string[3].toUpperCase() +
        string[4].toLowerCase() +
        string[5].toLowerCase();
  }

  String getLocation(Evento evento) {
    final eventoLocation = evento.location.split(",");
    if (eventoLocation.length > 1) {
      return eventoLocation[0] + "," + eventoLocation[1];
    }
    return eventoLocation[0];
  }

  List<double> getCoodenadas(Evento evento) {
    final eventoLocation = evento.location.split(",");
    return [double.parse(eventoLocation[2]), double.parse(eventoLocation[3])];
  }

  void share(BuildContext context, Evento evento) {
    final RenderBox box = context.findRenderObject();
    final String text =
        "${evento.title} - ${evento.punchLine1} ${evento.punchLine2}\nPara mais informações acesse: ${evento.site}";
    Share.share(
      text,
      subject: evento.description,
      sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
    );
  }

  void call(Evento evento) async {
    launch('tel:${evento.phone.toString()}');
  }

  void goToWebsite(Evento evento) async {
    if (await canLaunch(evento.site)) {
      await launch(evento.site);
    }
  }

  void addEventToCalendar(Evento evento) {
    final Event event = Event(
      title: evento.title,
      description: evento.description,
      location: getLocation(evento),
      startDate: DateTime.parse(evento.initialDate),
      endDate: DateTime.parse(evento.finalDate),
    );
    Add2Calendar.addEvent2Cal(event);
  }

  @override
  Widget build(BuildContext context) {
    final evento = Provider.of<Evento>(context);

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: widget.themeIsDark ? Color(0xFF212226) : Colors.white,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    width: screenWidth,
                    height: screenHeight * 0.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                      child: Image.network(
                        evento.imagePath,
                        fit: BoxFit.cover,
                        color: Color(0x70000000),
                        colorBlendMode: BlendMode.darken,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 40.0, left: 6.0, right: 6.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            FontAwesomeIcons.arrowLeft,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ScrollConfiguration(
                  behavior: ScrollBehavior(),
                  child: GlowingOverscrollIndicator(
                    color: Color(0xFF2d3033),
                    axisDirection: AxisDirection.down,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      physics: AlwaysScrollableScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0, top: 18),
                            child: Text(
                              evento.title,
                              style: eventwhiteTitleTextStyle.copyWith(
                                fontSize: 30,
                                fontWeight: FontWeight.w600,
                                color: widget.themeIsDark
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 16.0, bottom: 8),
                            child: Text(
                              "${evento.punchLine1}${evento.punchLine2}",
                              style: eventoDescription.copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: widget.themeIsDark
                                    ? Colors.white38
                                    : Color(0xFF444444),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0, top: 8),
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(right: 16.0),
                                  child: FaIcon(
                                    FontAwesomeIcons.calendarAlt,
                                    size: 25,
                                    color: widget.themeIsDark
                                        ? Colors.white
                                        : Color(0xFF212226),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 16.0),
                                  child: Text(
                                    DateFormat.MMMMd("pt_BR").format(
                                            DateTime.parse(
                                                evento.initialDate)) +
                                        " - " +
                                        DateFormat.MMMMd("pt_BR").format(
                                            DateTime.parse(evento.finalDate)),
                                    style: eventoSubtitle.copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: widget.themeIsDark
                                          ? Colors.white38
                                          : Color(0xFF444444),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (evento.phone != null && evento.phone != "")
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 16.0, top: 8),
                              child: Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(right: 16.0),
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: 22.5,
                                      height: 30,
                                      child: FaIcon(
                                        FontAwesomeIcons.mobileAlt,
                                        size: 25,
                                        color: widget.themeIsDark
                                            ? Colors.white
                                            : Color(0xFF212226),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      evento.phone,
                                      style: eventoSubtitle.copyWith(
                                        fontWeight: FontWeight.w400,
                                        color: widget.themeIsDark
                                            ? Colors.white38
                                            : Color(0xFF444444),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0, top: 8),
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(right: 16.0),
                                  child: FaIcon(
                                    FontAwesomeIcons.compass,
                                    size: 25,
                                    color: widget.themeIsDark
                                        ? Colors.white
                                        : Color(0xFF212226),
                                  ),
                                ),
                                Flexible(
                                  child: Text(
                                    getLocation(evento),
                                    style: eventoSubtitle.copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: widget.themeIsDark
                                          ? Colors.white38
                                          : Color(0xFF444444),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (evento.description != null)
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 16,
                                right: 16,
                                top: 16,
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    "Sobre o evento",
                                    style: eventLocationTextStyle.copyWith(
                                      fontSize: 22,
                                      color: widget.themeIsDark
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: ReadMoreText(
                              evento.description,
                              trimLines: 4,
                              colorClickableText:
                                  widget.appState.colorSecundary,
                              trimMode: TrimMode.Line,
                              trimCollapsedText: '...\nVer mais',
                              trimExpandedText: '\nVer menos',
                              style: eventoDescription.copyWith(
                                fontSize: 15,
                                fontWeight: FontWeight.w300,
                                color: widget.themeIsDark
                                    ? Colors.white38
                                    : Color(0xFF444444),
                              ),
                            ),
                          ),
                          if (evento.location.split(",").length > 1)
                            Container(
                              padding: EdgeInsets.only(top: 16),
                              width: screenWidth,
                              height: 275,
                              child: FlutterMap(
                                options: new MapOptions(
                                  center: new LatLng(getCoodenadas(evento)[0],
                                      getCoodenadas(evento)[1]),
                                  zoom: 15.0,
                                  maxZoom: 17.0,
                                ),
                                layers: [
                                  new TileLayerOptions(
                                      urlTemplate:
                                          "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                                      subdomains: ['a', 'b', 'c']),
                                  new MarkerLayerOptions(
                                    markers: [
                                      new Marker(
                                        width: 80.0,
                                        height: 80.0,
                                        point: new LatLng(
                                            getCoodenadas(evento)[0],
                                            getCoodenadas(evento)[1]),
                                        builder: (ctx) => new Container(
                                          decoration: BoxDecoration(
                                              color: widget
                                                  .appState.colorSecundary
                                                  .withOpacity(0.25),
                                              shape: BoxShape.circle),
                                          child: Center(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black26,
                                                    offset: Offset(0, 2),
                                                    blurRadius: 2,
                                                  ),
                                                ],
                                                border: Border.all(
                                                    color: Colors.white,
                                                    width: 3),
                                                shape: BoxShape.circle,
                                              ),
                                              child: Container(
                                                height: 15,
                                                width: 15,
                                                decoration: BoxDecoration(
                                                    color: widget.appState
                                                        .colorSecundary,
                                                    shape: BoxShape.circle),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: screenHeight * 0.45,
            width: screenWidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: FloatingActionButton(
                    heroTag: "calendar",
                    backgroundColor:
                        widget.themeIsDark ? Color(0xFF212226) : Colors.white,
                    child: ShaderMask(
                      shaderCallback: (bounds) => LinearGradient(
                        colors: [
                          Color(0xFF80A2FC),
                          Color(0xFF798CF5),
                        ],
                        tileMode: TileMode.mirror,
                      ).createShader(bounds),
                      child: Container(
                        child: FaIcon(
                          FontAwesomeIcons.calendarAlt,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    onPressed: () => addEventToCalendar(evento),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: FloatingActionButton(
                    heroTag: "link",
                    backgroundColor:
                        widget.themeIsDark ? Color(0xFF212226) : Colors.white,
                    child: FaIcon(
                      FontAwesomeIcons.link,
                      color:
                          widget.themeIsDark ? Colors.white : Color(0xFF212226),
                    ),
                    onPressed: () => goToWebsite(evento),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 16.0, left: 8),
                  child: FloatingActionButton(
                    heroTag: "share",
                    backgroundColor:
                        widget.themeIsDark ? Color(0xFF212226) : Colors.white,
                    child: ShaderMask(
                      shaderCallback: (bounds) => LinearGradient(
                        colors: [
                          widget.appState.colorPrimary,
                          widget.appState.colorSecundary
                        ],
                        tileMode: TileMode.mirror,
                      ).createShader(bounds),
                      child: Container(
                        child: FaIcon(
                          FontAwesomeIcons.shareAlt,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    onPressed: () => share(context, evento),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
