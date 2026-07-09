use context dcic2024

#|
    Este arquivo contém o template para a solução dos exercícios do Laboratório 5 de INF05008 - Pensamento Computacional.

    Autor: Prof. Lucas N. Alegre 
|#

include image
# Importa funções e constantes da biblioteca de pokemon
include url("https://lucasalegre.github.io/pensamento-computacional/src/data/labs/pokemon-lib4.arr")


# Definição de Dados

type Conteudo = List<Nodo>
# Um Conteudo é:
# | empty
# | link(first :: Nodo, rest :: Conteudo)

data Nodo:
    | arquivo(nome :: String, pokemon :: Pokemon)
    | diretorio(nome :: String, conteudo :: Conteudo)
end


P-BULBASAUR = extrai-pokemon-tabela(1, POKE-DATA)
P-CHARMANDER = extrai-pokemon-tabela(4, POKE-DATA)
P-SQUIRTLE = extrai-pokemon-tabela(7, POKE-DATA)
P-PIKACHU = extrai-pokemon-tabela(25, POKE-DATA)
P-CHIKORITA = extrai-pokemon-tabela(152, POKE-DATA)
P-CYNDAQUIL = extrai-pokemon-tabela(155, POKE-DATA)
P-TOTODILE = extrai-pokemon-tabela(158, POKE-DATA)
P-TREECKO = extrai-pokemon-tabela(252, POKE-DATA)
P-TORCHIC = extrai-pokemon-tabela(255, POKE-DATA)
P-MUDKIP = extrai-pokemon-tabela(258, POKE-DATA)
P-MEWTWO = extrai-pokemon-tabela(150, POKE-DATA)

MINHA-POKEDEX :: Nodo =
    diretorio("Pokedex", [list:
        diretorio("Iniciais", [list:
            diretorio("Kanto", [list:
                arquivo("Pikachu.pkm", P-PIKACHU),
                diretorio("Rota-1", [list:
                    arquivo("Bulbasaur.pkm", P-BULBASAUR),
                    arquivo("Charmander.pkm", P-CHARMANDER),
                    arquivo("Squirtle.pkm", P-SQUIRTLE)
                ])
            ]),
            diretorio("Johto", [list:
                arquivo("Chikorita.pkm", P-CHIKORITA),
                diretorio("Laboratorio", [list:
                    arquivo("Cyndaquil.pkm", P-CYNDAQUIL),
                    arquivo("Totodile.pkm", P-TOTODILE)
                ])
            ]),
            diretorio("Hoenn", [list:
                arquivo("Treecko.pkm", P-TREECKO),
                arquivo("Torchic.pkm", P-TORCHIC),
                arquivo("Mudkip.pkm", P-MUDKIP)
            ])
        ]),
        arquivo("Mewtwo.pkm", P-MEWTWO)
    ])


# Exercício 1 - Busca de arquivos e diretórios

fun encontra-no-nivel(conteudo :: Conteudo, nome :: String) -> Boolean:
    doc: "Dados o conteudo de um diretorio e um nome de nodo, verifica se existe um arquivo/diretório com este nome neste conteúdo de diretório, SEM CONSIDERAR SUBDIRETÓRIOS."
    # cases (Conteudo) conteudo:
        # Se o Conteudo for vazio, retorna falso
        # Se não, verifica o primeiro elemento do conteúdo:
            # Se o primeiro elemento do conteudo for um arquivo,
                # Se esse arquivo for o arquivo procurado, retorna true
                # Caso contrário, verifica se o arquivo procurado está no restante do conteúdo
            # Se o primeiro elemento for um diretório,
                # Se o nome deste diretório for o nome procurado, retorna true
                # Caso contrário, verifica se o arquivo procurado está no restante do conteúdo
    # end
    false
where:
    encontra-no-nivel(MINHA-POKEDEX.conteudo, "Iniciais") is true
    encontra-no-nivel(MINHA-POKEDEX.conteudo, "Pikachu.pkm") is false
end

