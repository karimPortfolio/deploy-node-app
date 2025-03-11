import express from 'express';
import bodyParser from 'body-parser';
import { configDotenv } from 'dotenv';


configDotenv();

const app = express();
app.use(bodyParser.json());
app.use(express.json());

app.set('view engine', 'ejs');
app.use(express.static('public'));

app.get('/', (req, res) => {
    res.render('index', {
        name: 'Mohamed Karim Balla',
        title: 'Home'
    });
});

const port = process.env.PORT || 3000;
app.listen(port, () => console.log(`Server is running on port ${port}`));
