//1 menampilkan postingan dengan 0 komentar
DELIMITER &&  
CREATE OR REPLACE PROCEDURE get_zero_comments()  
BEGIN  
    SELECT tbl_scraping.`id`, tbl_scraping.`ig_username`, tbl_scraping.`url`, tbl_scraping.`comment_count` 
    FROM tbl_scraping WHERE comment_count = 0;    
END &&  
DELIMITER ;

//pemanggilan
CALL get_zero_comments()

//2 menunjukkan berapa lama postingan tersebut dipost
DELIMITER //
CREATE FUNCTION lama_postingan(date1 DATE) RETURNS INT DETERMINISTIC
BEGIN
 DECLARE date2 DATE;
  SELECT CURRENT_DATE()INTO date2;
  RETURN (TO_DAYS(date2)-TO_DAYS(date1));
END 
//
DELIMITER ;

//pemanggilan
SELECT id, ig_username, url, like_count, comment_count, (lama_postingan(taken_at)) AS umur_postingan_dalam_hari
FROM tbl_scraping

//3 menghitung jumlah postingan di tahun 2021

CREATE VIEW user_post_2021 AS
SELECT ig_username, COUNT(ig_username) AS total_konten_di_2021
FROM tbl_scraping
WHERE taken_at BETWEEN '2021-01-01' AND '2022-01-01'
GROUP BY ig_username

//pemanggilan
SELECT * FROM user_post_2021