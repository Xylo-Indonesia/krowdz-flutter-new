import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:transparent_image/transparent_image.dart';

class Profile extends StatelessWidget {
  final String? client, name;
  final image, isLoading;

  const Profile({Key? key, this.client, this.name, this.image, this.isLoading}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.transparent),
            child: image == null
                ? Image(
                    image: AssetImage('assets/images/wuling.png'),
                  )
                : FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: image,
                    fit: BoxFit.contain,
                    width: double.infinity,
                  ),
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              isLoading
                  ? Padding(
                      padding: const EdgeInsets.only(bottom: 4.0),
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey[850]!,
                        highlightColor: Colors.grey[800]!,
                        child: Container(
                          width: 80,
                          height: 12,
                          color: Colors.grey[800],
                        ),
                      ),
                    )
                  : Text(
                      client!,
                      style: TextStyle(color: Colors.white),
                    ),
              isLoading
                  ? Shimmer.fromColors(
                      baseColor: Colors.grey[850]!,
                      highlightColor: Colors.grey[800]!,
                      child: Container(
                        width: 80,
                        height: 16,
                        color: Colors.grey[800],
                      ),
                    )
                  : Text(
                      name!,
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20, height: 1.1),
                    ),
            ],
          )
        ],
      ),
    );
  }
}
