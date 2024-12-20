
### ER Diagram

![[Pasted image 20241218234841.png]]
### Relational Model

#### 1. **Customers Table**

| Column Name | Data Type | Constraints                                  |
| ----------- | --------- | -------------------------------------------- |
| CustomerID  | INT       | PRIMARY KEY                                  |
| FirstName   | VARCHAR   | NOT NULL                                     |
| LastName    | VARCHAR   | NOT NULL                                     |
| Address     | VARCHAR   |                                              |
| Email       | VARCHAR   | UNIQUE                                       |
| Phone       | VARCHAR   | UNIQUE                                       |
| DoB         | DATE      |                                              |
| PaymentInfo | VARCHAR   |                                              |
| JoinDate    | DATE      |                                              |
| ReferredBy  | INT       | FOREIGN KEY REFERENCES Customers(CustomerID) |

---

#### 2. **Pets Table**

|Column Name|Data Type|Constraints|
|---|---|---|
|CustomerID|INT|FOREIGN KEY REFERENCES Customers(CustomerID)|
|Pet#|INT|PRIMARY KEY, AUTO_INCREMENT|
|NickName|VARCHAR|NOT NULL|
|Address|VARCHAR||
|Email|VARCHAR||
|Phone|VARCHAR||
|Category|VARCHAR||
|Species/Breed|VARCHAR||
|Species/BreedDescription|VARCHAR||
|Gender|VARCHAR||
|DoB|DATE||
|Notes|TEXT||

---

#### 3. **Staff Table**

|Column Name|Data Type|Constraints|
|---|---|---|
|EmployeeID|INT|PRIMARY KEY, AUTO_INCREMENT|
|FirstName|VARCHAR|NOT NULL|
|LastName|VARCHAR|NOT NULL|
|SSN|VARCHAR|UNIQUE|
|Address|VARCHAR||
|Email|VARCHAR|UNIQUE|
|Phone|VARCHAR|UNIQUE|
|DoB|DATE||
|SupervisorID|INT|FOREIGN KEY REFERENCES Staff(EmployeeID)|

---

#### 4. **Visit Table**

|Column Name|Data Type|Constraints|
|---|---|---|
|VisitID|INT|PRIMARY KEY, AUTO_INCREMENT|
|Date|DATE|NOT NULL|
|Time|TIME||
|CustomerID|INT|FOREIGN KEY REFERENCES Customers(CustomerID)|
|PetID|INT|FOREIGN KEY REFERENCES Pets(Pet#)|
|ServiceID|INT|FOREIGN KEY REFERENCES Service(ServiceID)|
|StaffID|INT|FOREIGN KEY REFERENCES Staff(EmployeeID)|
|Bill|DECIMAL(10,2)||
|Paid|BOOLEAN|DEFAULT FALSE|

---

#### 5. **Service Table**

|Column Name|Data Type|Constraints|
|---|---|---|
|ServiceID|INT|PRIMARY KEY, AUTO_INCREMENT|
|ServiceName|VARCHAR|NOT NULL|
|ServicePrice|DECIMAL(10,2)||
|ServiceDescription|TEXT||

---

### Relationships in the Relational Model

1. **Customers → Pets**: 1-to-Many (A customer can have multiple pets).
    
    - **Foreign Key**: `Pets.CustomerID → Customers.CustomerID`
2. **Customers → Visit**: 1-to-Many (A customer can have multiple visits).
    
    - **Foreign Key**: `Visit.CustomerID → Customers.CustomerID`
3. **Pets → Visit**: 1-to-Many (A pet can have multiple visits).
    
    - **Foreign Key**: `Visit.PetID → Pets.Pet#`
4. **Staff → Visit**: 1-to-Many (A staff member can handle multiple visits).
    
    - **Foreign Key**: `Visit.StaffID → Staff.EmployeeID`
5. **Visit → Service**: Many-to-One (Each visit involves one service).
    
    - **Foreign Key**: `Visit.ServiceID → Service.ServiceID`
6. **Staff → Staff**: Self-referencing relationship for supervisors.
    
    - **Foreign Key**: `Staff.SupervisorID → Staff.EmployeeID`
7. **Customers → Customers**: Self-referencing relationship for referrals.
    
    - **Foreign Key**: `Customers.ReferredBy → Customers.CustomerID`

---

