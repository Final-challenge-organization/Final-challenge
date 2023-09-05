//
//  GameLogic.swift
//  Mythos
//
//  Created by Narely Lima on 05/09/23.
//

import Foundation

class GameLogic {

    var jogadores: [Player] = []
    var numberOfPlayers: Int = 0
    var distributeCards: Bool = false
    var startGame: Bool = false
    var willBeAttacked: Bool = true
    var willBeDefense: Bool = true
    var numberOfCard: Int = 0
    var currentPlayer = Player()
    var currentCard = Cards()
    var currentNextPlayer = Player()
    var currentIndex: Int = 0
    var currentIndexNextPlayer: Int = 0
    var currentCardNextPlayer = Cards()
    var direcionamento: Int = 1
    let cardsShuffle = cards.shuffled()
    var randomCards: [Cards] = []
    let handDeck = 3
    var danoTotal: Int = 0

    // da 3 cartas aleatorias para cada jogador

    func firstGamePlay(_ numberOfPlayers: Int) {
        // colocar a função numberOfPlayers = inputUser()
        print("Jogarão \(numberOfPlayers) pessoas")
        if numberOfPlayers == 3 || numberOfPlayers == 4 {
            for i in 0..<numberOfPlayers {
                jogadores.append(Player(id: i, name: "Jogador \(i+1)"))
            }
            distributeCards = true
//            // da cartas
            giveCardsToPlayers(distributeCards)
//            // seleciona o primeiro jogador
            chooseFirstPlayer()
//            // define o prox jogador
            definitionNextPlayer(currentIndex, numberOfPlayers)

//            // anuncia q o primeiro jogador deve começar
            sendMessagePlayer(currentPlayer)
//            // pergunta qual a carta q o jogador vai usar para atacar
            print("""
                Name:  \(currentPlayer.name)
                Cards: [1] \(currentPlayer.individualsCards[0].typeOfCards) Dano: \(currentPlayer.individualsCards[0].damage)
                       [2] \(currentPlayer.individualsCards[1].typeOfCards) Dano: \(currentPlayer.individualsCards[1].damage)
                       [3] \(currentPlayer.individualsCards[2].typeOfCards) Dano: \(currentPlayer.individualsCards[2].damage)
            """
            )
            askActionPlayer(currentPlayer, numberOfCard)
//            // pergunta qual a carta q o jogador vai usar para se defender
//            // e faz a tentativa de ataque
            print("""
                Name:  \(currentNextPlayer.name)
                Cards: [1] \(currentNextPlayer.individualsCards[0].typeOfCards) Dano: \(currentNextPlayer.individualsCards[0].damage)
                       [2] \(currentNextPlayer.individualsCards[1].typeOfCards) Dano: \(currentNextPlayer.individualsCards[1].damage)
                       [3] \(currentNextPlayer.individualsCards[2].typeOfCards) Dano: \(currentNextPlayer.individualsCards[2].damage)
            """
            )
            haveAttackCard(currentNextPlayer, currentCard)
            nextPlayer()

        } else {
            print("Infelizmente só 3 ou 4 jogadores poderão jogar")
            distributeCards = false
        }
    }
    // da cartas

    func giveCardsToPlayers(_ start: Bool) {
        if start {
            for jogador in 0..<jogadores.count {
                jogadores[jogador].individualsCards = dealCards()
                randomCards = []
            }
        } else {
            print("Deu erro")
        }
    }

    func defaultGamePlay(_ index: Int) {

        currentPlayer = jogadores[index]
        currentIndex = currentPlayer.id
//        // define o prox jogador
        definitionNextPlayer(index, numberOfPlayers)
        // anuncia q o primeiro jogador deve começar
        sendMessagePlayer(currentPlayer)
        // pergunta qual a carta q o jogador vai usar para atacar
        print("""
            Name:  \(currentPlayer.name)
            Cards: [1] \(currentPlayer.individualsCards[0].typeOfCards) Dano: \(currentPlayer.individualsCards[0].damage)
                   [2] \(currentPlayer.individualsCards[1].typeOfCards) Dano: \(currentPlayer.individualsCards[1].damage)
                   [3] \(currentPlayer.individualsCards[2].typeOfCards) Dano: \(currentPlayer.individualsCards[2].damage)
        """
        )
        askActionPlayer(currentPlayer, numberOfCard)
        // pergunta qual a carta q o jogador vai usar para se defender
        // e faz a tentativa de ataque
        print("""
            Name:  \(currentNextPlayer.name)
            Cards: [1] \(currentNextPlayer.individualsCards[0].typeOfCards) Dano: \(currentNextPlayer.individualsCards[0].damage)
                   [2] \(currentNextPlayer.individualsCards[1].typeOfCards) Dano: \(currentNextPlayer.individualsCards[1].damage)
                   [3] \(currentNextPlayer.individualsCards[2].typeOfCards) Dano: \(currentNextPlayer.individualsCards[2].damage)
        """
        )
        haveAttackCard(currentNextPlayer, currentCard)
        nextPlayer()
    }

