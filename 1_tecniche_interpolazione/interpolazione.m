function [errore] = interpolazione(funzione,tipo,A,B,N_nodi)

    if nargin < 2
         errordlg('Errore inserimento input');
        error('Errore inserimento input')
    end 
    
    if nargin == 2
        a = 0
        b = a+10
        n_nodi = 10
    end
    
    if nargin == 3
        a = A
        b = A+10
       n_nodi = 10
    end
    
    if nargin == 4
        a = A 
        b = B
        n_nodi = 10
    end
    
      if nargin == 5
        a = A
        b = B
        n_nodi = N_nodi
    end
    
    
    if n_nodi <= 0 
        errordlg('Inserire numero nodi non negativo');
        error('Inserire numero nodi non negativo')
    end
            
    if b-a<=0
           errordlg('Inserire ampiezza intervallo consentita');
        error('Inserire ampiezza intervallo consentita')
    end
    
  
    
    switch tipo
        case 'polinomiale'
            
            % Tramite i dati di input, estremo_sx ed estremo_dx 
            % definisco l'intervallo di definizione della mia funzione f
            % lungo l'asse x tramite la funzione di Matlab linespace, che
            % dati un estremo di sinista e di destra ci restituisce un
            % vettore riga di 100 punti equidistanti tra i due estremi. 
            t = linspace(a,b);
            % Dato l'intervallo valuto la mia funzione di ingresso nei
            % punti dell'intervallo
            y1 = funzione(t);
            
            % Adesso utilizziamo le funzioni offerte da matlab per
            % calcolare una funzione che interpola i seguenti punti (x,y)
            % che sono pari a num_nodi e sono presi equidistanziati tra 
            % l'intervallo [estremo_sx,estremo_dx]
            % Dove x e' un vettore che rappresenta le ascisse dei 
            % punti da interpolare
            
            x = linspace(a,b,n_nodi); 
            
            % Mi trovo il valore delle ordinate dei punti di x valutati in
            % f
      
            y = funzione(x);
            
            % Attraverso la funzione polyfit si trovano i coefficienti del 
            % polinomio che meglio si adatta ai punti (x,y) nel senso dei minimi
            % quadrati
            
            p = polyfit(x,y,n_nodi-1);
            
            % La funzione polyval valuta il vettore p in ogni punto x
            y_out = polyval(p,t);
            
            % Plottiamo il grafico della funzione di ingresso e del
            % polinomio interpolante
%             x y punti, t y_out funzione interpolata, t y1 funzione reale
            plot(t,y1,'r',t,y_out,'b',x,y,'ok');
            legend('Funzione','Interpolazione Polinomiale','Punti')
            title('Interpolazione polinomiale')
            
            
        case 'lineare'
            
            t = linspace(a,b);
            y1 = funzione(t);
            
            x = linspace(a,b,n_nodi);
            y = funzione(x);
            
            % la funzione interp1 fa la interpolazione di grado 1 per ogni
            % coppia di nodi adiacenti
            y_out = interp1(x,y,t);
            
            plot(app.UIAxes,t,y1,'r',t,y_out,'b',x,y,'ok');
            legend('Funzione','Interpolazione Polinomiale a tratti','Punti')
            title('Interpolazione polinomiale a tratti')
            
        case 'spline_not_a_knot'
            
            t = linspace(a,b);
            y1 = funzione(t);
            
            x = linspace(a,b,n_nodi);
            y = funzione(x);
            
            % La funzione spline fa un interpolazione naturale cubica (
            % interpolazione di grado 3) a partire dai vettori x e y.
            y_out = spline(x,y,t);
            
             plot(t,y1,'r',t,y_out,'b',x,y,'ok');
            legend('Funzione','Interpolazione Spline not-a-knot','Punti')
            title('Interpolazione Spline not-a-knot')
            
       case 'spline_naturale'
            
            t = linspace(a,b);
            y1 = funzione(t);
            
            x = linspace(a,b,n_nodi);
            y = funzione(x);
            
            % La funzione spline fa un interpolazione naturale cubica (
            % interpolazione di grado 3) a partire dai vettori x e y.
            pp = csape(x,y,'second')
            y_out = ppval(pp,t);
            
             plot(t,y1,'r',t,y_out,'b',x,y,'ok');
            legend('Funzione','Interpolazione Spline Naturale','Punti')
            title('Interpolazione Spline Naturale')
     
        case 'spline_completa'
            
            t = linspace(a,b);
            y1 = funzione(t);
            
            x = linspace(a,b,n_nodi);
            y = funzione(x);
            
            % La funzione spline fa un interpolazione naturale cubica (
            % interpolazione di grado 3) a partire dai vettori x e y.
            pp = csape(x,[0 y 0],'clamped')
            y_out = ppval(pp,t);
            
             plot(t,y1,'r',t,y_out,'b',x,y,'ok');
            legend('Funzione','Interpolazione Spline Completa','Punti')
            title('Interpolazione Spline Completa')
            
    end
%       interpolazione(@(x)1./(1+25.*x.^2),7,-1,1,'spline')
     errore = norm(y_out-y1,inf);
end