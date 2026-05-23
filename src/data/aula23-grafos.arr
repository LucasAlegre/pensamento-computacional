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

G :: Grafo = [list:
                nodo("A", [list: "B", "C"]),
                nodo("B", [list: "A", "C"]),
                nodo("C", [list: "B", "D"]),
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
    doc: "Dada uma lista de vizinhos e um caminho, retorna uma lista de caminhos estendendo o caminho com cada vizinhos sendo colocado na primeira posição do caminho."
    cases (List<String>) viz:
        | empty => empty
        | link(f, r) =>
            # Cria um novo caminho estendendo o caminho atual com o vizinho f
            novo-caminho = link(f, caminho)

            # Gera lista de caminhos com o caminho gerado, e os caminhos gerados com o resto dos vizinhos
            link(novo-caminho, estende-caminho(r, caminho))
    end
where:
    estende-caminho([list: "B", "C"], [list: "A", "D"]) is [list: [list: "B", "A", "D"], [list: "C", "A", "D"]]
    estende-caminho(empty, [list: "A", "D"]) is empty
end


# Existe um caminho entre dois nodos em um grafo?

fun existe-caminho(g :: Grafo, origem :: String, destino :: String) -> Boolean:
    doc: "Dados um grafo, um nodo de origem e um nodo de destino, determina se existe um caminho do nodo origem ao nodo destino."

    fun existe-caminho-busca-em-largura(fila :: List<String>, visitados :: List<String>) -> Boolean:
        doc: "Função auxiliar para realizar a busca em largura. Recebe o grafo, a origem, o destino, uma fila de nodos a explorar e uma lista de nodos visitados. Retorna true se existe um caminho do nodo origem ao nodo destino, ou false caso contrário."
        cases (List<String>) fila:
            | empty => false # Se fila vazia, não existe caminho
            | link(first, rest) =>   
                ask:
                    # Se o nó atual é o destino, retorna true
                    | first == destino then: true
                    # Se o nó atual já foi visitado, procura no resto da fila
                    | esta-na-lista(visitados, first) then: existe-caminho-busca-em-largura(rest, visitados)
                    | otherwise:
                        novos-visitados = link(first, visitados) # Adiciona o nó atual à lista de visitados
                        nova-fila = rest + vizinhos(g, first)

                        existe-caminho-busca-em-largura(nova-fila, novos-visitados)
                end
        end
    end

    fila = [list: origem] 
    existe-caminho-busca-em-largura(fila, empty)
where:
    existe-caminho(G1, "A", "G") is true
    existe-caminho(G1, "C", "A") is false
end


# Qual é o caminho mais curto entre dois nodos em um grafo?

fun menor-caminho(g :: Grafo, origem :: String, destino :: String) -> List<String>:
    doc: "Dados um grafo, um nodo de origem e um nodo de destino, retorna o caminho mais curto (em número de arestas) do nodo origem ao nodo destino, ou lista vazia se não existe."
    # fila de caminhos a explorar, iniciando com o caminho que contém apenas a origem
    fila = [list: [list: origem]] 

    busca-em-largura(g, origem, destino, fila, empty)
where:
    menor-caminho(G1, "A", "G") is [list: "A", "B", "F", "G"]
    menor-caminho(G1, "C", "A") is empty
end


fun busca-em-largura(g :: Grafo, origem :: String, destino :: String, fila :: List<List<String>>, visitados :: List<String>) -> List<String>:
    doc: "Função auxiliar para realizar a busca em largura. Recebe o grafo, a origem, o destino, uma fila de caminhos a explorar e uma lista de nodos visitados. Retorna o caminho do nodo origem ao nodo destino ou lista vazia se não existe."
    cases (List<List<String>>) fila:
        | empty => empty # Se fila vazia, não existe caminho
        | link(first :: List<String>, rest :: List<List<String>>) =>   
            no = first.first # O nó atual é o primeiro elemento do caminho no início da fila
            ask:
                | no == destino then: reverse(first)   # Se o nó atual é o destino, retorna o caminho (invertido para a ordem correta)
                | esta-na-lista(visitados, no) then: busca-em-largura(g, origem, destino, rest, visitados) # Se o nó atual já foi visitado, descarta caminho e procura no resto da fila
                | otherwise:
                    novos-visitados = link(no, visitados)
                    novos-caminhos = estende-caminho(vizinhos(g, no), first)
                    nova-fila = rest + novos-caminhos

                    busca-em-largura(g, origem, destino, nova-fila, novos-visitados)
            end
    end
where:
    busca-em-largura(G1, "A", "D", [list: [list: "A"]], empty) is [list: "A", "B", "F", "D"]
    busca-em-largura(G1, "C", "A", empty, empty) is empty
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

    fun gera-todos-caminhos-busca-em-largura(fila :: List<List<String>>) -> List<List<String>>:
        cases (List<List<String>>) fila:
            | empty => empty # Se fila vazia, retorna lista vazia
            | link(first :: List<String>, rest :: List<List<String>>) =>  
                no = first.first # O nó atual é o primeiro elemento do caminho no início da fila
                resto-do-caminho = first.rest # O resto do caminho é o caminho sem o nó atual
                ask:
                    # Se o nó atual é o destino, adiciona caminho (invertido para a ordem correta) à lista de caminhos encontrados no resto da fila
                    | no == destino then: link(reverse(first), gera-todos-caminhos-busca-em-largura(rest))
                    # Se o nó atual já está no caminho (gerou ciclo), descarta caminho e procura no resto da fila
                    | esta-na-lista(resto-do-caminho, no) then: 
                        gera-todos-caminhos-busca-em-largura(rest) 
                    | otherwise:
                        # Estende caminho atual com os vizinhos do nó atual e adiciona os novos caminhos à fila para exploração
                        novos-caminhos = estende-caminho(vizinhos(g, no), first)
                        nova-fila = rest + novos-caminhos

                        gera-todos-caminhos-busca-em-largura(nova-fila)
                end
        end
    end

    fila = [list: [list: origem]] 
    gera-todos-caminhos-busca-em-largura(fila)
where:
    gera-todos-caminhos(G1, "A", "D") is [list: [list: "A", "B", "F", "D"], [list: "A", "E", "C", "D"], [list: "A", "E", "F", "D"], [list: "A", "B", "E", "C", "D"], [list: "A", "B", "E", "F", "D"]]
    gera-todos-caminhos(G1, "C", "A") is empty
end

todos-caminhos :: List<List<String>> = gera-todos-caminhos(mapa, "Chicago", "Toronto")

todos-caminhos
todos-caminhos.length()
