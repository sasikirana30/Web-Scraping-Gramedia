/*
=================================================
Milestone 1

Nama  : Sasi Novia Kirana 
Batch : CODA-RMT-019

Program ini dibuat untuk membuat database PostgreSQL dari data CSV hasil web scraping
=================================================
*/



-- Step 1 Pembuatan table staging_buku 
CREATE TABLE staging_buku (
    judul TEXT,
    harga INTEGER,
    penulis TEXT,
    diskon INTEGER
);

-- Step 2 Pembuatan tabel penulis 
CREATE TABLE penulis (
    id_penulis SERIAL PRIMARY KEY,
    nama_penulis TEXT UNIQUE
);

-- Step 3 Pembuatan tabel buku 
CREATE TABLE buku (
    id_buku SERIAL PRIMARY KEY,
    judul TEXT,
    harga INTEGER,
    diskon INTEGER,
    id_penulis INTEGER,
    FOREIGN KEY (id_penulis) REFERENCES penulis(id_penulis)
);

-- step 4 Import CSV ke staging 

COPY staging_buku(judul, harga, penulis, diskon)
FROM 'D:\PROJECT SASI\M1\novel_gramedia.csv'
DELIMITER ','
CSV HEADER;

-- step 5 Cek data dalam tabel 
-- kalau hasilnya 0 data belum ada yang masuk
SELECT COUNT(*) FROM public.staging_buku;

-- step 6 Insert data ke tabel penulis 

INSERT INTO penulis (nama_penulis)
SELECT DISTINCT penulis
FROM staging_buku;

-- step 7 Insert data ke tabel buku  
INSERT INTO buku (judul, harga, diskon, id_penulis)
SELECT
    staging_buku.judul,
    staging_buku.harga,
    staging_buku.diskon,
    penulis.id_penulis
FROM staging_buku 
JOIN penulis 
ON staging_buku.penulis = penulis.nama_penulis;












