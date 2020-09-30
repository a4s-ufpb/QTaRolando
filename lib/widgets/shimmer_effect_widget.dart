import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:local_events/styleguide.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerEffectWidget extends StatefulWidget {
  bool themeIsDark;
  ShimmerEffectWidget({Key key, this.themeIsDark}) : super(key: key);
  @override
  _ShimmerEffectWidgetState createState() => _ShimmerEffectWidgetState();
}

class _ShimmerEffectWidgetState extends State<ShimmerEffectWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 1),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(15)),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 1),
              blurRadius: 1.0,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Container(
                      child: Shimmer.fromColors(
                        baseColor: Colors.black38,
                        highlightColor: Colors.black12,
                        child: Container(
                          height: 125,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 125,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: widget.themeIsDark
                                ? Color(0xFF2d3033)
                                : Color(0xFFF1F3F4),
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                offset: Offset(0, 2),
                                blurRadius: 3.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Shimmer.fromColors(
                  baseColor: Colors.black38,
                  highlightColor: Colors.black12,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: 125,
                              height: 25,
                              color: Theme.of(context).primaryColor,
                            ),
                            SizedBox(height: 10),
                            FittedBox(
                              child: Material(
                                color: Colors.transparent,
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      FontAwesomeIcons.solidCompass,
                                      size: eventLocationTextStyle.fontSize,
                                      color: widget.themeIsDark
                                          ? Color(0xFF212226)
                                          : Colors.white,
                                    ),
                                    SizedBox(width: 5),
                                    Container(
                                        width: 150,
                                        height: 20,
                                        color: Colors.white),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          IconButton(
                            enableFeedback: false,
                            icon: FaIcon(
                              FontAwesomeIcons.shareAlt,
                              color: Colors.white,
                            ),
                            onPressed: () {},
                          ),
                          IconButton(
                            enableFeedback: false,
                            icon: FaIcon(
                              FontAwesomeIcons.calendarAlt,
                              color: Colors.white,
                            ),
                            onPressed: () {},
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
      ),
    );
  }
}
