// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:palette_generator/palette_generator.dart';
//
// class DynamicColorExample extends StatefulWidget {
//   DynamicColorExample({Key? key}) : super(key: key);
//
//   @override
//   State<DynamicColorExample> createState() => _DynamicColorExampleState();
// }
//
// class _DynamicColorExampleState extends State<DynamicColorExample> {
//   late ColorScheme currentColorScheme;
//   late int selectedImage;
//   late bool isLoading;
//   final List<NetworkImage> images = <NetworkImage>[
//     const NetworkImage(
//         'https://flutter.github.io/assets-for-api-docs/assets/material/content_based_color_scheme_1.png'),
//     const NetworkImage(
//         'https://static.vecteezy.com/system/resources/thumbnails/027/257/268/small_2x/new-year-number-2024-gold-3d-png.png'),
//     const NetworkImage(
//         'https://flutter.github.io/assets-for-api-docs/assets/material/content_based_color_scheme_3.png'),
//     const NetworkImage(
//         'https://flutter.github.io/assets-for-api-docs/assets/material/content_based_color_scheme_4.png'),
//     const NetworkImage(
//         'https://flutter.github.io/assets-for-api-docs/assets/material/content_based_color_scheme_5.png'),
//     const NetworkImage(
//         'https://flutter.github.io/assets-for-api-docs/assets/material/content_based_color_scheme_6.png'),
//   ];
//
//   List<Color> imageColors = []; // Store the extracted colors for each image
//
//   @override
//   void initState() {
//     super.initState();
//     selectedImage = 0;
//     isLoading = false;
//     currentColorScheme = const ColorScheme.dark();
//     _loadImageColors();
//   }
//
//   Future<void> _loadImageColors() async {
//     List<Color> colors = [];
//     for (NetworkImage image in images) {
//       final PaletteGenerator paletteGenerator =
//           await PaletteGenerator.fromImageProvider(
//         image,
//         size: Size(200, 100), // Adjust size as needed
//       );
//       colors.add(paletteGenerator.dominantColor!.color);
//     }
//     setState(() {
//       imageColors = colors;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final ColorScheme colorScheme = currentColorScheme;
//
//     return MaterialApp(
//       theme: ThemeData(useMaterial3: true, colorScheme: colorScheme),
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Content Based Dynamic Color'),
//           backgroundColor: colorScheme.primary,
//           foregroundColor: colorScheme.onPrimary,
//         ),
//         body: Center(
//           child: isLoading
//               ? const CircularProgressIndicator()
//               : ListView.builder(
//                   itemCount: images.length,
//                   itemBuilder: (context, index) {
//                     return Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Row(
//                         children: [
//                           Container(
//                             height: 100,
//                             width: 100,
//                             color: imageColors.isNotEmpty
//                                 ? imageColors[index]
//                                 : Colors.red, // Use extracted color
//                           ),
//                           Container(
//                             height: 100,
//                             width: 200,
//                             color: colorScheme.background,
//                             child: Image(
//                               height: 100,
//                               width: 200,
//                               fit: BoxFit.contain,
//                               image: images[index],
//                             ),
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                 ),
//         ),
//       ),
//     );
//   }
// }
