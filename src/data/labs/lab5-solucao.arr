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
    cases (Conteudo) conteudo:
        # Se o Conteudo for vazio, retorna falso
        | empty => false
        | link(f, r) =>
            cases (Nodo) f:
                # Se o primeiro elemento do conteudo for um arquivo,
                | arquivo(nome-a, p) =>
                        ask:
                            # Se esse arquivo for o arquivo procurado, retorna true
                            | nome-a == nome then: true
                            # Caso contrário, verifica se o arquivo procurado está no restante do conteúdo
                            | otherwise: encontra-no-nivel(r, nome)
                        end
                # Se o conteúdo for um diretório, verifica se o arquivo procurado está no restante do conteúdo
                | diretorio(nome-d, conteudo-d) =>
                    ask:
                        # Se o nome deste diretório for o nome procurado, retorna true
                        | nome-d == nome then: true
                        # Caso contrário, verifica se o arquivo procurado está no restante do conteúdo
                        | otherwise: encontra-no-nivel(r, nome)
                    end
            end
    end
where:
    encontra-no-nivel(MINHA-POKEDEX.conteudo, "Iniciais") is true
    encontra-no-nivel(MINHA-POKEDEX.conteudo, "Pikachu.pkm") is false
end

fun encontra-na-entrada(entrada :: Nodo, nome :: String) -> Boolean:
    doc: "Dado um nodo e um nome de arquivo/diretório, se o nodo for um arquivo, verifica se é o arquivo procurado; se for um diretório verifica se é o diretório procurado ou o arquivo procurado está dentro do diretório (ou subdiretório)."
    cases (Nodo) entrada:
        # Se o nodo for um arquivo, verifica se é o arquivo procurado
        | arquivo(nome-a, p) => nome-a == nome
        # Se o nodo for um diretório, verifica se o arquivo procurado está dentro do conteúdo do diretório
        | diretorio(nome-d, conteudo-d) =>
            ask:
                # Se o nome deste diretório for o nome procurado, retorna true
                | nome-d == nome then: true
                # Caso contrário, verifica se o arquivo procurado está no conteúdo deste diretório
                | otherwise: encontra-no-conteudo(conteudo-d, nome)
            end
    end
where:
    encontra-na-entrada(MINHA-POKEDEX, "Iniciais") is true
    encontra-na-entrada(MINHA-POKEDEX, "Psyduck.pkm") is false
end

fun encontra-no-conteudo(conteudo :: Conteudo, nome :: String) -> Boolean:
    doc: "Dado um Conteudo e um nome de arquivo, verifica se existe um arquivo com este nome neste conteudo ou em qualquer subdiretório deste conteudo."
    cases (Conteudo) conteudo:
        # Se o conteudo for vazio, retorna falso
        | empty => false
        # Se não, verifica se o arquivo está
        | link(f, r) =>
            # no primeiro elemento do conteudo, ou 
            encontra-na-entrada(f, nome) or
            # no restante do conteudo 
            encontra-no-conteudo(r, nome)
    end
where:
    encontra-no-conteudo(MINHA-POKEDEX.conteudo, "Pikachu.pkm") is true
    encontra-no-conteudo(MINHA-POKEDEX.conteudo, "Psyduck.pkm") is false
end


# Exercício 2 - Contagem de Arquivos

fun conta-arquivos-na-entrada(entrada :: Nodo) -> Number:
    doc: "Dado um nodo, conta o número de arquivos neste nodo, considerando também os subdiretórios."
    cases (Nodo) entrada:
        # Se o nodo for um arquivo, conta como 1
        | arquivo(nomeA, p) => 1
        # Se o nodo for um diretório, conta o número de arquivos no conteúdo deste diretório
        | diretorio(nomeD, conteudoD) => conta-arquivos-no-conteudo(conteudoD)
    end
where:
    conta-arquivos-na-entrada(MINHA-POKEDEX) is 11
end

fun conta-arquivos-no-conteudo(conteudo :: Conteudo) -> Number:
    doc: "Dado o conteudo de um diretorio, conta o número de arquivos neste conteúdo de diretório, considerando também os subdiretórios."
    cases (Conteudo) conteudo:
        # Se o conteudo for vazio, não há arquivos
        | empty => 0
        # Senão, o total de arquivos é a soma do número de arquivos no primeiro elemento do conteúdo com o número de arquivos no restante do conteúdo
        | link(f, r) => conta-arquivos-na-entrada(f) + conta-arquivos-no-conteudo(r)
    end
where:
    conta-arquivos-no-conteudo(empty) is 0
    conta-arquivos-no-conteudo(MINHA-POKEDEX.conteudo) is 11
end


# Exercício 3 - Visualização da Pokedex

