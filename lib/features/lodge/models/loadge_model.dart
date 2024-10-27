// lib/models/lodge_model.dart
class Lodge {
  final String title;
  final String description;
  final String logo;

  Lodge({required this.title, required this.description, required this.logo});

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'logo': logo,
    };
  }
}

class Contact {
  final String telefono;
  final String website;
  final String correo;
  final String ubicacion;

  Contact(
      {required this.telefono,
      required this.website,
      required this.correo,
      required this.ubicacion});

  Map<String, dynamic> toJson(int? id) {
    return {
      'lodge_id': id,
      'phone': telefono,
      'page': website,
      'email': correo,
      'place': ubicacion,
    };
  }
}

class Service {
  final String name;

  Service({required this.name});

  Map<String, dynamic> toJson(int? id) {
    return {
      'lodge_id': id,
      'name': name,
    };
  }
}

class GalleryImage {
  final String url;
  final String footer;

  GalleryImage({required this.url, required this.footer});

  Map<String, dynamic> toJson(int? id) {
    return {
      'lodge_id': id,
      'url': url,
      'footer': footer,
    };
  }
}

class Information {
  final String info;

  Information({required this.info});

  Map<String, dynamic> toJson(int? id) {
    return {
      'lodge_id': id,
      'name': info,
    };
  }
}
