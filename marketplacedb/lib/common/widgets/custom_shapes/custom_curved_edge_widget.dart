import 'package:flutter/material.dart';
import 'package:marketplacedb/common/widgets/custom_shapes/custom_curved_edges.dart';

class CurvedEdgeWidget extends StatelessWidget {
  const CurvedEdgeWidget({
    super.key,
    required this.child,
  });

  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return ClipPath(clipper: CustomCurvedEdges(), child: child);
  }
}
