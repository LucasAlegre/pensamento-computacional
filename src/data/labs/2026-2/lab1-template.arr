use context starter2024

#|
    Este arquivo contém um modelo para a solução dos exercícios do Laboratório 1 de INF05008 - Pensamento Computacional.
    Tema: Truco Gaúcho (Gaudério)
    Regras de Referência: https://www.jogatina.com/regras-como-jogar-truco-gauderio.html

    Prof. Lucas N. Alegre
|#

#|
    Constantes Úteis (Exercício 2)
|#

CARTA-ALT = 175
CARTA-LAR = 125

# Imagens dos quatro naipes do baralho espanhol preparadas para a atividade
ICONE-ESPADAS = scale(0.1, image-url("https://raw.githubusercontent.com/LucasAlegre/pensamento-computacional/refs/heads/main/src/data/labs/2026-2/images/espadas.jpg"))
ICONE-PAUS = scale(0.1, image-url("https://raw.githubusercontent.com/LucasAlegre/pensamento-computacional/refs/heads/main/src/data/labs/2026-2/images/paus.jpg"))
ICONE-OUROS = scale(0.1, image-url("https://raw.githubusercontent.com/LucasAlegre/pensamento-computacional/refs/heads/main/src/data/labs/2026-2/images/ouros.jpg"))
ICONE-COPAS = scale(0.1, image-url("https://raw.githubusercontent.com/LucasAlegre/pensamento-computacional/refs/heads/main/src/data/labs/2026-2/images/copas.jpg"))


#| 
    Exercício 1: Constantes de Texto
|#

# TODO: Defina as constantes para representar os quatro naipes:
# NAIPE-ESPADAS, NAIPE-PAUS, NAIPE-OUROS e NAIPE-COPAS
NAIPE-ESPADAS = "ESPADAS"


# TODO: Defina as constantes para representar os resultados da rodada:
# VITORIA-J1, VITORIA-J2 e EMPATE



#|
    Exercício 2: Constantes Visuais e Mesa
|#

# TODO: Defina as imagens para FUNDO-CARTA (com rectangle solid branco), 
# a MESA (com circle solid verde) e a BORDA (com rectangle solid branco)



#| 
    Exercício 3: Composição Básica de Imagens (Sem Condicionais)
|#

fun fundo-com-icone(icone :: Image) -> Image:
  doc: "Dado o ícone de um naipe, centraliza o ícone sobre o fundo da carta."
  # TODO: Centralize o icone sobre FUNDO-CARTA usando overlay
  empty-image
end

fun adiciona-borda(carta :: Image) -> Image:
  doc: "Dada a imagem de uma carta, devolve a mesma carta com borda externa."
  # TODO: Use frame e overlay-align com a BORDA
  empty-image
end


#| 
    Exercício 4: Expressões Condicionais (Seleção de Ícone e Manilhas)
|#

fun seleciona-icone-naipe(naipe :: String) -> Image:
  doc: "Dado o nome de um naipe, devolve a imagem do ícone correspondente."
  # TODO: Implemente usando ask
  empty-image
where:
  # TODO: Escreva testes para os naipes
  1 is 1 # Teste temporário, apague e substitua pelos seus testes
end

fun eh-manilha(valor :: Number, naipe :: String) -> Boolean:
  doc: "Dado o valor numérico e o naipe de uma carta, devolve true se ela for uma das 4 manilhas fixas do Truco Gaúcho, e false caso contrário."
  # TODO: Implemente usando ask
  false
where:
  # TODO: Escreva testes cobrindo as 4 manilhas e cartas normais
  1 is 1
end


#| 
    Exercício 5: Montagem da Carta
|#

fun cria-carta(valor :: Number, naipe :: String) -> Image:
  doc: "Dado o valor numérico e o naipe da carta, devolve a imagem da carta montada com valor, ícone, nome do naipe e borda."
  # TODO: Monte a carta combinando o valor no topo, o resultado de fundo-com-icone no centro, o nome do naipe na base e a borda externa
  empty-image
end

# Teste a sua função de construir cartas (remova o # abaixo para executar quando sua função estiver pronta):
# cria-carta(1, NAIPE-ESPADAS)
# cria-carta(7, NAIPE-OUROS)


#| 
    Exercício 6: Força da Carta no Truco Gaúcho
|#

fun forca-carta(valor :: Number, naipe :: String) -> Number:
  doc: ```Dado o valor numérico e o naipe de uma carta, devolve o seu peso de força no Truco Gaúcho (escala de 1 a 14).
  Regras: https://www.jogatina.com/regras-como-jogar-truco-gauderio.html
  ```
  # TODO: Implemente a escala de força usando ask (dica: avalie primeiro as manilhas!)
  0
where:
  # TODO: Escreva testes documentando manilhas, cartas altas e cartas comuns
  1 is 1
end


#| 
    Exercício 7: Duelo e Montagem da Rodada na Mesa
|#

fun compara-cartas(valor1 :: Number, naipe1 :: String, valor2 :: Number, naipe2 :: String) -> String:
  doc: "Dadas duas cartas (Jogador 1 vs Jogador 2), devolve a constante de resultado: VITORIA-J1, VITORIA-J2 ou EMPATE."
  # TODO: Compare a forca-carta de cada uma usando ask diretamente (sem variáveis locais) e retorne o resultado
  ""
where:
  # TODO: Escreva testes para vitórias de ambos os lados e casos de empate
  1 is 1
end

fun rotula-carta(nome-jogador :: String, valor :: Number, naipe :: String) -> Image:
  doc: "Dado o nome do jogador e a carta, devolve a carta com o rótulo do jogador posicionado acima dela."
  # TODO: Coloque o texto do nome do jogador acima da carta criada
  empty-image
end

fun desenha-duelo(valor1 :: Number, naipe1 :: String, valor2 :: Number, naipe2 :: String) -> Image:
  doc: "Desenha as cartas rotuladas de ambos os jogadores lado a lado e centralizadas sobre a MESA."
  # TODO: Posicione as cartas rotuladas lado a lado e centralize sobre a MESA
  empty-image
end

fun desenha-cenario(valor1 :: Number, naipe1 :: String, valor2 :: Number, naipe2 :: String) -> Image:
  doc: "Dadas as cartas jogadas pelo Jogador 1 e pelo Jogador 2, desenha o cenário do duelo sobre a MESA verde com rótulos dos jogadores e o resultado abaixo da mesa."
  # TODO: Combine desenha-duelo e o texto com o resultado de compara-cartas
  empty-image
end

# Após implementar tudo, remova os comentários da linha abaixo e veja o resultado do duelo na mesa!
# desenha-cenario(1, NAIPE-ESPADAS, 7, NAIPE-OUROS)
# desenha-cenario(3, NAIPE-PAUS, 3, NAIPE-COPAS)
