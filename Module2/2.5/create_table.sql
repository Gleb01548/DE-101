DROP TABLE IF EXISTS company.sales;
DROP TABLE IF EXISTS company.region;
DROP TABLE IF EXISTS company.address_data;
DROP TABLE IF EXISTS company.ship_mode;
DROP TABLE IF EXISTS company.customer;
DROP TABLE IF EXISTS company.product;
DROP TABLE IF EXISTS company.returned;

drop schema if exists company;
create schema company;

CREATE TABLE company.sales (
    sales_id serial NOT NULL,
    order_id varchar(30) NOT NULL,
    sales numeric NOT NULL,
    profit numeric NOT NULL,
    discount numeric,
    order_date DATE NOT NULL,
    ship_date DATE NOT NULL,
    region_id integer NOT NULL,
    address_data_id integer NOT NULL,
    customer_id integer NOT NULL,
    ship_mode_id integer NOT NULL,
    product_id integer NOT NULL,
    returned_id integer,
    CONSTRAINT sales_pk PRIMARY KEY (sales_id)
) WITH (
  OIDS=FALSE
);


CREATE TABLE company.region (
    region_region_id serial NOT NULL,
    region varchar(30) NOT NULL,
    person varchar(50) NOT NULL,

    CONSTRAINT region_pk PRIMARY KEY (region_region_id),
    CONSTRAINT region_unique UNIQUE (region, person)
) WITH (
  OIDS=FALSE
);


CREATE TABLE company.address_data (
    address_data_id serial NOT NULL,
    country varchar(50) NOT NULL,
    state varchar(50) NOT NULL,
    city varchar(50),
    postal_code varchar(10),

    CONSTRAINT address_data_pk PRIMARY KEY (address_data_id),
    CONSTRAINT address_data_unique UNIQUE (country, state, city, postal_code)
) WITH (
  OIDS=FALSE
);

CREATE TABLE company.ship_mode (
    ship_mode_id serial NOT NULL,
    ship_name varchar(30) NOT NULL UNIQUE,
    
    CONSTRAINT ship_mode_pk PRIMARY KEY (ship_mode_id)) 
    WITH (
  OIDS=FALSE
);


CREATE TABLE company.customer (
    customer_id serial NOT NULL,
    customer_id_original varchar(15) NOT NULL UNIQUE,
    customer_name varchar(50) NOT NULL,
    segment varchar(20) NOT NULL,

    CONSTRAINT customer_pk PRIMARY KEY (customer_id),
    CONSTRAINT customer_unique UNIQUE (customer_id_original, customer_name, segment)
) WITH (
  OIDS=FALSE
);


CREATE TABLE company.product (
    product_id serial NOT NULL,
    product_name varchar(500) NOT NULL,
    category varchar(50) NOT NULL,
    subcategory varchar(50) NOT NULL,

    CONSTRAINT product_pk PRIMARY KEY (product_id),
    CONSTRAINT product_unique_value UNIQUE (product_name, category, subcategory)

) WITH (
  OIDS=FALSE
);

CREATE TABLE company.returned (
    returned_id serial NOT NULL,
    returned varchar(10) NOT NULL UNIQUE,
    CONSTRAINT returned_pk PRIMARY KEY (returned_id)
);


ALTER TABLE company.sales ADD CONSTRAINT sales_fk0 FOREIGN KEY (region_id) REFERENCES company.region(region_region_id);
ALTER TABLE company.sales ADD CONSTRAINT sales_fk1 FOREIGN KEY (address_data_id) REFERENCES company.address_data(address_data_id);
ALTER TABLE company.sales ADD CONSTRAINT sales_fk2 FOREIGN KEY (customer_id) REFERENCES company.customer(customer_id);
ALTER TABLE company.sales ADD CONSTRAINT sales_fk3 FOREIGN KEY (ship_mode_id) REFERENCES company.ship_mode(ship_mode_id);
ALTER TABLE company.sales ADD CONSTRAINT sales_fk4 FOREIGN KEY (product_id) REFERENCES company.product(product_id);
ALTER TABLE company.sales ADD CONSTRAINT sales_fk5 FOREIGN KEY (returned_id) REFERENCES company.returned(returned_id);

