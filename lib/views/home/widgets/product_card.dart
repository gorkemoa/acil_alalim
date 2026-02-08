import 'package:flutter/material.dart';
import 'package:acil_alalim/models/product_model.dart';
import 'package:acil_alalim/core/responsive/size_config.dart';
import 'package:acil_alalim/core/responsive/size_tokens.dart';
import 'package:acil_alalim/core/utils/image_util.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  final VoidCallback? onTap;

  const ProductCard({super.key, required this.product, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: SizeTokens.k12),
      clipBehavior: Clip.antiAlias,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(SizeTokens.r12),
      ),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (product.mainImageUrl != null)
              Image.network(
                product.mainImageUrl!,
                height: SizeConfig.getProportionateScreenHeight(180),
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    _buildPlaceholder(),
              )
            else
              _buildPlaceholder(),
            Padding(
              padding: EdgeInsets.all(SizeTokens.k12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: SizeConfig.getProportionateScreenWidth(16),
                        backgroundImage: ImageUtil.getImageProvider(
                          product.userAvatarUrl,
                        ),
                        child: product.userAvatarUrl == null
                            ? Text(
                                product.userName?[0].toUpperCase() ?? '?',
                                style: TextStyle(fontSize: SizeTokens.fontS),
                              )
                            : null,
                      ),
                      SizedBox(width: SizeTokens.k8),
                      Expanded(
                        child: Text(
                          product.userName ?? 'Anonim',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: SizeTokens.fontM,
                          ),
                        ),
                      ),
                      if (product.isSponsor == 1)
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: SizeTokens.k8,
                            vertical: SizeTokens.k4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.amber.shade100,
                            borderRadius: BorderRadius.circular(SizeTokens.r8),
                          ),
                          child: Text(
                            'Sponsorlu',
                            style: TextStyle(
                              fontSize: SizeTokens.fontXS,
                              color: Colors.amber.shade900,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: SizeTokens.k8),
                  Text(
                    product.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: SizeTokens.fontL,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: SizeTokens.k4),
                  Text(
                    product.description,
                    style: TextStyle(
                      fontSize: SizeTokens.fontM,
                      color: Colors.grey[600],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: SizeTokens.k12),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: SizeTokens.iconSmall,
                        color: Colors.blue,
                      ),
                      SizedBox(width: SizeTokens.k4),
                      Text(
                        '${product.provinceName ?? ''} / ${product.districtName ?? ''}',
                        style: TextStyle(
                          fontSize: SizeTokens.fontS,
                          color: Colors.blue,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        product.createdAt?.split(' ')[0] ?? '',
                        style: TextStyle(
                          fontSize: SizeTokens.fontXS,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      height: SizeConfig.getProportionateScreenHeight(180),
      width: double.infinity,
      color: Colors.grey[200],
      child: Icon(
        Icons.image_outlined,
        size: SizeTokens.iconLarge,
        color: Colors.grey[400],
      ),
    );
  }
}
