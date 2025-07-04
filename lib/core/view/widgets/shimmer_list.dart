// import '../../../export.dart';

// class ShimmerList extends StatelessWidget {
//   const ShimmerList({
//     super.key,
//     this.count = 6,
//     this.child,
//     this.listChild,
//     this.childHeight = 80,
//   });

//   final int? count;
//   final Widget? child;
//   final double? childHeight;
//   final Widget? listChild;

//   @override
//   Widget build(BuildContext context) {
//     return child ??
//         ListView.builder(
//           itemCount: count,
//           itemBuilder: (context, index) {
//             return VxShimmer(
//                 child: listChild ?? ShimmerChild(height: childHeight));
//           },
//         );
//   }
// }

// class ShimmerChild extends StatelessWidget {
//   const ShimmerChild({
//     super.key,
//     this.height = 80,
//     this.width,
//   });

//   final double? height;
//   final double? width;

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 1.0,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: SizedBox(height: height, width: width),
//     );
//   }
// }

// class RoundedShimmerChild extends StatelessWidget {
//   const RoundedShimmerChild({
//     super.key,
//     this.radius = 20,
//   });

//   final double? radius;

//   @override
//   Widget build(BuildContext context) {
//     return VxShimmer(child: VxCircle(radius: radius));
//   }
// }
