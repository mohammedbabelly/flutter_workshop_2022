import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:workshop22/Pages/add_post.dart';
import 'package:workshop22/models/post.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Stream<QuerySnapshot> collectionStream =
      FirebaseFirestore.instance.collection('posts').snapshots();

  final CollectionReference postsCollection =
      FirebaseFirestore.instance.collection('posts');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("App"),
          actions: [
            IconButton(
                onPressed: () async {
                  var text = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddPostPage(
                                passedParam: 1,
                              )));
                  addPost(Post(text: text, interactions: 0));
                },
                icon: Icon(Icons.add))
          ],
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: collectionStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading");
            }

            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                var post = Post.fromJson(data);
                post.id = document.id;
                return ListTile(
                  title: Text(post.text),
                  subtitle: Text(post.interactions.toString()),
                  trailing: IconButton(
                    icon: Icon(Icons.arrow_circle_up_rounded),
                    onPressed: () async {
                      await updatePost(post);
                    },
                  ),
                );
              }).toList(),
            );
          },
        ));
  }

  Future<void> addPost(Post post) {
    // Call the user's CollectionReference to add a new post
    return postsCollection
        .add(post.toJson())
        .then((value) => print("Post Added"))
        .catchError((error) => print("Failed to add post: $error"));
  }

  Future<void> updatePost(Post post) {
    post.interactions++;
    return postsCollection
        .doc(post.id)
        .update(post.toJson())
        .then((value) => print("Post Updated"))
        .catchError((error) => print("Failed to update post: $error"));
  }
}
