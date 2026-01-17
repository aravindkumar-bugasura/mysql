-- Create table tUser
create table tUser (User_id int(11) ,
					Name varchar(50) not null,
					Email_id varchar(50) not null ,
					Password varchar(50) not null,
					Address varchar(100) null,
					Phone bigint(18) null,
					primary key (User_id));

-- Create tFriends table
create table tFriends (user_id int,
					   friend_id int ,
					   constraint fk_user foreign key (user_id) references tUser(User_id),
					   constraint fk_friend foreign key (friend_id) references tUser(User_id));	

-- Create tWall table 
create table tWall (user_id int ,
					posting_date datetime default current_timestamp ,
					post varchar(200) not null ,
					constraint fk_user_wall foreign key(user_id) references tUser(User_id));

--query to fetch all information for a person given his name
SELECT u.User_id,u.Name,u.Email_id,u.Password,u.Address,u.Phone,f.friend_id,w.posting_date,w.post 
FROM tUser u LEFT OUTER JOIN tFriends f 
ON u.User_id=f.user_id LEFT OUTER JOIN tWall w 
ON u.User_id=w.user_id 
WHERE u.Name='aravind';

--query to fetch all posts of a person given his name
SELECT w.post 
FROM tUser u LEFT OUTER JOIN tWall w 
ON u.User_id=w.user_id 
WHERE u.Name='vikram'

--query to fetch all posts of a particular friend of a person, given his name and the friends name
SELECT w.post
FROM tUser u LEFT OUTER JOIN tFriends f 
ON u.user_id = f.user_id LEFT OUTER JOIN tUser fr 
ON f.friend_id = fr.user_id LEFT OUTER JOIN tWall w 
ON w.user_id = fr.user_id
WHERE u.name = 'vikram' AND fr.name = 'ravi';

--query to fetch all friends of a particular friend of a person, given the persons name and friend's name
SELECT f3.Name, f3.User_id
FROM tUser u
LEFT OUTER JOIN tFriends f ON u.User_id = f.user_id
LEFT OUTER JOIN tUser f1 ON f1.User_id = f.friend_id
LEFT OUTER JOIN tFriends f2 ON f2.user_id = f1.User_id
LEFT OUTER JOIN tUser f3 ON f3.User_id = f2.friend_id
WHERE u.Name = 'aravind' AND f1.Name = 'vikram';

--query to remove a particular friend from a persons list, given the persons name
DELETE f
FROM tFriends f LEFT OUTER JOIN tUser u 
ON f.user_id = u.User_id LEFT OUTER JOIN tUser u1 
ON f.friend_id = u1.User_id
WHERE u.Name = 'aravind' AND u1.Name = 'vikram';

--query to post something on his wall
INSERT INTO tWall (user_id,post) 
VALUES(1,'hello ,this is my first post!');
