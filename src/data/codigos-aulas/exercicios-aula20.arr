use context starter2024

# INF05008 — Pensamento Computacional
# Aula 20: Árvores Binárias e de Pesquisa
# Exercícios

# =============================================================================
# DEFINIÇÕES DE TIPOS (não modifique)
# =============================================================================

data Pessoa:
  | ninguem
  | pessoa(
      nome      :: String,
      ano       :: Number,
      tipo-sang :: String,
      pai       :: Pessoa,
      mae       :: Pessoa
    )
end

data AB:
  | vazia
  | no(
      id       :: Number,
      conteudo :: String,
      esq      :: AB,
      dir      :: AB
    )
end

data Par:
  | par(id :: Number, cont :: String)
end

# =============================================================================
# EXEMPLOS (não modifique)
# =============================================================================

CARLOS  = pessoa("Carlos",  1926, "A", ninguem, ninguem)
BETINA  = pessoa("Betina",  1927, "B", ninguem, ninguem)
EVA     = pessoa("Eva",     1960, "O", CARLOS,  BETINA)
FRED    = pessoa("Fred",    1958, "A", ninguem, ninguem)
GUSTAVO = pessoa("Gustavo", 1988, "A", FRED,    EVA)

#         10(A)
#        /     \
#      12(B)   3(C)
#              /   \
#           15(D)  20(E)
#           /
#          1(F)
AB1 = no(10, "A",
       no(12, "B", vazia, vazia),
       no(3,  "C",
         no(15, "D",
           no(1, "F", vazia, vazia),
           vazia),
         no(20, "E", vazia, vazia)))

#         10(A)
#        /     \
#      3(B)   17(C)
#             /   \
#           15(D) 20(E)
#           /
#         11(F)
ABP1 = no(10, "A",
         no(3, "B", vazia, vazia),
         no(17, "C",
           no(15, "D",
             no(11, "F", vazia, vazia),
             vazia),
           no(20, "E", vazia, vazia)))

# =============================================================================
# EXERCÍCIO 1 — Contar ancestrais
# =============================================================================
#
# Complete as lacunas (___) para que as funções funcionem corretamente.
#
# Estratégia:
#   conta-com-pessoa:
#     Trivial: se p é `ninguem`, não há ninguém para contar → retorne ___
#     Difícil: se p é uma pessoa, conte ela (1) mais os ancestrais do pai e da mãe
#
#   conta-ancestrais:
#     Conta somente os ancestrais, sem incluir a própria pessoa.
#     Dica: pense em como reutilizar conta-com-pessoa.

fun conta-com-pessoa(p :: Pessoa) -> Number:
  doc: "Conta p e todos os seus ancestrais conhecidos."
  cases (Pessoa) p:
    # Caso base:
    | ninguem => 0
    | pessoa(nome, ano, tipo, pai, mae) =>
        1 + 
        conta-com-pessoa(pai) + 
        conta-com-pessoa(mae)
  end
where:
  conta-com-pessoa(ninguem)  is 0
  conta-com-pessoa(CARLOS)   is 1
  conta-com-pessoa(EVA)      is 3   # Eva + Carlos + Betina
  conta-com-pessoa(GUSTAVO)  is 5   # Gustavo + Fred + Eva + Carlos + Betina
end

fun conta-ancestrais2(p :: Pessoa) -> Number:
  doc: "Conta somente os ancestrais conhecidos de p (não conta p)."
  cases (Pessoa) p:
    | ninguem => 0
    | pessoa(nome, ano, tipo, pai, mae) =>
        conta-com-pessoa(mae) + conta-com-pessoa(pai)
  end
where:
  conta-ancestrais2(ninguem)  is 0
  conta-ancestrais2(CARLOS)   is 0
  conta-ancestrais2(EVA)      is 2   # Carlos + Betina
  conta-ancestrais2(GUSTAVO)  is 4   # Fred + Eva + Carlos + Betina
end

fun conta-ancestrais(p :: Pessoa) -> Number:
  doc: "Conta somente os ancestrais conhecidos de p (não conta p)."
  cases (Pessoa) p:
    | ninguem => 0
    | pessoa(nome, ano, tipo, pai, mae) =>
        (conta-ancestrais(pai) +
        if is-ninguem(pai): 0 else: 1 end)
         +
        (conta-ancestrais(mae) + 
        if is-ninguem(mae): 0 else: 1 end)
  end
where:
  conta-ancestrais(ninguem)  is 0
  conta-ancestrais(CARLOS)   is 0
  conta-ancestrais(EVA)      is 2   # Carlos + Betina
  conta-ancestrais(GUSTAVO)  is 4   # Fred + Eva + Carlos + Betina
end

# =============================================================================
# EXERCÍCIO 2 — Lista de ids de uma árvore binária
# =============================================================================
#
# Complete as lacunas para que a função retorne a lista de todos os ids.
#
# Estratégia:
#   Trivial: árvore vazia → lista ___
#   Difícil: árvore com nó → combine o id da raiz com os ids das sub-árvores.
#            Use `link(valor, lista)` e `+` para concatenar listas.

fun ids-arvore(ab :: AB) -> List<Number>:
  doc: "Retorna a lista dos ids de todos os nós da árvore binária."
  cases (AB) ab:
    | vazia => empty
    | no(id, conteudo, esq, dir) =>
        link(
            id, 
            ids-arvore(esq) +
            ids-arvore(dir))
  end
where:
  ids-arvore(vazia) is empty
  ids-arvore(no(5, "x", vazia, vazia)) is [list: 5]
  # AB1 tem ids 10, 12, 3, 15, 1, 20 — em ordem pré-fixada:
  ids-arvore(AB1) is [list: 10, 12, 3, 15, 1, 20]
end

# =============================================================================
# EXERCÍCIO 3 — Busca em Árvore Binária de Pesquisa
# =============================================================================
#
# Complete as lacunas para implementar a busca eficiente em uma ABP.
#
# Estratégia (use a invariante: esq < raiz < dir):
#   Trivial 1: árvore vazia       → retorne "Nó não encontrado"
#   Trivial 2: id == id da raiz   → retorne o ___ da raiz
#   Difícil:   id > id da raiz    → busque na sub-árvore ___
#              id < id da raiz    → busque na sub-árvore ___

fun busca-abp(id :: Number, abp :: AB) -> String:
  doc: "Retorna o conteudo do no com id em abp, ou 'No nao encontrado'."
  cases (AB) abp:
    | vazia => "Nó não encontrado"
    | no(r-id, r-c, esq, dir) =>
        if id == r-id:
          r-c
        else if id > r-id:
          busca-abp(id, dir)
        else:
          busca-abp(id, esq)
        end
  end
where:
  busca-abp(10, ABP1) is "A"
  busca-abp(3,  ABP1) is "B"
  busca-abp(15, ABP1) is "D"
  busca-abp(11, ABP1) is "F"
  busca-abp(99, ABP1) is "Nó não encontrado"
  busca-abp(5,  vazia) is "Nó não encontrado"
end