fun encontra-no-nodo(nodo :: Nodo, nome :: String) -> Boolean:
    doc: "Dado um nodo e um nome de arquivo/diretório, se o nodo for um arquivo, verifica se é o arquivo procurado; se for um diretório verifica se é o diretório procurado ou o arquivo procurado está dentro do diretório (ou subdiretório)."
    # cases (Nodo) nodo:
        # Se o nodo for um arquivo, verifica se é o arquivo procurado
        # Se o nodo for um diretório,
            # Se o nome deste diretório for o nome procurado, retorna true
            # Caso contrário, verifica se o arquivo procurado está no conteúdo deste diretório
    # end
    false
where:
    encontra-no-nodo(MINHA-POKEDEX, "Iniciais") is true
    encontra-no-nodo(MINHA-POKEDEX, "Psyduck.pkm") is false
end

fun encontra-no-conteudo(conteudo :: Conteudo, nome :: String) -> Boolean:
    doc: "Dado um Conteudo e um nome de arquivo, verifica se existe um arquivo com este nome neste conteudo ou em qualquer subdiretório deste conteudo."
    # cases (Conteudo) conteudo:
        # Se o conteudo for vazio, retorna falso
        # Se não, verifica se o arquivo está
            # no primeiro elemento do conteudo, ou
            # no restante do conteudo
    # end
    false
where:
    encontra-no-conteudo(MINHA-POKEDEX.conteudo, "Pikachu.pkm") is true
    encontra-no-conteudo(MINHA-POKEDEX.conteudo, "Psyduck.pkm") is false
end


# Exercício 2 - Contagem de Arquivos

fun conta-arquivos-no-nodo(nodo :: Nodo) -> Number:
    doc: "Dado um nodo, conta o número de arquivos neste nodo, considerando também os subdiretórios."
    # cases (Nodo) nodo:
        # Se o nodo for um arquivo, conta como 1
        # Se o nodo for um diretório, conta o número de arquivos no conteúdo deste diretório
    # end
    -1
where:
    conta-arquivos-no-nodo(MINHA-POKEDEX) is 11
end

fun conta-arquivos-no-conteudo(conteudo :: Conteudo) -> Number:
    doc: "Dado o conteudo de um diretorio, conta o número de arquivos neste conteúdo de diretório, considerando também os subdiretórios."
    # cases (Conteudo) conteudo:
        # Se o conteudo for vazio, não há arquivos
        # Senão, o total de arquivos é a soma do número de arquivos no primeiro elemento do conteúdo com o número de arquivos no restante do conteúdo
    # end
    -1
where:
    conta-arquivos-no-conteudo(empty) is 0
    conta-arquivos-no-conteudo(MINHA-POKEDEX.conteudo) is 11
end


# Exercício 3 - Visualização da Pokedex

fun mostra-nodo(nodo :: Nodo) -> Image:
    doc: "Dado um nodo, se for um arquivo, gera uma imagem mostrando o nome deste arquivo e a carta do pokemon contido neste arquivo. Se for um diretório, gera uma imagem mostrando o nome deste diretório e seu conteúdo abaixo indentado."
        # Arquivo: mostra "├── nome" em verde e a carta do pokemon abaixo (indentada)
        
        # Dica:
        #above-align("left",
        #        text("├── " + n, 18, "darkgreen"),
        #        ...

        # Diretório: mostra "├── nome/" em azul e o conteúdo abaixo (indentado)
    # end
    empty-image
end

fun mostra-conteudo(c :: Conteudo) -> Image:
    doc: "Dado um conteudo, gera uma imagem mostrando o conteúdo deste diretório, onde cada nodo do conteúdo é mostrado um abaixo do outro."
        # Se o conteúdo for vazio, ...
        # Se não,...

        # Dica: 
        #   above-align("left",
        #        text("├── " + n + "/", 18, "darkblue"),
        #        beside(
        #            text("       ", 20, "white"),
        #            ...
    # end
    empty-image
end

mostra-nodo(MINHA-POKEDEX)


# Exercício 4 - Inclusão de Arquivos e Diretórios

