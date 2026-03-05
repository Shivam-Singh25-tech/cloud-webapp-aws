const express = require("express");
const mysql = require("mysql2");

const app = express();

const db = mysql.createConnection({
 host: "RDS-ENDPOINT",
 user: "admin",
 password: "password",
 database: "cloudapp"
});

app.get("/users",(req,res)=>{
 db.query("SELECT * FROM users",(err,result)=>{
   if(err) throw err;
   res.json(result);
 });
});

app.listen(3000,()=>{
 console.log("Server running");
});
