function comiteAtual = selecaoComite(redes, entrada, resposta, mse, exploracao )
   tamMax = size(redes, 1);
   tamEntrada =  size(entrada, 1);
   
   % lista de indices dos classificadores que estao no comite atualmente
   [mseAtual, comiteAtual] = min(mse);
   
   i=1;
   while i <= tamMax
       
       if ( find( comiteAtual==i ) )
           %se ja esta no comite, ignore
           i = i + 1;
           continue
       end
       
       comiteNovo = [comiteAtual, i ];
       saida = comite( redes(comiteNovo), entrada );
       
       mseNovo = sum( (saida - resposta') .^ 2 ) / tamEntrada
       
       if ( mseNovo < mseAtual )
           mseAtual=mseNovo;
           comiteAtual = comiteNovo;
           
           if (exploracao == 1 )
                i = 0; %reset loop
           end
           
       end
       
       i = i + 1;
       
   end
   comiteAtual = redes(comiteAtual);
   %plotconfusion( round( comite(comiteAtual, entrada) ), resposta' );
end