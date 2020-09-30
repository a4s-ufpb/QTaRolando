import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:local_events/app_state.dart';
import 'package:local_events/models/filter.dart';
import 'package:local_events/styleguide.dart';

class FilterButton extends StatefulWidget {
  final Filter filter;
  final AppState appState;
  final bool isSelected;

  const FilterButton({Key key, this.filter, this.appState, this.isSelected})
      : super(key: key);

  @override
  _FilterButtonState createState() => _FilterButtonState();
}

class _FilterButtonState extends State<FilterButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).buttonColor,
          width: 1,
        ),
        borderRadius: BorderRadius.all(Radius.circular(50)),
        gradient: LinearGradient(
          colors: widget.isSelected
              ? [
                  widget.appState.colorPrimary,
                  widget.appState.colorSecundary,
                ]
              : [
                  Colors.transparent,
                  Colors.transparent,
                ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 2.0),
            child: Center(
              child: Text(
                widget.filter.name,
                style: widget.isSelected
                    ? Theme.of(context).textTheme.headline1.copyWith(
                          color: Theme.of(context).primaryColor,
                        )
                    : Theme.of(context).textTheme.headline1,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 8),
            decoration: BoxDecoration(
                border: Border(
                    left: BorderSide(
              color: Theme.of(context).buttonColor,
            ))),
            child: widget.isSelected
                ? FaIcon(
                    FontAwesomeIcons.times,
                    size: selectedCategoryTextStyle.fontSize,
                    color: Theme.of(context).buttonColor.withOpacity(0.5),
                  )
                : FaIcon(
                    FontAwesomeIcons.check,
                    size: selectedCategoryTextStyle.fontSize,
                    color: Theme.of(context).buttonColor.withOpacity(0.5),
                  ),
          ),
        ],
      ),
    );
  }
}
