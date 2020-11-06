import 'package:flutter/material.dart';
import 'package:my_app/src/api/api.dart';
import 'package:my_app/src/models/photos.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Api api = Api();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      // body: Center(
      //   child: CustomGradientButton(
      //     text: Text('Mexico'),
      //     width: 150,
      //     height: 40,
      //     gradientColors: [Colors.green, Colors.white, Colors.red],
      //     initialPosition: Alignment.centerLeft,
      //     finalPosition: Alignment.centerRight,
      //     function: ()=>print('Hello Colombia!'),
      //     leadingIcon: Icon(Icons.person),
      //     ),
      //     ),
      body: FutureBuilder<List<Photos>>(
        future: api.getPhotos(),
        builder: (BuildContext ctx, AsyncSnapshot<List<Photos>> snapshot) {
          return snapshot.hasData &&
                  snapshot.connectionState == ConnectionState.done
              ? ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext ctx, int index) {
                    return Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundImage:
                              NetworkImage(snapshot.data[index].thumbnailUrl),
                        ),
                        title: Text(snapshot.data[index].id.toString()),
                        subtitle: Text(
                            'Description of album ${snapshot.data[index].id}'),
                      ),
                    );
                  })
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget customContainer() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(16),
      child: Text('Platzi'.toUpperCase()),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.purple,
        border: Border.all(
          color: Colors.teal,
          width: 5,
        ),
      ),
      transform: Matrix4.rotationZ(.10),
      constraints: BoxConstraints(maxWidth: 200),
    );
  }
}

class CustomGradientButton extends StatelessWidget {
  final Text text;
  final double width;
  final double height;
  final List<Color> gradientColors;
  final Alignment initialPosition;
  final Alignment finalPosition;
  final Function function;
  final Icon leadingIcon;
  final Icon finalIcon;

  const CustomGradientButton(
      {Key key,
      @required this.text,
      @required this.width,
      @required this.height,
      @required this.gradientColors,
      @required this.initialPosition,
      @required this.finalPosition,
      @required this.function,
      this.leadingIcon,
      this.finalIcon})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: gradientColors,
                begin: initialPosition,
                end: finalPosition),
            boxShadow: [
              BoxShadow(
                  color: Colors.black,
                  offset: Offset(2, -2),
                  blurRadius: height * .1,
                  spreadRadius: 1)
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            leadingIcon ?? Container(),
            text,
            finalIcon ?? Offstage(),
          ],
        ),
      ),
    );
  }
}
