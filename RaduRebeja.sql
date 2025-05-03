CREATE DATABASE RaduRebeja;
GO

USE RaduRebeja;
GO

CREATE TABLE Echipe (
    ID_Echipa INT PRIMARY KEY IDENTITY(1,1),
    NumeEchipa NVARCHAR(50) NOT NULL,
    Categoria NVARCHAR(20) NOT NULL
);
GO

CREATE TABLE Jucatori (
    ID_Jucator INT PRIMARY KEY IDENTITY(1,1),
    Nume NVARCHAR(50) NOT NULL,
    Prenume NVARCHAR(50) NOT NULL,
    DataNasterii DATE NOT NULL,
    Pozitie NVARCHAR(30) NOT NULL,
    ID_Echipa INT FOREIGN KEY REFERENCES Echipe(ID_Echipa)
);
GO

CREATE VIEW VwJucatoriCuNumeEchipa AS
SELECT 
    J.ID_Jucator,
    J.Nume,
    J.Prenume,
    J.DataNasterii,
    J.Pozitie,
    E.NumeEchipa AS Echipa
FROM 
    Jucatori J
    LEFT JOIN Echipe E ON J.ID_Echipa = E.ID_Echipa;
GO

SELECT * FROM VwJucatoriCuNumeEchipa

CREATE TABLE Antrenori (
    ID_Antrenor INT PRIMARY KEY IDENTITY(1,1),
    Nume NVARCHAR(50) NOT NULL,
    Prenume NVARCHAR(50) NOT NULL,
    DataNasterii DATE NOT NULL,
    ExperientaAni INT NOT NULL,
    ID_Echipa INT FOREIGN KEY REFERENCES Echipe(ID_Echipa)
);
GO

CREATE VIEW VwAntrenoriCuNumeEchipa AS
SELECT 
    A.ID_Antrenor,
    A.Nume,
    A.Prenume,
    A.DataNasterii,
    A.ExperientaAni,
    E.NumeEchipa AS Echipa
FROM 
    Antrenori A
    LEFT JOIN Echipe E ON A.ID_Echipa = E.ID_Echipa;
GO

SELECT * FROM VwAntrenoriCuNumeEchipa

CREATE TABLE Meciuri (
    ID_Meci INT PRIMARY KEY IDENTITY(1,1),
    DataMeci DATE NOT NULL,
    Locatie NVARCHAR(100) NOT NULL,
    ID_EchipaGazda INT FOREIGN KEY REFERENCES Echipe(ID_Echipa),
    ID_EchipaOaspete INT FOREIGN KEY REFERENCES Echipe(ID_Echipa),
    ScorGazda INT,
    ScorOaspete INT
);
GO

CREATE VIEW VwMeciuriCuNumeEchipe AS
SELECT 
    M.ID_Meci,
    M.DataMeci,
    M.Locatie,
    EG.NumeEchipa AS EchipaGazda,
    EO.NumeEchipa AS EchipaOaspete,
    M.ScorGazda,
    M.ScorOaspete
FROM 
    Meciuri M
    INNER JOIN Echipe EG ON M.ID_EchipaGazda = EG.ID_Echipa
    INNER JOIN Echipe EO ON M.ID_EchipaOaspete = EO.ID_Echipa;
GO

SELECT * FROM VwMeciuriCuNumeEchipe
SELECT * FROM Meciuri

INSERT INTO Echipe (NumeEchipa, Categoria) VALUES
('Academia Nord', 'U14'),
('Academia Sud', 'U16'),
('Academia Vest', 'U18');
GO

INSERT INTO Jucatori (Nume, Prenume, DataNasterii, Pozitie, ID_Echipa) VALUES
('Popescu', 'Andrei', '2010-04-15', 'Fundaș', 1),
('Ionescu', 'Vlad', '2008-09-22', 'Mijlocaș', 2),
('Dumitrescu', 'Radu', '2006-01-30', 'Atacant', 3);
GO

INSERT INTO Antrenori (Nume, Prenume, DataNasterii, ExperientaAni, ID_Echipa) VALUES
('Marinescu', 'Alex', '1980-07-10', 10, 1),
('Stan', 'Mihai', '1978-11-05', 12, 2),
('Vasilescu', 'Cristian', '1985-03-18', 8, 3);
GO

INSERT INTO Meciuri (DataMeci, Locatie, ID_EchipaGazda, ID_EchipaOaspete, ScorGazda, ScorOaspete) VALUES
('2025-05-10', 'Stadion Nord', 1, 2, 2, 1),
('2025-05-15', 'Stadion Sud', 2, 3, 1, 1),
('2025-05-20', 'Stadion Vest', 3, 1, 0, 3);
GO

--------------------------------------------------------
-- Get Jucatori
CREATE PROCEDURE GetJucatori
AS
BEGIN
    SELECT * FROM Jucatori
END
GO

-- Adaugare Jucator
CREATE PROCEDURE AdaugaJucator
    @Nume NVARCHAR(50),
    @Prenume NVARCHAR(50),
    @DataNasterii DATE,
    @Pozitie NVARCHAR(30),
    @ID_Echipa INT
AS
BEGIN
    INSERT INTO Jucatori (Nume, Prenume, DataNasterii, Pozitie, ID_Echipa)
    VALUES (@Nume, @Prenume, @DataNasterii, @Pozitie, @ID_Echipa)
