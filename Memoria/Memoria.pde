int cols = 3;
int rows = 2;
int total = cols * rows;
Carta[] cartas = new Carta[total];
PImage[] imagens;
Carta primeiraSelecionada = null;
Carta segundaSelecionada = null;
int delayVirar = 0;
boolean travado = false;

void setup() {
  size(600, 400);
  carregarImagens();
  iniciarCartas();
}

void draw() {
  background(30, 100, 150);

  for (Carta c : cartas) {
    c.mostrar();
  }

  if (segundaSelecionada != null && millis() > delayVirar) {
    verificarPar();
  }

  if (jogoCompleto()) {
    mostrarTelaDeVitoria();
  }
}


void mousePressed() {
  if (jogoCompleto()) {
    if (mouseX > 170 && mouseX < 170 + 130 && mouseY > 250 && mouseY < 290) {
      iniciarCartas();
      primeiraSelecionada = null;
      segundaSelecionada = null;
      travado = false;
      return;
    }

    if (mouseX > 320 && mouseX < 320 + 130 && mouseY > 250 && mouseY < 290) {
      exit(); 
    }
    return;
  }

  if (travado) return;

  for (Carta c : cartas) {
    if (c.foiClicada(mouseX, mouseY) && !c.virada) {
      c.virada = true;

      if (primeiraSelecionada == null) {
        primeiraSelecionada = c;
      } else {
        segundaSelecionada = c;
        travado = true;
        delayVirar = millis() + 1000;
      }
      break;
    }
  }
}


void verificarPar() {
  if (primeiraSelecionada != null && segundaSelecionada != null) {
    if (primeiraSelecionada.id != segundaSelecionada.id) {
      primeiraSelecionada.virada = false;
      segundaSelecionada.virada = false;
    }
    primeiraSelecionada = null;
    segundaSelecionada = null;
    travado = false;
  }
}

boolean jogoCompleto() {
  for (Carta c : cartas) {
    if (!c.virada) return false;
  }
  return true;
}

void carregarImagens() {
  imagens = new PImage[total / 2];
  for (int i = 0; i < imagens.length; i++) {
    imagens[i] = loadImage("fruta" + (i + 1) + ".png");
  }
}

void iniciarCartas() {
  ArrayList<Integer> indices = new ArrayList<Integer>();
  for (int i = 0; i < imagens.length; i++) {
    indices.add(i);
    indices.add(i);
  }

  embaralhar(indices);

  int w = width / cols;
  int h = height / rows;

  for (int i = 0; i < total; i++) {
    int x = (i % cols) * w;
    int y = (i / cols) * h;
    int id = indices.get(i);
    cartas[i] = new Carta(x, y, w - 10, h - 10, imagens[id], id);
  }
}

void embaralhar(ArrayList<Integer> lista) {
  for (int i = lista.size() - 1; i > 0; i--) {
    int j = int(random(i + 1));
    int temp = lista.get(i);
    lista.set(i, lista.get(j));
    lista.set(j, temp);
  }
}

class Carta {
  int x, y, w, h;
  boolean virada = false;
  PImage img;
  int id;

  Carta(int x, int y, int w, int h, PImage img, int id) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.img = img;
    this.id = id;
  }

  void mostrar() {
    stroke(255);
    if (virada) {
      fill(255);
      rect(x, y, w, h);
      image(img, x, y, w, h);
    } else {
      fill(200);
      rect(x, y, w, h);
    }
  }

  boolean foiClicada(int mx, int my) {
    return mx > x && mx < x + w && my > y && my < y + h;
  }
}

void mostrarTelaDeVitoria() {
  fill(0, 180);
  rect(0, 0, width, height);

  String msg = "Parabéns! Você encontrou todos os pares!";
  textSize(24);
  textAlign(CENTER, CENTER);

  // Medidas baseadas no texto
  float boxW = textWidth(msg) + 60;
  float boxH = 90;
  float boxX = width / 2 - boxW / 2;
  float boxY = 130;

  fill(255, 240);
  rect(boxX, boxY, boxW, boxH, 15);

  fill(30);
  text(msg, width / 2, boxY + boxH / 2);

  fill(0, 200, 100); 
  rectMode(CORNER);
  rect(170, 250, 130, 40, 10);
  fill(255);
  textSize(16);
  text("Jogar Novamente", 170 + 65, 250 + 20);

  fill(200, 50, 50); 
  rect(320, 250, 130, 40, 10);
  fill(255);
  text("Fechar o Jogo", 320 + 65, 250 + 20);
}
