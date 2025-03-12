import express from "express";
import bodyParser from "body-parser";
import { configDotenv } from "dotenv";
import path from "path";
import { fileURLToPath } from "url";

configDotenv();

const app = express();
app.use(bodyParser.urlencoded({ extended: false }));
app.use(express.json());

app.use(express.static("public"));
app.set("view engine", "ejs");

const products = [
  { id: 1, name: "Product 1" },
  { id: 2, name: "Product 2" },
  { id: 3, name: "Product 3" },
  { id: 4, name: "Product 4" },
  { id: 5, name: "Product 5" },
  { id: 6, name: "Product 6" },
];

const router = express.Router();

router.get("/api/v1/products", (req, res) => {
  res.json(products);
}); 

router.get("", (req, res) => {
  res.render("index", {
    name: "Mohamed Karim Balla",
    title: "Home",
    products: products,
  });
});

app.use("/", router);

const port = process.env.PORT || 3000;
app.listen(port, () => console.log(`Server is running on port ${port}`));
