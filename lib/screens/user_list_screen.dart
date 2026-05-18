import 'package:flutter/material.dart';

import '../models/user_model.dart';
import '../services/user_services.dart';
import 'register_user_screen.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  final UserService _userService = UserService();

  List<UserModel> users = [];

  bool isLoading = true;

  /// CONTROL DE TARJETAS EXPANDIDAS
  final Map<String, bool> expandedCards = {};

  @override
  void initState() {
    super.initState();

    loadUsers();
  }

  Future<void> loadUsers() async {
    final data = await _userService.getUsers();

    setState(() {
      users = data;
      isLoading = false;
    });
  }

  Future<void> deleteUser(String id) async {
    setState(() {
      isLoading = true;
    });

    await _userService.deleteUser(id);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.red,
        content: Text(
          "Usuario eliminado",
          textAlign: TextAlign.center,
        ),
      ),
    );

    await loadUsers();
  }

  Widget buildUserCard(UserModel user) {
    bool obscurePassword = true;

    return StatefulBuilder(
      builder: (context, setCardState) {
        final isExpanded = expandedCards[user.id] ?? false;

        return Container(
          margin: const EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                /// HEADER
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.blueAccent.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(
                          50,
                        ),
                      ),
                      child: const Icon(
                        Icons.person,
                        color: Colors.blueAccent,
                        size: 35,
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.fullName,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            "@${user.username}",
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                /// EMAIL
                Row(
                  children: [
                    const Icon(
                      Icons.email,
                      color: Colors.blueAccent,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        user.email,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                /// TELÉFONO
                Row(
                  children: [
                    const Icon(
                      Icons.phone,
                      color: Colors.green,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        user.phone,
                      ),
                    ),
                  ],
                ),

                /// INFORMACIÓN EXTRA
                if (isExpanded) ...[
                  const SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(
                        15,
                      ),
                    ),
                    child: Column(
                      children: [
                        /// DOCUMENTO
                        Row(
                          children: [
                            const Icon(
                              Icons.badge,
                              color: Colors.purple,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Text(
                                user.document,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(
                          height: 12,
                        ),

                        /// DIRECCIÓN
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              color: Colors.redAccent,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Text(
                                user.addres,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(
                          height: 12,
                        ),

                        /// FECHA
                        Row(
                          children: [
                            const Icon(
                              Icons.calendar_month,
                              color: Colors.orange,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Text(
                                "${user.birthDate.day}/${user.birthDate.month}/${user.birthDate.year}",
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(
                          height: 12,
                        ),

                        /// CONTRASEÑA
                        Row(
                          children: [
                            const Icon(
                              Icons.lock,
                              color: Colors.grey,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Text(
                                obscurePassword ? "********" : user.password,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                setCardState(() {
                                  obscurePassword = !obscurePassword;
                                });
                              },
                              icon: Icon(
                                obscurePassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],

                const SizedBox(height: 20),

                /// BOTONES RESPONSIVOS
                Wrap(
                  alignment: WrapAlignment.end,
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    /// MOSTRAR
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            12,
                          ),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          expandedCards[user.id] = !isExpanded;
                        });
                      },
                      icon: Icon(
                        isExpanded ? Icons.visibility_off : Icons.visibility,
                        color: Colors.white,
                      ),
                      label: Text(
                        isExpanded ? "Ocultar" : "Mostrar",
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),

                    /// EDITAR
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            12,
                          ),
                        ),
                      ),
                      onPressed: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => RegisterUserScreen(
                              user: user,
                            ),
                          ),
                        );

                        loadUsers();
                      },
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                      label: const Text(
                        "Editar",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),

                    /// ELIMINAR
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            12,
                          ),
                        ),
                      ),
                      onPressed: () {
                        deleteUser(user.id);
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                      label: const Text(
                        "Eliminar",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
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
          "Lista de Usuarios",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : users.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.people_outline,
                        size: 100,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "No hay usuarios",
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.grey[700],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(
                    20,
                  ),
                  child: ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      final user = users[index];

                      return buildUserCard(
                        user,
                      );
                    },
                  ),
                ),
    );
  }
}
