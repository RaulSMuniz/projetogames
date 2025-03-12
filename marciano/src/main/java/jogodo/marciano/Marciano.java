/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 */
package jogodo.marciano;

import java.util.Scanner;
import java.util.Random;

public class Marciano {

    public static void main(String[] args) {
        Random rng = new Random();
        Scanner userInp = new Scanner(System.in);
        char newGame;
        int maxTries = 0;
        int randomNum, triedNumber, playerTries, option = 0;
        String difficulty = "";
        do {
            randomNum = rng.nextInt(100) + 1;
            playerTries = 0;
            System.out.println("Escolha a dificuldade: ");
            System.out.println("1. Fácil (10 tentativas)");
            System.out.println("2. Médio (7 tentativas)");
            System.out.println("3. Difícil (5 tentativas)");

            System.out.println("Digite o número da opção escolhida.");
            option = userInp.nextInt();
            if (option == 1) {
                maxTries = 10;
                difficulty = "[Fácil]";
            } else if (option == 2) {
                maxTries = 7;
                difficulty = "[Médio]";
            } else if (option == 3) {
                maxTries = 5;
                difficulty = "[Difícil]";
            } else {
                System.out.println("Escolha uma opção válida.");
            }

            System.out.println("Um alienígena invadiu nosso planeta, é seu dever o encontrar! \n"
                    + "Caso você não encontre dentro do limite de tentativas... \n"
                    + "Algo terrível... Algo assustador pode acontecer. \n"
                    + "O marciano se escondeu entre a árvore 1 e 100, o encontre!");

            do {
                System.out.println("Escolha o número: ");
                triedNumber = userInp.nextInt();
                playerTries++;
                int totalTries = maxTries - playerTries;

                if (maxTries == 5 && playerTries == 2) {
                    System.out.println("O marciano descobriu que você está chegando perto dele... \n"
                            + "Portanto, ele pode ter se escondido em até 5 árvores para baixo ou 5 árvores para cima. \n"
                            + "Regra 1: Se a árvore do marciano for maior do que 5, ele se esconderá entre 1 e 5 árvores abaixo. \n"
                            + "Regra 2: Se a árvore do marciano for menor do que 5, ele se esconderá entre 1 e 5 árvores acima. \n"
                            + "Regra 3: Se a árvore do marciano for maior do que 95, ele se esconderá entre 1 e 5 árvores abaixo. \n"
                            + "Regra 4: Se a árvore do marciano for menor do que 95, ele se esconderá entre 1 e 5 árvores acima.");

                    if (randomNum > 95 || randomNum > 5) {
                        int newTree = rng.nextInt(5) + 1;
                        randomNum -= newTree;
                        System.out.println("O marciano se escondeu " + newTree + " árvores abaixo.");
                    } else if (randomNum < 95 || randomNum < 5) {
                        int newTree = rng.nextInt(5) + 1;
                        randomNum += newTree;
                        System.out.println("O marciano se escondeu " + newTree + " árvores acima.");
                    }
                }
                
                

                if (triedNumber > randomNum) {
                    System.out.println("Tente um número menor.");
                    System.out.println("Tentativas restantes: " + totalTries);
                } else if (triedNumber < randomNum) {
                    System.out.println("Tente um número maior.");
                    System.out.println("Tentativas restantes: " + totalTries);
                } else {
                    System.out.println("Nível de dificuldade: " + difficulty);
                    System.out.println("Você encontrou o marciano e salvou a Terra, parabéns!");
                    System.out.println("Tentativas totais: " + playerTries);
                }

                if (playerTries == maxTries && triedNumber != randomNum) {
                    System.out.println("O marciano estava na árvore: " + randomNum + "\n"
                            + "O pior aconteceu... \n"
                            + "O marciano corrompeu toda a Terra através de sua tecnologia alienígena! \n"
                            + "Caro soldado, este é o fim para todos nós. Foi bom o ter no meu esquadrão durante este tempo.");

                    break;
                }

            } while (triedNumber != randomNum);

            userInp.nextLine();
            System.out.print("Deseja jogar novamente: [s/n]: ");
            newGame = userInp.nextLine().toUpperCase().charAt(0);
        } while (newGame == 'S');

    }
}
