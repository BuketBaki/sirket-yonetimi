-- Proje: Þirket Yönetimi Veritabaný
-- Açýklama: Bu projede þirket departmanlarý ve çalýþanlarý yönetmek için temel veritabaný yapýlarý ve stored procedure'ler kullanýlmýþtýr.

CREATE DATABASE sirket_yonetimi;

USE sirket_yonetimi;
--departman tablosu oluþturuldu
CREATE TABLE departmanlar (
    departman_id INT PRIMARY KEY IDENTITY(1,1),
    departman_adi VARCHAR(100) NOT NULL
);
GO
--çalýþanlar tablosu oluþturuldu
CREATE TABLE calisanlar (
    calisan_id INT PRIMARY KEY IDENTITY(1,1),
    isim VARCHAR(100) NOT NULL,
    soyisim VARCHAR(100) NOT NULL,
    departman_id INT,
    maas DECIMAL(10,2),
    ise_baslama_tarihi DATE,
    FOREIGN KEY (departman_id) REFERENCES departmanlar(departman_id)
);
GO
--departmanlar için veri ekliyoruz
INSERT INTO departmanlar (departman_adi) VALUES
('Ýnsan Kaynaklarý'),
('Muhasebe'),
('Bilgi Teknolojileri'),
('Satýþ'),
('Pazarlama');
GO

--çalýþanlar için veri giriþi
INSERT INTO calisanlar (isim, soyisim, departman_id, maas, ise_baslama_tarihi) VALUES
('Ahmet', 'Yýlmaz', 1, 12000, '2022-01-15'),
('Ayþe', 'Demir', 2, 11000, '2021-05-10'),
('Mehmet', 'Kara', 3, 15000, '2023-07-20'),
('Elif', 'Þahin', 4, 9000, '2022-03-01'),
('Deniz', 'Öztürk', 5, 9500, '2020-11-25');
GO

--çalýþanlarýn maaþýný arttýran stored procedure
CREATE PROCEDURE maas_arttir
    @calisan_id INT,
    @artis_miktari DECIMAL(10,2)
AS
BEGIN
    UPDATE calisanlar
    SET maas = maas + @artis_miktari
    WHERE calisan_id = @calisan_id;
END
GO

--yeni çalýþan ekleyen stored procedure
CREATE PROCEDURE yeni_calisan_ekle
    @isim VARCHAR(100),
    @soyisim VARCHAR(100),
    @departman_id INT,
    @maas DECIMAL(10,2),
    @ise_baslama_tarihi DATE
AS
BEGIN
    INSERT INTO calisanlar (isim, soyisim, departman_id, maas, ise_baslama_tarihi)
    VALUES (@isim, @soyisim, @departman_id, @maas, @ise_baslama_tarihi);
END
GO
--maaþ arttýran stored prosedürü çaðýr
EXEC maas_arttir @calisan_id = 3, @artis_miktari = 2000;
GO

--yeni çalýþan ekleme
EXEC yeni_calisan_ekle 
    @isim = 'Fatma',
    @soyisim = 'Koç',
    @departman_id = 3,
    @maas = 13500,
    @ise_baslama_tarihi = '2025-04-25';
GO


SELECT * FROM calisanlar;
SELECT * FROM departmanlar;