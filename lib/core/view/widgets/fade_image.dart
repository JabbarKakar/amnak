import 'package:cached_network_image/cached_network_image.dart';

import '../../../export.dart';

class FadeImage extends StatelessWidget {
  const FadeImage({
    super.key,
    this.errorImagePath,
    this.imageUrl = '',
    this.fit,
    this.height,
    this.width,
  });

  final String? errorImagePath;
  final String? imageUrl;
  final BoxFit? fit;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return (imageUrl!.isEmpty)
        ? Container(
            height: 50,
            color: Colors.grey[400],
          )
        : CachedNetworkImage(
            imageUrl: imageUrl ?? '',
            height: height,
            width: width,
            placeholder: (context, img) => FittedBox(
                  child: Image.asset('assets/images/loading.gif'),
                ),
            fit: fit ?? BoxFit.cover,
            errorWidget: (context, url, error) {
              return Container(
                height: height,
                width: width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image:
                        AssetImage(errorImagePath ?? "assets/images/logo.png"),
                    fit: fit ?? BoxFit.cover,
                  ),
                ),
              );
            });
  }
}
