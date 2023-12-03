CREATE TABLE User (
                      UserID INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
                      Username VARCHAR(255) NOT NULL,
                      Email VARCHAR(255) NOT NULL,
                      Password VARCHAR(255) NOT NULL,
                      Role ENUM('') NOT NULL
);

CREATE TABLE Feed (
                      FeedID INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
                      Name VARCHAR(255) NOT NULL,
                      Quantity INT NOT NULL
);

CREATE TABLE Animal (
                        AnimalID INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
                        Name VARCHAR(255) NOT NULL,
                        Sex ENUM('') NOT NULL,
                        Age INT NOT NULL,
                        MedicalInfo TEXT NOT NULL
);

CREATE TABLE Farm (
                      FarmID INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
                      AnimalID INT UNSIGNED,
                      UserID INT UNSIGNED NOT NULL,
                      Name VARCHAR(255) NOT NULL,
                      FOREIGN KEY (UserID) REFERENCES User(UserID) ON DELETE CASCADE,
                      FOREIGN KEY (AnimalID) REFERENCES Animal(AnimalID) ON DELETE CASCADE
);

CREATE TABLE Activity (
                          ActivityID INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
                          AnimalID INT UNSIGNED,
                          ActivityType ENUM('') NOT NULL,
                          StartTime TIME NOT NULL,
                          EndTime TIME NOT NULL,
                          Latitude INT NOT NULL,
                          Longitude INT NOT NULL,
                          FOREIGN KEY (AnimalID) REFERENCES Animal(AnimalID) ON DELETE CASCADE
);

CREATE TABLE FeedingSchedule (
                                 ScheduleID INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
                                 AnimalID INT UNSIGNED,
                                 FeedID INT UNSIGNED,
                                 FeedingTime TIME NOT NULL,
                                 FOREIGN KEY (AnimalID) REFERENCES Animal(AnimalID) ON DELETE CASCADE,
                                 FOREIGN KEY (FeedID) REFERENCES Feed(FeedID) ON DELETE CASCADE
);

CREATE TABLE Biometrics (
                            BiometricID INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
                            AnimalID INT UNSIGNED,
                            Pulse INT NOT NULL,
                            Temperature DOUBLE NOT NULL,
                            Weight DOUBLE NOT NULL,
                            BreathingRate INT NOT NULL,
                            FOREIGN KEY (AnimalID) REFERENCES Animal(AnimalID) ON DELETE CASCADE
);
