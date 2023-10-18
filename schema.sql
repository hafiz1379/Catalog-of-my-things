CREATE TABLE Label (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255),
    color VARCHAR(20)
);

CREATE TABLE Item (
    id INT PRIMARY KEY AUTO_INCREMENT,

    label_id INT,
    publish_date DATE,
    archived BOOLEAN,

    FOREIGN KEY (label_id) REFERENCES Label(id)
);

CREATE TABLE Book (
    item_id INT PRIMARY KEY,
    publisher VARCHAR(255),
    cover_state VARCHAR(50),
    FOREIGN KEY (item_id) REFERENCES Item(id)
);