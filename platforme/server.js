const express = require("express");
const app = express();
const port = 3003;
const path = require('path');
const mysql = require('mysql');
const bodyParser = require('body-parser');
app.use(bodyParser.json());
const fs = require('fs');
const multer = require('multer');
const storage = multer.memoryStorage(); 
const upload = multer({ storage: storage });


const connection = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: '',
  database: 'platforme'
});

connection.connect();

//add
app.get("/addclient", function (req, res) {

const { nom, prenom, age, cin, adresse,login, password } = req.body;
 

  var sql = "INSERT INTO client(nom,prenom,age,cin,adresse,login,password) VALUES (?,?,?,?,?,?,?)";

  connection.query(sql,[nom,prenom,age,cin,adresse,login,password], function (error, results, fields) {
    
    res.send("table inseré avec succés ! bonjour ");
  });
});

//add
app.use(upload.single('cv'));

app.post('/addredacteur', (req, res) => {
    const { nom, prenom, age, cin, adresse, login, password, profession, numcompte } = req.body;

    
    const cvFileBuffer = req.file ? req.file.buffer : null;

    const insertQuery = 'INSERT INTO redacteur (nom, prenom, age, cin, adresse, login, password, profession, numcompte, cv) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)';
    connection.query(insertQuery, [nom, prenom, age, cin, adresse, login, password, profession, numcompte, cvFileBuffer], (error, results, fields) => {
        if (error) {
            console.error('Erreur lors de linsertion des données :', error);
            res.status(500).send('Erreur lors de linsertion des données dans la base de données.');
        } else {
            console.log('Données insérées avec succès dans la base de données.');
            res.send('Données insérées avec succès dans la base de données.');
        }
    });
});

     // add
app.post('/addprojet', (req, res) => {
  const { titre, prix, description, delailiv, IDC} = req.body;

  
  if (!titre || !prix || !description || !delailiv || !IDC ) {
      return res.status(400).send('All fields are required.');
  }

  
  const insertQuery = 'INSERT INTO projet (titre, prix, description, delailiv, IDC, ) VALUES (?, ?, ?, ?, ?)';
  connection.query(insertQuery, [titre, prix, description, delailiv, IDC], (error, results, fields) => {
      if (error) {
          console.error('Error inserting project data:', error);
          return res.status(500).send('Error inserting project data into the database.');
      }

      console.log('Project data inserted successfully into the database.');
      res.send('Project data inserted successfully into the database.');
  });
});

//login
app.post('/login', (req, res, next) => {
  const { login, password } = req.body;

  
  connection.query('SELECT * FROM client WHERE login = ? AND password = ?', [login, password], (error, clientResults) => {
      if (error) {
          console.error('Error checking client credentials:', error);
          return res.status(500).send('Internal Server Error');
      }

      
      if (clientResults.length === 1) {
          return res.send('Client login successful');
      } else {
          connection.query('SELECT * FROM redacteur WHERE login = ? AND password = ?', [login, password], (error, redacteurResults) => {
              if (error) {
                  console.error('Error checking redacteur credentials:', error);
                  return res.status(500).send('Internal Server Error');
              }

              if (redacteurResults.length === 1) {
                  return res.send('Redacteur login successful');
              } else {
                  return res.status(401).send('Login failed');
              }
          });
      }
  });
});
app.listen(port, () => {
  console.log(`Example app listening on port ${port}`);
});
