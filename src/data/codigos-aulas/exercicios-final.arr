use context dcic2024
# ========================================================
# TIPOS DE DADOS: FIGURINHAS, PILHAS DE FIGURINHAS E ALBUM
# ========================================================

data Id:
    idfig(
      pais:: String, # codigo de 3 letras que representa o país
      num:: Number   # número da figurinha 
      )
end

data Figurinha:
    fig(
      id:: Id,    # identificador único da figurinha
      img:: Image # imagem a ser colocada na figurinha
      )
end

type PilhaFig = List<Figurinha>

# Um álbum é definido como uma árvore de figurinhas (árvore binária d pesquisa)
data Album:
  | vazio
  | album(
      raiz:: Figurinha,  # cada nodo do álbum é uma figurinha
      esq:: Album,       # sub-arvore da esquerda, na qual todos ids são menores que o id da raiz
      dir:: Album        # sub-arvore da direita, na qual todos ids são maiores que o id da raiz
      )
end

# ========================================================
# CONSTANTES: FIGURINHAS, PILHAS DE FIGURINHAS 
# ========================================================
SELECOES = [list: "ALG", "ARG", "BRA", "CAN", "GER", "MEX", "POR", "USA"] 
MAX-SELECAO = 10
NUM-FIGS = [list: 1,2,3,4,5,6,7,8,9,10]


# Funções auxiliares para gerar constantes do tipos Figurinha e escudos:

fun figurinha(s:: String, n:: Number) -> Figurinha:
  doc: "Dados uma seleção e um número, gera uma figurinha."
  fig(idfig(s, n), escudo(s))
end

# IMG-ESCUDOS:
fun escudo(selecao :: String) -> Image:
  doc: "Dado o id de um escudo (string de 3 digitos), devolve a imagem deste escudo."
  #  url = "https://drive.google.com/file/d/1iXLuJaOtgr6vWJimAj_9h4Ldi_46b1k4/view?usp=drive_link"
  img = ask:
    |selecao == "POR" then: 
      image-url("https://code.pyret.org/shared-image-contents?sharedImageId=1Auy5_7oB6c4hGIkqf7G6bi0SOvZV2GMw")
    | selecao == "BRA" then: 
      image-url("https://code.pyret.org/shared-image-contents?sharedImageId=17LodrSSLGwZly3CFcJb0jj4vFBi7ZV4a")
    | selecao == "GER" then:
      image-url("https://code.pyret.org/shared-image-contents?sharedImageId=1ohljDWOByLpNnN_IV2JrsED5aav0gTQ1")
    | selecao == "CAN"then: 
      image-url("https://code.pyret.org/shared-image-contents?sharedImageId=15ExUKr6i-BpYVvkWZgyxP8FrHBfXOMbP")
    | selecao == "ARG"then: 
      image-url("https://code.pyret.org/shared-image-contents?sharedImageId=185xLWHpUNStiToDaERw3eaIvWsdNOtvC")
    | selecao == "ALG"then: 
      image-url("https://code.pyret.org/shared-image-contents?sharedImageId=1laeiFbNDmxTJzYQVV8H4l3wWJgbXundt")
    | selecao == "MEX"then: 
      image-url("https://code.pyret.org/shared-image-contents?sharedImageId=10zFekre1qESfGie9Gbu3ucUGbUBTBy9N")
    | selecao == "USA"then: 
      image-url("https://code.pyret.org/shared-image-contents?sharedImageId=1fr0Cw5OKr3-f7SiyaLk5zQI7_GFsHRjH")
    | otherwise: image-url("https://code.pyret.org/shared-image-contents?sharedImageId=17LodrSSLGwZly3CFcJb0jj4vFBi7ZV4a")
  end
  scale(0.10, img)
end

LARG-FIG = image-width(escudo("BRA"))
ALT-FIG = image-height(escudo("BRA"))
IMGF = rectangle(LARG-FIG, ALT-FIG, "solid", "gray")

