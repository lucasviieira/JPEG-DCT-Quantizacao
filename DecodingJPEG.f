      Program DecodingJPEG
      implicit real *8(a-h,o-z)

      dimension f(8,8)
      dimension g(8,8)
      dimension q(8,8)
      dimension r(8,8)
      dimension erro(8,8)
      integer X,Y,i,j

      ! Constantes
      pi=4.d0*datan(1.d0)
      L = 8
      d = 0.25
      
      ! arquivos de entrada
      Open(24, file='final.dat', status='unknown')
      Open(26, file='matriz.dat', status='unknown')
      Open(23, file='matrizQ.dat', status='unknown')
      ! arquivos de saida
      Open(20, file='Dmatriz1.dat', status='unknown')
      Open(21, file='Dmatriz2.dat', status='unknown')
      Open(25, file='Dfinal.dat', status='unknown')
      Open(26, file='matriz.dat', status='unknown')
      Open(27, file='erro.dat', status='unknown')

      rewind(24)
      rewind(23)
      rewind(26)
      ! leitura das matrizes de entrada
      read(26,*) erro
      read(24,*) r
      read(23,*) q
      erro = transpose(erro)
      r = transpose(r)
      q = transpose(q)
      ! calculo inverso da matriz de quantiza‡Æo
      do i=1,L
         do j=1,L
            r(i,j) = (r(i,j) * q(i,j))
         end do
      end do
      ! escreve no arquivo essa nova matriz
      do i=1,L
         write(20, '(1000f8.0)') r(i,:L)
      end do
      ! calcula a IDCT
      do X=0,L-1
         do Y=0,L-1
            C = 0.d0
            do i=0,L-1
               if(i == 0) then
                   Alfa1 = 1/sqrt(2.0)
               else
                   Alfa1 = 1
               endif
               do j=0,L-1
                  if(j == 0) then
                      Alfa2 = 1/sqrt(2.0)
                  else
                      Alfa2 = 1
                  endif
                  A = dcos( ((2*(X) + 1) * (i*pi) ) / (2*L) )
                  B = dcos( ((2*(Y) + 1) * (j*pi) ) / (2*L) )
                  C = C + Alfa1 * Alfa2 * r(i+1,j+1) * A * B
                end do
            end do
            g(X+1,Y+1) = idnint(d * C)
          end do
      end do
      ! faz o shift inverso de 120
      f = g + 128
      ! calcula o erro baseado na matriz original(original - uncompressed)
      erro = erro - f
      ! escreve as matrizes nos arquivos
      do i=1,L
            write(21, '(1000f8.0)') g(i,:L)
            write(25, '(1000f8.0)') f(i,:L)
            write(27, '(1000f8.0)') erro(i,:L)
      end do


      close(20)
      close(21)
      close(23)
      close(24)
      close(25)
      close(26)
      close(27)

      stop
      end
