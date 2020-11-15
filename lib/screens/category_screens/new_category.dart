import 'package:flutter/material.dart';
import 'package:todo_list/models/task_category.dart';
import '../../constants.dart';
import 'package:todo_list/provider/databaseProvider.dart';
import '../../size_config.dart';

class NewCategory extends StatefulWidget {
  @override
  _NewCategoryState createState() => _NewCategoryState();
}

class _NewCategoryState extends State<NewCategory> {
  String categoryName = "";
  Color _selectedColor = Color(0xff6074F9);
  double defaultSize = SizeConfig.defaultSize;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("New Category")),
        body: Padding(
          padding: EdgeInsets.all(SizeConfig.defaultSize * 1.4),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildTitleField(),
                SizedBox(height: SizeConfig.defaultSize * 1.4),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: defaultSize * 2),
                  child: Text("Choose Color",
                      style: TextStyle(fontSize: defaultSize * 2)),
                ),
                SizedBox(height: SizeConfig.defaultSize * 1.4),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: defaultSize * 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedColor = Color(0xff6074F9);
                          });
                        },
                        child: Container(
                            width: defaultSize * 5,
                            height: defaultSize * 5,
                            decoration: BoxDecoration(
                                color: Color(0xff6074F9),
                                borderRadius: BorderRadius.circular(5),
                                border: (_selectedColor == Color(0xff6074F9))
                                    ? Border.all(color: kPrimaryColor, width: 3)
                                    : null)),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedColor = Color(0xffE42B6A);
                          });
                        },
                        child: Container(
                            width: defaultSize * 5,
                            height: defaultSize * 5,
                            decoration: BoxDecoration(
                                color: Color(0xffE42B6A),
                                borderRadius: BorderRadius.circular(5),
                                border: (_selectedColor == Color(0xffE42B6A))
                                    ? Border.all(color: kPrimaryColor, width: 3)
                                    : null)),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedColor = Color(0xff5ABB56);
                          });
                        },
                        child: Container(
                            width: defaultSize * 5,
                            height: defaultSize * 5,
                            decoration: BoxDecoration(
                                color: Color(0xff5ABB56),
                                borderRadius: BorderRadius.circular(5),
                                border: (_selectedColor == Color(0xff5ABB56))
                                    ? Border.all(color: kPrimaryColor, width: 3)
                                    : null)),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedColor = Color(0xff3D3A62);
                          });
                        },
                        child: Container(
                            width: defaultSize * 5,
                            height: defaultSize * 5,
                            decoration: BoxDecoration(
                                color: Color(0xff3D3A62),
                                borderRadius: BorderRadius.circular(5),
                                border: (_selectedColor == Color(0xff3D3A62))
                                    ? Border.all(color: kPrimaryColor, width: 3)
                                    : null)),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedColor = Color(0xffF4CA8F);
                          });
                        },
                        child: Container(
                            width: defaultSize * 5,
                            height: defaultSize * 5,
                            decoration: BoxDecoration(
                                color: Color(0xffF4CA8F),
                                borderRadius: BorderRadius.circular(5),
                                border: (_selectedColor == Color(0xffF4CA8F))
                                    ? Border.all(color: kPrimaryColor, width: 3)
                                    : null)),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: SizeConfig.defaultSize * 1.4),
                FlatButton(
                  child: Container(
                    width: SizeConfig.screenWidth,
                    decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.circular(4)),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: defaultSize * 1.4),
                      child: Text(
                        "Add Task",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: defaultSize * 2, color: Colors.white),
                      ),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      TaskCategory category = TaskCategory(
                          color: _selectedColor.value, title: categoryName);
                      DBProvider.db.insertCategory(category);
                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            )),
          ),
        ));
  }

  Widget buildTitleField() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize * 1.2),
      child: TextFormField(
        keyboardType: TextInputType.name,
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: SizeConfig.defaultSize * 2),
        decoration: InputDecoration(
          hintText: "Category Title",
          contentPadding: EdgeInsets.symmetric(
              horizontal: SizeConfig.defaultSize * 1.2,
              vertical: SizeConfig.defaultSize * 2),
        ),
        validator: (value) {
          return (value.trim().isEmpty) ? "Title is empty" : null;
        },
        onSaved: (value) {
          categoryName = value;
        },
      ),
    );
  }
}
