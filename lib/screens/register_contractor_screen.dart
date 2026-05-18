import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../models/contractor_model.dart';
import '../services/contractor_services.dart';

class RegisterContractorScreen extends StatefulWidget {
  final ContractorModel? contractor;

  const RegisterContractorScreen({
    super.key,
    this.contractor,
  });

  @override
  State<RegisterContractorScreen> createState() =>
      _RegisterContractorScreenState();
}

class _RegisterContractorScreenState extends State<RegisterContractorScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController fullNameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();

  final TextEditingController usernameController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController addressController = TextEditingController();

  final TextEditingController documentController = TextEditingController();

  final TextEditingController specialtyController = TextEditingController();

  final TextEditingController experienceController = TextEditingController();

  final TextEditingController companyController = TextEditingController();

  final TextEditingController availabilityController = TextEditingController();

  final ContractorServices _contractorService = ContractorServices();

  bool isLoading = false;

  bool obscurePassword = true;

  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();

    if (widget.contractor != null) {
      fullNameController.text = widget.contractor!.fullName;

      emailController.text = widget.contractor!.email;

      phoneController.text = widget.contractor!.phone;

      usernameController.text = widget.contractor!.username;

      passwordController.text = widget.contractor!.password;

      addressController.text = widget.contractor!.address;

      documentController.text = widget.contractor!.document;

      specialtyController.text = widget.contractor!.specialty;

      experienceController.text = widget.contractor!.experience;

      companyController.text = widget.contractor!.company;

      availabilityController.text = widget.contractor!.availability;

      selectedDate = widget.contractor!.birthDate;
    }
  }

  Future<void> pickBirthDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> saveContractor() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Seleccione la fecha de nacimiento",
          ),
        ),
      );

      return;
    }

    setState(() {
      isLoading = true;
    });

    const uuid = Uuid();

    final contractor = ContractorModel(
      id: widget.contractor?.id ?? uuid.v4(),
      fullName: fullNameController.text.trim(),
      document: documentController.text.trim(),
      phone: phoneController.text.trim(),
      email: emailController.text.trim(),
      address: addressController.text.trim(),
      specialty: specialtyController.text.trim(),
      experience: experienceController.text.trim(),
      company: companyController.text.trim(),
      availability: availabilityController.text.trim(),
      username: usernameController.text.trim(),
      password: passwordController.text.trim(),
      birthDate: selectedDate!,
    );

    if (widget.contractor == null) {
      await _contractorService.addContractor(contractor);
    } else {
      await _contractorService.updateContractor(
        contractor,
      );
    }

    setState(() {
      isLoading = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.only(
          bottom: 350,
          left: 20,
          right: 20,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            15,
          ),
        ),
        content: Text(
          widget.contractor == null
              ? "Contratista registrado"
              : "Contratista actualizado",
          textAlign: TextAlign.center,
        ),
      ),
    );

    Navigator.pop(context);
  }

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    addressController.dispose();
    documentController.dispose();
    specialtyController.dispose();
    experienceController.dispose();
    companyController.dispose();
    availabilityController.dispose();

    super.dispose();
  }

  String? _validateUser(
    String? value,
  ) {
    if (value == null || value.isEmpty) {
      return "Campo obligatorio";
    }

    if (value.length < 6) {
      return "Mínimo 6 caracteres";
    }

    if (value.length > 15) {
      return "Máximo 15 caracteres";
    }

    return null;
  }

  String? _validatePassword(
    String? value,
  ) {
    if (value == null || value.isEmpty) {
      return "Campo obligatorio";
    }

    if (value.length < 8) {
      return "Mínimo 8 caracteres";
    }

    final passwordRegex = RegExp(
      r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]+$',
    );

    if (!passwordRegex.hasMatch(value)) {
      return "La contraseña debe ser alfanumérica";
    }

    return null;
  }

  String? _validateFullName(
    String? value,
  ) {
    if (value == null || value.isEmpty) {
      return "Campo obligatorio";
    }

    if (value.length < 6) {
      return "Mínimo 6 caracteres";
    }

    if (value.length > 30) {
      return "Máximo 30 caracteres";
    }

    return null;
  }

  String? _validatePhone(
    String? value,
  ) {
    if (value == null || value.isEmpty) {
      return "Campo obligatorio";
    }

    if (int.tryParse(value) == null) {
      return "Solo números permitidos";
    }

    if (value.length != 10) {
      return "Debe tener 10 números";
    }

    return null;
  }

  String? _validateDocument(
    String? value,
  ) {
    if (value == null || value.isEmpty) {
      return "El documento es obligatorio";
    }

    if (int.tryParse(value) == null) {
      return "Solo números permitidos";
    }

    return null;
  }

  String? _validateAddress(
    String? value,
  ) {
    if (value == null || value.isEmpty) {
      return "La dirección es obligatoria";
    }

    return null;
  }

  String? _validateEmail(
    String? value,
  ) {
    if (value == null || value.isEmpty) {
      return "El correo es obligatorio";
    }

    final emailRegex = RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
    );

    if (!emailRegex.hasMatch(value)) {
      return "Correo inválido";
    }

    return null;
  }

  InputDecoration customInput(
    String label,
    IconData icon,
  ) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(
        icon,
        color: Colors.blueAccent,
      ),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          15,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          15,
        ),
        borderSide: const BorderSide(
          color: Colors.grey,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          15,
        ),
        borderSide: const BorderSide(
          color: Colors.blueAccent,
          width: 2,
        ),
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
        title: Text(
          widget.contractor == null
              ? "Registrar Contratista"
              : "Editar Contratista",
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(
                  20,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(
                            20,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(
                                0.05,
                              ),
                              blurRadius: 10,
                              offset: const Offset(
                                0,
                                5,
                              ),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            const Icon(
                              Icons.engineering,
                              size: 80,
                              color: Colors.blueAccent,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              "Formulario de Contratista",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                              controller: fullNameController,
                              decoration: customInput(
                                "Nombre Completo",
                                Icons.person,
                              ),
                              validator: _validateFullName,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: emailController,
                              decoration: customInput(
                                "Correo Electrónico",
                                Icons.email,
                              ),
                              validator: _validateEmail,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: phoneController,
                              keyboardType: TextInputType.phone,
                              decoration: customInput(
                                "Teléfono",
                                Icons.phone,
                              ),
                              validator: _validatePhone,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: documentController,
                              keyboardType: TextInputType.number,
                              decoration: customInput(
                                "Documento",
                                Icons.badge,
                              ),
                              validator: _validateDocument,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: addressController,
                              decoration: customInput(
                                "Dirección",
                                Icons.location_on,
                              ),
                              validator: _validateAddress,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: specialtyController,
                              decoration: customInput(
                                "Especialidad",
                                Icons.build,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: experienceController,
                              decoration: customInput(
                                "Experiencia",
                                Icons.work,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: companyController,
                              decoration: customInput(
                                "Empresa",
                                Icons.business,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: availabilityController,
                              decoration: customInput(
                                "Disponibilidad",
                                Icons.schedule,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: usernameController,
                              decoration: customInput(
                                "Usuario",
                                Icons.account_circle,
                              ),
                              validator: _validateUser,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: passwordController,
                              obscureText: obscurePassword,
                              decoration: customInput(
                                "Contraseña",
                                Icons.lock,
                              ).copyWith(
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    obscurePassword
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                  onPressed: () {
                                    setState(
                                      () {
                                        obscurePassword = !obscurePassword;
                                      },
                                    );
                                  },
                                ),
                              ),
                              validator: _validatePassword,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            InkWell(
                              onTap: pickBirthDate,
                              child: InputDecorator(
                                decoration: customInput(
                                  "Fecha de Nacimiento",
                                  Icons.calendar_month,
                                ),
                                child: Text(
                                  selectedDate == null
                                      ? "Seleccione una fecha"
                                      : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: 55,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blueAccent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      15,
                                    ),
                                  ),
                                ),
                                onPressed: saveContractor,
                                child: Text(
                                  widget.contractor == null
                                      ? "Guardar Contratista"
                                      : "Actualizar Contratista",
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
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