BRA1 = figurinha("BRA", 1)
BRA2 = figurinha("BRA", 2)
BRA7 = figurinha("BRA", 7)
BRA9 = figurinha("BRA", 9)
USA5 = figurinha("USA", 5)
USA10 = figurinha("USA", 10)
MEX5 = figurinha("MEX", 5)
MEX2 = figurinha("MEX", 2)
CAN5 = figurinha("CAN", 7)
CAN2 = figurinha("CAN", 8)
POR2 = figurinha("POR", 1)
POR7 = figurinha("POR", 2)
POR9 = figurinha("POR", 7)
GER3 = figurinha("GER", 3)
GER5 = figurinha("GER", 5)
GER8 = figurinha("GER", 8)
ALG2 = figurinha("ALG", 2)
ALG6 = figurinha("ALG", 6)
ALG7 = figurinha("ALG", 7)
ARG1 = figurinha("ARG", 1)
ARG4 = figurinha("ARG", 4)
ARG10 = figurinha("ARG", 10)


# ========================================================
# FUNÇÕES AUXILIARES: MENOR E QUICKSORT GENÉRICO
# ========================================================


fun menor(f1:: Figurinha, f2:: Figurinha) -> Boolean:
  doc:"Dadas duas figurinhas, diz se o id da primeira é menor que o da segunda, considerando a ordem lexicográfica."
  if f1.id.pais == f2.id.pais:
    (f1.id.num < f2.id.num)
  else: (f1.id.pais < f2.id.pais)
  end
end
# tipo de recursão: não é recursiva
# terminação: trivial, pois não há recursão e todas funções usadas terminam


fun quicksort(comp:: (Any, Any -> Boolean), l:: List<Any>) -> List<Any>:
  doc: "Dadas uma função de comparação de elementos de algum tipo e uma lista de elementos deste tipo, devolve a lista ordenada segundo o critério de comparação."
  cases (List<Any>) l:
    | empty => empty
    | link(prim, resto) =>
      quicksort(comp, filter(lam(f): comp(f, prim) end, resto))
      + [list: prim] +
      quicksort(comp, filter(lam(f): not(comp(f, prim)) end, resto))
  end
where:
  quicksort(lam(a,b): a < b end, [list: 4, 5, 2, 8, 1]) is [list: 1, 2, 4, 5, 8]
  quicksort(menor, [list: POR7, ALG2, BRA1, GER8, MEX2]) is [list: ALG2, BRA1, GER8, MEX2, POR7]
end
# tipo de recursão: generativa
# terminação:
#  (1) existe um caso trivial, que é quando a lista está vazia, e neste caso não há chamada recursiva
#  (2) cada chamada recursiva é realizada sobre uma lista que é obtida filtrando o resto da lista original e, portanto, é uma lista estritamente menor, se aproximando do caso trivial
#  (3) todas as funções auxiliares terminam (assumindo que a função recebida como argumento termina)

# ===================================================================
# FUNÇÕES PARA RELACIONAR ALBUNS E LISTAS DE FIGURINHAS
# ===================================================================


fun coloca-fig-album(f:: Figurinha, alb:: Album)-> Album:
  doc: "Dada uma figurinha e um album, coloca a figurinha no local correto do album. Assume que a figurinha não está no álbum."
  cases (Album) alb:
      # se o álbum está vazio, gera um álbum somente com a figurinha dada
    | vazio => album(f, vazio, vazio)
      # senão
    | album(r, esq, dir) =>
      # se o id de f é menor do que a raiz do álbum , coloca f na subárvore da esquerda
      if menor(f, r): album(r, coloca-fig-album(f, esq), dir)
      # senão, coloca f na subárvore da direita
      else: album(r, esq, coloca-fig-album(f, dir))
      end
  end
end
# tipo de recursão: estrutural
# terminação: trivial, pois é recursão estrutural e as funções auxiliares terminam

