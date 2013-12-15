function comiteAtual = podaComESem(redes, entrada, resposta, mse, exploracao )

   %tamanho da entrada
   tamEntrada =  size(entrada, 1);

   %lista com TODOS os comit�s
   comites = cumsum(ones(1, size(redes, 1)));
   
   %sa�da feita com todos os comit�s
   saida = comite(redes(comites), entrada);
   
   %calculando a m�dia do erro ao quadrado
   mse = sum( (saida - resposta') .^ 2 ) / size(entrada, 1);
   
   %passando mse e comite para outras vari�veis para ficar mais leg�vel
   mseAtual = mse;
   comiteAtual = comites;
     
   while true
       
       %contador de explora��o
       i = 1;
       
       %vari�vel para quando n�o temos explora��o: alguma mudan�a no comit�
       %ocorreu?
       change = 0;
       
       %quantas colunas tem o comit�?
       tamComite = size(comiteAtual, 2);
       
       %se explora��o == 1 � para poda com explora��o.
       if (exploracao == 1)
          %atirar de A TIRAR e n�o de disparar. � para guardar qual posi��o
          %da lista de membros do comit� ser� tirada
          atirar = 0; 
       end
       
       %enquanto n�o se passar por todos os membros do comit�
       while i <= tamComite
           
           %retiramos um membro do comit�
           comiteNovo = [comiteAtual(1:i-1), comiteAtual(i+1:tamComite)];
           
           %calculamos o resultado do comit�...
           saida = comite( redes(comiteNovo), entrada );
           
           %e o novo erro...
           mseNovo = sum( (saida - resposta') .^ 2 ) / tamEntrada;
           
           %em caso de explora��o
           if (exploracao == 1)
              
              %se houve uma melhora na solu��o, �timo!
              %guardamos ela e guardamos o que precisa ser retirado na tal
              %melhora
              if ( mseNovo < mseAtual )
                  %como ocorre substitui��o somente se houver
                  %melhora, no fim da varredura, teremos o melhor a
                  %substituir
                    mseAtual=mseNovo;
                    atirar = i;
              end
           %se for sem explora��o
           elseif ( mseNovo < mseAtual )
               mseAtual=mseNovo;
               comiteAtual=comiteNovo;
               %change indica se 1, que houve mudan�a, se 0, que n�o
               %ent�o se a varredura for feita em todas as possibilidades
               %de tirar um e n�o achar nada...
               %change = 0 e paramos de procurar por um comit� melhor
               change = 1;
               break
           end
           
           i = i+1;
       end
       
       %no caso de explora��o...
       if (exploracao == 1)
           %se h� o que tirar, tiremos
           if (atirar ~= 0)
               comiteAtual = [comiteAtual(1:atirar-1), comiteAtual(atirar+1:tamComite)];
           else
               break
           end
       %no caso de n�o ter explora��o...
       %se n�o houve mudan�a ap�s a varredura, chega de busca!
       elseif (change == 0)
           break
       end
       
   end
   %retornamos o comit�
   comiteAtual = redes(comiteAtual);
   %plotconfusion( round( comite(comiteAtual, entrada) ), resposta' );
end