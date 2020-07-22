import 'package:flutter/material.dart';
import 'package:local_events/app_state.dart';
import 'package:local_events/models/category.dart';
import 'package:local_events/styleguide.dart';
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
      margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(
          color: isSelected
              ? appState.colorPrimary.withOpacity(0.2)
              : Colors.black54,
          width: 2,
        ),
        borderRadius: BorderRadius.all(Radius.circular(50)),
        color: isSelected ? appState.colorPrimary : Colors.transparent,
      ),
      child: InkWell(
        onTap: () {
          if (!isSelected) {
            appState.UpdateCategoryId(
                widget.category.categoryId, widget.category.color);
          }

          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              AnimatedDefaultTextStyle(
                style: isSelected
                    ? selectedCategoryTextStyle.copyWith(
                        color: Colors.white,
                        fontSize: 16,
                      )
                    : categoryTextStyle.copyWith(color: Color(0xFF444444)),
                duration: Duration(milliseconds: 300),
                child: Text(widget.category.name),
              )
            ],
          ),
        ),
      ),
    );
  }
}