fun monta-album(lf:: List<Figurinha>) -> Album:
  doc:"Dada uma lista de figurinhas, monta um album."
  cases (List<Figurinha>) lf:
      # se a lista de figurinhas está vazia, devolve o álbum vazio
    | empty => vazio
      # senão coloca a primeira figurinha no álbum construído com o resto das figurinhas
    | link(f,r) => coloca-fig-album(f, monta-album(r))
  end
end
# tipo de recursão: estrutural
# terminação: trivial, pois é recursão estrutural e as funções auxiliares terminam

fun lista-fig(alb:: Album) -> List<Figurinha>:
  doc:"Dado um album, devolve a lista de figurinhas contidas neste album, ordenada."
  cases (Album) alb:
      # se o álbum está vazio, devolve a lista vazia
    | vazio => empty
      # senão
    | album(r, esq, dir) =>
      #junta a lista de figurinhas da esquerda da raiz, a raiz e a lista de figurinhas da direita da raiz
      lista-fig(esq) + [list: r] + lista-fig(dir)
  end
where: 
  lista-fig(monta-album([list: ARG10, ARG1, BRA7, POR2, BRA1, GER3])) is 
  [list: ARG1, ARG10, BRA1, BRA7, GER3, POR2]
end 
# tipo de recursão: estrutural
# terminação: trivial, pois é recursão estrutural e as funções auxiliares terminam

# ===================================================================
# FUNÇÕES PARA ENCONTRAR LISTAS DE FIGURINHAS QUE FALTAM
# ===================================================================

fun lista-figurinhas-faltantes(a:: Album) -> List<Id>:
  doc: "Dado um album de figurinhas, devolve a lista de identificadores das figurinhas que faltam."
  # descobre as faltantes na lista de figurinhas gerada pelo album a:
  lista-faltantes(lista-fig(a), SELECOES)
end
# tipo de recursão: não é recursiva
# terminação: trivial, pois não há recursão e as funções auxiliares terminam
  
fun lista-faltantes(lf:: List<Figurinha>, ls:: List<String>) -> List<Id>:
  doc: "Dada uma lista de figurinhas de um album, ordenada, e a lista de seleções, devolve a lista de identificadores das figurinhas que faltam." 

  cases (List<String>) ls:
    | empty => empty
    | link(prim-sel, resto-sel) =>
      # juntar as seguintes listas:
      append(
        # a lista com os ids faltantes da seleção do prim-fig:
        monta-lista-faltantes-selecao(prim-sel, filter(lam(f): f.id.pais == prim-sel end, lf)),
        # a lista com os ids faltantes das outras selecoes:
        lista-faltantes(lf, resto-sel))
  end
end
# tipo de recursão: estrutural
# terminação: trivial, pois é recursão estrutural e as funções auxiliares terminam

fun monta-lista-faltantes-selecao(s:: String,  lf:: List<Figurinha>) -> List<Id>:
  doc: "Dados o nome de uma seleção e a lista de figurinhas de uma seleção, devolve a lista de ids de figurinhas faltantes desta seleção."
  nums-selecao = map(_.num, map(_.id, lf))
  nums-faltantes = filter(lam(elem): not(member(nums-selecao,elem)) end, NUM-FIGS)  
  #map(lam(ns:: String): string-append(s, ns) end, map(num-to-string, nums-faltantes))
  map(lam(n:: Number): idfig(s, n) end, nums-faltantes)
end
# tipo de recursão: não é recursiva
# terminação: trivial, pois não há recursão e as funções auxiliares terminam

# ===================================================================
# FUNÇÕES PARA DESENHAR FIGURINHAS E ÁLBUNS
# ===================================================================

fun desenha-fig(f:: Figurinha) -> Image:
  doc: "Dada uma figuinha, gera uma imagem desta figurinha"
  frame(above(
      f.img,
      text(f.id.pais + " " + num-to-string(f.id.num), 20, "black")
      ))
end
# tipo de recursão: não é recursiva
# terminação: trivial, pois não há recursão e as funções auxiliares terminam


