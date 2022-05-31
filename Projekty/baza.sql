SET FOREIGN_KEY_CHECKS=0;

CREATE OR REPLACE TABLE customers(
    id INT(4) PRIMARY KEY AUTO_INCREMENT,
    phone_number INT(10) NOT NULL,
    pesel BIGINT(11) NOT NULL
);

CREATE OR REPLACE TABLE equipment(
    id INT(3) PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    quantity INT(10) NOT NULL,
    price_per_day DECIMAL(5,2) NOT NULL,
    producer VARCHAR(50),
    target_group ENUM('children', 'teeneger', 'adult')
);


CREATE OR REPLACE TABLE rental(
    id INT(5) PRIMARY KEY AUTO_INCREMENT,
    rental_date DATE NOT NULL,
    return_date DATE,
    days INT(2) NOT NULL,
    customer_id INT(4) NOT NULL,
    FOREIGN KEY(customer_id) REFERENCES customers(id),
    equipment_id INT(3) NOT NULL,
    quantity INT(2) NOT NULL,
    FOREIGN KEY(equipment_id) REFERENCES equipment(id)
);

CREATE OR REPLACE TABLE addresses(
    id INT(4) PRIMARY KEY AUTO_INCREMENT,
    address VARCHAR(255) NOT NULL,
    city VARCHAR(50) NOT NULL
);

CREATE OR REPLACE TABLE personal_data(
    id INT(3) PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(15) NOT NULL,
    last_name VARCHAR(16) NOT NULL,
    birth_date DATE NOT NULL,
    address_id INT NOT NULL,
    FOREIGN KEY(address_id)REFERENCES addresses(id),
    salary DECIMAL(7,2) NOT NULL
);

CREATE OR REPLACE TABLE employees(
    id INT(3) PRIMARY KEY AUTO_INCREMENT,
    personal_data_id INT(3) NOT NULL,
    function VARCHAR(20) NOT NULL,
    FOREIGN KEY(personal_data_id) REFERENCES personal_data(id)
);

CREATE OR REPLACE TABLE teams(
    id INT(4) PRIMARY KEY AUTO_INCREMENT,
    club_name VARCHAR(50) NOT NULL,
    section ENUM('junior', 'senior') NOT NULL
);

CREATE OR REPLACE TABLE meetings(
    id INT(3) PRIMARY KEY AUTO_INCREMENT,
    our_team_id INT(4) NOT NULL,
    other_team_id INT(4) NOT NULL,
    address_id INT(4),
    date DATE NOT NULL,
    FOREIGN KEY(our_team_id) REFERENCES teams(id),
    FOREIGN KEY(other_team_id) REFERENCES teams(id),
    FOREIGN KEY(address_id) REFERENCES addresses(id)
);



CREATE OR REPLACE TABLE games(
    id INT(4) PRIMARY KEY AUTO_INCREMENT,
    winning_team_id INT(4) NOT NULL,
    lost_team_id INT(4) NOT NULL,
    rank ENUM('tournament', 'friendly','1') NOT NULL,
    date DATE NOT NULL,
    FOREIGN KEY(winning_team_id) REFERENCES teams(id),
    FOREIGN KEY(lost_team_id) REFERENCES teams(id)
);


CREATE OR REPLACE TABLE players(
    id INT(3) PRIMARY KEY AUTO_INCREMENT,
    personal_data_id INT(3) NOT NULL,
    team_id INT(4) NOT NULL,
    joining_date DATE NOT NULL,
    active BIT NOT NULL,
    FOREIGN KEY(personal_data_id) REFERENCES personal_data(id),
    FOREIGN KEY(team_id) REFERENCES teams(id)
);


CREATE OR REPLACE TABLE participation(
    id INT(5) PRIMARY KEY AUTO_INCREMENT,
    player_id INT(3) NOT NULL,
    game_id INT(4) NOT NULL,
    FOREIGN KEY(player_id) REFERENCES players(id),
    FOREIGN KEY(game_id) REFERENCES games(id)
);


SET FOREIGN_KEY_CHECKS=1;
    
