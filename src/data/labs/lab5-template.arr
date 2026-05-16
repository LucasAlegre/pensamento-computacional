use context dcic2024

#|
    Este arquivo contém o template para a solução dos exercícios do Laboratório 5 de INF05008 - Pensamento Computacional.

    Autor: Prof. Lucas N. Alegre 
|#

include image
# Importa funções e constantes da biblioteca de pokemon
include url("https://lucasalegre.github.io/pensamento-computacional/src/data/labs/pokemon-lib4.arr")


# Definição de Dados

type Conteudo = List<Entrada>
# Um Conteudo é:
# | empty
# | link(first :: Entrada, rest :: Conteudo)

data Entrada:
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


MINHA-POKEDEX :: Entrada = 
    diretorio("Pokedex", [list:
        diretorio("Kanto", [list:
            arquivo("Pikachu.pkm", P-PIKACHU),
            arquivo("Bulbasaur.pkm", P-BULBASAUR),
            arquivo("Charmander.pkm", P-CHARMANDER),
            arquivo("Squirtle.pkm", P-SQUIRTLE)
        ]),
        diretorio("Johto", [list:
            arquivo("Chikorita.pkm", P-CHIKORITA),
            arquivo("Cyndaquil.pkm", P-CYNDAQUIL),
            arquivo("Totodile.pkm", P-TOTODILE)
        ]),
        diretorio("Hoenn", [list:
            arquivo("Treecko.pkm", P-TREECKO),
            arquivo("Torchic.pkm", P-TORCHIC),
            arquivo("Mudkip.pkm", P-MUDKIP)
        ])
    ])


# Exercício 1 - Busca de arquivos e diretórios

fun encontra-no-nivel(conteudo :: Conteudo, nome :: String) -> Boolean:
    doc: "Dados o conteudo de um diretorio e um nome de entrada, verifica se existe um arquivo/diretório com este nome neste conteúdo de diretório, SEM CONSIDERAR SUBDIRETÓRIOS."
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
    encontra-no-nivel(MINHA-POKEDEX.conteudo, "Kanto") is true
    encontra-no-nivel(MINHA-POKEDEX.conteudo, "Pikachu.pkm") is false
end

fun encontra-na-entrada(entrada :: Entrada, nome :: String) -> Boolean:
    doc: "Dado uma entrada e um nome de arquivo/diretório, se a entrada for um arquivo, verifica se é o arquivo procurado; se for um diretório verifica se é o diretório procurado ou o arquivo procurado está dentro do diretório (ou subdiretório)."
    # cases (Entrada) entrada:
        # Se entrada for um arquivo, verifica se é o arquivo procurado
        # Se a entrada for um diretório,
            # Se o nome deste diretório for o nome procurado, retorna true
            # Caso contrário, verifica se o arquivo procurado está no conteúdo deste diretório
    # end
    false
where:
    encontra-na-entrada(MINHA-POKEDEX, "Pikachu.pkm") is true
    encontra-na-entrada(MINHA-POKEDEX, "Psyduck.pkm") is false
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

fun conta-arquivos-na-entrada(entrada :: Entrada) -> Number:
    doc: "Dado uma entrada, conta o número de arquivos nesta entrada, considerando também os subdiretórios."
    # cases (Entrada) entrada:
        # Se a entrada for um arquivo, conta como 1
        # Se a entrada for um diretório, conta o número de arquivos no conteúdo deste diretório
    # end
    -1
where:
    conta-arquivos-na-entrada(MINHA-POKEDEX) is 10
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
    conta-arquivos-no-conteudo(MINHA-POKEDEX.conteudo) is 10
end


# Exercício 3 - Visualização da Pokedex

fun mostra-entrada(entrada :: Entrada) -> Image:
    doc: "Dado uma entrada, se for um arquivo, gera uma imagem mostrando o nome deste arquivo e a carta do pokemon contido neste arquivo. Se for um diretório, gera uma imagem mostrando o nome deste diretório e seu conteúdo abaixo indentado."
    # cases (Entrada) entrada:
        # Arquivo: mostra "├── nome" em verde e a carta do pokemon abaixo (indentada)
        # Diretório: mostra "├── nome/" em azul e o conteúdo abaixo (indentado)
    # end
    empty-image
