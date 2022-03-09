import 'package:flutter/material.dart';

class AddPostPage extends StatelessWidget {
  final int passedParam;
  AddPostPage({required this.passedParam});
  @override
  Widget build(BuildContext context) {
    final _controller = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Post Page"),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
              onPressed: () {
                popBack(context, _controller.text);
              },
              icon: Icon(Icons.check))
        ],
        leading: IconButton(
            onPressed: () {
              popBack(context, _controller.text);
            },
            icon: Icon(Icons.arrow_back_ios)),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: TextField(
            controller: _controller,
          ),
        ),
      ),
    );
  }

  void popBack(BuildContext context, String text) {
    Navigator.pop(context, text);
  }
}
