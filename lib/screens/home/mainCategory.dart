import 'package:botcontroller/models/option.dart';
import 'package:botcontroller/provider/optionsData.dart';
import 'package:botcontroller/widgets/skimmer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainCategory extends StatefulWidget {
  const MainCategory({
    @required this.mainBoxDecoration,
  });
  final BoxDecoration mainBoxDecoration;
  @override
  _MainCategoryState createState() => _MainCategoryState();
}

class _MainCategoryState extends State<MainCategory> {
  List<Options> mainCategoryOptionData;
  bool _isLoading = true;

  collectingData() {
    mainCategoryOptionData =
        Provider.of<OptionData>(context).filteringDatas('mainPage');
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void didChangeDependencies() {
    collectingData();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return _isLoading
        ? Skimmer(screenWidth: screenWidth)
        : Container(
            child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: mainCategoryOptionData.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 30,
                    mainAxisSpacing: 20),
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        gridIcon(index),
                        const SizedBox(height: 10),
                        gridTxt(index)
                      ],
                    ),
                    decoration: widget.mainBoxDecoration,
                  );
                }),
          );
  }

  Text gridTxt(int index) {
    return Text(
      mainCategoryOptionData[index].name.toString(),
      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
    );
  }

  Icon gridIcon(int index) {
    return Icon(
      mainCategoryOptionData[index].icon,
      color: Colors.white,
    );
  }
}
