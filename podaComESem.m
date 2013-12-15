function comiteAtual = podaComESem(redes, entrada, resposta, mse, exploracao )

   %tamanho da entrada
   tamEntrada =  size(entrada, 1);

   %lista com TODOS os comitês
   comites = cumsum(ones(1, size(redes, 1)));
   
   %saída feita com todos os comitês
   saida = comite(redes(comites), entrada);
   
   %calculando a média do erro ao quadrado
   mse = sum( (saida - resposta') .^ 2 ) / size(entrada, 1);
   
   %passando mse e comite para outras variáveis para ficar mais legível
   mseAtual = mse;
   comiteAtual = comites;
     
   while true
       
       %contador de exploração
       i = 1;
       
       %variável para quando não temos exploração: alguma mudança no comitê
       %ocorreu?
       change = 0;
       
       %quantas colunas tem o comitê?
       tamComite = size(comiteAtual, 2);
       
       %se exploração == 1 é para poda com exploração.
       if (exploracao == 1)
          %atirar de A TIRAR e não de disparar. É para guardar qual posição
          %da lista de membros do comitê será tirada
          atirar = 0; 
       end
       
       %enquanto não se passar por todos os membros do comitê
       while i <= tamComite
           
           %retiramos um membro do comitê
           comiteNovo = [comiteAtual(1:i-1), comiteAtual(i+1:tamComite)];
           
           %calculamos o resultado do comitê...
           saida = comite( redes(comiteNovo), entrada );
           
           %e o novo erro...
           mseNovo = sum( (saida - resposta') .^ 2 ) / tamEntrada;
           
           %em caso de exploração
           if (exploracao == 1)
              
              %se houve uma melhora na solução, ótimo!
              %guardamos ela e guardamos o que precisa ser retirado na tal
              %melhora
              if ( mseNovo < mseAtual )
                  %como ocorre substituição somente se houver
                  %melhora, no fim da varredura, teremos o melhor a
                  %substituir
                    mseAtual=mseNovo;
                    atirar = i;
              end
           %se for sem exploração
           elseif ( mseNovo < mseAtual )
               mseAtual=mseNovo;
               comiteAtual=comiteNovo;
               %change indica se 1, que houve mudança, se 0, que não
               %então se a varredura for feita em todas as possibilidades
               %de tirar um e não achar nada...
               %change = 0 e paramos de procurar por um comitê melhor
               change = 1;
               break
           end
           
           i = i+1;
       end
       
       %no caso de exploração...
       if (exploracao == 1)
           %se há o que tirar, tiremos
           if (atirar ~= 0)
               comiteAtual = [comiteAtual(1:atirar-1), comiteAtual(atirar+1:tamComite)];
           else
               break
           end
       %no caso de não ter exploração...
       %se não houve mudança após a varredura, chega de busca!
       elseif (change == 0)
           break
       end
       
   end
   %retornamos o comitê
   comiteAtual = redes(comiteAtual);
   %plotconfusion( round( comite(comiteAtual, entrada) ), resposta' );
end