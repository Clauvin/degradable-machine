function comiteAtual = selecaoComitePoda(redes, entrada, resposta, mse, exploracao )

   tamMax = size(redes, 1);
   
   tamEntrada =  size(entrada, 1);
   
   comites = cumsum(ones(1, tamMax));
   
   saida = comite(redes(comites), entrada);
   
   mse = sum( (saida - resposta') .^ 2 ) / tamEntrada;
   
   %comitê com todos os 
   mseAtual = mse;
   comiteAtual = comites;
     
   while true
       
       i = 1;
       nochange = 0;
       
       tamComite = size(comiteAtual, 2);
       
       if (exploracao == 1)
          atirar = 0; 
       end
       
       while i <= tamComite
           i = i
           comiteNovo = [comiteAtual(1:i-1), comiteAtual(i+1:tamComite)];
           saida = comite( redes(comiteNovo), entrada );
           mseNovo = sum( (saida - resposta') .^ 2 ) / tamEntrada;
           
           if (exploracao == 1)
              if ( mseNovo < mseAtual )
                    mseAtual=mseNovo;
                    atirar = i
              end 
           elseif ( mseNovo < mseAtual )
               mseAtual=mseNovo;
               comiteAtual=comiteNovo;
               nochange = 1;
               break
           end
           
           i = i+1;
       end
       
       if (exploracao == 1)
           if (atirar ~= 0)
               comiteAtual = [comiteAtual(1:atirar-1), comiteAtual(atirar+1:tamComite)];
           else
               break
           end
       elseif (nochange == 0)
           break
       end
       
   end
   comiteAtual = redes(comiteAtual);
   %plotconfusion( round( comite(comiteAtual, entrada) ), resposta' );
end