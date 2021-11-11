CREATE DATABASE Library
USE Library

CREATE TABLE Users(
	userID int,/*primary key*/
	username varchar(50),
	familyname varchar(50),
	age  int,
	PRIMARY KEY (userID)
);

CREATE TABLE Book(
	bookID int,/*primary key*/
	Title varchar(50),
	Author varchar(50),
	Publisher varchar(50),
	Edition int,	
	PRIMARY KEY (bookID)
)

CREATE TABLE Shelf(
	shelfID int,/*primary key*/
	ownerID int,
	topic varchar(50), 
	bookID varchar(50),
	PRIMARY KEY (shelfID)
)

CREATE TABLE ShelfBook(
	ShelfID int FOREIGN KEY REFERENCES Shelf(ShelfID),
	BookID int FOREIGN KEY REFERENCES Book(BookID),
)

INSERT INTO Users VALUES(2,'armina','sadeghi',20)
INSERT INTO Users VALUES(3,'ali','sadeghi',45)
INSERT INTO Book VALUES(1,'ravesh','safabakhsh','amirkabir',5)
INSERT INTO Book VALUES(2,'elec','momtazpour','amirkabir',5)
INSERT INTO Shelf VALUES(1,2,'science',1)
INSERT INTO Shelf VALUES(2,2,'science',2)

INSERT INTO ShelfBook(ShelfID)
SELECT ShelfID FROM Shelf

INSERT INTO ShelfBook(BookID)
SELECT bookID FROM Book

/*INSERT INTO ShelfBook VALUES(1,1,1)
INSERT INTO ShelfBook VALUES(2,2,0)*/

/*نمایش همه ی کتاب ها*/
SELECT * FROM Book

/*نمایش همه ی کاربرها */
SELECT * FROM Users

/*نمایش همه ی قفسه ها*/
SELECT * FROM Shelf

/*تمام قفسه های یک کاربر*/
SELECT Users.username, Shelf.topic, Book.Title, Book.Author
FROM Shelf 
INNER JOIN Users ON Users.userID = Shelf.ownerID
INNER JOIN Book ON Shelf.BookID = Book.bookID
ORDER BY Users.username

/*تعداد کتاب های هر کاربر*/
SELECT Users.username, COUNT(Book.bookID) AS [numbe of books]
FROM Shelf 
INNER JOIN Users ON Users.userID = Shelf.ownerID
INNER JOIN Book ON Shelf.BookID = Book.bookID
GROUP BY Users.username


DROP TABLE ShelfBook;
DROP TABLE Users;
DROP TABLE Shelf;
DROP TABLE Book;


ALTER TABLE ShelfBook
ADD ReadStatus int NOT NULL DEFAULT 0

SELECT * FROM ShelfBook 

ALTER TABLE ShelfBook
DROP COLUMN ReadStatus;
/*وضعیت خوانده شده یا خوانده نشده هر کاربر*/
SELECT Users.username,
Count(*) AS totalBooks,
sum(Case when ShelfBook.ReadStatus=1 then 1 else 0 end) AS is_read,
sum(case when ShelfBook.ReadStatus=0 then 1 else 0 end) AS is_not_read
FROM Shelf
INNER JOIN Users ON Users.userID = Shelf.ownerID
INNER JOIN ShelfBook ON Shelf.shelfID=ShelfBook.shelfID
Group by Users.username

/*تعداد کتاب های خوانده شده هر کاربر*/
SELECT Users.username,
Count(*) AS totalBooks,
sum(Case when ShelfBook.ReadStatus=1 then 1 else 0 end) AS is_read
FROM Shelf
INNER JOIN Users ON Users.userID = Shelf.ownerID
INNER JOIN ShelfBook ON Shelf.shelfID=ShelfBook.shelfID
Group by Users.username


