import 'package:flutter/material.dart';

import 'post_service.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final postService = PostService();
  Future<Post> postFuture;

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
            FutureBuilder<Post>(
              future: postFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  final error = snapshot.error;
                  return StyledText(error.toString());
                } else if (snapshot.hasData) {
                  final post = snapshot.data;
                  return StyledText(post.toString());
                } else {
                  return StyledText('Press the button 👇');
                }
              },
            ),
            RaisedButton(
              child: Text('Get Post'),
              onPressed: () async {
                setState(() {
                  postFuture = postService.getOnePost();
                });
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
