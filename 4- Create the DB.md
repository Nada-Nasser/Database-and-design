### **1. Customers Table**

```sql
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DoB DATE,
    PaymentInfo VARCHAR(100),
    JoinDate DATE,
    ReferredByCustomerID INT,
    FOREIGN KEY (ReferredByCustomerID) REFERENCES Customers(CustomerID)
);
```

---

### **2. CustomerContact Table**

```sql
CREATE TABLE CustomerContact (
    CustomerID INT PRIMARY KEY,
    Address VARCHAR(255),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);
```

---

### **3. Pets Table**

```sql
CREATE TABLE Pets (
    CustomerID INT,
    Pet# INT,
    NickName VARCHAR(50),
    Category VARCHAR(50),
    SpeciesBreed VARCHAR(50),
    Gender CHAR(1),
    DoB DATE,
    Notes TEXT,
    PRIMARY KEY (CustomerID, Pet#),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);
```

---

### **4. Species Table**

```sql
CREATE TABLE Species (
    SpeciesBreed VARCHAR(50) PRIMARY KEY,
    SpeciesBreedDescription TEXT
);
```

---

### **5. Staff Table**

```sql
CREATE TABLE Staff (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    SSN VARCHAR(20) UNIQUE,
    Address VARCHAR(255),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    DoB DATE,
    SupervisorID INT,
    FOREIGN KEY (SupervisorID) REFERENCES Staff(EmployeeID)
);
```

---

### **6. Service Table**

```sql
CREATE TABLE Service (
    ServiceID INT PRIMARY KEY,
    ServiceName VARCHAR(100),
    ServicePrice DECIMAL(10, 2),
    ServiceDescription TEXT
);
```

---

### **7. Visit Table**

```sql
CREATE TABLE Visit (
    VisitID INT PRIMARY KEY,
    Date DATE,
    Time TIME,
    CustomerID INT,
    Pet# INT,
    ServiceID INT,
    EmployeeID INT,
    Bill DECIMAL(10, 2),
    Paid BOOLEAN,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (Pet#, CustomerID) REFERENCES Pets(Pet#, CustomerID),
    FOREIGN KEY (ServiceID) REFERENCES Service(ServiceID),
    FOREIGN KEY (EmployeeID) REFERENCES Staff(EmployeeID)
);
```

---

### **8. Pets_Staff Table**

```sql
CREATE TABLE Pets_Staff (
    CustomerID INT,
    Pet# INT,
    EmployeeID INT,
    PRIMARY KEY (CustomerID, Pet#, EmployeeID),
    FOREIGN KEY (CustomerID, Pet#) REFERENCES Pets(CustomerID, Pet#),
    FOREIGN KEY (EmployeeID) REFERENCES Staff(EmployeeID)
);
```

---
