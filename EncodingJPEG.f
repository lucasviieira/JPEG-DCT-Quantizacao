      Program EncodigJPEG
      implicit real *8(a-h,o-z)

      dimension f(8,8)
      dimension g(8,8)
      dimension q(8,8)
      dimension r(8,8)
      integer X,Y,i,j
      ! Constantes
      pi=4.d0*datan(1.d0)
      L = 8
      d = 0.25d0
      ! arquivos de entrada
      Open(20, file='matriz.dat', status='unknown')
      Open(23, file='matrizQ.dat', status='unknown')
      ! arquivos de saida
      Open(21, file='matriz2.dat', status='unknown')
      Open(22, file='dct.dat', status='unknown')
      Open(24, file='final.dat', status='unknown')

      rewind(20)
      rewind(23)
      ! leitura das matrizes de entrada
      read(20,*) f
      read(23,*) q
      f = transpose(f)
      q = transpose(q)
      ! shift dos valores para centralizar em 0 [-128,127]
      f = f - 128
      ! escreve esta primeira matriz no arquivo
      do i=1,L
            write(21,*) f(i,:)
      end do
      ! calcula a DCT
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
            C = 0.d0
            do X=0,L-1
               do Y=0,L-1
               A = dcos( ((2*(X) + 1) * (i*pi) ) / (2*L) )
               B = dcos( ((2*(Y) + 1) * (j*pi) ) / (2*L) )
               C = C + f(X+1,Y+1) * A * B
               end do
            end do
      
            g(i+1,j+1) = d * Alfa1 * Alfa2 * C
         end do
      end do
      ! escreve a DCT no arquivo
      do i=1,L
            write(22, '(1000f8.2)') g(i,:L)
      end do

      !rewind(22)
      !read(22,*) g
      !g = transpose(g)

      ! divide a matriz DCT gerada, pela matriz de quantiza‡Æo e arredonda
      do i=1,L
         do j=1,L
            r(i,j) = idnint(g(i,j) / q(i,j))
         end do
      end do
      ! escreve as matrizes no arquivo
      do i=1,L
            write(24, '(1000f5.0)') r(i,:L)
      end do
      
      close(20)
      close(21)
      close(22)
      close(23)
      close(24)
      
123   format(f8.2)

      stop
      end