    func dealCards() -> [Cards] {
        for _ in 0..<3 {
            randomCards.append(cardsShuffle.randomElement()!)
        }
        return randomCards
    }

    // Escolhe o jogador atual e o próximo jogador em relaçao a ele

    func chooseFirstPlayer() {
        // seleciona o primeiro jogador
        currentPlayer = jogadores.randomElement()!
        currentIndex = currentPlayer.id

    }
    // define o prox jogador

    func definitionNextPlayer(_ index: Int, _ numberPlayers: Int) {

        currentIndexNextPlayer = (index + direcionamento) % numberPlayers
        currentNextPlayer = jogadores[currentIndexNextPlayer]
    }

    // avisa ao jogador que é a vez dele jogar

    func sendMessagePlayer(_ player: Player) {
        print("\(player.name), você é o próximo a jogar")
    }

    // pergunta qual carta irá jogar

    func askActionPlayer(_ player: Player, _ numberCard: Int) {

        print("Qual carta você irá jogar? [1, 2 ou 3]")
        numberOfCard = inputUser()
        let validOptions2 = [1, 2, 3]

        if !validOptions2.contains(numberOfCard) {
            while !validOptions2.contains(numberOfCard) {
                print("Qual carta você irá jogar? [1, 2 ou 3]")
                numberOfCard = inputUser()
            }
        } else {
            currentCard = currentPlayer.individualsCards[numberOfCard-1]
        }
    }

    // 1º Cenário: ATAQUE X DEFESA

    // tentativa de ataque no próximo jogador

    func haveAttackCard(_ nextPlayer: Player, _ currentCard: Cards) {
        if nextPlayer.individualsCards.contains(where: { tipo in
            tipo.typeOfCards == .defense
        }) {
            askReactionPlayer(nextPlayer, numberOfCard)
            willBeAttacked = false
            print("jogue sua carta de defesa")
        }
        else {
            willBeAttacked = true
            danoTotal = currentCard.damage
            if danoTotal <= 0 { danoTotal = 0}
            currentNextPlayer.life = currentNextPlayer.life - danoTotal
            print("A vida do jogador atacado é: ", currentNextPlayer.life)

            print("Você nao tem carta de defesa, logo recebeu dano")
        }
    }

    func tryDefensePlayer(_ cardNextPlayer: Cards) {

        // verifica se o prox jogador tem carta de defesa
        if cardNextPlayer.typeOfCards == .attack {
            willBeDefense = false
            print("Você nao pode se defender usando um ataque, escolha uma carta q seja de defesa")
            askReactionPlayer(currentNextPlayer, numberOfCard)

        } else if cardNextPlayer.typeOfCards == .defense ||  currentCardNextPlayer.typeOfCards == .specialEffect {
            willBeDefense = true
            danoTotal = currentCard.damage - currentCardNextPlayer.damage
            if danoTotal <= 0 { danoTotal = 0}
            currentNextPlayer.life = currentNextPlayer.life - danoTotal
            print("A vida do jogador atacado é: ", currentNextPlayer.life)
            print("Jogador se defendeu")
        }
    }

    // pergunta com qual carta a pessoa vai se defender

    func askReactionPlayer(_ player: Player, _ numberCard: Int) {

        print("Com qual carta você irá reagir? [1, 2 ou 3]")
        numberOfCard = inputUser()
        let validOptions2 = [1, 2, 3]

        if !validOptions2.contains(numberOfCard) {
            while !validOptions2.contains(numberOfCard) {
                print("Qual carta você irá jogar? [1, 2 ou 3]")
                numberOfCard = inputUser()
            }
        } else {
            currentCardNextPlayer = currentNextPlayer.individualsCards[numberOfCard-1]
            tryDefensePlayer(currentCardNextPlayer)
        }
    }

    // define a ordem dos jogadores

    func inverterDirecionamento() {
        direcionamento = direcionamento == 1 ? -1 : 1
    }

    func nextPlayer() {
        currentIndex = (currentIndex + direcionamento) % jogadores.count
        defaultGamePlay(currentIndex)
    }

    func inputUser() -> Int {

        let numberInputs = readLine()!
        let numberOfInputs = Int(numberInputs)!
        return numberOfInputs
    }

}

let gameLogic = GameLogic()

var number = gameLogic.inputUser()

