import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/image_model.dart';

class ImageRepository {
  final String apiUrl = 'https://muniupala.go.cr/turismo/api/images.php';

  Future<List<ImageModel>> fetchImages() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body)['data'];
      return data.map((json) => ImageModel.fromJson(json)).toList();
    } else {
      throw Exception('Error al cargar las imágenes');
    }
  }

  // Subir una imagen y obtener el enlace
  Future<String> uploadImage(String imagePath, String footer) async {
    var request = http.MultipartRequest('POST', Uri.parse(apiUrl));

    request.files.add(await http.MultipartFile.fromPath('image', imagePath));
    request.fields['footer'] = footer;

    var response = await request.send();
    final responseBody = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      final jsonData = json.decode(responseBody.body);
      return jsonData['url'];
    } else {
      throw Exception('Error al subir la imagen');
    }
  }
}
