import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatelessWidget {
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = MediaQuery.of(context).size.width;
    double gro = 55000;
    double shop = 30000;
    double recharge = 35000;
    double mobile = 50000;

    double total = gro + shop + recharge + mobile ;

    return Scaffold(
      body: Container(
        height: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.green, spreadRadius: 3),
          ],
        ),
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Text('Overall Spend',style: TextStyle(fontSize: 15.0),),
              ],
            ),
            Row(
              children: [
                Text('${total}',style: TextStyle(fontSize: 40.0),),
              ],
            ),
            Divider(
              color: Colors.black26,
            ),
            Row(
              children: [
                MyAssetsBar(
                  width: width * .99,
                  background: colorFromHex("CFD8DC"),
                  //height: 50,
                  radius: 10,
                  assetsLimit: 100,
                  //order: OrderType.Descending,
                  assets: [
                    MyAsset(size: gro/total*100, color: colorFromHex("#BE52F2")),
                    MyAsset(size: shop/total*100, color: colorFromHex("#6979F8")),
                    MyAsset(size: recharge/total*100, color: colorFromHex("##8C3232")),
                    MyAsset(size: mobile/total*100, color: colorFromHex("##27AE60")),

                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text('|',style: TextStyle(fontSize: 40.0,color: colorFromHex("BE52F2"), fontWeight: FontWeight.bold),),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Grocery Bundle: Gold',style: TextStyle(fontSize: 18),),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      child: Row(
                        children: <Widget>[
                          Text(
                            '$gro', style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text('|',style: TextStyle(fontSize: 40.0,color: colorFromHex("6979F8"), fontWeight: FontWeight.bold),),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Grocery Bundle: Silver',style: TextStyle(fontSize: 18),),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      child: Row(
                        children: <Widget>[
                          Text(
                            '$shop', style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

              ],
            ),
            Divider(
              color: Colors.black26,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Text('|',style: TextStyle(fontSize: 40.0,color: colorFromHex("#8C3232"), fontWeight: FontWeight.bold),),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Grocery Bundle: Bronze',style: TextStyle(fontSize: 18),),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      child: Row(
                        children: <Widget>[
                          Text(
                            '$recharge', style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text('|',style: TextStyle(fontSize: 40.0,color: colorFromHex("#27AE60"), fontWeight: FontWeight.bold),),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Grocery Card',style: TextStyle(fontSize: 18),),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      child: Row(
                        children: <Widget>[
                          Text(
                            '$mobile', style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Divider(
              color: Colors.black26,
            ),
          ],
        ),
      ),
    );
  }
}

/*Utils*/
Color colorFromHex(String hexColor) {
  final hexCode = hexColor.replaceAll('#', '');
  return Color(int.parse('FF$hexCode', radix: 16));
}

const double _kHeight = 30;
enum OrderType { Ascending, Descending, None }
/*Utils*/

class MyAsset {
  final double size;
  final Color color;

  MyAsset({this.size, this.color});
}

class MyAssetsBar extends StatelessWidget {
  MyAssetsBar(
      {Key key,
        @required this.width,
        this.height = _kHeight,
        this.radius,
        this.assets,
        this.assetsLimit,
        this.order,
        this.background = Colors.grey})
      : assert(width != null),
        assert(assets != null),
        super(key: key);

  final double width;
  final double height;
  final double radius;
  final List<MyAsset> assets;
  final double assetsLimit;
  final OrderType order;
  final Color background;

  double _getValuesSum() {
    double sum = 0;
    assets.forEach((single) => sum += single.size);
    return sum;
  }

  void orderMyAssetsList() {
    switch (order) {
      case OrderType.Ascending:
        {
          //From the smallest to the largest
          assets.sort((a, b) {
            return a.size.compareTo(b.size);
          });
          break;
        }
      case OrderType.Descending:
        {
          //From largest to smallest
          assets.sort((a, b) {
            return b.size.compareTo(a.size);
          });
          break;
        }
      case OrderType.None:
      default:
        {
          break;
        }
    }
  }

  //single.size : assetsSum = x : width
  Widget _createSingle(MyAsset singleAsset) {
    return SizedBox(
      width: (singleAsset.size * width) / (assetsLimit ?? _getValuesSum()),
      child: Container(color: singleAsset.color),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (assetsLimit != null && assetsLimit < _getValuesSum()) {
      print("assetsSum < _getValuesSum() - Check your values!");
      return Container();
    }

    //Order assetsList
    orderMyAssetsList();

    final double rad = radius ?? (height / 2);

    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(rad)),
      child: Container(
        decoration: new BoxDecoration(
          color: background,
        ),
        width: width,
        height: height,
        child: Row(
            children: assets
                .map((singleAsset) => _createSingle(singleAsset))
                .toList()),
      ),
    );
  }
}
