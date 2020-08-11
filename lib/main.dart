import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TODO APP',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'TODO APP'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _todoList = [];
  String _text = '';

  final TextEditingController _controller = new TextEditingController();

  void appendTodo(String title) {
    setState(() {
      _todoList.add(title);
      _controller.clear();
    });
  }

  void _handleText(String e) {
    setState(() {
      _text = e;
    });
  }

  void deleteTodo(int index) {
    setState(() {
      _todoList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: Stack(
          children: [
            ListView.builder(
              padding: EdgeInsets.only(bottom: 100.0),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_todoList[index].toString()),
                  onTap: () {
                    deleteTodo(index);
                  },
                );
              },
              itemCount: _todoList.length,
            ),
            Positioned(
                left: 0.0,
                right: 0.0,
                bottom: 0.0,
                child: Card(
                  child: Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 100.0, left: 15.0),
                        child: new TextField(
                          controller: _controller,
                          autofocus: true,
                          decoration: const InputDecoration(labelText: 'TODOタイトル'),
                          enabled: true,
                          maxLength: 100,
                          maxLengthEnforced: false,
                          style: TextStyle(color: Colors.black),
                          obscureText: false,
                          maxLines: 1,
                          onChanged: _handleText,
                        ),
                      ),
                      Positioned(
                        right: 0,
                        top: 0,
                        bottom: 0,
                        child: MaterialButton(
                          child: Text('追加'),
                          color: Colors.greenAccent,
                          onPressed: () {
                            appendTodo(_text);
                          },
                        ),
                      )

                    ],
                  ),
                )
            ),
          ],
        ));
  }
}