end

fun mostra-conteudo(c :: Conteudo) -> Image:
    doc: "Dado um conteudo, gera uma imagem mostrando o conteúdo deste diretório, onde cada entrada do conteúdo é mostrada uma abaixo da outra."
    # cases (Conteudo) c:
        # Se o conteúdo for vazio, gera uma imagem vazia
        # Se não, mostra a primeira entrada e o restante do conteúdo abaixo
    # end
    empty-image
end

mostra-entrada(MINHA-POKEDEX)


# Exercício 4 - Inclusão de Arquivos e Diretórios

fun insere-na-entrada(nova-entrada :: Entrada, entrada :: Entrada) -> Entrada:
    doc: "Dado uma nova entrada (arquivo/diretorio) e uma entrada, devolve uma nova entrada igual a esta entrada mas com este arquivo/diretorio adicionado a esta entrada. Caso já exista um arquivo/diretório com o nome desta nova entrada, retorna a entrada sem alterações."
    # cases (Entrada) entrada:
        # Se a entrada for um arquivo, retorna a entrada sem alterações
        # Se a entrada for um diretório,
            # Se já existir um arquivo com o nome deste arquivo neste diretório (mesmo nível) retorna a entrada sem alterações
            # Caso contrário, adiciona este arquivo ao conteúdo deste diretório e retorna a entrada atualizada
    # end
    arquivo("0", P-PIKACHU)
where:
    insere-na-entrada(arquivo("Psyduck.pkm", P-PIKACHU), arquivo("Bulbasaur.pkm", P-BULBASAUR)) is arquivo("Bulbasaur.pkm", P-BULBASAUR)
    insere-na-entrada(arquivo("Psyduck.pkm", P-PIKACHU), diretorio("Kanto", empty)) is diretorio("Kanto", [list: arquivo("Psyduck.pkm", P-PIKACHU)])
end

fun insere-no-conteudo(nova-entrada :: Entrada, conteudo :: Conteudo) -> Conteudo:
    doc: "Dado uma nova entrada (arquivo/diretorio) e um conteudo, devolve um novo conteudo igual a este conteudo mas com esta entrada adicionada a este conteudo, caso já não exista uma entrada com o nome desta nova entrada neste conteudo (considerando também os subdiretórios)."
    # cases (Conteudo) conteudo:
        # Se o conteúdo for vazio, retorna uma lista com apenas esta entrada
        # Se não,
            # Se já existir uma entrada no nível deste conteúdo com o nome desta nova entrada, não insere esta nova entrada e retorna o conteúdo sem alterações
            # Caso contrário, adiciona este arquivo na primeira posição do conteúdo e retorna o conteúdo atualizado
    # end
    empty
where:
    insere-no-conteudo(arquivo("Psyduck.pkm", P-PIKACHU), empty) is [list: arquivo("Psyduck.pkm", P-PIKACHU)]
    insere-no-conteudo(diretorio("Kanto", empty), MINHA-POKEDEX.conteudo) is MINHA-POKEDEX.conteudo
end


# Exercício 5 - Criação de Pokedex a partir de um Time

fun cria-pokedex(time :: Time) -> Entrada:
    doc: "Dado um time, cria uma entrada de diretório representando uma pokedex com um arquivo para cada pokemon deste time, onde o nome de cada arquivo é o nome do pokemon seguido da extensão .pkm."
    # cases (Time) time:
        # Se o time for vazio, retorna um diretório pokedex com conteúdo vazio
        # Se não,
            # Cria um arquivo para este pokemon
            # Insere este arquivo na pokedex criada com o resto do time
    # end
    arquivo("0", P-PIKACHU)
where:
    cria-pokedex(empty) is diretorio("Pokedex", empty)
    cria-pokedex([list: P-PIKACHU]) is diretorio("Pokedex", [list: arquivo(P-PIKACHU.nome + ".pkm", P-PIKACHU)])
end

POKEMONS :: Time = cria-time(POKE-DATA, range(1, 151))

POKEDEX = cria-pokedex(POKEMONS)
mostra-entrada(POKEDEX)
