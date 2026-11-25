import 'package:material_ui/material_ui.dart';

void main() {
  runApp(const RegForm());
}

class RegForm extends StatelessWidget {
  const RegForm({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: { "/": (context) => const Fscreen(),
        "/confirmation": (context) => const Cscreen(),
      },
    );
  }
}

class Fscreen extends StatefulWidget {
  const Fscreen({super.key});

  @override
  State<Fscreen> createState() => _FscreenState();
}

class _FscreenState extends State<Fscreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  String? nameValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Please enter your name.";
    }

    return null;
  }

  String? emailValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Please enter email.";
    }

    final email = value.trim();

    if (!email.contains("@") ||
        !email.substring(email.indexOf("@") + 1).contains(".")) {
      return "Invalid email address";
    }

    return null;
  }

  void submitForm() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushNamed(
        context,
        "/confirmation",
        arguments: {
          "name": _nameController.text.trim(),
          "email": _emailController.text.trim(),
        },
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registration Form"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: "Full Name",
                  border: OutlineInputBorder(),
                ),
                validator: nameValidator,
              ),
              const SizedBox(height: 25),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: "Email Address",
                  border: OutlineInputBorder(),
                ),
                validator: emailValidator,
              ),
              const SizedBox(height: 25),
              ElevatedButton(
                onPressed: submitForm,
                child: const Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Cscreen extends StatelessWidget {
  const Cscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments
            as Map<String, String>;

    final name = arguments["name"]!;
    final email = arguments["email"]!;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Confirmation"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Registration Successful!",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 25),
            Text("Full Name: $name"),
            const SizedBox(height: 15),
            Text("Email Address: $email"),
            const SizedBox(height: 25),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Back"),
            ),
          ],
        ),
      ),
    );
  }
}
