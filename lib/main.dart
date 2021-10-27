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
        centerTitle: true,
        title: const Text(
          "PixaBay",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                  suffixIcon: IconButton(
                      onPressed: () {
                        if (_controller.text.isNotEmpty) {
                          context
                              .read<PostProvider>()
                              .getPostList(_controller.text);
                          _controller.clear();
                        }
                      },
                      icon: const Icon(Icons.search))),
              controller: _controller,
            ),
          ),
          const Text("Create By sunmkim"),
          const SizedBox(
            height: 16,
          ),
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : Expanded(
                  child: GridView(
                    padding: const EdgeInsets.all(16.0),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16),
                    children: posts
                        .map((post) => Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(post.previewURL)),
                                borderRadius:
                                   const BorderRadius.all(Radius.circular(16.0)),
                              ),
                              height: 100.0,
                            ))
                        .toList(),
                  ),
                )
        ],
      ),
    );
  }
}
