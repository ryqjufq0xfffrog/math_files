# Fractal and calculus (March 19, 2026)

3月19日の発表の資料と、
Juliaでのアニメーションによる可視化スクリプトです。

スライドのコンパイル、
```
$ npm install @marp-team/marp-cli
$ npx @marp-team/marp-cli slide.md -o slide.html --theme-set ../themes/0xfffrog.css
```

Juliaのスクリプトは、
```
$ julia 3d_calculus_anim.jl output.mp4
$ julia fractal_and_dimensions.jl output.png
```
のように、第1引数には出力ファイル名を付けて実行してください。
例外: `fractal_functions.jl` は、第1引数が関数名、第2引数が出力ファイル名です。

# Dependencies (Julia)
`GLMakie`, `Colors`, `GeometryBasics`

Julia のパッケージマネージャーでインストールしてください。
