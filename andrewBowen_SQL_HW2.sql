-- Andrew Bowen
-- SQL Bridge Program: Week 2 HW


DROP TABLE IF EXISTS videos;
DROP TABLE IF EXISTS reviewers;

CREATE TABLE videos (id int,
					 title varchar(255),
                     video_length double,
                     url varchar(255)
                     );
-- Inserting vids into videos table
INSERT INTO videos (id, title, video_length, url) 
VALUES (10001, 
		'5 Tips For Object-Oriented Programming Done Well - In Python',
        16.1,
		'https://www.youtube.com/watch?v=-ghD-XjjO2g');
        
INSERT INTO videos (id, title, video_length, url) 
VALUES (10002, 
		'4 SQL Tips For Data Scientists And Data Analysts',
        14.75,
		'https://www.youtube.com/watch?v=kSt9NV-qZkc');      

INSERT INTO videos (id, title, video_length, url) 
VALUES (10003, 
		'5 Ways to Improve Your SQL Queries',
        10.05,
		'https://www.youtube.com/watch?v=V-4_PAMBSjY');

-- Creating and inserting values into reviewers table
CREATE TABLE reviewers (video_id int,
						reviewer_name varchar(50),
                        rating int,
                        review varchar(50)
                     );

INSERT INTO reviewers (video_id, reviewer_name, rating, review)
VALUES (10001, 'Ryan', 4, 'Good vid, love python!');
INSERT INTO reviewers (video_id, reviewer_name, rating, review)
VALUES (10002, 'Edwin', 5, 'Best SQL video ever!!!');
INSERT INTO reviewers (video_id, reviewer_name, rating, review)
VALUES (10002, 'Angelica', 2, 'Worst SQL video ever!!!');

-- Writing a left join statement to grab reviews for each video in our videos table
SELECT videos.id, videos.title, reviewers.reviewer_name, reviewers.rating, reviewers.review
FROM videos
LEFT JOIN reviewers ON videos.id=reviewers.video_id