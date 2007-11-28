for %%i in (screenshot_*.png) do ^
convert -filter Hermite -resize 160x160 -colors 128 +dither %%i -depth 8 ..\%%~ni_thumb.png && ^
pngout ..\%%~ni_thumb.png && ^
convert -filter Hermite -resize 600x600 -colors 256 +dither %%i -depth 8 ..\%%i && ^
pngout ..\%%i