fun desenha-selecao(s:: String, lf:: List<Figurinha>) -> Image:
    doc: "Dada uma lista de figurinhas de uma seleção, gera uma imagem com essas figurinhas, colocando figurinhas vazias marcando as figurinhas faltantes."
  # lista de numeros das figurinhas de lf:
  lista-num-figs = map(_.num, map(_.id, lf))
  # lista de numeros de figurinhas que não estão em lf:
  lista-num-faltantes = filter(lam(n): not(member(lista-num-figs, n)) end, NUM-FIGS)
  # figurinhas que não estão em lf (com imagens de figs faltantes):
  lista-figs-faltantes = map(lam(n):fig(idfig(s, n), IMGF) end, lista-num-faltantes)
  # lista de figurinhas da selecao, ordenada:
  lista-figs = quicksort(menor, lf + lista-figs-faltantes)
  
  # devolve imagem das figurinhas desta seleção:
  beside(
    escudo(s),
    fold(beside, empty-image, map(desenha-fig, lista-figs)))
end
# tipo de recursão: não é recursiva
# terminação: trivial, pois não há recursão e as funções auxiliares terminam


fun seleciona-selecao(s:: String, lf:: List<Figurinha>) -> List<Figurinha>:
  doc: "Dados um nome de seleção e uma lista de figurinhas, devolve as figurinhas desta seleção"
  filter(lam(f:: Figurinha): f.id.pais == s end, lf)
end
# tipo de recursão: não é recursiva
# terminação: trivial, pois não há recursão e as funções auxiliares terminam


fun gera-album(a:: Album) -> Image:
  doc: "Dado um album, gera a imagem das figurinhas do album"
  lista-figurinhas = lista-fig(a)
  # gera uma lista com as imagens das selecoes de cada pais:
  img-selecoes = map(lam(s):desenha-selecao(s,seleciona-selecao(s,lista-figurinhas)) end, SELECOES)
  # e junta todas essas imagens de seleções, uma acima da outra:
  fold(above, empty-image, img-selecoes)
end
# tipo de recursão: não é recursiva
# terminação: trivial, pois não há recursão e as funções auxiliares terminam


# Exemplo de lista de figurinhas e álbum:
FIGS = [list: BRA1, BRA2, BRA7, BRA9, USA5, USA10, MEX5, MEX2, CAN5, CAN2, POR2, POR7, POR9, GER3, GER5, GER8, ALG2, ALG6, ALG7, ARG1, ARG4, ARG10]

A = monta-album(FIGS)
gera-album(A)

# =========================
# REDE DE COLECIONADORES:
# ========================

data Colecionador:
    colecionador(
      nome:: String,        # nome do colecionador
      repetidas:: List<Id>, # lista de figurinhas repetidas do colecionador
      album:: Album,        # álbum do cokecionador
      amigos:: List<String>)# lista de nomes de amigos do colecionador
end
    
# A Rede de Trocas é um grafo de colecionadores.
type RedeTrocas = List<Colecionador>


# =========================
# CONSTANTES :
# ========================
A1 = monta-album([list: ALG6, BRA1, BRA2, POR7, CAN5, POR9, ALG7, ARG10, GER3, GER5])
A2 = monta-album([list: BRA1,MEX5,  USA5,  MEX2, MEX5, CAN2])
A3 = monta-album([list: ARG1, ALG2,  ALG6,  GER8, POR9, BRA7, MEX2])
A4 = monta-album([list: BRA2,BRA7,  USA10,  CAN5, POR9, GER5, ALG6, ARG4])

LEILA = colecionador("Leila", [list: idfig("ALG", 2), idfig("BRA",2), idfig("BRA", 2), idfig("POR", 7)], A1, 
  [list: "Lucas", "Lucio"])
LUCAS = colecionador("Lucas", [list: idfig("BRA",1), idfig("MEX", 10), idfig("USA", 5), idfig("CAN", 2)], A2, 
  [list: "Leila", "Lucio", "Pedro"])
PEDRO = colecionador("Pedro", [list: idfig("ARG",1), idfig("ALG",2), idfig("GER", 8), idfig("POR", 8)], A3, 
  [list: "Lucas"])
