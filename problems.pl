:- consult(data).
:- dynamic item/3.
:- dynamic alternative/2.
:- dynamic boycott_company/2.

%_____________________________________________________________

%append lists

concat([], L2, L2).

concat([H | T], L2, [H | R]) :-
	concat(T, L2, R).


%insert element at the end
push_back(L, E, R):-
	concat(L, [E], R).

%insert element at the beg
push_front(L, E, R):-
	concat([E], L, R).

%_____________________________________________________________

list_orders(CustomerName, AllOrders) :-
	list_orders(CustomerName, 1, [], AllOrders).

list_orders(CustomerName, OrderNum, Orders, AllOrders) :-
	customer(CustomerID, CustomerName),
	order(CustomerID, OrderNum, Items),
	NextOrderNum is OrderNum + 1,
	push_front(Orders, order(CustomerID, OrderNum, Items), NewAllOrders),
	list_orders(CustomerName, NextOrderNum, NewAllOrders, AllOrders).

list_orders(_, _, Orders, Orders).
%_____________________________________________________________


% problem 2
countOrdersOfCustomer(CustomerUserName, Count):-
	list_orders(CustomerUserName, AllOrders),
        countOrders(AllOrders, Count).

countOrders([],0).
countOrders([_|T], Count):-
    countOrders(T,NewCount),
    Count is NewCount+1.

%_____________________________________________________________


% problem 3
getItemsInOrderById(CustomerUsername, OrderID, Items) :-
	customer(CustomerID, CustomerUsername),
	order(CustomerID, OrderID, Items).
% problem 3 Done

%_____________________________________________________________

% problem 4
getNumOfItems(CustomerUserName, OrderID, Count):-
    customer(CustomerID, CustomerUserName),
    order(CustomerID, OrderID,Items),
    countItems(Items,Count).

countItems([],0).
countItems([_|T],Count):-
    countItems(T,NewCount),
    Count is NewCount+1.
%_____________________________________________________________

% Problem 5

calcPriceOfOrder1(Name,Oid,TotalPrice):-
    order(Name,Oid,List),calcPrice(List,0,TotalPrice).

calcPrice([],TotalPrice,TotalPrice).

calcPrice([Item|Tail],Price1,TotalPrice):-
    item(Item,_,Price),
    NewPrice is Price1 + Price,
    calcPrice(Tail,NewPrice,TotalPrice).
%_____________________________________________________________


% Problem 5
calcOrder([],0).
calcOrder([H|T],Price):-
calcOrder(T,P1),item(H,_,P),Price is P1+P.

calcPriceOfOrder(Cname,OID,TotalPrice):-
    customer(CID, Cname),
    order(CID, OID, List),
    calcOrder(List,TotalPrice).

%_____________________________________________________________


% Problem 6
isBoycott(C):-
boycott_company(C,_).
isBoycott(I):-
item(I,X,_),isBoycott(X).

%_____________________________________________________________

%problem 7
whyToBoycott(X,Justification) :-
    boycott_company(X, Justification).

whyToBoycott(X,Justification) :-
    item(X,Company,_),
    boycott_company(Company,Justification).

%_____________________________________________________________

%problem 8

removeBoycottItemsFromAnOrder(Name,Oid,NewList):-
	customer(CID, Name),
	order(CID,Oid,PrevList),
	deleteItems(PrevList,NewList).


deleteItems([],[]).

deleteItems([Item|Tail],NewList):-
    \+ alternative(Item,_),
    deleteItems(Tail,NewTail),
    NewList = [Item|NewTail].

deleteItems([_|Tail], NewList) :-
    deleteItems(Tail, NewList).
%_____________________________________________________________


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

%_____________________________________________________________


% Problem 10
calcPriceAfterReplacingBoycottItemsFromAnOrder(Cname,OID,NewList,TotalPrice):-
replaceBoycottItemsFromAnOrder(Cname, OID, NewList), calcOrder(NewList,TotalPrice).

%_____________________________________________________________


% problem 11
getTheDifferenceInPriceBetweenItemAndAlternative(BoycottItem, Alt, DiffPrice):-
	alternative(BoycottItem, Alt),
	item(Alt, _, AltPrice),
	item(BoycottItem, _, BoycottPrice),
	DiffPrice is BoycottPrice - AltPrice.
% problem 11 Done

%_____________________________________________________________


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
	assertz(boycott_company(CompName, Description)).

remove_boycott_company(CompName, Description):-
	retract(boycott_company(CompName, Description)).

