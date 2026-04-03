#!/usr/bin/env python3
"""Convert dbt_teaching_manual_ru.md to styled HTML and PDF."""

from pathlib import Path

import markdown
from weasyprint import HTML

REPO_ROOT = Path(__file__).resolve().parent.parent
MD_PATH = REPO_ROOT / "dbt_teaching_manual_ru.md"
OUT_DIR = Path(__file__).resolve().parent
HTML_PATH = OUT_DIR / "dbt_teaching_manual_ru.html"
PDF_PATH = OUT_DIR / "dbt_teaching_manual_ru.pdf"

CSS = """
@page {
    size: A4;
    margin: 2cm 2.5cm;
    @bottom-center {
        content: counter(page);
        font-size: 10px;
        color: #999;
    }
}

body {
    font-family: 'Segoe UI', 'Noto Sans', 'Liberation Sans', sans-serif;
    font-size: 14px;
    line-height: 1.6;
    color: #222;
    max-width: 900px;
    margin: 0 auto;
    padding: 20px 40px;
}

h1 {
    color: #FF694A;
    font-size: 32px;
    border-bottom: 3px solid #FF694A;
    padding-bottom: 8px;
    margin-top: 40px;
    page-break-after: avoid;
}

h2 {
    color: #1a1a2e;
    font-size: 24px;
    border-bottom: 1px solid #ddd;
    padding-bottom: 6px;
    margin-top: 36px;
    page-break-after: avoid;
}

h3 {
    color: #333;
    font-size: 18px;
    margin-top: 24px;
    page-break-after: avoid;
}

h4 {
    color: #555;
    font-size: 16px;
    margin-top: 20px;
    page-break-after: avoid;
}

code {
    background: #f4f4f4;
    border-radius: 4px;
    padding: 2px 6px;
    font-family: 'Consolas', 'Fira Code', 'Source Code Pro', monospace;
    font-size: 13px;
}

pre {
    background: #f5f5f5;
    border-left: 4px solid #FF694A;
    border-radius: 4px;
    padding: 14px 16px;
    overflow-x: auto;
    font-size: 12.5px;
    line-height: 1.5;
    page-break-inside: avoid;
}

pre code {
    background: transparent;
    padding: 0;
    font-size: inherit;
}

table {
    border-collapse: collapse;
    width: 100%;
    margin: 16px 0;
    font-size: 13px;
    page-break-inside: avoid;
}

th, td {
    border: 1px solid #ddd;
    padding: 8px 12px;
    text-align: left;
}

th {
    background: #1a1a2e;
    color: #fff;
    font-weight: 600;
}

tr:nth-child(even) {
    background: #fafafa;
}

blockquote {
    border-left: 4px solid #FF694A;
    padding: 8px 16px;
    margin: 16px 0;
    font-style: italic;
    color: #555;
    background: #fff8f6;
    border-radius: 0 4px 4px 0;
}

hr {
    border: none;
    border-top: 2px solid #eee;
    margin: 32px 0;
}

a {
    color: #FF694A;
    text-decoration: none;
}

a:hover {
    text-decoration: underline;
}

ul, ol {
    padding-left: 24px;
}

li {
    margin-bottom: 4px;
}

strong {
    color: #1a1a2e;
}

/* TOC styling */
h2:first-of-type + ul {
    columns: 2;
    column-gap: 24px;
}

/* Print-friendly */
@media print {
    body { padding: 0; }
    h2 { page-break-before: auto; }
}
"""


def build() -> None:
    md_text = MD_PATH.read_text(encoding="utf-8")

    # Convert markdown -> HTML
    extensions = ["tables", "fenced_code", "toc", "codehilite", "sane_lists"]
    html_body = markdown.markdown(md_text, extensions=extensions)

    full_html = f"""<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>dbt (Data Build Tool) — Учебное пособие</title>
    <style>{CSS}</style>
</head>
<body>
{html_body}
</body>
</html>"""

    # Write HTML
    HTML_PATH.write_text(full_html, encoding="utf-8")
    print(f"HTML: {HTML_PATH}")

    # Write PDF
    HTML(string=full_html).write_pdf(str(PDF_PATH))
    print(f"PDF:  {PDF_PATH}")


if __name__ == "__main__":
    build()
