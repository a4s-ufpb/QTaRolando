import 'package:flutter/material.dart';
import 'package:local_events/app_state.dart';
import 'package:local_events/models/filter.dart';
import 'package:local_events/widgets/filter_button_widget.dart';

class FilterContentWidget extends StatefulWidget {
  final AppState appState;

  const FilterContentWidget({Key key, this.appState}) : super(key: key);

  @override
  _FilterContentWidgetState createState() => _FilterContentWidgetState();
}

class _FilterContentWidgetState extends State<FilterContentWidget> {
  String filterByDate = "";
  bool isSelectedDate = false;
  String filterByType = "";
  bool isSelectedType = false;

  @override
  void initState() {
    super.initState();
    filterByDate = widget.appState.filterByDate;
    filterByType = widget.appState.filterByType;
  }

  _buildFilterByDate() {
    List<Widget> choices = List();
    filtersByDate.forEach((item) {
      choices.add(Padding(
        padding: const EdgeInsets.only(right: 8),
        child: ChoiceChip(
          pressElevation: 0,
          elevation: 0,
          disabledColor: Theme.of(context).primaryColor,
          selectedColor: Theme.of(context).primaryColor,
          backgroundColor: Theme.of(context).primaryColor,
          padding: const EdgeInsets.all(0),
          labelPadding: const EdgeInsets.all(0),
          label: FilterButton(
            filter: item,
            appState: widget.appState,
            isSelected: isSelectedDate = filterByDate == item.name,
          ),
          selected: filterByDate == item.name,
          onSelected: (selected) {
            if (widget.appState.filterByDate != item.name) {
              widget.appState.UpdateFilterByDate(item.name);
              this.setState(() {
                filterByDate = widget.appState.filterByDate;
              });
            } else {
              widget.appState.UpdateFilterByDate("");
              this.setState(() {
                filterByDate = "";
              });
            }
          },
        ),
      ));
    });
    return choices;
  }

  _buildFilterByType() {
    List<Widget> choices = List();
    filtersByType.forEach((item) {
      choices.add(Padding(
        padding: const EdgeInsets.only(right: 16.0),
        child: ChoiceChip(
          pressElevation: 0,
          elevation: 0,
          disabledColor: Theme.of(context).primaryColor,
          selectedColor: Theme.of(context).primaryColor,
          backgroundColor: Theme.of(context).primaryColor,
          padding: const EdgeInsets.all(0),
          labelPadding: const EdgeInsets.all(0),
          label: FilterButton(
            filter: item,
            appState: widget.appState,
            isSelected: isSelectedType = filterByType == item.name,
          ),
          selected: filterByDate == item.name,
          onSelected: (selected) {
            if (widget.appState.filterByType != item.name) {
              widget.appState.UpdateFilterByType(item.name);
              this.setState(() {
                filterByType = widget.appState.filterByType;
              });
            } else {
              widget.appState.UpdateFilterByType("");
              this.setState(() {
                filterByType = "";
              });
            }
          },
        ),
      ));
    });
    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Material(
            color: Colors.transparent,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Container(
                    height: 7,
                    width: 45,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(.5),
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0, top: 8),
                  child: Text(
                    "Filtrar por:",
                    style: Theme.of(context).textTheme.headline2.copyWith(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    "Período",
                    style: Theme.of(context).textTheme.headline2.copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Wrap(
                    direction: Axis.horizontal,
                    spacing: 2,
                    children: _buildFilterByDate(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    "Tipo",
                    style: Theme.of(context).textTheme.headline2.copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: _buildFilterByType(),
                ),
                SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
