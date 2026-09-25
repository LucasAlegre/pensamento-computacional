use context dcic2024

include csv
include data-source

# Lendo tabelas de arquivos CSV

url = "https://raw.githubusercontent.com/adaoduque/Brasileirao_Dataset/refs/heads/master/campeonato-brasileiro-full.csv"

DADOS =
  load-table: ID, rodata, dataa, hora, mandante,visitante,formacao_mandante,formacao_visitante,tecnico_mandante,tecnico_visitante,vencedor,arena,mandante_Placar,visitante_Placar,mandante_Estado,visitante_Estado
    source: csv-table-url(url, default-options)
  end

fun is-2024(row :: Row) -> Boolean:
  string-contains(row["dataa"], "2024")
end

DADOS-2024 = filter-with(DADOS, is-2024)

DADOS-2024

