// import 'package:anime_app/app/core/common/services/image_cache_service.dart';
// import 'package:anime_app/app/ui/components/shimed_box.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';

// class ImageCached extends StatefulWidget {
//   const ImageCached({super.key, required this.url, this.fit, this.radius});

//   final String url;
//   final BoxFit? fit;
//   final double? radius;

//   @override
//   State<ImageCached> createState() => _ImageCachedState();
// }

// class _ImageCachedState extends State<ImageCached> {
//   bool loading = true;
//   bool error = false;

//   Uint8List? bytes;
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) async {
//       var bytes = await ImageCacheService().getImage(widget.url);
//       if (bytes != null) {
//         this.bytes = bytes;
//       } else {
//         error = true;
//       }
//       loading = false;
//       if (mounted) setState(() {});
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (loading) {
//       return const ShimmedBox();
//     }
//     if (error || bytes == null) {
//       return const SizedBox(
//         width: 100,
//         height: 100,
//         child: Center(
//           child: Icon(Icons.error),
//         ),
//       );
//     }
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(widget.radius ?? 0),
//       child: Image.memory(
//         bytes!,
//         fit: widget.fit ?? BoxFit.cover,
//       ),
//     );
//   }
// }

import 'package:anime_app_tv/app/core/common/services/image_cache_service.dart';
import 'package:anime_app_tv/app/ui/components/shimed_box.dart';
import 'package:flutter/material.dart';

class ImageCached extends StatefulWidget {
  const ImageCached({super.key, required this.url, this.fit, this.radius});

  final String url;
  final BoxFit? fit;
  final double? radius;

  @override
  State<ImageCached> createState() => _ImageCachedState();
}

class _ImageCachedState extends State<ImageCached> {
  ImageCachedResponse? resp;

  @override
  void initState() {
    ImageCacheService().getR(widget.url).then(
      (value) {
        resp = value;
        if (mounted) setState(() {});
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        if (resp != null) {
          if (resp!.type == ImageResponseType.bytes) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(widget.radius ?? 0),
              child: Image.memory(
                resp!.bytes!,
                fit: widget.fit ?? BoxFit.cover,
              ),
            );
          }
          return ClipRRect(
            borderRadius: BorderRadius.circular(widget.radius ?? 0),
            child: Image.network(
              resp!.url!,
              fit: widget.fit ?? BoxFit.cover,
            ),
          );
        }
        return const ShimmedBox();
      },
    );
  }
}
