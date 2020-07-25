import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:local_events/models/event.dart';
import 'package:local_events/styleguide.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class EventDetailsContent extends StatefulWidget {
  final Color colorPunchLine1;
  final bool themeIsDark;

  const EventDetailsContent({Key key, this.colorPunchLine1, this.themeIsDark})
      : super(key: key);

  @override
  _EventDetailsContentState createState() => _EventDetailsContentState();
}

class _EventDetailsContentState extends State<EventDetailsContent> {
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

  @override
  Widget build(BuildContext context) {
    final evento = Provider.of<Evento>(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: widget.themeIsDark ? Color(0xFF212226) : Colors.white,
      resizeToAvoidBottomInset: false,
      body: Column(
        children: <Widget>[
          Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              Container(
                height: screenHeight * 0.5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 2),
                      blurRadius: 6.0,
                    ),
                  ],
                ),
                child: Hero(
                  tag: evento.imagePath,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30)),
                    child: Image.network(
                      evento.imagePath,
                      fit: BoxFit.cover,
                      color: Color(0x70000000),
                      colorBlendMode: BlendMode.darken,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    IconButton(
                      icon: FaIcon(
                        FontAwesomeIcons.share,
                        color: Colors.white,
                      ),
                      onPressed: () => share(context, evento),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 20,
                bottom: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      evento.title,
                      style: eventwhiteTitleTextStyle,
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          FontAwesomeIcons.locationArrow,
                          size: 10,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          evento.location,
                          style: eventLocationTextStyle.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: Container(
              color: widget.themeIsDark ? Color(0xFF212226) : Colors.white,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: evento.punchLine1,
                              style: punchLine1TextStyle.copyWith(
                                color: widget.colorPunchLine1,
                              ),
                            ),
                            TextSpan(
                              text: evento.punchLine2,
                              style: punchLine2TextStyle.copyWith(
                                color: widget.themeIsDark
                                    ? Colors.white
                                    : punchLine2TextStyle.color,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (evento.description != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: [
                            Text(
                              "Descrição:",
                              style: eventLocationTextStyle.copyWith(
                                fontWeight: FontWeight.w700,
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
                      child: RichText(
                        text: TextSpan(
                          text: evento.description,
                          style: eventLocationTextStyle.copyWith(
                            fontSize: 17,
                            color: Color(0xFF444444),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16, top: 16),
                      child: Row(
                        children: [
                          Text(
                            "Data:",
                            style: eventLocationTextStyle.copyWith(
                              fontWeight: FontWeight.w700,
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
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 4, vertical: 4),
                            decoration: BoxDecoration(
                              color: widget.colorPunchLine1,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  offset: Offset(0, 2),
                                  blurRadius: 1.0,
                                ),
                              ],
                            ),
                            child: Center(
                              child: Icon(
                                Icons.calendar_today,
                                color: widget.themeIsDark
                                    ? Color(0xFF212226)
                                    : Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            evento.date,
                            style: eventLocationTextStyle.copyWith(
                              color: Color(0xFF444444),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16, top: 8),
                      child: Row(
                        children: [
                          Text(
                            "Mais informações:",
                            style: eventLocationTextStyle.copyWith(
                              fontWeight: FontWeight.w700,
                              color: widget.themeIsDark
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (evento.phone != null && evento.phone != "")
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 4, vertical: 4),
                              decoration: BoxDecoration(
                                color: widget.colorPunchLine1,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    offset: Offset(0, 2),
                                    blurRadius: 1.0,
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.phone,
                                  color: widget.themeIsDark
                                      ? Color(0xFF212226)
                                      : Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            SelectableText(
                              evento.phone,
                              style: eventLocationTextStyle.copyWith(
                                color: Color(0xFF444444),
                              ),
                            ),
                          ],
                        ),
                      ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 16, bottom: 16, top: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 4, vertical: 4),
                            decoration: BoxDecoration(
                              color: widget.colorPunchLine1,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  offset: Offset(0, 2),
                                  blurRadius: 1.0,
                                ),
                              ],
                            ),
                            child: Center(
                              child: Icon(
                                Icons.link,
                                color: widget.themeIsDark
                                    ? Color(0xFF212226)
                                    : Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          InkWell(
                            onTap: () async {
                              if (await canLaunch(evento.site)) {
                                await launch(evento.site);
                              }
                            },
                            child: SelectableText(
                              evento.site,
                              style: eventLocationTextStyle.copyWith(
                                decoration: TextDecoration.underline,
                                color: Colors.blue,
                              ),
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
        ],
      ),
    );
  }
}
