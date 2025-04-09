float xBola, yBola, raio = 15;
float velocidadeX, velocidadeY;
float velocidadeInicialX = 5, velocidadeInicialY = 3;
float incrementoVelocidade = 0.1;
int contagemFrames = 0;

float larguraPalheta = 10, alturaPalheta;
float xPalhetaEsq = 30, yPalhetaEsq;
float xPalhetaDir, yPalhetaDir;
float velocidadePalheta = 5;

int pontosEsq = 0, pontosDir = 0;
int limitePontos = 5;
boolean jogoAtivo = false;
boolean menuAtivo = true;
boolean modoContraBot = false;
String vencedor = "";

boolean wPressionado = false;
boolean sPressionado = false;
boolean upPressionado = false;
boolean downPressionado = false;

int dificuldade = 2;

void setup() {
  size(800, 500);
  textFont(createFont("Arial", 20));
  xPalhetaDir = width - 40;
}

void draw() {
  background(30);
  if (menuAtivo) {
    mostrarMenu();
  } else if (jogoAtivo) {
    desenharBola();
    moverBola();
    desenharPalhetas();
    moverPalhetas();
    verificarColisao();
    mostrarPlacar();
    verificarPonto();
    contagemFrames++;
    if (contagemFrames % 300 == 0) {
      if (velocidadeX > 0) velocidadeX += incrementoVelocidade;
      else velocidadeX -= incrementoVelocidade;
      if (velocidadeY > 0) velocidadeY += incrementoVelocidade;
      else velocidadeY -= incrementoVelocidade;
    }
  } else {
    mostrarTelaVencedor();
  }
}

void mostrarMenu() {
  fill(255);
  textAlign(CENTER);
  textSize(28);
  text("PONG", width/2, height/2 - 100);
  textSize(20);
  text("Pressione 1 para Player vs Player", width/2, height/2 - 20);
  text("Pressione 2 para Player vs IA", width/2, height/2 + 20);
}

void iniciarJogo() {
  xBola = width/2;
  yBola = height/2;
  xPalhetaDir = width - 40;
  yPalhetaEsq = height/2 - alturaPalheta/2;
  yPalhetaDir = height/2 - alturaPalheta/2;
  definirDificuldade(dificuldade);
  velocidadeX = random(1) < 0.5 ? velocidadeInicialX : -velocidadeInicialX;
  velocidadeY = random(1) < 0.5 ? velocidadeInicialY : -velocidadeInicialY;
  contagemFrames = 0;
  jogoAtivo = true;
  menuAtivo = false;
}

void desenharBola() {
  ellipse(xBola, yBola, raio*2, raio*2);
}

void moverBola() {
  xBola += velocidadeX;
  yBola += velocidadeY;
  if (yBola < raio || yBola > height - raio) {
    velocidadeY *= -1;
  }
}

void desenharPalhetas() {
  rect(xPalhetaEsq, yPalhetaEsq, larguraPalheta, alturaPalheta);
  rect(xPalhetaDir, yPalhetaDir, larguraPalheta, alturaPalheta);
}

void moverPalhetas() {
  if (wPressionado) yPalhetaEsq -= velocidadePalheta;
  if (sPressionado) yPalhetaEsq += velocidadePalheta;
  if (!modoContraBot) {
    if (upPressionado) yPalhetaDir -= velocidadePalheta;
    if (downPressionado) yPalhetaDir += velocidadePalheta;
  } else {
    float centroPalheta = yPalhetaDir + alturaPalheta/2;
    if (yBola < centroPalheta - 10) yPalhetaDir -= velocidadePalheta;
    if (yBola > centroPalheta + 10) yPalhetaDir += velocidadePalheta;
  }
  yPalhetaEsq = constrain(yPalhetaEsq, 0, height - alturaPalheta);
  yPalhetaDir = constrain(yPalhetaDir, 0, height - alturaPalheta);
}

void verificarColisao() {
  if (xBola - raio < xPalhetaEsq + larguraPalheta &&
      yBola > yPalhetaEsq && yBola < yPalhetaEsq + alturaPalheta) {
    velocidadeX *= -1;
  }
  if (xBola + raio > xPalhetaDir &&
      yBola > yPalhetaDir && yBola < yPalhetaDir + alturaPalheta) {
    velocidadeX *= -1;
  }
}

void verificarPonto() {
  if (xBola < 0) {
    pontosDir++;
    checarVencedor();
    iniciarJogo();
  } else if (xBola > width) {
    pontosEsq++;
    checarVencedor();
    iniciarJogo();
  }
}

void mostrarPlacar() {
  textSize(24);
  fill(255);
  textAlign(CENTER);
  text(pontosEsq + "  |  " + pontosDir, width/2, 30);
}

void checarVencedor() {
  if (pontosEsq >= limitePontos) {
    vencedor = "Jogador da Esquerda venceu!";
    jogoAtivo = false;
  } else if (pontosDir >= limitePontos) {
    vencedor = modoContraBot ? "IA venceu!" : "Jogador da Direita venceu!";
    jogoAtivo = false;
  }
}

void mostrarTelaVencedor() {
  background(0);
  textSize(32);
  fill(255);
  textAlign(CENTER);
  text(vencedor, width/2, height/2 - 20);
  textSize(20);
  text("Pressione ENTER para voltar ao menu", width/2, height/2 + 30);
}

void keyPressed() {
  if (menuAtivo) {
    if (key == '1') {
      modoContraBot = false;
      pontosEsq = 0;
      pontosDir = 0;
      iniciarJogo();
    } else if (key == '2') {
      modoContraBot = true;
      pontosEsq = 0;
      pontosDir = 0;
      iniciarJogo();
    }
  } else if (!jogoAtivo && key == ENTER) {
    pontosEsq = 0;
    pontosDir = 0;
    jogoAtivo = false;
    menuAtivo = true;
  }

  if (key == 'w' || key == 'W') wPressionado = true;
  if (key == 's' || key == 'S') sPressionado = true;
  if (keyCode == UP) upPressionado = true;
  if (keyCode == DOWN) downPressionado = true;
}

void keyReleased() {
  if (key == 'w' || key == 'W') wPressionado = false;
  if (key == 's' || key == 'S') sPressionado = false;
  if (keyCode == UP) upPressionado = false;
  if (keyCode == DOWN) downPressionado = false;
}

void definirDificuldade(int nivel) {
  if (nivel == 1) {
    alturaPalheta = 120;
    velocidadeInicialX = 4;
    velocidadeInicialY = 2;
  } else if (nivel == 2) {
    alturaPalheta = 80;
    velocidadeInicialX = 5;
    velocidadeInicialY = 3;
  } else if (nivel == 3) {
    alturaPalheta = 60;
    velocidadeInicialX = 6;
    velocidadeInicialY = 4;
  }
}
