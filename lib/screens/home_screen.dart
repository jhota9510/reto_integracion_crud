import 'package:flutter/material.dart';
import 'package:servisnet/screens/register_contractor_screen.dart';

import 'contractor_list_screen.dart';
import 'register_user_screen.dart';
import 'user_list_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Widget customButton({
    required String text,
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: 145,
      height: 48,
      child: ElevatedButton.icon(
        icon: Icon(
          icon,
          color: Colors.white,
          size: 18,
        ),
        label: Flexible(
          child: Text(
            text,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          elevation: 5,
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              14,
            ),
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        title: const Text(
          "ServiNet",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 1,
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                /// ICONO
                Container(
                  padding: const EdgeInsets.all(
                    25,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(
                      0xffc6c6c8,
                    ),
                    borderRadius: BorderRadius.circular(
                      100,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withOpacity(
                          0.3,
                        ),
                        blurRadius: 15,
                        offset: const Offset(
                          0,
                          8,
                        ),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.home,
                    color: Color(
                      0xff4941b8,
                    ),
                    size: 70,
                  ),
                ),

                const SizedBox(height: 30),

                /// TITULO
                const Text(
                  "Bienvenido a ServiNet",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),

                const SizedBox(height: 10),

                const Text(
                  "Sistema de gestión de servicios",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 40),

                /// REGISTRAR
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Registrar",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                /// BOTONES RESPONSIVOS
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  alignment: WrapAlignment.center,
                  children: [
                    customButton(
                      text: "Usuario",
                      icon: Icons.person_add,
                      color: Colors.blueAccent,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const RegisterUserScreen(),
                          ),
                        );
                      },
                    ),
                    customButton(
                      text: "Contratista",
                      icon: Icons.engineering,
                      color: Colors.indigo,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const RegisterContractorScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 35),

                /// VER REGISTROS
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Ver registros",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  alignment: WrapAlignment.center,
                  children: [
                    customButton(
                      text: "Usuarios",
                      icon: Icons.people,
                      color: Colors.green,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const UserListScreen(),
                          ),
                        );
                      },
                    ),
                    customButton(
                      text: "Contratistas",
                      icon: Icons.groups,
                      color: Colors.teal,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const ContractorListScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 45),

                Text(
                  "Gestiona usuarios y prestadores de servicios fácilmente",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
