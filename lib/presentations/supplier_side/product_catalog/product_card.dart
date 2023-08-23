import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_daktari/constants/colors.dart';
import 'package:my_daktari/models/product.dart';
import '../../../../constants/route.dart' as route;

class SupplierProductCard extends StatelessWidget {
  const SupplierProductCard({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => Navigator.of(context)
          .pushNamed(route.productScreen, arguments: product),
      child: Card(
        color: Colors.white,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          height: 120,
          width: size.width * .5,
          child: Row(
            children: <Widget>[
              Container(
                width: size.width * .2,
                height: 100,
                clipBehavior: Clip.antiAlias,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(5)),
                child: CachedNetworkImage(
                    placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(strokeWidth: 1)),
                    errorWidget: (context, url, error) => const Icon(
                        Icons.error_outline,
                        size: 54,
                        color: Colors.red),
                    imageUrl: product.productsImages!.first.toString(),
                    fit: BoxFit.cover),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 8.0, bottom: 8.0, right: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(product.productName.toString(),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      Text('View Details',
                          style: TextStyle(color: AppColor.primaryColor))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
