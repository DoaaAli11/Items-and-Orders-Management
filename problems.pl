:- consult(data).
:- dynamic item/3.
:- dynamic alternative/2.
:- dynamic boycott_company/2.

% problem 3
getItemsInOrderById(CustomerUsername, OrderID, Items) :-
	customer(CustomerID, CustomerUsername),
	order(CustomerID, OrderID, Items).
% problem 3 Done

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

