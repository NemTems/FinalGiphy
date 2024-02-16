class ImageBase{
  final String? url;
  final String? width;
  final String? height;

  ImageBase({
    required this.url,
    required this.width,
    required this.height
  });

  factory ImageBase.fromJson(Map<String, dynamic> json) => ImageBase(
    url: json['url'] as String?,
    width: json['width'] as String?,
    height: json['height'] as String?,
  );
}


class GifsImages{
  final ImageBase smallImage;
  final ImageBase detailedImage;
  
  GifsImages({
    required this.smallImage,
    required this.detailedImage,
  });

  factory GifsImages.fromJson(Map<String,dynamic> json) => GifsImages(
    smallImage: ImageBase.fromJson(json['preview_gif'] as Map<String, dynamic>),
    detailedImage: ImageBase.fromJson(json['original'] as Map<String, dynamic>)
  );
}