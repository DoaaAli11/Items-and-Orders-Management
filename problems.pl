:- consult(data).
:- dynamic item/3.
:- dynamic alternative/2.
:- dynamic boycott_company/2.

% problem 3
getItemsInOrderById(CustomerUsername, OrderID, Items) :-
	customer(CustomerID, CustomerUsername),
	order(CustomerID, OrderID, Items).
% problem 3 Done


% Problem 5
calcOrder([],0).
calcOrder([H|T],Price):-
calcOrder(T,P1),item(H,_,P),Price is P1+P.

calcPriceOfOrder(Cname,OID,TotalPrice):-
    customer(CID, Cname),
    order(CID, OID, List),
    calcOrder(List,TotalPrice).

% Problem 6
isBoycott(C):-
boycott_company(C,_).
isBoycott(I):-
item(I,X,_),isBoycott(X).

% problem 9

is_Alternative(Item, List, [NewItem|List]) :-
    alternative(Item, NewItem).
is_Alternative(Item, List, [Item|List]) :-
    \+ alternative(Item, _).

checklist([], []).
checklist([H|T], NewList) :-
    checklist(T, TempList),
    is_Alternative(H, TempList, NewList).

replaceBoycottItemsFromAnOrder(Cname, OID, NewList) :-
    customer(CID, Cname),
    order(CID, OID, List),
    checklist(List, NewList).


% Problem 10
calcPriceAfterReplacingBoycottItemsFromAnOrder(Cname,OID,NewList,TotalPrice):-
replaceBoycottItemsFromAnOrder(Cname, OID, NewList), calcOrder(NewList,TotalPrice).

% problem 11
getTheDifferenceInPriceBetweenItemAndAlternative(BoycottItem, Alt, DiffPrice):-
	alternative(BoycottItem, Alt),
	item(Alt, _, AltPrice),
	item(BoycottItem, _, BoycottPrice),
	DiffPrice is BoycottPrice - AltPrice.
% problem 11 Done


% Bonus
% insert / remove item
add_item(ItemName, Company, Price):-
	assertz(item(ItemName, Company, Price)).

remove_item(ItemName, Company, Price):-
	retract(item(ItemName, Company, Price)).


% insert / remove alternative
add_alternative(ItemName, Alt):-
	assertz(alternative(ItemName, Alt)).

remove_alternative(ItemName, Alt):-
	retract(alternative(ItemName, Alt)).


% insert / remove boycott
add_boycott_company(CompName, Description):-
	assertz(boycott_company(CompName, Descriptio)).

remove_boycott_company(CompName, Descriptio):-
	retract(boycott_company(CompName, Descriptio)).

