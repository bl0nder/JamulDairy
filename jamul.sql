CREATE TABLE `jamul`.`product` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(90) NOT NULL,
  `Product_desc` VARCHAR(100) NULL,
  `Type` VARCHAR(45) NOT NULL,
  `Unit_price` INT NOT NULL,
  PRIMARY KEY (`Id`));

CREATE TABLE `jamul`.`admin` (
  `AdminId` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NOT NULL,
  `Password` VARCHAR(45) NOT NULL,
  `Salary` INT NOT NULL DEFAULT 0,
  `ContactNum` VARCHAR(45) NOT NULL,
  `Birthday` DATE NOT NULL,
  `HouseNum` INT NOT NULL,
  `StreetNum` VARCHAR(40) NULL DEFAULT ' ',
  `City` VARCHAR(45) NULL DEFAULT ' ',
  `State` VARCHAR(45) NOT NULL DEFAULT ' ',
  `Pincode` INT NOT NULL,
  PRIMARY KEY (`AdminId`));

CREATE TABLE `jamul`.`employee` (
  `EmployeeId` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NOT NULL,
  `Password` VARCHAR(45) NOT NULL,
  `Salary` INT NOT NULL DEFAULT 0,
  `ContactNum` VARCHAR(45) NOT NULL,
  `Birthday` DATE NOT NULL,
  `HouseNum` INT NOT NULL,
  `StreetNum` VARCHAR(40) NULL DEFAULT ' ',
  `City` VARCHAR(45) NULL DEFAULT ' ',
  `State` VARCHAR(45) NOT NULL DEFAULT ' ',
  `Pincode` INT NOT NULL,
  PRIMARY KEY (`EmployeeId`));

CREATE TABLE `jamul`.`branch` (
  `BranchId` INT NOT NULL AUTO_INCREMENT,
  `Location` VARCHAR(300) NOT NULL,
  `NumEmployees` INT NULL DEFAULT 0,
  `NumVehicles` INT NULL DEFAULT 0,
  PRIMARY KEY (`BranchId`));

ALTER TABLE employee ADD EmployeeBranchId INT;
ALTER TABLE employee ADD CONSTRAINT EmployeeBranchId FOREIGN KEY (EmployeeBranchId) REFERENCES  branch (BranchId);  

CREATE TABLE `jamul`.`customer` (
  `CustomerId` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NOT NULL,
  `Password` VARCHAR(45) NOT NULL,
  `ContactNum` VARCHAR(45) NOT NULL,
  `Birthday` DATE NOT NULL,
  `HouseNum` INT NOT NULL,
  `StreetNum` VARCHAR(40) NULL DEFAULT ' ',
  `City` VARCHAR(45) NULL DEFAULT ' ',
  `State` VARCHAR(45) NOT NULL DEFAULT ' ',
  `Pincode` INT NOT NULL,
  PRIMARY KEY (`CustomerId`));  

