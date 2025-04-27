-- Proje: �irket Y�netimi Veritaban�
-- A��klama: Bu projede �irket departmanlar� ve �al��anlar� y�netmek i�in temel veritaban� yap�lar� ve stored procedure'ler kullan�lm��t�r.

CREATE DATABASE sirket_yonetimi;

USE sirket_yonetimi;
--departman tablosu olu�turuldu
CREATE TABLE departmanlar (
    departman_id INT PRIMARY KEY IDENTITY(1,1),
    departman_adi VARCHAR(100) NOT NULL
);
GO
--�al��anlar tablosu olu�turuldu
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
--departmanlar i�in veri ekliyoruz
INSERT INTO departmanlar (departman_adi) VALUES
('�nsan Kaynaklar�'),
('Muhasebe'),
('Bilgi Teknolojileri'),
('Sat��'),
('Pazarlama');
GO

--�al��anlar i�in veri giri�i
INSERT INTO calisanlar (isim, soyisim, departman_id, maas, ise_baslama_tarihi) VALUES
('Ahmet', 'Y�lmaz', 1, 12000, '2022-01-15'),
('Ay�e', 'Demir', 2, 11000, '2021-05-10'),
('Mehmet', 'Kara', 3, 15000, '2023-07-20'),
('Elif', '�ahin', 4, 9000, '2022-03-01'),
('Deniz', '�zt�rk', 5, 9500, '2020-11-25');
GO

--�al��anlar�n maa��n� artt�ran stored procedure
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

--yeni �al��an ekleyen stored procedure
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
--maa� artt�ran stored prosed�r� �a��r
EXEC maas_arttir @calisan_id = 3, @artis_miktari = 2000;
GO

--yeni �al��an ekleme
EXEC yeni_calisan_ekle 
    @isim = 'Fatma',
    @soyisim = 'Ko�',
    @departman_id = 3,
    @maas = 13500,
    @ise_baslama_tarihi = '2025-04-25';
GO


SELECT * FROM calisanlar;
SELECT * FROM departmanlar;