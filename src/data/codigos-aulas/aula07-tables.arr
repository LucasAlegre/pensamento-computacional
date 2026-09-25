use context dcic2024


include csv
include data-source

import math as M
import statistics as S
import lists as L


# Criando tabelas

table: name :: String, age :: Number
  row: "Alicia", 30
  row: "Meihui", 40
  row: "Jamal", 25
end

check:
  table: name, age
    row: "Alicia", 30
    row: "Meihui", 40
    row: "Jamal", 25
  end
  is-not
  table: age, name
    row: 30, "Alicia"
    row: 40, "Meihui"
    row: 25, "Jamal"
  end
end

people = table: name, age
  row: "Alicia", 30
  row: "Meihui", 40
  row: "Jamal", 25
end


# Extraindo linhas e células

shuttle :: Table = table: month, riders
  row: "Jan", 1123
  row: "Feb", 1045
  row: "Mar", 1087
  row: "Apr", 999
end

shuttle.row-n(2)


shuttle.row-n(2)["riders"]

march-row = shuttle.row-n(2)
march-row["riders"]
shuttle.row-n(2)["riders"] >= 1000

# Funções sobre linhas

fun cleared-1K(r :: Row) -> Boolean:
  doc: "determine whether given row has at least 1000 riders"
  r["riders"] >= 1000
where:
  cleared-1K(shuttle.row-n(2)) is true
  cleared-1K(shuttle.row-n(3)) is false
end

fun is-summer(r :: Row) -> Boolean:
  doc: "determine whether given row is in summer months"
  month = r["month"]
  (month == "Jan") or (month == "Feb") or (month == "Mar")
where:
  is-summer(shuttle.row-n(0)) is true
  is-summer(shuttle.row-n(3)) is false
end

# Encontrando linhas

#|
ask:
| shuttle.row-n(0)["riders"] < 1000 then: shuttle.row-n(0)
| shuttle.row-n(1)["riders"] < 1000 then: shuttle.row-n(1)
| shuttle.row-n(2)["riders"] < 1000 then: shuttle.row-n(2)
| otherwise: # ...
end
|#
   
#|
if shuttle.row-n(0)["riders"] < 1000:
  shuttle.row-n(0)
else if shuttle.row-n(1)["riders"] < 1000:
  shuttle.row-n(1)
else if shuttle.row-n(2)["riders"] < 1000:
  shuttle.row-n(2)
else if shuttle.row-n(3)["riders"] < 1000:
  shuttle.row-n(3)
else: ... # not clear what to do here
end
|#

filter-with(shuttle, is-summer)

# Ordenando linhas

order-by(shuttle, "riders", true)

fun month-with-least-drivers(t :: Table) -> String:
  doc: "return the row with the least riders"
  order-by(t, "riders", true).row-n(0)["month"]
where:
  month-with-least-drivers(shuttle) is shuttle.row-n(3)["month"]
end

# Adicionando novas colunas

employees =
  table: name,   hourly-wage, hours-worked
    row: "Harley",  15,          40
    row: "Obi",     20,          45
    row: "Anjali",  18,          39
    row: "Miyako",  18,          40
  end

fun compute-wages(r :: Row) -> Number:
  doc: "compute total wages based on wage and hours worked"
  r["hourly-wage"] * r["hours-worked"]
end

build-column(employees, "total-wage", compute-wages)

# Atualizando valores nas colunas

fun new-rate(rate :: Number) -> Number:
  doc: "Raise rates under 20 by 10%"
  if rate < 20:
    rate * 1.1
  else:
    rate
  end
where:
  new-rate(20) is 20
  new-rate(10) is 11
  new-rate(0) is 0
end

wages-test =
  table: hourly-wage
    row: 15
    row: 20
    row: 18
    row: 18
  end

fun give-raises(t :: Table) -> Table:
  doc: "Give a 10% raise to anyone making under 20"
  transform-column(t, "hourly-wage", new-rate)

where:
  give-raises(wages-test) is
  table: hourly-wage
    row: 15 * 1.1
    row: 20
    row: 18 * 1.1
    row: 18 * 1.1
  end
end


# Lendo tabelas de arquivos CSV