LUCIO = colecionador("Lucio", [list:  idfig("BRA", 2), idfig("CAN", 5), idfig("POR", 9)], A4, 
  [list: "Lucas", "Leila"])

REDE = [list: LEILA, LUCAS, LUCIO, PEDRO]

# ====================================================================
# FUNÇÕES QUE ENCONTRAM AS FIGURINHAS QUE FALTAM EM UMA REDE DE TROCAS:
# ====================================================================

fun amigos(nc:: String, r:: RedeTrocas) -> List<String>:
  doc: "Dados um nome de colecionador e a sua rede de trocas, devolve os nomes dos amigos diretos deste colecionador" 
  cases (RedeTrocas) r:
      # Se não há colecionador com este nome, devolve uma lista vazia de amigos
    | empty => empty 
      #  senão, 
    | link(primeiro-colecionador, resto) =>
      #se há o nome do primeiro colecionador é o procurado,  devolve os amigos deste colecionador:
      if primeiro-colecionador.nome == nc: primeiro-colecionador.amigos
      # caso contrário, devolve os amigos deste colecionador no resto da rede de trocas:
      else: amigos(nc, resto)
      end
  end
where:
  amigos("Lucas", REDE) is [list: "Leila", "Lucio", "Pedro"]
end
# tipo de recursão: estrutural
# terminação: trivial, pois é recursão estrutural e as funções auxiliares terminam


fun encontra-faltantes(c:: Colecionador, rede:: RedeTrocas) -> List<String>:
  doc: "Dado um colecionador e sua rede de trocas, devolve uma lista de strings, onde cada string é um caminho até cada figurinha faltante que ele conseguiria em sua rede de trocas, ou a string vazia, caso essa figurinha não exista na rede."
  faltam = lista-figurinhas-faltantes(c.album)
  encontra-faltantes-rede(c.nome, faltam, rede)  
end


fun encontra-faltantes-rede(nome:: String, idfigs:: List<Id>,  r:: RedeTrocas) -> List<String>:
  doc: "Dados um nome de colecionador, uma lista de ids de figurinhas faltantes e uma rede de trocas, devolve os caminhos até as figurinhas faltantes que podem ser achadas nessa rede."
  cases (List<Id>) idfigs:
      # se a lista de ids está vazia, devolve a lista de strings vazia
    | empty => empty
      # se há uma figurinha a ser procurada, 
    | link(prim-fig, resto-fig) =>
      # constrói o rótulo para a linha desta figurinha na saída:
      rotulo-fig = prim-fig.pais + " " + num-to-string(prim-fig.num) + ": "
      # encontra um caminho até a figurinha (será vazio, se não houver caminho):
      caminho-fig = encontra-faltante-amigos(prim-fig, amigos(nome,r), [list: nome], r) 
      # monta a string juntando o rótulo ao caminho:
      result-prim-fig = rotulo-fig + caminho-fig + "\n"
      # e finalmente constrói a lista com esta string e com as strings obtidas para cada uma das figurinhas do resto da lista:
      link(
        result-prim-fig, 
        encontra-faltantes-rede(nome, resto-fig, r))
  end
end
# tipo de recursão: estrutural
# terminação: trivial, pois é recursão estrutural e as funções auxiliares terminam


