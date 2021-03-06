import 'package:flutter/material.dart';
import 'package:local_events/app_state.dart';
import 'package:local_events/models/category.dart';
import 'package:provider/provider.dart';

class CategoryWidget extends StatefulWidget {
  final Category category;

  const CategoryWidget({Key key, this.category}) : super(key: key);

  @override
  _CategoryWidgetState createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final isSelected =
        appState.selectedCategoryId == widget.category.categoryId;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(
          color: isSelected
              ? appState.colorPrimary.withOpacity(0.05)
              : Theme.of(context).buttonColor,
          width: 1,
        ),
        boxShadow: (isSelected)
            ? [
                BoxShadow(
                    blurRadius: 3, offset: Offset(0, 1), color: Colors.black26)
              ]
            : [],
        borderRadius: BorderRadius.all(Radius.circular(50)),
        gradient: LinearGradient(
          colors: isSelected
              ? [
                  appState.colorPrimary,
                  appState.colorSecundary,
                ]
              : [
                  Colors.transparent,
                  Colors.transparent,
                ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: InkWell(
        focusColor: Colors.transparent,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: () {
          if (!isSelected) {
            appState.UpdateCategoryId(widget.category.categoryId,
                widget.category.colorPrimary, widget.category.colorSecundary);
          }

          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Icon(
                  widget.category.icon,
                  size: 15,
                  color: isSelected
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).buttonColor,
                ),
              ),
              Text(
                widget.category.name,
                style: isSelected
                    ? Theme.of(context).textTheme.headline1.copyWith(
                          color: Theme.of(context).primaryColor,
                        )
                    : Theme.of(context)
                        .textTheme
                        .headline1
                        .copyWith(color: Theme.of(context).buttonColor),
              )
            ],
          ),
        ),
      ),
    );
  }
}