# the url for the file
url = "https://raw.githubusercontent.com/data-centric-computing/dcic-public/main/materials/datasets/events-f25.csv"

event-data =
 load-table: name, email, tickcount, discount, delivery, zip
    source: csv-table-url(url, default-options)
    sanitize name using string-sanitizer
    sanitize email using string-sanitizer
    sanitize tickcount using num-sanitizer
    sanitize discount using string-sanitizer
    sanitize delivery using string-sanitizer
    sanitize zip using string-sanitizer
  end

event-data


# Normalizando dados

fun cell-to-discount-code(str :: String) -> String:
  doc: ```uppercase all strings other than none,
       convert blank cells to contain none```
  if (str == "") or (string-replace(str, " ", "") == "") or (string-to-lower(str) == "none"):
    "none"
  else:
    string-to-upper(str)
  end
where:
  cell-to-discount-code("") is "none"
  cell-to-discount-code("none") is "none"
  cell-to-discount-code("NoNe") is "none"
  cell-to-discount-code("birthday") is "BIRTHDAY"
  cell-to-discount-code("Birthday") is "BIRTHDAY"
end

discount-fixed =
  transform-column(event-data, "discount", cell-to-discount-code)

discount-fixed

# Contando valores distintos
count(discount-fixed, "discount")


# Creating bins

fun order-scale-label(r :: Row) -> String:
  doc: "categorize the number of tickets as small, medium, large"
  numtickets = r["tickcount"]
  ask:
  | numtickets >= 10 then: "large"
  | numtickets >= 5 then: "medium"
  | otherwise: "small"
  end
end

order-bin-data =
  build-column(discount-fixed, "order-scale", order-scale-label)

order-bin-data

# Visualizations and plots

# freq-bar-chart(order-bin-data, "delivery")


#| 
  Extraindo colunas como listas
|#



tickcounts = event-data.get-column("tickcount")

#|
   Criando literais de listas
|#

[list: 1, 2, 3]
[list: -1, 5, 2.3, 10]
[list: "a", "b", "c"]
[list: "This", "is", "a", "list", "of", "words"]
shopping-list = [list: "muesli", "fiddleheads"]

[list: 10, -1, 5, 2.3]  # (Lista de Números)
[list: "maçã", "banana", "uva"]  # (Lista de Strings)
shopping = [list: "pão", "leite"]  # (Atribuindo a lista a uma variável)
[list: ]  # (Uma lista vazia. Pode parecer inútil agora, mas será muito importante depois!)


#| 
    Operadores de listas
|#

M.max(tickcounts)     # largest number in a list
M.sum(tickcounts)     # sum of numbers in a list
S.mean(tickcounts)    # mean (average) of numbers in a list
S.median(tickcounts)  # median of numbers in a list

#|
   Operadores gerais
|#

codes = event-data.get-column("discount")
L.distinct(codes)
L.remove(codes, "none")


fun real-code(c :: String) -> Boolean:
  not(c == "none")
end
L.filter(real-code, L.distinct(codes))


fun web-com-address(email :: String) -> Boolean:
  doc: "determine whether email is from web.com"
  if string-contains(email, "@"):
    string-split(email, "@").get(1) == "web.com"
   else:
    false
  end
where:
  web-com-address("bonnie@pyret.org") is false
  web-com-address("parrot@web.com") is true
end

emails = event-data.get-column("email")
L.length(L.filter(web-com-address, emails))

#|
   Transformando listas
|#


fun extract-username(email :: String) -> String:
  doc: "extract the portion of an email address before the @ sign"
  string-split(email, "@").get(0)
where:
  extract-username("bonnie@pyret.org") is "bonnie"
  extract-username("parrot@web.com") is "parrot"
end

L.map(extract-username, [list: "parrot@web.com", "bonnie@pyret.org"])

# Given the events table, produce a list of names of all people who will pick up their tickets.


fun will-pickup(r :: Row) -> Boolean:
  doc: "determine whether delivery method is pickup"
  r["delivery"] == "pickup"
end


fun pickup-names(t :: Table) -> List<String>:
  doc: "determine whether delivery method is pickup"
  filter-with(t, will-pickup).get-column("name")
end

pickup-names(event-data)