fun mostra-entrada(entrada :: Nodo) -> Image:
    doc: "Dado um nodo, se for um arquivo, gera uma imagem mostrando o nome deste arquivo e a carta do pokemon contido neste arquivo. Se for um diretório, gera uma imagem mostrando o nome deste diretório e seu conteúdo abaixo indentado."
    cases (Nodo) entrada:
        # Arquivo: mostra "├── nome" em verde e a carta do pokemon abaixo (indentada)
        | arquivo(n, p) =>
            above-align("left",
                text("├── " + n, 18, "darkgreen"),
                beside(
                    text("       ", 20, "white"),
                    desenha-pokemon(p)))
        # Diretório: mostra "├── nome/" em azul e o conteúdo abaixo (indentado)
        | diretorio(n, c) =>
            above-align("left",
                text("├── " + n + "/", 18, "darkblue"),
                beside(
                    text("       ", 20, "white"),
                    mostra-conteudo(c)))
    end
end

fun mostra-conteudo(c :: Conteudo) -> Image:
    doc: "Dado um conteudo, gera uma imagem mostrando o conteúdo deste diretório, onde cada nodo do conteúdo é mostrado um abaixo do outro."
    cases (Conteudo) c:
        # Se o conteúdo for vazio, gera uma imagem vazia
        | empty => empty-image
        # Se não, mostra o primeiro nodo e o restante do conteúdo abaixo
        | link(f, r) =>
            above-align("left",
                mostra-entrada(f),
                mostra-conteudo(r))
    end
end

#save-image(
    mostra-entrada(MINHA-POKEDEX)
#, "images/lab5/pokedex.png")


# Exercício 4 - Inclusão de Arquivos e Diretórios


fun insere-na-entrada(nova-entrada :: Nodo, entrada :: Nodo) -> Nodo:
    doc: "Dado um novo nodo (arquivo/diretorio) e um nodo, devolve um novo nodo igual a este nodo mas com este arquivo/diretorio adicionado a este nodo. Caso já exista um arquivo/diretório com o nome deste novo nodo, retorna o nodo sem alterações."
    cases (Nodo) entrada:
        # Se o nodo for um arquivo, retorna o nodo sem alterações
        | arquivo(n, p) => entrada
        # Se o nodo for um diretório,
        | diretorio(n, c) =>
            ask:
                # Se já existir um arquivo com o nome deste arquivo neste diretório (mesmo nível) retorna o nodo sem alterações
                | encontra-no-nivel(c, nova-entrada.nome) then: entrada
                # Caso contrário, adiciona este arquivo ao conteúdo deste diretório e retorna o nodo atualizado
                | otherwise: diretorio(n, insere-no-conteudo(nova-entrada, c))
            end
    end
where:
    insere-na-entrada(arquivo("Psyduck.pkm", P-PIKACHU), arquivo("Bulbasaur.pkm", P-BULBASAUR)) is arquivo("Bulbasaur.pkm", P-BULBASAUR)
    insere-na-entrada(arquivo("Psyduck.pkm", P-PIKACHU), diretorio("Kanto", empty)) is diretorio("Kanto", [list: arquivo("Psyduck.pkm", P-PIKACHU)])
end

fun insere-no-conteudo(nova-entrada :: Nodo, conteudo :: Conteudo) -> Conteudo:
    doc: "Dado um novo nodo (arquivo/diretorio) e um conteudo, devolve um novo conteudo igual a este conteudo mas com este nodo adicionado a este conteudo, caso já não exista um nodo com o nome deste novo nodo neste conteudo (considerando também os subdiretórios)."
    cases (Conteudo) conteudo:
        # Se o conteúdo for vazio, retorna uma lista com apenas este nodo
        | empty => [list: nova-entrada]
        # Se não,
        | link(f, r) =>
            ask:
                # Se já existir um nodo no nível deste conteúdo com o nome deste novo nodo, não insere este novo nodo e retorna o conteúdo sem alterações
                | encontra-no-nivel(conteudo, nova-entrada.nome) then: conteudo
                # Caso contrário, adiciona este arquivo na primeira posição do conteúdo e retorna o conteúdo atualizado
                | otherwise: link(nova-entrada, conteudo)
            end
    end
where:
    insere-no-conteudo(arquivo("Psyduck.pkm", P-PIKACHU), empty) is [list: arquivo("Psyduck.pkm", P-PIKACHU)]
    insere-no-conteudo(diretorio("Iniciais", empty), MINHA-POKEDEX.conteudo) is MINHA-POKEDEX.conteudo
end


# Exercício 5 - Criação de Pokedex a partir de um Time

