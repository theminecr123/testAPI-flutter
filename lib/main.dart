import 'package:flutter/material.dart';
import 'models/blog.dart';
import 'services/blog_service.dart';
import 'detail.dart';

void main() {
  runApp(BlogApp());
}

class BlogApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:false,
      title: 'Blog App',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        fontFamily: 'RobotoMono',
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BlogListPage(),
    );
  }
}

class BlogListPage extends StatefulWidget {
  @override
  _BlogListPageState createState() => _BlogListPageState();
}

class _BlogListPageState extends State<BlogListPage> {
  late Future<List<Blog>> futureBlogs;
  final BlogService _blogService = BlogService();

  @override
  void initState() {
    super.initState();
    futureBlogs = _blogService.fetchBlogs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blogs', style: TextStyle(fontSize: 24)),
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: FutureBuilder<List<Blog>>(
        future: futureBlogs,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Blog>? blogs = snapshot.data;
            return ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: blogs?.length,
              itemBuilder: (context, index) {
                return _buildBlogCard(context, blogs![index]);
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  // Create a decorated card for each blog item
  Widget _buildBlogCard(BuildContext context, Blog blog) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 10),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BlogDetailPage(blogId: blog.id),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  'https://media.licdn.com/dms/image/v2/D5612AQEpl4qDNXaGMA/article-cover_image-shrink_720_1280/article-cover_image-shrink_720_1280/0/1694436469209?e=2147483647&v=beta&t=jWyI7-W-bhwxJeCy6J7yvl-QD15K4XwR1S1OG9S_LAQ',
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 10),
              Text(
                blog.title,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                blog.body,
                style: TextStyle(color: Colors.black.withOpacity(0.6)),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
