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

    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.symmetric(horizontal: 0.8, vertical: 0.8),
      width: isSelected ? 75 : 70,
      height: isSelected ? 75 : 70,
      decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? appState.colorPrimary : Color(0xFF444444),
            width: 2,
          ),
          borderRadius: BorderRadius.all(Radius.circular(16)),
          color: isSelected ? appState.colorPrimary : Colors.transparent),
      child: InkWell(
        onTap: () {
          if (!isSelected) {
            appState.UpdateCategoryId(
                widget.category.categoryId, widget.category.color);
          }
        },
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                widget.category.icon,
                color: isSelected ? Colors.white : Color(0xFF444444),
                size: isSelected ? 30 : 25,
              ),
              SizedBox(height: 4),
              Text(
                widget.category.name,
                style: isSelected
                    ? selectedCategoryTextStyle.copyWith(color: Colors.white)
                    : categoryTextStyle.copyWith(color: Color(0xFF444444)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
