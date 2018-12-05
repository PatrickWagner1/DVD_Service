CREATE USER dvd_user WITH ENCRYPTED PASSWORD 'dvd_password';
GRANT ALL PRIVILEGES ON DATABASE dvd_db TO dvd_user;
-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle Category
--

CREATE TABLE Category (
  id int NOT NULL,
  name text NOT NULL
) ;

--
-- Daten für Tabelle Category
--

INSERT INTO Category (id, name) VALUES
(0, 'Standard'),
(1, 'Collectors Edition'),
(2, 'Directors Cut'),
(3, 'Censored Version'),
(4, 'Extended Edition');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle DVD
--

CREATE TABLE DVD (
  id int NOT NULL,
  id_category int NOT NULL,
  price double precision NOT NULL,
  title text NOT NULL
) ;

--
-- Daten für Tabelle DVD
--

INSERT INTO DVD (id, id_category, price, title) VALUES
(0, 1, 1.20, ''),
(1, 2, 50.00, ''),
(2, 3, 10.00, ''),
(3, 4, 20.00,''),
(4, 1, 5.0,''),
(5, 1, 5.0,''),
(6, 2, 15.0,''),
(7, 2, 15.0,'');
-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle DVD_has_Film
--

CREATE TABLE DVD_has_Film (
  id_DVD int NOT NULL,
  id_Film int NOT NULL
) ;

--
-- Daten für Tabelle DVD_has_Film
--

INSERT INTO DVD_has_Film (id_DVD, id_Film) VALUES
(0, 0),
(1, 2),
(1, 3),
(1, 4),
(2, 5),
(3, 6),
(4, 7),
(5, 8),
(5, 1),
(6, 9),
(7, 10);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle Film
--

CREATE TABLE Film (
  id int NOT NULL,
  title text DEFAULT NULL
) ;

--
-- Daten für Tabelle Film
--

INSERT INTO Film (id, title) VALUES
(0, 'Pipi und die wilden Piraten'),
(1, 'Star Wars, die jagt auf Kahn'),
(2, 'Frankreich>Deutschland (Natürlich in qm)'),
(3, 'Renault vs. Ferrari'),
(4, 'Erstes Jahr als Student'),
(5, 'Homosexualität in SciFy'),
(6, 'Star Treck, das erschlaffen der Macht'),
(7, 'Harry Poter und ein Stein'),
(8, 'Juressic Park, a fallen Franchise'),
(9, 'Das macht mich Agro'),
(10, '008: Der kleine Bruder von James Bond');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle Inventory
--

CREATE TABLE Inventory (
  inventory_number int NOT NULL,
  id_DVD int NOT NULL,
  id_Condition int NOT NULL,
  aviable smallint DEFAULT NULL
) ;

--
-- Daten für Tabelle Inventory
--

INSERT INTO Inventory (inventory_number, id_DVD, id_Condition, aviable) VALUES
(2, 0, 0, 1),
(10, 0, 1, 0),
(11, 0, 2, 0),
(12, 0, 3, 1),
(3, 1, 0, 1),
(4, 2, 0, 0),
(5, 3, 0, 1),
(6, 4, 0, 1),
(13, 4, 4, 1),
(7, 5, 0, 0),
(8, 6, 0, 0),
(9, 7, 0, 1);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle Wear
--

CREATE TABLE Wear (
  id int NOT NULL,
  name text NOT NULL
) ;

--
-- Daten für Tabelle Wear
--

INSERT INTO Wear (id, name) VALUES
(0, 'New'),
(1, 'Broken'),
(2, 'Minimal wear'),
(3, 'Used'),
(4, 'Heavily used');


--
-- Indizes der exportierten Tabellen
--

--
-- Indizes für die Tabelle Category
--
ALTER TABLE Category
  ADD PRIMARY KEY (id);

--
-- Indizes für die Tabelle DVD
--
ALTER TABLE DVD
  ADD PRIMARY KEY (id),
  ADD KEY FK_Category (id_category);

--
-- Indizes für die Tabelle DVD_has_Film
--
ALTER TABLE DVD_has_Film
  ADD KEY FK_DVD_has_Film_Film (id_Film),
  ADD KEY FK_DVD_has_Film_DVD (id_DVD);

--
-- Indizes für die Tabelle Film
--
ALTER TABLE Film
  ADD PRIMARY KEY (id);

--
-- Indizes für die Tabelle Inventory
--
ALTER TABLE Inventory
  ADD PRIMARY KEY (inventory_number),
  ADD KEY FK_DVD (id_DVD),
  ADD KEY FK_Condition (id_Condition);

--
-- Indizes für die Tabelle Wear
--
ALTER TABLE Wear
  ADD PRIMARY KEY (id);

--
-- AUTO_INCREMENT für exportierte Tabellen
--

--
-- AUTO_INCREMENT für Tabelle Inventory
--
ALTER TABLE Inventory
  MODIFY inventory_number int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints der exportierten Tabellen
--

--
-- Constraints der Tabelle DVD
--
ALTER TABLE DVD
  ADD CONSTRAINT FK_Category FOREIGN KEY (id_category) REFERENCES Category (id) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints der Tabelle DVD_has_Film
--
ALTER TABLE DVD_has_Film
  ADD CONSTRAINT FK_DVD_has_Film_DVD FOREIGN KEY (id_DVD) REFERENCES DVD (id) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT FK_DVD_has_Film_Film FOREIGN KEY (id_Film) REFERENCES Film (id) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints der Tabelle Inventory
--
ALTER TABLE Inventory
  ADD CONSTRAINT FK_Condition FOREIGN KEY (id_Condition) REFERENCES Wear (id) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT FK_DVD FOREIGN KEY (id_DVD) REFERENCES DVD (id) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO dvd_user;

