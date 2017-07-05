# JPEG-DCT-Quantizacao
Programa em fortran para codificação parcial e decodificação parcial JPEG, gerando uma matriz DCT e uma matriz quantizada.

O programa de codificação recebe uma matriz 8x8, já transformada do RGB para Y'CbCr, calcula a Discrete Cosine Transform(DCT) da matriz de entrada, gerando então a matriz DCT, logo depois, cada componente da matriz DCT é dividida pelo seu correspondente na matriz de quantização, a matriz de quantização é pré definida e define o nível de compressão, os valores desta nova matriz são arredondadas para valores inteiros, gerando assim a matriz final.

O programa de decodificação recebe a matriz final, e faz o processo inverso da decodificação, ela multiplica cada componente da matriz final por cada componente da matriz de quantização, logo depois ele calcula a IDCT, a matriz DCT inversa, e então é gerada a matriz decodificada, além disso, é gerada também uma matriz de erro, que define as diferenças entre a matriz original e a matriz decodificada.

Este projeto foi criado para a ilustrar o processo de codificação e decodificação JPEG.

OBS: as matrizes de entrada do encoding estão no git, porém as matrizes de entrada do decoding não, para rodar o decoding, é necessário primeiro rodar o encoding e então o decoding sobre as matrizes de saida do encoding.