fun cria-pokedex(time :: Time) -> Nodo:
    doc: "Dado um time, cria um nodo de diretório representando uma pokedex com um arquivo para cada pokemon deste time, onde o nome de cada arquivo é o nome do pokemon seguido da extensão .pkm."
    cases (Time) time:
        # Se o time for vazio, retorna um diretório pokedex com conteúdo vazio
        | empty => diretorio("Pokedex", empty)
        | link(first, rest) =>
            # Cria um arquivo para este pokemon
            nova-entrada = arquivo(first.nome + ".pkm", first)
            # Insere este arquivo na pokedex criada com o resto do time
            insere-na-entrada(nova-entrada, cria-pokedex(rest))
    end
where:
    cria-pokedex(empty) is diretorio("Pokedex", empty)
    cria-pokedex([list: P-PIKACHU]) is diretorio("Pokedex", [list: arquivo(P-PIKACHU.nome + ".pkm", P-PIKACHU)])
end

POKEMONS :: Time = cria-time(POKE-DATA, range(1, 151))

POKEDEX = cria-pokedex(POKEMONS)
mostra-entrada(POKEDEX)


# Desafio - Mostra caminho até um arquivo

fun mostra-caminho(entrada :: Nodo, nome :: String) -> String:
    doc: "Dado um nodo e um nome de arquivo, retorna o caminho até este arquivo a partir deste nodo, caso exista um arquivo com este nome neste nodo ou em algum subdiretório deste nodo. O caminho deve ser uma string com o nome de cada diretório seguido de uma barra (/) e, no final, o nome do arquivo. Caso não exista um arquivo com este nome neste nodo ou em algum subdiretório deste nodo, retorna a string 'Arquivo não encontrado'."
    cases (Nodo) entrada:
        # Se o nodo for um arquivo, verifica se é o arquivo procurado
        | arquivo(nome-a, p) =>
            ask:
                # Se esse arquivo for o arquivo procurado, retorna o nome deste arquivo
                | nome-a == nome then: nome-a
                # Caso contrário, retorna "Arquivo não encontrado"
                | otherwise: "Arquivo não encontrado"
            end
        # Se o nodo for um diretório, verifica se o arquivo procurado está dentro do conteúdo do diretório
        | diretorio(nome-d, conteudo-d) =>
            ask:
                # Se o nome deste diretório for o nome procurado, retorna o nome deste diretório seguido de uma barra e o nome do arquivo procurado
                | nome-d == nome then: nome-d + "/" + nome
                # Se o arquivo procurado está no conteúdo deste diretório, retorna o nome deste diretório seguido de uma barra e o caminho até este arquivo a partir do conteúdo deste diretório
                | mostra-caminho-conteudo(conteudo-d, nome) <> "Arquivo não encontrado" then: nome-d + "/" + mostra-caminho-conteudo(conteudo-d, nome)
                # Senão, retorna "Arquivo não encontrado"
                | otherwise: "Arquivo não encontrado"
            end
    end
where:
    mostra-caminho(MINHA-POKEDEX, "Digimon.pkm") is "Arquivo não encontrado"
    mostra-caminho(MINHA-POKEDEX, "Charmander.pkm") is "Pokedex/Iniciais/Kanto/Rota-1/Charmander.pkm"
end

fun mostra-caminho-conteudo(conteudo :: Conteudo, nome :: String) -> String:
    doc: "Dado um conteudo e um nome de arquivo, retorna o caminho até este arquivo a partir deste conteudo, caso exista um arquivo com este nome neste conteudo ou em algum subdiretório deste conteudo. O caminho deve ser uma string com o nome de cada diretório seguido de uma barra (/) e, no final, o nome do arquivo. Caso não exista um arquivo com este nome neste conteudo ou em algum subdiretório deste conteudo, retorna a string 'Arquivo não encontrado'."
    cases (Conteudo) conteudo:
        # Se o conteúdo for vazio, retorna "Arquivo não encontrado"
        | empty => "Arquivo não encontrado"
        # Se não, verifica se o arquivo está
        | link(f, r) =>
            ask:
                # Se o arquivo procurado está no primeiro elemento do conteúdo, retorna o caminho até este arquivo a partir deste elemento
                | mostra-caminho(f, nome) <> "Arquivo não encontrado" then: mostra-caminho(f, nome)
                # Verifica se o arquivo procurado está no restante do conteúdo e, caso esteja, retorna o caminho até este arquivo a partir do restante do conteúdo
                | mostra-caminho-conteudo(r, nome) <> "Arquivo não encontrado" then: mostra-caminho-conteudo(r, nome)
                # Caso contrário, retorna "Arquivo não encontrado"
                | otherwise: "Arquivo não encontrado"
            end
    end
where:
    mostra-caminho-conteudo(MINHA-POKEDEX.conteudo, "Charmander.pkm") is "Iniciais/Kanto/Rota-1/Charmander.pkm"
    mostra-caminho-conteudo(MINHA-POKEDEX.conteudo, "Digimon.pkm") is "Arquivo não encontrado"
end