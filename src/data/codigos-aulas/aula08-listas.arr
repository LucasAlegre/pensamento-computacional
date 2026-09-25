use context dcic2024

include csv
include data-source
import math as M
import statistics as S


ssid = "1Ks4ll5_8wyYK1zyXMm_21KORhagSMZ59dcr7i3qY6T4"

url = "https://raw.githubusercontent.com/data-centric-computing/dcic-public/main/materials/datasets/events-f25.csv"

EVENT-DATA :: Table =
 load-table: name, email, tickcount, discount, delivery, zip
    source: csv-table-url(url, default-options)
    sanitize name using string-sanitizer
    sanitize email using string-sanitizer
    sanitize tickcount using num-sanitizer
    sanitize discount using string-sanitizer
    sanitize delivery using string-sanitizer
    sanitize zip using string-sanitizer
  end

EVENT-DATA

# Extraindo colunas

TICKCOUNTS :: List<Number> = EVENT-DATA.get-column("tickcount")

[list: 2, 1, 5, 0, 3, 10, 3]


M.max(TICKCOUNTS)     # largest number in a list
M.sum(TICKCOUNTS)     # sum of numbers in a list
S.mean(TICKCOUNTS)    # mean (average) of numbers in a list
S.median(TICKCOUNTS)  # median of numbers in a list


fun is-pickup(row :: Row) -> Boolean:
  doc: "Dado uma linha, retorna true se o valor na coluna delivery for pickup, e false caso contrário."
  row["delivery"] == "pickup"
end

fun nomes-retirar-ingresso(table :: Table) -> List<String>:
  doc: "Dado uma tabela, retorna o nome das pessoas que vão retirar os seus ingressos no dia do evento. Isto é, cujo valor na coluna delivery é pickup."
  tabela-filtrada = filter-with(table, is-pickup)

  tabela-filtrada.get-column("name")
where:
  nomes-retirar-ingresso(EVENT-DATA) is [list: "Sam Ochibe", "Shweta Chowpatti"]
end

nomes-retirar-ingresso(EVENT-DATA)


# Listas

data NumList:
    | nl-empty  # lista vazia
    | nl-link(first :: Number, rest :: NumList)  
    # first é o primeiro número da lista, rest é o restante da lista
end


nl-empty
nl-link(3, nl-empty)
nl-link(7, nl-link(3, nl-empty))
nl-link(2, nl-link(7, nl-link(3, nl-empty)))


l1 :: List<String> = [list: "a", "b", "c"]
l2 :: List<Number> = [list: 1, 2, 3, 4, 5]
l3 :: List<Boolean> = [list: true, false, true]

check:
    empty is [list: ]
    link(1, link(2, link(3, empty))) is [list: 1, 2, 3]
    link("a", link("b", link("c", empty))) is [list: "a", "b", "c"]
end

nl-link(1,
  nl-link(2,
    nl-link(3,
      nl-link(4,
        nl-link(5,
          nl-link(6,
            nl-link(7,
              nl-link(8,
                nl-empty))))))))


fun contem-7(nl :: NumList) -> Boolean:
  doc: "Dado uma lista de números, retorna true se ela contém o número 7, e false caso contrário."
  cases (NumList) nl:
    # Se a lista for vazia, ela não contém o número 7
    | nl-empty => false
    # Se a lista não for vazia:
    | nl-link(first, rest) =>
        # Se o primeiro número da lista for 7, então a retorna true
        if first == 7: 
            true
        # Se não, verificar se o resto da lista contem o número 7
        else: 
            contem-7(rest)
        end
  end
where:
  contem-7(nl-empty) is false
  contem-7(nl-link(1, nl-link(2, nl-link(3, nl-empty)))) is false
  contem-7(nl-link(1, nl-link(7, nl-empty))) is true
end

fun contem-7-v2(nl :: NumList) -> Boolean:
  doc: "Dado uma lista de números, retorna true se ela contém o número 7, e false caso contrário."
  ask:
    # Se a lista for vazia, ela não contém o número 7
    | is-nl-empty(nl) then: false
    # Se a lista não for vazia:
    | is-nl-link(nl) then:
        # Se o primeiro número da lista for 7, então a retorna true
        if nl.first == 7: 
            true
        # Se não, verificar se o resto da lista contem o número 7
        else: 
            contem-7-v2(nl.rest)
        end
  end
where:
  contem-7-v2(nl-empty) is false
  contem-7-v2(nl-link(1, nl-link(2, nl-link(3, nl-empty)))) is false
  contem-7-v2(nl-link(1, nl-link(7, nl-empty))) is true
end
