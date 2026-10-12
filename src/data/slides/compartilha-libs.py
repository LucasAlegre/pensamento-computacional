"""Pós-render do Quarto: junta as bibliotecas dos decks em public/slides/libs/.

O revealjs copia ~8 MB de bibliotecas (reveal.js, plugins, fontes) para
`aulaNN-*_files/libs/` de cada deck, ignorando `lib-dir`. Os arquivos são
idênticos entre os decks (o CSS do tema muda, mas tem um hash no nome), então
movemos tudo para uma pasta compartilhada e reescrevemos os caminhos no HTML.
"""

import os
import shutil
from pathlib import Path

saida = Path(os.environ.get("QUARTO_PROJECT_OUTPUT_DIR", "../../../public/slides")).resolve()
libs = saida / "libs"

for html in sorted(saida.glob("aula*.html")):
    pasta = saida / f"{html.stem}_files"
    origem = pasta / "libs"
    if not origem.is_dir():
        continue
    for arquivo in origem.rglob("*"):
        if arquivo.is_file():
            destino = libs / arquivo.relative_to(origem)
            destino.parent.mkdir(parents=True, exist_ok=True)
            shutil.copy2(arquivo, destino)
    shutil.rmtree(origem)
    if not any(pasta.iterdir()):
        pasta.rmdir()
    texto = html.read_text(encoding="utf-8")
    html.write_text(texto.replace(f"{html.stem}_files/libs/", "libs/"), encoding="utf-8")
    print(f"compartilha-libs: {html.name}")
