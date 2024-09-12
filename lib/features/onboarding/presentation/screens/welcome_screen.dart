import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildBackground(),
          _buildLogo(),
          _buildCard(context),
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 125, 190, 222),
    );
  }

  Widget _buildBackground() {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/fundo_estrelas.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: screenHeight > 300 ? screenHeight * 0.6 : 300,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 25.0,
                  left: 40.0,
                  right: 22.0,
                ),
                child: Text(
                  'Boas vindas ao Clarity!',
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        color: const Color.fromARGB(255, 46, 74, 85),
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2.0,
                      ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 50.0,
                  left: 22.0,
                  right: 22.0,
                ),
                child: Text(
                  'Somos uma plataforma de estudos inclusiva. Aqui, você encontrará cursos adaptados com progresso gamificado, conteúdos em fases e relatórios para acompanhar seu aprendizado!',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.notoSans(
                    fontSize: 18,
                    color: const Color.fromARGB(255, 142, 147, 150),
                    letterSpacing: 2.0,
                    height: 1.5,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 40.0),
                child: ElevatedButton(
                  onPressed: () {
                    // quando clicar no botão
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 92, 167, 205),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30.0,
                      vertical: 15.0,
                    ),
                  ),
                  child: Text(
                    'Vamos começar!',
                    style: GoogleFonts.notoSans(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Positioned(
      top: 40,
      left: 0,
      right: 0,
      child: Column(
        children: [
          Image.asset(
            'assets/images/clarity.png',
            width: 120,
            height: 120,
            fit: BoxFit.contain,
          ),
          Transform.translate(
            offset: const Offset(0, -40),
            child: ColorFiltered(
              colorFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
              child: Image.asset(
                'assets/images/logo_azul.png',
                width: 200,
                height: 200,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
