--İlk hafta ödevi 
-- Eğer tablo varsa siler. 
IF OBJECT_ID('dbo.books', 'U') IS NOT NULL
    DROP TABLE dbo.books;
GO

-- Tablo oluşturur.
CREATE TABLE dbo.books (
    book_id INT PRIMARY KEY,           
    title NVARCHAR(200) NOT NULL,      
    author NVARCHAR(100) NOT NULL,     
    genre NVARCHAR(50),                
    price DECIMAL(10,2) CHECK (price >= 0),  -- 10 hane ve 2 basamaklı ayarlandı.
    stock_qty INT CHECK (stock_qty >= 0),   -- stok negatif olamaz. 
    published_year INT CHECK (published_year BETWEEN 1800 AND 2025), 
    added_at DATE                        
);
GO

-- 15 kitap kaydını tabloya ekleyelim
INSERT INTO dbo.books (book_id, title, author, genre, price, stock_qty, published_year, added_at)
VALUES
(1, 'Kayıp Zamanın İzinde', 'M. Proust', 'roman', 129.90, 25, 1913, '2025-08-20'),
(2, 'Simyacı', 'P. Coelho', 'roman', 89.50, 40, 1988, '2025-08-21'),
(3, 'Sapiens', 'Y. N. Harari', 'tarih', 159.00, 18, 2011, '2025-08-25'),
(4, 'İnce Memed', 'Y. Kemal', 'roman', 99.90, 12, 1955, '2025-08-22'),
(5, 'Körlük', 'J. Saramago', 'roman', 119.00, 7, 1995, '2025-08-28'),
(6, 'Dune', 'F. Herbert', 'bilim', 149.00, 30, 1965, '2025-09-01'),
(7, 'Hayvan Çiftliği', 'G. Orwell', 'roman', 79.90, 55, 1945, '2025-08-23'),
(8, '1984', 'G. Orwell', 'roman', 99.00, 35, 1949, '2025-08-24'),
(9, 'Nutuk', 'M. K. Atatürk', 'tarih', 139.00, 20, 1927, '2025-08-27'),
(10, 'Küçük Prens', 'A. de Saint-Exupéry', 'çocuk', 69.90, 80, 1943, '2025-08-26'),
(11, 'Başlangıç', 'D. Brown', 'roman', 109.00, 22, 2017, '2025-09-02'),
(12, 'Atomik Alışkanlıklar', 'J. Clear', 'kişisel gelişim', 129.00, 28, 2018, '2025-09-03'),
(13, 'Zamanın Kısa Tarihi', 'S. Hawking', 'bilim', 119.50, 16, 1988, '2025-08-29'),
(14, 'Şeker Portakalı', 'J. M. de Vasconcelos', 'roman', 84.90, 45, 1968, '2025-08-30'),
(15, 'Bir İdam Mahkûmunun Son Günü', 'V. Hugo', 'roman', 74.90, 26, 1829, '2025-08-31');
GO

-- Tüm verileri kontrol edelim
SELECT * FROM dbo.books;


-- Görev 1 – Tüm kitapların title, author, price alanlarını fiyatı artan şekilde listele

SELECT title, author, price
FROM dbo.books
ORDER BY price ASC;  


-- Görev 2 – Türü 'roman' olan kitapları A→Z title sırasıyla göster

SELECT title, author, genre
FROM dbo.books
WHERE genre = 'roman'
ORDER BY title ASC; 


-- Görev 3 – Fiyatı 80 ile 120 arasındaki kitaplar

SELECT title, price
FROM dbo.books
WHERE price BETWEEN 80 AND 120;  -- 80 ≤ price ≤ 120


-- Görev 4 – Stok adedi 20’den az olan kitaplar

SELECT title, stock_qty
FROM dbo.books
WHERE stock_qty < 20;


-- Görev 5 – Title içinde 'zaman' geçen kitaplar

SELECT title
FROM dbo.books
WHERE title LIKE '%zaman%';  -- % = öncesi veya sonrası olabilir


-- Görev 6 – Genre değeri 'roman' veya 'bilim' olan kitaplar

SELECT title, genre
FROM dbo.books
WHERE genre IN ('roman', 'bilim');


--Görev 7 – Published_year 2000 ve sonrası, en yeni yıldan eskiye sırala

SELECT title, published_year
FROM dbo.books
WHERE published_year >= 2000
ORDER BY published_year DESC;  


--Görev 8 – Son 10 gün içinde eklenen kitaplar

SELECT title, added_at
FROM dbo.books
WHERE added_at >= DATEADD(DAY, -10, GETDATE());


--Görev 9 – En pahalı 5 kitabı price azalan sırada listele

SELECT TOP 5 title, price
FROM dbo.books
ORDER BY price DESC;


-- Görev 10 – Stok adedi 30 ile 60 arasında olan kitapları price artan şekilde sırala

SELECT title, stock_qty, price
FROM dbo.books
WHERE stock_qty BETWEEN 30 AND 60
ORDER BY price ASC;


-- ÖĞRENDİKLERİM

-- ASC - Artan sırada sıralar (Ascending)
-- DESC -  Azalan sırada sıralar (Descending)
-- LIKE - Metin içinde belirli bir deseni arar
-- IN - Bir sütun değerinin listede olup olmadığını kontrol eder
-- SELECT - Tablodan veri seçer
-- FROM - Verinin hangi tablodan alınacağını belirtir
-- WHERE - Satırları filtreler
-- BETWEEN - Aralık sorgusu yapar
-- NOT NULL - Boş geçilemez
-- PRIMARY KEY - Benzersiz ve boş bırakılamaz alan
-- CHECK - Mantıksal kısıt uygular
-- INSERT INTO - Tabloya veri ekler
-- DATEADD - Tarih üzerinde işlem yapar (ekleme/çıkarma)
-- GETDATE() - Bugünün tarihi
-- TOP N - En üst N kaydı alır
-- ORDER BY - Sıralama yapar (ASC/DESC ile)
