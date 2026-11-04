use context dcic2024

# INF05008 - Pensamento Computacional
# Autor: Prof. Lucas N. Alegre

data Nodo:
    nodo(
        id :: String,              # Identificador do nodo
        vizinhos :: List<String>   # Lista de nomes dos vizinhos do nodo
    )
end

type Grafo = List<Nodo>
# Um grafo é:
# | empty
# | link(first :: Nodo, rest :: List<Nodo>)

CIDADES = [list:
    nodo("Duluth", [list: "Toronto"]),
    nodo("Pittsburgh", [list: "Toronto"]),
    nodo("Toronto", [list: "Duluth", "Chicago", "Pittsburgh"]),
    nodo("Chicago", [list: "Toronto"])
]


G :: Grafo = [list:
                nodo("A", [list: "B", "C"]),
                nodo("B", [list: "A", "C"]),
                nodo("C", [list: "A", "B", "D"]),
                nodo("D", [list: "C"])
            ]

G1 :: Grafo = [list: 
                nodo("A", [list: "B", "E"]),
                nodo("B", [list: "E", "F"]),
                nodo("C", [list: "D"]),
                nodo("D", empty),
                nodo("E", [list: "C", "F"]),
                nodo("F", [list: "D", "G"]),
                nodo("G", empty)]


fun vizinhos(g :: Grafo, id :: String) -> List<String>:
    doc: "Dados um grafo e um identificador de nodo, retorna a lista de vizinhos do nodo correspondente. O nodo deve fazer parte do grafo."
    cases (Grafo) g:
        # Se o grafo estiver vazio, retorna lista vazia
        | empty => empty
        | link(f, r) =>
            ask:   
                # Se o nodo atual é o que estamos procurando, retorna seus vizinhos
                | f.id == id then: f.vizinhos
                # Senão, procura os vizinhos do id nos nodos restantes do grafo
                | otherwise: vizinhos(r, id)
            end
    end
where:
    vizinhos(G1, "A") is [list: "B", "E"]
    vizinhos(G1, "C") is [list: "D"]
    vizinhos(G1, "X") is empty
end

fun esta-na-lista(l :: List<String>, id :: String) -> Boolean:
    doc: "Determina se um identificador de nodo está presente em uma lista de strings."
    cases (List<String>) l:
        | empty => false
        | link(f, r) =>
            ask:
                | f == id then: true
                | otherwise: esta-na-lista(r, id)
            end
    end
where:
    esta-na-lista([list: "A", "B", "C"], "B") is true
    esta-na-lista([list: "A", "B", "C"], "D") is false
end

fun estende-caminho(viz :: List<String>, caminho :: List<String>) -> List<List<String>>:
    doc: "Dada uma lista de vizinhos e um caminho, retorna uma lista de caminhos estendendo o caminho com cada vizinho sendo colocado na primeira posição do caminho."
    cases (List<String>) viz:
        | empty => empty
        | link(f, r) =>
            # Cria um novo caminho estendendo o caminho atual com o vizinho f
            novo-caminho = link(f, caminho)
            link(novo-caminho, estende-caminho(r, caminho))
    end
where:
    # "A" → "B" → "F" (guardado de trás para frente) estendido com os vizinhos de "F"
    estende-caminho([list: "D", "G"], [list: "F", "B", "A"]) is
        [list: [list: "D", "F", "B", "A"], [list: "G", "F", "B", "A"]]
    estende-caminho(empty, [list: "F", "B", "A"]) is empty
end


# Existe um caminho entre dois nodos em um grafo?

fun existe-caminho(g :: Grafo, origem :: String, destino :: String) -> Boolean:
    doc: "Dados um grafo, um nodo de origem e um nodo de destino, determina se existe um caminho do nodo origem ao nodo destino."

    fun busca-em-largura(fila :: List<String>, visitados :: List<String>) -> Boolean:
        cases (List<String>) fila:
            | empty => false # Fila vazia: não existe caminho
            | link(no, resto) =>
                ask:
                    | no == destino then: true
                    # Nodo já visitado: segue com o resto da fila
                    | esta-na-lista(visitados, no) then: busca-em-largura(resto, visitados)
                    | otherwise:
                        # Os vizinhos do nodo atual vão para o fim da fila
                        nova-fila = resto + vizinhos(g, no)
                        busca-em-largura(nova-fila, link(no, visitados))
                end
        end
    end

    busca-em-largura([list: origem], empty)
where:
    existe-caminho(G1, "A", "G") is true
    existe-caminho(G1, "C", "A") is false
end


# Qual é o caminho mais curto entre dois nodos em um grafo?
# Mesma busca do existe-caminho, mas a fila guarda caminhos em vez de nodos.