fun insere-no-nodo(novo-nodo :: Nodo, nodo :: Nodo) -> Nodo:
    doc: "Dado um novo nodo (arquivo/diretorio) e um nodo, devolve um novo nodo igual a este nodo mas com este arquivo/diretorio adicionado a este nodo. Caso já exista um arquivo/diretório com o nome deste novo nodo, retorna o nodo sem alterações."

    arquivo("0", P-PIKACHU)
where:
    insere-no-nodo(arquivo("Psyduck.pkm", P-PIKACHU), arquivo("Bulbasaur.pkm", P-BULBASAUR)) is arquivo("Bulbasaur.pkm", P-BULBASAUR)
    insere-no-nodo(arquivo("Psyduck.pkm", P-PIKACHU), diretorio("Kanto", empty)) is diretorio("Kanto", [list: arquivo("Psyduck.pkm", P-PIKACHU)])
end

fun insere-no-conteudo(novo-nodo :: Nodo, conteudo :: Conteudo) -> Conteudo:
    doc: "Dado um novo nodo (arquivo/diretorio) e um conteudo, devolve um novo conteudo igual a este conteudo mas com este nodo adicionado a este conteudo, caso já não exista um nodo com o nome deste novo nodo neste conteudo (considerando também os subdiretórios)."
    
    empty
where:
    insere-no-conteudo(arquivo("Psyduck.pkm", P-PIKACHU), empty) is [list: arquivo("Psyduck.pkm", P-PIKACHU)]
    insere-no-conteudo(diretorio("Iniciais", empty), MINHA-POKEDEX.conteudo) is MINHA-POKEDEX.conteudo
end


# Exercício 5 - Criação de Pokedex a partir de um Time

fun cria-pokedex(time): # Complete o contrato
    doc: "Dado um time, cria um nodo de diretório representando uma pokedex com um arquivo para cada pokemon deste time, onde o nome de cada arquivo é o nome do pokemon seguido da extensão .pkm."

    arquivo("0", P-PIKACHU)
where:
    cria-pokedex(empty) is diretorio("Pokedex", empty)
    cria-pokedex([list: P-PIKACHU]) is diretorio("Pokedex", [list: arquivo(P-PIKACHU.nome + ".pkm", P-PIKACHU)])
end

POKEMONS :: Time = cria-time(POKE-DATA, range(1, 151))  # range(a, b) gera uma lista de números de a até b-1

POKEDEX = cria-pokedex(POKEMONS)
mostra-nodo(POKEDEX)






# Desafio - Mostra caminho até um arquivo

fun mostra-caminho(nodo :: Nodo, nome :: String) -> String:
    doc: "Dado um nodo e um nome de arquivo, retorna o caminho até este arquivo a partir deste nodo, caso exista um arquivo com este nome neste nodo ou em algum subdiretório deste nodo. O caminho deve ser uma string com o nome de cada diretório seguido de uma barra (/) e, no final, o nome do arquivo. Caso não exista um arquivo com este nome neste nodo ou em algum subdiretório deste nodo, retorna a string 'Arquivo não encontrado'."
 
    "Arquivo não encontrado"
where:
    mostra-caminho(MINHA-POKEDEX, "Digimon.pkm") is "Arquivo não encontrado"
    mostra-caminho(MINHA-POKEDEX, "Charmander.pkm") is "Pokedex/Iniciais/Kanto/Rota-1/Charmander.pkm"
end

fun mostra-caminho-conteudo(conteudo :: Conteudo, nome :: String) -> String:
    doc: "Dado um conteudo e um nome de arquivo, retorna o caminho até este arquivo a partir deste conteudo, caso exista um arquivo com este nome neste conteudo ou em algum subdiretório deste conteudo. O caminho deve ser uma string com o nome de cada diretório seguido de uma barra (/) e, no final, o nome do arquivo. Caso não exista um arquivo com este nome neste conteudo ou em algum subdiretório deste conteudo, retorna a string 'Arquivo não encontrado'."

    "Arquivo não encontrado"
where:
    mostra-caminho-conteudo(MINHA-POKEDEX.conteudo, "Charmander.pkm") is "Iniciais/Kanto/Rota-1/Charmander.pkm"
    mostra-caminho-conteudo(MINHA-POKEDEX.conteudo, "Digimon.pkm") is "Arquivo não encontrado"
end
