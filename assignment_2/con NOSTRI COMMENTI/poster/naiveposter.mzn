% Naive model


int: n; % numero di post
int: w; % larghezza della bobina di carta
int: h; % altezza della bobina di carta

array[1..n] of int: ws; % larghezza dei poster
array[1..n] of int: hs; % altezza dei poster

% angolo in basso a sx di ogni poster (X, Y) --> evitare che i poster escano dai bordi
array[1..n] of var 0..w-1: x; % = massimi spazi disponibili per la posizione dei poster 
array[1..n] of var 0..h-1: y; % variabili decisionali x e y, che rappresentano le coordinate x e y del lato in basso a sinistra di ciascun poster. Le variabili sono vincolate a non superare la larghezza e l'altezza disponibili sulla bobina di carta.

% controllo che il pezzo i riesca a stare dentro allo spazio ancora disponibile e che non superi w o h della bobina 
constraint forall(i in 1..n) (x[i] + ws[i] <= w); 
constraint forall(i in 1..n) (y[i] + hs[i] <= h);

%implied constraints --> poster non sovrappongano tra loro
% vincoli impliciti --> assicurano che la somma delle altezze dei poster sovrapposti verticalmente (rispettando le dimensioni) sia inferiore o uguale all'altezza della bobina e che la somma delle larghezze dei poster sovrapposti orizzontalmente (rispettando le dimensioni) sia inferiore o uguale alla larghezza della bobina
constraint forall(i in 1..n) ((sum(j in 1..n where (x[j]<=i /\ i<x[j]+ws[j]))(hs[j]))<= h);
constraint forall(i in 1..n) ((sum(j in 1..n where (y[j]<=i /\ i<y[j]+hs[j]))(ws[j]))<= w);

% evita che i poster si sovrappongano. Se si sovrappongono, uno deve essere posizionato a sx dell'altro, al di sopra dell'altro o viceversa.
constraint forall(i,j in 1..n where i < j)
    ((x[i]+ws[i]<=x[j]) \/ (x[j]+ws[j]<=x[i]) \/ (y[i]+hs[i]<=y[j]) \/ (y[j]+hs[j]<=y[i]));
    
solve satisfy;


