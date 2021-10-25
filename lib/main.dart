import 'package:flutter/material.dart';
import 'package:mvvmapi/post.dart';
import 'package:mvvmapi/post_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider<PostProvider>(
          create: (_) => PostProvider(), child: const HomeScreen()),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Future.microtask(() => context.read<PostProvider>().getPostList("iphone"));
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<Post> posts = context.watch<PostProvider>().postList;
    bool isLoading = context.watch<PostProvider>().isLoading;
    return Scaffold(
      appBar: AppBar(
        title: Text("MVVM API"),
      ),
      body: Column(
        children: [
          TextField(
            controller: _controller,
          ),
          TextButton(
              onPressed: () {
                if (_controller.text.isNotEmpty) {
                  context.read<PostProvider>().getPostList(_controller.text);
                  _controller.clear();
                }
              },
              child: const Text("search")),
          isLoading
              ? const CircularProgressIndicator()
              : Expanded(
                  child: ListView(
                    children: posts
                        .map((post) => Container(
                              height: 50.0,
                              child: Text(post.tags),
                            ))
                        .toList(),
                  ),
                )
        ],
      ),
    );
  }
}
