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


% problem 3
getItemsInOrderById(CustomerUsername, OrderID, Items) :-
	customer(CustomerID, CustomerUsername),
	order(CustomerID, OrderID, Items).
% problem 3 Done

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
	assertz(boycott_company(CompName, Descriptio)).

remove_boycott_company(CompName, Descriptio):-
	retract(boycott_company(CompName, Descriptio)).

