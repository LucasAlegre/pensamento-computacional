use context dcic2024

include csv
include data-source

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

freq-bar-chart(order-bin-data, "delivery")


