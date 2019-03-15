%first line stations
line1(new_elmarg).
line1(elmarg).
line1(ezbet_elnakhl).
line1(ain_shams).
line1(elmatareyya).
line1(helmeyet_elzaitoun).
line1(hadayeq_elzaitoun).
line1(saray_elqobba).
line1(hammamat_elqobba).
line1(kobri_elqobba).
line1(manshiet_elsadr).
line1(eldemerdash).
line1(ghamra).
line1(alshohadaa).
line1(urabi).
line1(nasser).
line1(sadat).
line1(saad_zaghloul).
line1(alsayyeda_zeinab).
line1(elmalek_elsaleh).
line1(margirgis).
line1(elzahraa).
line1(dar_elsalam).
line1(hadayeq_elmaadi).
line1(maadi).
line1(thakanat_elmaadi).
line1(tora_elbalad).
line1(kozzika).
line1(tora_elasmant).
line1(elmaasara).
line1(hadayeq_helwan).
line1(wadi_hof).
line1(helwan_university).
line1(ain_helwan).
line1(helwan).
%second line stations
line2(shobra_elkheima).
line2(koliet_elzeraa).
line2(mezallat).
line2(khalafawy).
line2(sainte_teresa).
line2(road_elfarag).
line2(massara).
line2(alshohadaa).
line2(ataba).
line2(naguib).
line2(sadat).
line2(opera).
line2(dokki).
line2(bohooth).
line2(cairo_university).
line2(faisal).
line2(giza).
line2(omm_elmisryeen).
line2(sakiat_mekki).
line2(elmounib).
%first line connection
connected(new_elmarg,elmarg).
connected(elmarg,ezbet_elnakhl).
connected(ezbet_elnakhl,ain_shams).
connected(ain_shams,elmatareyya).
connected(elmatareyya,helmeyet_elzaitoun).
connected(helmeyet_elzaitoun,hadayeq_elzaitoun).
connected(hadayeq_elzaitoun,saray_elqobba).
connected(saray_elqobba,hammamat_elqobba).
connected(hammamat_elqobba,kobri_elqobba).
connected(kobri_elqobba,manshiet_elsadr).
connected(manshiet_elsadr,eldemerdash).
connected(eldemerdash,ghamra).
connected(ghamra,alshohadaa).
connected(alshohadaa,urabi).
connected(urabi,nasser).
connected(nasser,sadat).
connected(sadat,saad_zaghloul).
connected(saad_zaghloul, alsayyeda_zeinab).
connected(alsayyeda_zeinab,elmalek_elsaleh).
connected(elmalek_elsaleh,margirgis).
connected(margirgis,elzahraa).
connected(elzahraa,dar_elsalam).
connected(dar_elsalam,hadayeq_elmaadi).
connected(hadayeq_elmaadi,maadi).
connected(maadi,thakanat_elmaadi).
connected(thakanat_elmaadi,tora_elbalad).
connected(tora_elbalad,kozzika).
connected(kozzika,tora_elasmant).
connected(tora_elasmant,elmaasara).
connected(elmaasara,hadayeq_helwan).
connected(hadayeq_helwan,wadi_hof).
connected(wadi_hof,helwan_university).
connected(helwan_university,ain_helwan).
connected(ain_helwan,helwan).
%second line connection
connected(shobra_elkheima,koliet_elzeraa).
connected(koliet_elzeraa,mezallat).
connected(mezallat,khalafawy).
connected(khalafawy,sainte_teresa).
connected(sainte_teresa,road_elfarag).
connected(road_elfarag,massara).
connected(massara,alshohadaa).
connected(alshohadaa,ataba).
connected(ataba,naguib).
connected(naguib,sadat).
connected(sadat,opera).
connected(opera,dokki).
connected(dokki,bohooth).
connected(bohooth,cairo_university).
connected(cairo_university,faisal).
connected(faisal,giza).
connected(giza,omm_elmisryeen).
connected(omm_elmisryeen,sakiat_mekki).
connected(sakiat_mekki,elmounib).

%task1
path(S, D,any,[[S,D]]) :-
    connected(S, D).
path(S,D,any,[[S,H]|T]):-
   connected(S,H),
    path(H,D,any,T).

path(S, D,N,[[S,D]]) :-
  N\=any , N>0,connected(S, D).
path(S,D,N,[[S,H]|T]):-
  N\=any,N>0, connected(S,H)
    ,NN is N-1,
    path(H,D,NN,T).
%end of task1

%Task2
% In neighbors/2:
% StationList is bound to a list of the neighbor Stations of a given Station.
neighbors(Station, StationList) :-
    neighbors(Station, [], StationList).

%neighbors/3 tries to collect Neighbors as long as we haven't 
%seen them before (hence the \+ member check), and returns the 
%list where no new Neighbors accumulated into the L list can be found.
neighbors(Station, L, StationList) :-
    connected(Neighbor,Station),
    \+ member(Neighbor, L), !,
	neighbors(Station, [Neighbor|L], StationList);
    connected(Station,Neighbor),
    \+ member(Neighbor, L), !,
	neighbors(Station, [Neighbor|L], StationList).

neighbors(_, L, L).
    
% listCount(List, Count)
% Count is bound to the number of elements in List.
listCount([], 0).
listCount([_|Tail], Count) :-
    listCount(Tail, TailCount),
    Count is TailCount + 1.
	
% countNeighbors(Station, Count)
% Count is bound to the number of neighbor stations of Station.
countNeighbors(Station, Count) :-
    neighbors(Station, StationList),
    listCount(StationList, Count).
%end of task2

%Task3
cost(Source,Destination,Cost):-
    line1(Source),line1(Destination),
    path(Source, Destination,any,L),
    listCount(L,N),
    N@=<7,
    Cost = '3 EGP'.
   
cost(Source,Destination,Cost):-
    line2(Source),line2(Destination),
    path(Source, Destination,any,L),
    listCount(L,N),
    N@=<7,
    Cost = '3 EGP'.

cost(Source,Destination,Cost):-
    path(Source, Destination,any,L),
    listCount(L,N),
    N<16,
    N>7,
    Cost = '5 EGP'.

cost(Source,Destination,Cost):-
    line1(Source),line2(Destination),
    Cost = '5 EGP'.

cost(Source,Destination,Cost):-
    line2(Source),line1(Destination),
    Cost = '5 EGP'.

cost(Source,Destination,Cost):-
    path(Source, Destination,any,L),
    listCount(L,N),
    N@>=16,
    Cost = '7 EGP'.
%end of task3
