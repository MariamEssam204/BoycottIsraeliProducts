-- Database schema creation
USE Product;

-- Create Category table
CREATE TABLE Category (
    category_id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    name NVARCHAR(100) NOT NULL,
    description NVARCHAR(MAX) NOT NULL
);

-- Create Brand table
CREATE TABLE Brand (
    brand_id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    name NVARCHAR(100) NOT NULL,
    is_boycott BIT DEFAULT 0,
    country_of_origin NVARCHAR(100),
    logo_url NVARCHAR(255)
);
GO

-- Create BoycottReasons table
CREATE TABLE BoycottReasons (
    reason_id INT IDENTITY(1,1) PRIMARY KEY,
    title NVARCHAR(255) NOT NULL,
    details NVARCHAR(MAX),
    source_url NVARCHAR(255),
    brand_id INT NOT NULL,
    FOREIGN KEY (brand_id) REFERENCES Brand(brand_id)
);
GO

-- Create Product table
CREATE TABLE Product (
    product_id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    name NVARCHAR(255) NOT NULL,
    brand_id INT NOT NULL,
    product_image varchar(MAX) NOT NULL,
    category_id INT NOT NULL,
    FOREIGN KEY (brand_id) REFERENCES Brand(brand_id),
    FOREIGN KEY (category_id) REFERENCES Category(category_id)
);
GO

-- Create AlternativeProduct table
CREATE TABLE AlternativeProduct (
    alternative_id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    name NVARCHAR(255) NOT NULL,
    country_of_origin NVARCHAR(255),
    logo_url NVARCHAR(255),
    price DECIMAL(10, 2)
);
GO

CREATE TABLE AlternativeFor ( 
    alternative_id INT NOT NULL,
    product_id INT NOT NULL,
    FOREIGN KEY (alternative_id) REFERENCES AlternativeProduct(alternative_id),
    FOREIGN KEY (product_id) REFERENCES Product(product_id)
);
GO
