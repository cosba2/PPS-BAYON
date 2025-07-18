// import 'package:flutter/material.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('BLOG APP'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             // Botón para la sección de Usuarios
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.pushNamed(context, '/users');
//               },
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 16.0),
//                 child: Text(
//                   'Usuarios',
//                   style: TextStyle(fontSize: 18),
//                 ),
//               ),
//             ),
//             SizedBox(height: 20),

//             // Botón para la sección de Posts (nuevo)
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.pushNamed(context, '/posts');
//               },
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 16.0),
//                 child: Text(
//                   'Posts',
//                   style: TextStyle(fontSize: 18),
//                 ),
//               ),
//             ),
//             SizedBox(height: 20),

//             // Botón para la sección de Comentarios
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.pushNamed(context, '/comments');
//               },
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 16.0),
//                 child: Text(
//                   'Comentarios',
//                   style: TextStyle(fontSize: 18),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String message = 'Cargando...';

  @override
  void initState() {
    super.initState();
    testRequest();
  }

  Future<void> testRequest() async {
    final url = Uri.parse("https://pps-bayon.onrender.com/api/users");

    final headers = {
      'Content-Type': 'application/json',
      'X-API-KEY': 'marcospps',
    };

    try {
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        print("✅ Data: ${response.body}");
        setState(() {
          message = '✅ Conectado correctamente';
        });
      } else {
        print("❌ Error ${response.statusCode}: ${response.body}");
        setState(() {
          message = '❌ Error ${response.statusCode}: ${response.body}';
        });
      }
    } catch (e) {
      print("🚨 Excepción: $e");
      setState(() {
        message = '🚨 Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
