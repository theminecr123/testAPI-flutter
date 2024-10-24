import 'package:flutter/material.dart';
import 'models/blog.dart';
import 'services/blog_service.dart';

class BlogDetailPage extends StatelessWidget {
  final int blogId;

  BlogDetailPage({required this.blogId});

  final BlogService _blogService = BlogService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blog Detail', style: TextStyle(fontSize: 24)),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: FutureBuilder<Blog>(
        future: _blogService.fetchBlogDetail(blogId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Blog? blog = snapshot.data;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Placeholder for blog detail image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        'https://media.licdn.com/dms/image/v2/D5612AQEpl4qDNXaGMA/article-cover_image-shrink_720_1280/article-cover_image-shrink_720_1280/0/1694436469209?e=2147483647&v=beta&t=jWyI7-W-bhwxJeCy6J7yvl-QD15K4XwR1S1OG9S_LAQ',
                        height: 250,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      blog!.title,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      blog.body,
                      style: TextStyle(
                        fontSize: 18,
                        height: 1.5,
                        color: Colors.black.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