fun menor-caminho(g :: Grafo, origem :: String, destino :: String) -> List<String>:
    doc: "Dados um grafo, um nodo de origem e um nodo de destino, retorna o caminho mais curto (em número de arestas) do nodo origem ao nodo destino, ou lista vazia se não existe."

    fun busca-em-largura(fila :: List<List<String>>, visitados :: List<String>) -> List<String>:
        cases (List<List<String>>) fila:
            | empty => empty # Fila vazia: não existe caminho
            | link(caminho, resto) =>
                no = caminho.first # O caminho está de trás para frente: o nodo atual é o first
                ask:
                    | no == destino then: reverse(caminho) # Desvira o caminho
                    # Nodo já visitado: segue com o resto da fila
                    | esta-na-lista(visitados, no) then: busca-em-largura(resto, visitados)
                    | otherwise:
                        # Os caminhos estendidos com os vizinhos do nodo atual vão para o fim da fila
                        nova-fila = resto + estende-caminho(vizinhos(g, no), caminho)
                        busca-em-largura(nova-fila, link(no, visitados))
                end
        end
    end

    busca-em-largura([list: [list: origem]], empty)
where:
    menor-caminho(G1, "A", "G") is [list: "A", "B", "F", "G"]
    menor-caminho(G1, "C", "A") is empty
end


mapa :: Grafo = 
[list: nodo("Denver", [list: "Omaha", "Helena", "Oklahoma", "SantaFe", "KansasCity"]),
        nodo("Omaha", [list: "Denver", "KansasCity", "Chicago", "Duluth", "Helena"]),
        nodo("Helena", [list: "Denver", "Omaha", "Duluth", "Winipeg"]),
        nodo("Oklahoma", [list: "Denver", "KansasCity", "LittleRock", "SantaFe"]),
        nodo("SantaFe", [list: "Denver", "Oklahoma"]),
        nodo("KansasCity", [list: "Denver", "Omaha", "SaintLouis", "Oklahoma"]),
        nodo("Chicago", [list: "Omaha", "SaintLouis", "Pittsburgh", "Toronto", "Duluth"]),
        nodo("Duluth", [list: "Omaha", "Helena", "Winipeg", "SaultStMarie", "Toronto", "Chicago"]),
        nodo("Winipeg", [list: "Duluth", "Helena", "SaultStMarie"]),
        nodo("LittleRock", [list: "Oklahoma"  ,  "SaintLouis" ,  "Nashville"]),
        nodo("SaintLouis", [list:  "KansasCity" ,  "LittleRock" ,  "Nashville" ,  "Pittsburgh" ,  "Chicago"]),
        nodo("Pittsburgh",[list:  "Chicago" ,  "SaintLouis" ,  "Nashville" ,  "Toronto"]),
        nodo("Toronto", [list:  "Chicago" ,  "SaultStMarie" ,  "Duluth" ,  "Pittsburgh"]),
        nodo("SaultStMarie", [list:  "Toronto" ,  "Duluth" ,  "Winipeg"]),
        nodo("Nashville", [list:  "LittleRock" ,  "SaintLouis" ,  "Pittsburgh" ,  "Atlanta"]),
        nodo("Atlanta", [list:  "Nashville"])]


menor-caminho(mapa, "Denver", "Toronto")


# Gera todos os caminhos entre dois nodos em um grafo

fun gera-todos-caminhos(g :: Grafo, origem :: String, destino :: String) -> List<List<String>>:
    doc: "Dados um grafo, um nodo de origem e um nodo de destino, retorna uma lista de todos os caminhos do nodo origem ao nodo destino."

    # Aqui não dá para usar a lista de visitados: ela cortaria os outros caminhos que
    # passam pelo mesmo nodo. Para não andar em ciclos, descartamos só os caminhos que
    # repetem um nodo (o nodo atual já aparece no resto do caminho).
    fun busca-em-largura(fila :: List<List<String>>) -> List<List<String>>:
        cases (List<List<String>>) fila:
            | empty => empty # Fila vazia: não há mais caminhos
            | link(caminho, resto) =>
                no = caminho.first # O caminho está de trás para frente: o nodo atual é o first
                ask:
                    # Chegou ao destino: guarda o caminho (desvirado) e continua com o resto da fila
                    | no == destino then: link(reverse(caminho), busca-em-largura(resto))
                    # O caminho passou duas vezes pelo nodo atual (ciclo): descarta
                    | esta-na-lista(caminho.rest, no) then: busca-em-largura(resto)
                    | otherwise:
                        nova-fila = resto + estende-caminho(vizinhos(g, no), caminho)
                        busca-em-largura(nova-fila)
                end
        end
    end

    busca-em-largura([list: [list: origem]])
where:
    gera-todos-caminhos(G1, "A", "D") is [list: [list: "A", "B", "F", "D"], [list: "A", "E", "C", "D"], [list: "A", "E", "F", "D"], [list: "A", "B", "E", "C", "D"], [list: "A", "B", "E", "F", "D"]]
    gera-todos-caminhos(G1, "C", "A") is empty
end

todos-caminhos :: List<List<String>> = gera-todos-caminhos(mapa, "Chicago", "Toronto")

todos-caminhos
todos-caminhos.length()
