import 'package:flutter/material.dart';
import 'package:local_events/app_state.dart';
import 'package:local_events/models/category.dart';
import 'package:local_events/styleguide.dart';
import 'package:provider/provider.dart';

class CategoryWidget extends StatefulWidget {
  final Category category;
  final bool themeIsDark;

  const CategoryWidget({Key key, this.category, this.themeIsDark})
      : super(key: key);

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
      margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(
          color: isSelected
              ? appState.colorPrimary.withOpacity(0.05)
              : widget.themeIsDark ? Colors.white38 : Colors.black26,
          width: 1,
        ),
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
                      ? Colors.white
                      : widget.themeIsDark ? Colors.white70 : Color(0xFF444444),
                ),
              ),
              Text(
                widget.category.name,
                style: isSelected
                    ? selectedCategoryTextStyle.copyWith(
                        color: Colors.white,
                      )
                    : categoryTextStyle.copyWith(
                        color: widget.themeIsDark
                            ? Colors.white70
                            : Color(0xFF444444)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
