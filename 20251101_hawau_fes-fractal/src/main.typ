#import "@preview/slydst:0.1.4": *
#import "@preview/showybox:2.0.4": *

#show: slides.with(
  title: "フラクタル次元の計算法",
  subtitle: none,
  date: "Nov 1, 2025",
  authors: "学習院高等科 2年 (name removed)",
  title-color: rgb("#602040"),
)

== Outline
#outline()

= フラクタル図形

== 意外と身近なフラクタル
フラクタル $:=$ 拡大しても同じくらい複雑な図形
#figure(
  grid(
    columns: 2,
    gutter: 2cm,
    image("Koch.png"),
    image("Mandel_zoom_00_mandelbrot_set.jpg")
  ),
  caption: [
    有名なフラクタル図形
  ]
)
このようなフラクタル図形を日常生活で見ることはあまりない。\
しかし、地形や海岸線など、実は自然にフラクタルな形が生まれている\
$=>$ 自然な地形を生成するために、ゲームなどで使われている。

= フラクタル次元とは?

== 整数次元(i)

=== >整数次元の大小の比較
有限の面積を持つ、2次元の領域 (たとえば単位円) を考える。\
$1$次元の大きさ$=$「線の長さ」として測るなら、\
(たとえば らせんで埋め尽くす)、無限大の長さになる。
#figure(image("circle_filling.png", width:36%), caption: "円を らせん で埋めつくす (25周目)")

== 整数次元(ii)
今度は、同じ単位円を3次元から眺めてみる。\
体積は0である。
$ V=S h=pi r^2 times 0 = 0 $.

#figure(image("circle_in_3d.png", width:36%), caption:"円盤の体積は0.")

== 整数次元(iii)
しかし、この単位円は2次元図形としては有限の面積を持つ。\
$ S = pi r^2, 0 < S < infinity $
#showybox(title: "まとめると:", frame: (
  border-color: rgb("#304038"),
  title-color: rgb("#608070"),
  body-color: rgb("#eeeeee"),
  footer-color: rgb("#eeeeee"),
), footer: "ということになる。",
[
  測る人の次元を $d$ , 図形の次元を $D$ としたとき、
  - $d < D$のとき: 体積は無限大になる
  - $d = D$のとき: 体積は有限の値をとる
  - $d > D$のとき: 体積は0になる
]
)
測る対象と同じ次元でないと、体積を測れない。

== フラクタルの例; Koch曲線
#figure(image("Koch.png", width:95%), caption:"Koch曲線")
=== この図形の次元は?
- $1$次元の長さとして見ると、$n -> infinity,=> (4/3)^n -> infinity$なので長さは無限大である。
- $2$次元の面積として見ると、面積$0$。
なので、この図形の次元$d$は$1 < d < 2$である。$=> d$は$1.ast.basic ast.basic$になる。

= 具体的な次元の計算法

== フラクタル次元
このような図形の次元を測る様々な定義の*フラクタル次元*が存在する。\
(*Hausdorff次元*, 情報次元, box-counting次元, 樋口次元, etc...)\
#emph(text(8pt)[
  ここから、ある次元においての長さ、面積や体積に相当する量をすべて「体積」と表記する。
])
\
これらの次元の定義たちの多くに共通する性質: 
#figure(image("separate2.png", width:60%), caption:"2倍に拡大するとき")

== Koch曲線の次元 (i)
ここから、測る対象の曲線の次元を$D$と表記する。
#figure(image("Koch_3to4.png", width:95%), caption:"Koch曲線を色分けすると・・・。")
それぞれの色の部分は、全体に相似 (全体を$1/3$倍拡大したもの) 。\
$->$ すなわち、この一つ一つ部分について、$D$次元から見た「体積」は、\
全体の「体積」を$1$として: $(1/3)^D$である。

== Koch曲線の次元 (ii)
#figure(image("Koch_3to4.png", width:68%), caption:"Koch曲線を色分けすると・・・。")
それぞれの色の部分は$4$つある $=>$ \
$(1/3)^D$倍の「体積」の図形を$4$つあわせると、全体の体積になる。
$ (1/3)^D times 4 = 1 \
(-log 3)D + log 4 = 0 \
therefore D = (log 3) / (log 4) eq.dots.up 1.26 $

== 一般的な計算式
#figure(image("the_eq.png", width:85%), caption:"一般的に、各辺を同じ曲線で置き換えていく方式で作られる フラクタル曲線の次元は、上式で与えられる。")

= 終わりに

== 終わりに
$ (x_0)^D + (x_1)^D + dots.c + (x_n)^D = 1 $
自己相似図形に限ってではあるが、\
このようにきれいな方程式で求まることに感動した。\

=== 参考文献:\
Wikipediaの Fractal dimension の記事\
(https://en.wikipedia.org/wiki/Fractal_dimension)\
Wikipediaの Mandelbrot setの画像\
(https://upload.wikimedia.org/wikipedia/commons/2/21/Mandel_zoom_00_mandelbrot_set.jpg)
\
山田 俊雄. フラクタル次元の算出法とその事例. 情報地質, 第8巻, 第3号, pp.177-184\
(https://www.jstage.jst.go.jp/article/geoinformatics1990/8/3/8_3_177/_pdf)
