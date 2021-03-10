//Bringing in the node modules

const express = require('express')
const morgan = require('morgan')
const bodyParser = require('body-parser')
const cookieParser = require('cookie-parser')
const mongoose = require('mongoose')
const cors = require('cors')
const Prescription = require('./models/prescription');

//Configuring environment variables

require('dotenv').config()

//Bringing in Routes

const authRoutes = require('./routes/auth');
const doctorRoutes = require('./routes/doctor');
const presRoutes = require('./routes/prescription');

//App

const app = express()

//Database

mongoose
    .connect(process.env.DATABASE, {useNewUrlParser: true, useCreateIndex: true, useFindAndModify: false, useUnifiedTopology: true})
    .then(() => console.log('Database connected successfully'))
    .catch(() => console.log('error connecting to database'))
//Middlewares

app.use(morgan('dev'))
app.use(bodyParser.json())
app.use(cookieParser())

//cors
if(process.env.NODE_ENV === 'development') {
    app.use(cors({origin: `${process.env.CLIENT_URL}`}));
}

//Prescriptions




//Routes Middleware

app.use('/api', authRoutes);
app.use('/api', doctorRoutes);
app.use('/api', presRoutes);


// Port
const port = process.env.PORT || 8000
app.listen(port, () => {
    console.log(`Server is running on port ${port}`)
})