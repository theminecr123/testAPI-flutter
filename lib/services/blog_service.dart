import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/blog.dart';

class BlogService {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';

  // Fetch list of blogs
  Future<List<Blog>> fetchBlogs() async {
    final response = await http.get(Uri.parse('$baseUrl/posts'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((blog) => Blog.fromJson(blog)).toList();
    } else {
      throw Exception('Failed to load blogs');
    }
  }

  // Fetch blog details by id
  Future<Blog> fetchBlogDetail(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/posts/$id'));

    if (response.statusCode == 200) {
      return Blog.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load blog details');
    }
  }
}
