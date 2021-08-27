import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:local_events/app_state.dart';
import 'package:local_events/functions/features_functions.dart';
import 'package:local_events/functions/utils_functions.dart';
import 'package:local_events/models/event.dart';
import 'package:local_events/styleguide.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

class EventDetailsContent extends StatefulWidget {
  final AppState appState;
  final bool themeIsDark;

  const EventDetailsContent({Key key, this.appState, this.themeIsDark})
      : super(key: key);

  @override
  _EventDetailsContentState createState() => _EventDetailsContentState();
}

class _EventDetailsContentState extends State<EventDetailsContent> {
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
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            widget.appState.colorPrimary,
                            widget.appState.colorSecundary,
                          ],
                        ),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            offset: Offset(0, 2),
                            blurRadius: 3,
                          )
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                        child: FadeInImage.assetNetwork(
                          image: evento.imagePath,
                          width: MediaQuery.of(context).size.width,
                          height: 125,
                          fit: BoxFit.cover,
                          placeholder: 'assets/images/placeholder.png',
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 40.0, left: 16.0, right: 6.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).primaryColor.withOpacity(.9),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: IconButton(
                            icon: FaIcon(
                              FontAwesomeIcons.chevronLeft,
                              color: widget.themeIsDark
                                  ? lightTheme.primaryColor
                                  : darkTheme.primaryColor,
                              size: 20,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Expanded(
                child: NotificationListener<OverscrollIndicatorNotification>(
                  onNotification: (OverscrollIndicatorNotification overScroll) {
                    overScroll.disallowGlow();
                    return false;
                  },
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: AnimationLimiter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: AnimationConfiguration.toStaggeredList(
                          duration: Duration(milliseconds: 375),
                          childAnimationBuilder: (widget) => SlideAnimation(
                            verticalOffset: 50,
                            child: FadeInAnimation(
                              child: widget,
                            ),
                          ),
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 16.0, top: 18),
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
                                "${evento.punchLine1} ${evento.punchLine2}",
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
                              padding:
                                  const EdgeInsets.only(left: 16.0, top: 16),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border(
                                        right: BorderSide(
                                          width: 1,
                                          color: Colors.grey.withOpacity(.5),
                                        ),
                                      ),
                                    ),
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 16.0),
                                      child: Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                          color: widget.appState.colorPrimary
                                              .withOpacity(0.25),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Center(
                                          child: Text(
                                            DateFormat("dd", "pt_BR").format(
                                                DateTime.parse(
                                                    evento.initialDate)),
                                            style: eventoSubtitle.copyWith(
                                              fontSize: 25,
                                              fontWeight: FontWeight.w500,
                                              color:
                                                  widget.appState.colorPrimary,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 16.0,
                                      right: 16.0,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Text(
                                              capitalize(DateFormat(
                                                      "E, dd MMM, yyyy",
                                                      "pt_BR")
                                                  .format(DateTime.parse(
                                                      evento.initialDate))),
                                              style: eventLocationTextStyle
                                                  .copyWith(
                                                fontSize: 22,
                                                color: widget.themeIsDark
                                                    ? Colors.white
                                                    : Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 8, top: 4),
                                          child: Row(
                                            children: <Widget>[
                                              Text(
                                                "Fim: ",
                                                style: eventoSubtitle.copyWith(
                                                  fontWeight: FontWeight.w700,
                                                  color: widget.themeIsDark
                                                      ? Colors.white38
                                                      : Colors.black38,
                                                ),
                                              ),
                                              Text(
                                                DateFormat(
                                                        "dd MMM, yyy", "pt_BR")
                                                    .format(DateTime.parse(
                                                        evento.finalDate)),
                                                style: eventoSubtitle.copyWith(
                                                  fontWeight: FontWeight.w400,
                                                  color: widget.themeIsDark
                                                      ? Colors.white38
                                                      : Colors.black38,
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
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 16.0, top: 32),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border(
                                        right: BorderSide(
                                          width: 1,
                                          color: Colors.grey.withOpacity(.5),
                                        ),
                                      ),
                                    ),
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 16.0),
                                      child: Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          image: DecorationImage(
                                            image: AssetImage(
                                                "assets/icons/map_icon.png"),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0),
                                      child: Text(
                                        getLocation(evento.location),
                                        style: eventoSubtitle.copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: widget.themeIsDark
                                              ? Colors.white
                                              : Colors.black,
                                        ),
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
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline4
                                          .copyWith(fontSize: 22),
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
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 16,
                                  right: 16,
                                  top: 16,
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      "Mapa",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline4
                                          .copyWith(fontSize: 22),
                                    ),
                                    Spacer(),
                                    InkWell(
                                      onTap: () => launchMapsUrl(evento),
                                      child: Row(
                                        children: <Widget>[
                                          Text(
                                            "Ver localização",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline4
                                                .copyWith(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                          ),
                                          SizedBox(width: 8),
                                          FaIcon(
                                            FontAwesomeIcons.angleRight,
                                            color:
                                                Theme.of(context).buttonColor,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            if (evento.location.split(",").length > 1)
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 16,
                                ),
                                width: screenWidth,
                                height: 250,
                                child: FlutterMap(
                                  options: new MapOptions(
                                    center: LatLng(getCoodenadas(evento.location)[0], getCoodenadas(evento.location)[1]),
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
                                          point: LatLng(getCoodenadas(evento.location)[0], getCoodenadas(evento.location)[1]),
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
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 16, right: 16, top: 8, bottom: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "Fonte",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline4
                                        .copyWith(fontSize: 22),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    evento.site,
                                    style: eventoDescription.copyWith(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w300,
                                      color: widget.themeIsDark
                                          ? Colors.white38
                                          : Color(0xFF444444),
                                    ),
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
              ),
            ],
          ),
          Positioned(
            top: screenHeight * 0.45,
            width: screenWidth,
            child: AnimationLimiter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: AnimationConfiguration.toStaggeredList(
                  duration: Duration(milliseconds: 375),
                  childAnimationBuilder: (widget) => SlideAnimation(
                    horizontalOffset: 50,
                    child: FadeInAnimation(
                      child: widget,
                    ),
                  ),
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: _buildFloatingButton(
                          evento,
                          FontAwesomeIcons.calendarAlt,
                          Color(0xFF80A2FC),
                          Color(0xFF798CF5)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: _buildFloatingButton(
                          evento,
                          FontAwesomeIcons.link,
                          Theme.of(context).buttonColor,
                          Theme.of(context).buttonColor),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 16.0, left: 8),
                      child: _buildFloatingButton(
                          evento,
                          FontAwesomeIcons.shareAlt,
                          widget.appState.colorPrimary,
                          widget.appState.colorSecundary),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildFloatingButton(
      Evento evento, IconData icon, Color colorPrimary, Color colorSecundary) {
    return FloatingActionButton(
      heroTag: icon.toString(),
      backgroundColor: Theme.of(context).primaryColor,
      child: ShaderMask(
        shaderCallback: (bounds) => LinearGradient(
          colors: [colorPrimary, colorSecundary],
          tileMode: TileMode.mirror,
        ).createShader(bounds),
        child: Container(
          margin: EdgeInsets.all(1),
          child: FaIcon(
            icon,
            color: Colors.white,
          ),
        ),
      ),
      onPressed: () {
        if (icon == FontAwesomeIcons.calendarAlt) addEventToCalendar(evento);
        if (icon == FontAwesomeIcons.link) goToWebsite(evento);
        if (icon == FontAwesomeIcons.shareAlt) share(context, evento);
      },
    );
  }
}
