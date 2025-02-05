%RESOLU��O DO PROBLEMA DOS MISSION�RIOS E CANIBAIS
%ALUNOS: ANDRIOS ROBERT RA:0261028898
%	 VICTOR HUGO	RA:0261030370

%movimentos v�lidos
podeir(1,1). %um canibal e um missionario
podeir(2,0). %dois missin�rios
podeir(0,2). %dois canibais
podeir(1,0). %um missionario
podeir(0,1). %um canibal

%estados v�lidos
valido(N,N).%numero de mission�rios e canibais iguais
valido(3,_).%todos os mission�rios est�o na margem esquerda do rio
valido(0,_).%todos os mission�rios est�o na margem direita do rio


%muda o missionario e/ou canibal da margem esquerda para a direita
%controlando apenas as quantidades de Mission�rios e Canibais referentes
%a margem da esquerda, se saiu da esquerda para a direita ent�o
%subtra��o.
mudalado(estado(M1,C1,e),estado(M2,C2,d)) :- podeir(M,C),
	M =< M1, M2 is M1 - M, C =< C1,
	C2 is C1 - C,M1 =< 3, C1 =< 3, M2 =< 3,
        C2 =< 3,valido(M2,C2).

%muda o missionario e/ou canibal da margem direita para a esquerda
%controlando apenas as quantidades de Mission�rios e Canibais referentes
%a margem da esquerda, se saiu da direita para a esquerda ent�o adi��o.
mudalado(estado(M1,C1,d),estado(M2,C2,e)) :-  podeir(M,C),
	M =< 3 - M1, M2 is M1 + M, C =< 3 - C1,
	C2 is C1 + C,M1 =< 3,C1 =< 3, M2 =< 3,
	C2 =< 3,valido(M2,C2).
%a fun��o mudalado s� controla a margem esquerda do rio.


%resolve um determinado estado do jogo, essa fun��o tem uma lista de
%estados j� percorridos, que tem por intuito vefiricar se o estado,
%j� foi percorrido, a fun��o vai chamando recursivamente e concatenando
%o a lista de percorridos.
resolve(estado(0,0,d),R, [estado(0,0,d)|R]).
resolve(estado(M,C,L),V,R) :- mudalado(estado(M,C,L), estado(M1,C1,L1)),
 not(pertence(estado(M1,C1,L1),V)), resolve(estado(M1,C1,L1),[estado(M,C,L)|V],R).


%imprime um estado do jogo, seja indo um canibal/missionario indo para
%margem esquerda ou direira do rio.
percurso(estado(M1,C1,e),estado(M2,C2,d)):-
	      write('      '),N is M1-M2, write(N), write('              '),
              N2 is C1-C2, write(N2),write('	          '),
	      write(' Sai '),write('	         '),
	      write(' Vai \n').

percurso(estado(M1,C1,d),estado(M2,C2,e)):-
	      write('      '),N is M2-M1, write(N), write('              '),
              N2 is C2-C1, write(N2),write('	          '),
	      write(' Vai '),write('	         '),
	      write(' Sai \n').


% percorre a lista com as chamadas que foram feitas para resolver o jogo
% e vai imprimindo os movimentos necess�rios para concluir com sucesso.
imprime([_|[]]).
imprime([X,Y|Cauda]) :- percurso(X,Y), imprime([Y|Cauda]).

%funcoes basicas.
pertence(X, [X|_]).
pertence(X, [_|Y]) :- pertence(X, Y).

concatena([],L,L).
concatena([X|L1],L2,[X|L3]) :- concatena(L1,L2,L3).

inverte([],[]).
inverte([X|R],L) :-
        inverte(R,T),
        concatena(T,[X],L).

%resolve o jogo, passo o estado inicial, e ele resolve e imprime.
%solucao(3,3,e).
solucao(M,C,L):- (resolve(estado(M,C,L),[],R),
        inverte(R,R2),tabela(_), imprime(R2),linha(_)).

%faz o layout de tabelinha
tabela(_):- nl,nl,write('     ------------**CANIBAIS & MISSION�RIO**-----------'),nl,
	    linha(_),nl,
	    write('MISSION�RIOS'),write('     '),write('CANIBAIS'),write('     '),
	    write('MRG. ESQUERDA'),write('    '),write('MRG. DIREITA'),nl,linha(_),nl,nl.
linha(_):-write('___________________________________________________________').
