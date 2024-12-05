import 'dart:convert';
import 'dart:io';

class DataFetcher {
  final String apiUrl;

  DataFetcher({required this.apiUrl});

  Future<List<dynamic>> fetchData() async {
    HttpClient client = HttpClient();
    client.autoUncompress = true;

    try {
      final HttpClientRequest request = await client.getUrl(Uri.parse(apiUrl));
      request.headers.set(HttpHeaders.contentTypeHeader, "application/json; charset=UTF-8");
      final HttpClientResponse response = await request.close();

      if (response.statusCode == 200) {
        final String content = await response.transform(utf8.decoder).join();
        final List data = json.decode(content);
        return data;
      } else {
        throw HttpException('Failed to fetch data, status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error while fetching data: $e');
    } finally {
      client.close();
    }
  }
}