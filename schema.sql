CREATE TABLE Genre (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE Label (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    color VARCHAR(20)
);

CREATE TABLE Item (
    id INT PRIMARY KEY AUTO_INCREMENT,

    label_id INT NOT NULL,
    publish_date DATE NOT NULL,
    archived BOOLEAN NOT NULL,

    FOREIGN KEY (label_id) REFERENCES Label(id)
);

CREATE TABLE Music_album (
    id INT PRIMARY KEY AUTO_INCREMENT,
    on_spotify BOOLEAN NOT NULL,
    item_id INT NOT NULL,
    FOREIGN KEY (item_id) REFERENCES Item(id)
);

CREATE TABLE Book (
    item_id INT PRIMARY KEY,
    publisher VARCHAR(255) NOT NULL,
    cover_state VARCHAR(50),
    FOREIGN KEY (item_id) REFERENCES Item(id)
);