END;
GO

-- Stergere Jucator
CREATE PROCEDURE StergeJucator
    @ID_Jucator INT
AS
BEGIN
    DELETE FROM Jucatori WHERE ID_Jucator = @ID_Jucator
END;
GO

-- Actualizare Jucator
CREATE PROCEDURE ActualizeazaJucator
    @ID_Jucator INT,
    @Nume NVARCHAR(50),
    @Prenume NVARCHAR(50),
    @DataNasterii DATE,
    @Pozitie NVARCHAR(30),
    @ID_Echipa INT
AS
BEGIN
    UPDATE Jucatori
    SET Nume = @Nume, Prenume = @Prenume, DataNasterii = @DataNasterii,
        Pozitie = @Pozitie, ID_Echipa = @ID_Echipa
    WHERE ID_Jucator = @ID_Jucator
END;
GO

--------------------------------------------------------------------
CREATE PROCEDURE GetAntrenori
AS
BEGIN
    SELECT * FROM Antrenori
END
GO

-- Adaugare Antrenor
CREATE PROCEDURE AdaugaAntrenor
    @Nume NVARCHAR(50),
    @Prenume NVARCHAR(50),
    @DataNasterii DATE,
    @ExperientaAni INT,
    @ID_Echipa INT
AS
BEGIN
    INSERT INTO Antrenori (Nume, Prenume, DataNasterii, ExperientaAni, ID_Echipa)
    VALUES (@Nume, @Prenume, @DataNasterii, @ExperientaAni, @ID_Echipa)
END;
GO

-- Stergere Antrenor
CREATE PROCEDURE StergeAntrenor
    @ID_Antrenor INT
AS
BEGIN
    DELETE FROM Antrenori WHERE ID_Antrenor = @ID_Antrenor
END;
GO

-- Actualizare Antrenor
CREATE PROCEDURE ActualizeazaAntrenor
    @ID_Antrenor INT,
    @Nume NVARCHAR(50),
    @Prenume NVARCHAR(50),
    @DataNasterii DATE,
    @ExperientaAni INT,
    @ID_Echipa INT
AS
BEGIN
    UPDATE Antrenori
    SET Nume = @Nume, Prenume = @Prenume, DataNasterii = @DataNasterii,
        ExperientaAni = @ExperientaAni, ID_Echipa = @ID_Echipa
    WHERE ID_Antrenor = @ID_Antrenor
END;
GO

-------------------------------------------------------------------------------
-- Get Echipa
CREATE PROCEDURE GetEchipa
AS
BEGIN
    SELECT * FROM Echipe
END
GO

SELECT * FROM Echipe

-- Adaugare Echip
CREATE PROCEDURE AdaugaEchipa
    @NumeEchipa NVARCHAR(50),
    @Categoria NVARCHAR(20)
AS
BEGIN
    INSERT INTO Echipe (NumeEchipa, Categoria)
    VALUES (@NumeEchipa, @Categoria)
END;
GO

-- Stergere Echipa
CREATE PROCEDURE StergeEchipa
    @ID_Echipa INT
AS
BEGIN
    DELETE FROM Echipe WHERE ID_Echipa = @ID_Echipa
END;
GO

-- Actualizare Echipa
CREATE PROCEDURE ActualizeazaEchipa
    @ID_Echipa INT,
    @NumeEchipa NVARCHAR(50),
    @Categoria NVARCHAR(20)
AS
BEGIN
    UPDATE Echipe
    SET NumeEchipa = @NumeEchipa, Categoria = @Categoria
    WHERE ID_Echipa = @ID_Echipa
END;
GO

--------------------------------------------
-- Get Meci
CREATE PROCEDURE GetMeciuri
AS
BEGIN
    SELECT * FROM Meciuri
END
GO

-- Adaugare Meci
CREATE PROCEDURE AdaugaMeci
    @DataMeci DATE,
    @Locatie NVARCHAR(100),
    @ID_EchipaGazda INT,
    @ID_EchipaOaspete INT,
    @ScorGazda INT,
    @ScorOaspete INT
AS
BEGIN
    INSERT INTO Meciuri (DataMeci, Locatie, ID_EchipaGazda, ID_EchipaOaspete, ScorGazda, ScorOaspete)
    VALUES (@DataMeci, @Locatie, @ID_EchipaGazda, @ID_EchipaOaspete, @ScorGazda, @ScorOaspete)
END;
GO

-- Stergere Meci
CREATE PROCEDURE StergeMeci
    @ID_Meci INT
AS
BEGIN
    DELETE FROM Meciuri WHERE ID_Meci = @ID_Meci
END;
GO

-- Actualizare Meci
CREATE PROCEDURE ActualizeazaMeci
    @ID_Meci INT,
    @DataMeci DATE,
    @Locatie NVARCHAR(100),
    @ID_EchipaGazda INT,
    @ID_EchipaOaspete INT,
    @ScorGazda INT,
    @ScorOaspete INT
AS
BEGIN
    UPDATE Meciuri
    SET DataMeci = @DataMeci, Locatie = @Locatie, 
        ID_EchipaGazda = @ID_EchipaGazda, ID_EchipaOaspete = @ID_EchipaOaspete, 
        ScorGazda = @ScorGazda, ScorOaspete = @ScorOaspete
    WHERE ID_Meci = @ID_Meci
END;
GO
