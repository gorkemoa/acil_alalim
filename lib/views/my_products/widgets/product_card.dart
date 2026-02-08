import 'package:flutter/material.dart';
import '../../../models/product_model.dart';
import '../../../core/responsive/size_tokens.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.only(bottom: SizeTokens.k16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(SizeTokens.r12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: EdgeInsets.all(SizeTokens.k12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            ClipRRect(
              borderRadius: BorderRadius.circular(SizeTokens.r8),
              child:
                  product.mainImageUrl != null &&
                      product.mainImageUrl!.isNotEmpty
                  ? Image.network(
                      product.mainImageUrl!,
                      width: SizeTokens.k48 * 1.5,
                      height: SizeTokens.k48 * 1.5,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          _buildPlaceholder(),
                    )
                  : _buildPlaceholder(),
            ),
            SizedBox(width: SizeTokens.k12),
            // Product Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          product.title,
                          style: TextStyle(
                            fontSize: SizeTokens.fontL,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (product.status != null)
                        _buildStatusBadge(product.status!),
                    ],
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
                  SizedBox(height: SizeTokens.k8),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: SizeTokens.iconSmall,
                        color: Colors.grey,
                      ),
                      SizedBox(width: SizeTokens.k4),
                      Text(
                        '${product.provinceName ?? ''}, ${product.districtName ?? ''}',
                        style: TextStyle(
                          fontSize: SizeTokens.fontS,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: SizeTokens.k8),
                  Wrap(
                    spacing: SizeTokens.k8,
                    children: [
                      if (product.categoryName != null)
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: SizeTokens.k8,
                            vertical: SizeTokens.k4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(SizeTokens.r4),
                          ),
                          child: Text(
                            product.categoryName!,
                            style: TextStyle(
                              fontSize: SizeTokens.fontXS,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
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
                            color: Colors.amber.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(SizeTokens.r4),
                          ),
                          child: Text(
                            'Sponsorlu',
                            style: TextStyle(
                              fontSize: SizeTokens.fontXS,
                              color: Colors.amber[800],
                              fontWeight: FontWeight.bold,
                            ),
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

  Widget _buildStatusBadge(String status) {
    Color color;
    String label;

    switch (status.toLowerCase()) {
      case 'active':
        color = Colors.green;
        label = 'Aktif';
        break;
      case 'pending':
        color = Colors.orange;
        label = 'Beklemede';
        break;
      default:
        color = Colors.grey;
        label = status;
    }

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: SizeTokens.k8,
        vertical: SizeTokens.k4,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(SizeTokens.r4),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: SizeTokens.fontXS,
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      width: SizeTokens.k48 * 1.5,
      height: SizeTokens.k48 * 1.5,
      color: Colors.grey[100],
      child: Icon(Icons.image_outlined, color: Colors.grey[400]),
    );
  }
}

// Fixed missing k6 constant access if it doesn't exist. 
// I'll check SizeTokens again. It doesn't have k6, k2. 
// I will use k8 and k4 instead for standard.