CREATE TABLE `jamul`.`branchcatalog` (
  `BranchId` INT NOT NULL,
  `ProductId` INT NULL,
  `Quantity` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`BranchId`),
  INDEX `productId_idx` (`ProductId` ASC) VISIBLE,
  CONSTRAINT `branchId`
    FOREIGN KEY (`BranchId`)
    REFERENCES `jamul`.`branch` (`BranchId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `productId`
    FOREIGN KEY (`ProductId`)
    REFERENCES `jamul`.`product` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);  

CREATE TABLE `jamul`.`vehicle` (
  `VehicleId` INT NOT NULL AUTO_INCREMENT,
  `Brand` VARCHAR(100) NOT NULL,
  `Model` VARCHAR(100) NOT NULL,
  `VehicleBranchId` INT NOT NULL,
  `DriverId` INT NOT NULL,
  PRIMARY KEY (`VehicleId`),
  INDEX `DriverId_idx` (`DriverId` ASC) VISIBLE,
  INDEX `BranchId_idx` (`VehicleBranchId` ASC) VISIBLE,
  CONSTRAINT `DriverId`
    FOREIGN KEY (`DriverId`)
    REFERENCES `jamul`.`employee` (`EmployeeId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `VehicleBranchId`
    FOREIGN KEY (`VehicleBranchId`)
    REFERENCES `jamul`.`branch` (`BranchId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE `jamul`.`orders` (
  `OrderId` INT NOT NULL,
  `BranchOrderId` INT NOT NULL,
  `BranchCustomerId` INT NOT NULL,
  `TotalCost` INT NOT NULL,
  `Date` DATE NOT NULL,
  INDEX `BranchOrderId_idx` (`BranchOrderId` ASC) VISIBLE,
  INDEX `CustomerOrderId_idx` (`BranchCustomerId` ASC) VISIBLE,
  CONSTRAINT `BranchOrderId`
    FOREIGN KEY (`BranchOrderId`)
    REFERENCES `jamul`.`branch` (`BranchId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `CustomerOrderId`
    FOREIGN KEY (`BranchCustomerId`)
    REFERENCES `jamul`.`customer` (`CustomerId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE `jamul`.`source` (
  `SupplierId` INT NOT NULL AUTO_INCREMENT,
  `SupplyingBranchId` INT NOT NULL,
  `Name` VARCHAR(100) NOT NULL,
  `Quantity` INT NOT NULL DEFAULT 0,
  `Date` DATE NOT NULL,
  PRIMARY KEY (`SupplierId`),
  INDEX `SupplyingBranchId_idx` (`SupplyingBranchId` ASC) VISIBLE,
  CONSTRAINT `SupplyingBranchId`
    FOREIGN KEY (`SupplyingBranchId`)
    REFERENCES `jamul`.`branch` (`BranchId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE `jamul`.`suppliercatalog` (
  `SupplierId` INT NOT NULL,
  `SuppliedProductId` INT NOT NULL,
  `SuppliedProductName` VARCHAR(90) NOT NULL,
  `SuppliedProductDesc` VARCHAR(200) NULL,
  `SuppliedProductPrice` INT NOT NULL,
  `SuppliedProductQuantity` INT NOT NULL,
  PRIMARY KEY (`SupplierId`),
  INDEX `SuppliedProductId_idx` (`SuppliedProductId` ASC) VISIBLE,
  CONSTRAINT `SupplierId`
    FOREIGN KEY (`SupplierId`)
    REFERENCES `jamul`.`source` (`SupplierId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `SuppliedProductId`
    FOREIGN KEY (`SuppliedProductId`)
    REFERENCES `jamul`.`product` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


CREATE TABLE `jamul`.`sale` (
  `ProductId` INT NOT NULL,
  `BranchId` INT NOT NULL,
  `Date` DATE NOT NULL,
  `Quantity` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`ProductId`, `BranchId`),
  INDEX `f1_idx` (`BranchId` ASC) VISIBLE,
  CONSTRAINT `f1`
    FOREIGN KEY (`BranchId`)
    REFERENCES `jamul`.`branch` (`BranchId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `f2`
    FOREIGN KEY (`ProductId`)
    REFERENCES `jamul`.`product` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
CREATE TABLE `jamul`.`addtocart` (
  `CustomerId` INT NOT NULL,
  `BranchId` INT NOT NULL,
  `ProductId` INT NOT NULL,
  `Quantity` INT NOT NULL,
  PRIMARY KEY (`CustomerId`, `BranchId`, `ProductId`),
  INDEX `f3_idx` (`BranchId` ASC) VISIBLE,
  INDEX `f5_idx` (`ProductId` ASC) VISIBLE,
  CONSTRAINT `f3`
    FOREIGN KEY (`BranchId`)
    REFERENCES `jamul`.`branch` (`BranchId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `f4`
    FOREIGN KEY (`CustomerId`)
    REFERENCES `jamul`.`customer` (`CustomerId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `f5`
    FOREIGN KEY (`ProductId`)
    REFERENCES `jamul`.`product` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

ALTER TABLE orders ADD PRIMARY KEY(OrderId);
CREATE TABLE `jamul`.`orderproductlist` (
  `OrderId` INT NOT NULL,
  `ProductId` INT NOT NULL,
  `ProductName` VARCHAR(45) NOT NULL,
  `ProductQuantity` INT NOT NULL,
  PRIMARY KEY (`OrderId`),
  INDEX `f7_idx` (`ProductId` ASC) VISIBLE,
  CONSTRAINT `f6`
    FOREIGN KEY (`OrderId`)
    REFERENCES `jamul`.`orders` (`OrderId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `f7`
    FOREIGN KEY (`ProductId`)
    REFERENCES `jamul`.`product` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE `jamul`.`customerorderhistory` (
  `CustomerId` INT NOT NULL,
  `OrderId` INT NOT NULL,
  PRIMARY KEY (`OrderId`),
  INDEX `f9_idx` (`CustomerId` ASC) VISIBLE,
  CONSTRAINT `f9`
    FOREIGN KEY (`CustomerId`)
    REFERENCES `jamul`.`customer` (`CustomerId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `f10`
    FOREIGN KEY (`OrderId`)
    REFERENCES `jamul`.`orders` (`OrderId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);    
    
    CREATE TABLE `jamul`.`homedelivery` (
  `Branch_Id` INT NOT NULL,
  `Vehicle_Id` INT NOT NULL,
  INDEX `f13_idx` (`Branch_Id` ASC) VISIBLE,
  INDEX `f14_idx` (`Vehicle_Id` ASC) VISIBLE,
  CONSTRAINT `f13`
    FOREIGN KEY (`Branch_Id`)
    REFERENCES `jamul`.`branch` (`BranchId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `f14`
    FOREIGN KEY (`Vehicle_Id`)
    REFERENCES `jamul`.`vehicle` (`VehicleId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
    CREATE TABLE `jamul`.`manager` (
  `Manager_Id` INT NOT NULL,
  `Branch_Id` INT NOT NULL,
  PRIMARY KEY (`Manager_Id`, `Branch_Id`),
  INDEX `f66_idx` (`Branch_Id` ASC) VISIBLE,
  CONSTRAINT `f55`
    FOREIGN KEY (`Manager_Id`)
    REFERENCES `jamul`.`employee` (`EmployeeId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `f66`
    FOREIGN KEY (`Branch_Id`)
    REFERENCES `jamul`.`branch` (`BranchId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