fun encontra-faltante-amigos(fid:: Id, lista-amigos:: List<String>, nomes-considerados:: List<String>, rede:: RedeTrocas) -> String :
  doc: "Dados o id de uma figurinha a conseguir,  uma lista de amigos, uma lista de amigos cujas repetidas já foram considerados, e uma rede de trocas, devolve o caminho (string) de amigos até chegar a esta figurinha, partindo de um dos amigos da lista. Se não houver caminhom devolve a string vazia."
  cases (List<String>) lista-amigos:
      # se a lista de amigos para trocar for vazia, devolve a string vazia ( a figurinha não foi encontrada:
    | empty => ""
      # se há algum amigo para trocar:
    | link(prim-amigo, resto-amigos) =>
        ask:
          # se este amigo já foi considerado, verifica se a figurinha pode ser encontrada por algum outro caminho (no resto dos amigos):
        | member(nomes-considerados, prim-amigo) then: encontra-faltante-amigos(fid, resto-amigos, nomes-considerados, rede)
          # se a figurinha estiver na lista de repetidas deste primeiro amigo, devolve o nome deste amigo
        | member(repetidas-amigo(prim-amigo, rede), fid) then: prim-amigo
        |otherwise:
          # encontra um camino até a figurinha procurada no resto dos amigos (se houver):       
          encontra-no-resto = encontra-faltante-amigos(fid, resto-amigos, nomes-considerados, rede)
          # se fid for encontrada no resto da lista (a string não é vazia), devolver esse caminho:
          if not(encontra-no-resto == ""):
            encontra-no-resto
            # senão devolver o caminho a partir do primeiro da lista (qq que seja):
          else: encontra-no-prim = encontra-faltante-amigos(fid, amigos(prim-amigo,rede), link(prim-amigo, nomes-considerados), rede)
            if not(encontra-no-prim == ""):
              prim-amigo + " -> " + encontra-no-prim
            else: ""
          end
        end
      end
    end
where:
  encontra-faltante-amigos(idfig("BRA", 2), [list: "Leila", "Lucas"], empty, REDE) is "Leila"
      encontra-faltante-amigos(idfig("ARG", 1), [list: "Leila", "Lucas"], empty, REDE)  is "Lucas -> Pedro"
end
# tipo de recursão: generativa (pois a segunda chamada da função não é sobre o resto da lista de amigos)
# terminação: 
#  (1) existe um caso trivial, que é quando a lista de amigos está vazia, e neste caso não há chamada recursiva
#  (2) cada chamada recursiva é realizada sobre ou sobre o resto da lista (que é uma lista estritamente menor e portanto se aproxima do caso trivial) ou sobre uma lista que representa os amigos do primeiro amigo considerado. Essa lista de amigos não necessariamente é menor que a lista original. Porém, o primeiro argumento desta chamada recursiva garante que a lista de amigos considerados será maior (porque o primeiro amigo é incluído), fazendo com que seja mais provável que o primeiro caso do bloco ask seja verdadeiro (como há um número finito de amigos, se a cada passo um novo amigo for incluído na lista de amigos a considerar, em algum momento essa condição será verdadeira). A consequência dessa condição ser verdadeira é uma chamada recursiva da função com o resto da lista de amigos, que claramente se aproxima do caso trivial.
#  (3) todas as funções auxiliares terminam 

 
fun repetidas-amigo(nome:: String, rede:: RedeTrocas) -> List<Id>:
doc: "dado um nome e uma rede de trocas, devolve os ids das figurinhas repetidas deste colecionador. Deve haver um colecionador com este nome na rede."
  cases (RedeTrocas) rede:
      # se a rede está vaziaq, devolve uma lista vazia de amigos
    | empty => empty 
      # senão
    | link(primeiro-colecionador, resto) => 
      # se há colecionador com esse nome, devolve as repetidas deste colecionador:
      if primeiro-colecionador.nome == nome: primeiro-colecionador.repetidas
      # caso contrário, devolve as repetidas do colecionador no resto da rede:
      else: repetidas-amigo(nome, resto)
      end
  end
where:  
  repetidas-amigo("Lucas", REDE) is [list: idfig("BRA", 1), idfig("MEX", 10), idfig("USA", 5), idfig("CAN", 2)]
end
# tipo de recursão: estrutural
# terminação: trivial, pois é recursão estrutural e as funções auxiliares terminam


print(fold(string-append, "", encontra-faltantes(LEILA, REDE)))

#desenha-fig(FIG1)

#BRA = seleciona-selecao("BRA", lista-fig(A))

#desenha-selecao("BRA", BRA)

#define-figurinhas-faltantes(A)   

#gera-album(A)
