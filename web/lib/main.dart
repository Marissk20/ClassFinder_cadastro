import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Configurações Supabase
const supabaseUrl = 'https://vpcevcuclswbjtvgbisp.supabase.co';
const supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZwY2V2Y3VjbHN3Ymp0dmdiaXNwIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDU1MjAxMzIsImV4cCI6MjA2MTA5NjEzMn0.AUsd8iAzp9bYu8ojNE3wl0wQYkjMzYmdVs39GaKkZi0';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseAnonKey);
  runApp(const MaterialApp(debugShowCheckedModeBanner: false, home: LoginPage()));
}

final supabase = Supabase.instance.client;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();

  Future<void> signIn(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha todos os campos')),
      );
      return;
    }

    try {
      final response = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user != null) {
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const HomePage()),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Usuário inválido.')),
        );
      }
    } on AuthException catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro: ${error.message}')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro inesperado.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/fundo.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('images/logo_projeto.png', width: 500),
                    const SizedBox(height: 40),

                    // Campo de Email
                    SizedBox(
                      width: 400,
                      child: TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xFF3D4A1F),
                          hintText: 'Digite seu e-mail...',
                          hintStyle: const TextStyle(color: Colors.white70),
                          labelText: 'E-mail',
                          labelStyle: const TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Campo de Senha
                    SizedBox(
                      width: 400,
                      child: TextField(
                        controller: senhaController,
                        obscureText: true,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xFF3D4A1F),
                          hintText: 'Digite sua senha...',
                          hintStyle: const TextStyle(color: Colors.white70),
                          labelText: 'Senha',
                          labelStyle: const TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),

                    const SizedBox(height: 10),

                    // Botões de texto
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {}, // Esqueci minha senha
                          child: const Text('Esqueci minha senha', style: TextStyle(color: Colors.blue)),
                        ),
                        const SizedBox(width: 20),
                        TextButton(
                          onPressed: () {}, // Cadastrar
                          child: const Text('Cadastrar-se', style: TextStyle(color: Colors.blue)),
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),

                    // Botão Login
                    SizedBox(
                      width: 270,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          final email = emailController.text.trim();
                          final senha = senhaController.text.trim();
                          signIn(email, senha);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xffe49937),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Text('Login', style: TextStyle(fontSize: 18, color: Colors.white)),
                      ),
                    ),

                    const SizedBox(height: 150),
                    Image.asset('images/logo_facul.png', width: 180),
                  ],
                ),
              ),
            ),
          ),

          Positioned(
            left: 0,
            top: 450,
            child: Image.asset('images/selos.png', width: 170),
          ),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('HomePage')),
      body: const Center(child: Text('Ainda em desenvolvimento, sorry :/')),
    );
  }
}
