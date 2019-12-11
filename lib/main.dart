import 'package:flutter/material.dart';
import 'package:proper_error_handling_tutorial/post_change_notifier.dart';
import 'package:provider/provider.dart';

import 'post_service.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: ChangeNotifierProvider(
        create: (_) => PostChangeNotifier(),
        child: Home(),
      ),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Error Handling'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Consumer<PostChangeNotifier>(
              builder: (_, notifier, __) {
                if (notifier.state == NotifierState.initial) {
                  return StyledText('Press the button 👇');
                } else if (notifier.state == NotifierState.loading) {
                  return CircularProgressIndicator();
                } else {
                  if (notifier.failure != null) {
                    return StyledText(notifier.failure.toString());
                  } else {
                    return StyledText(notifier.post.toString());
                  }
                }
              },
            ),
            RaisedButton(
              child: Text('Get Post'),
              onPressed: () async {
                Provider.of<PostChangeNotifier>(context).getOnePost();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class StyledText extends StatelessWidget {
  const StyledText(
    this.text, {
    Key key,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 40),
    );
  }
}
