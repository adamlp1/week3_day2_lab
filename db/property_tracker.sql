DROP TABLE IF EXISTS properties;

CREATE TABLE properties(

  id SERIAL4 PRIMARY KEY,
  address VARCHAR(255),
  value INT2,
  num_of_rooms INT2,
  year_built INT2
);
