const Prescription = require('./../models/prescription');
const express = require('express')
const router = express.Router();


router.post('/createprescription',  (req, res) => {
    const data = req.body;
    let prescription = new Prescription(data)
    prescription.save((err, pres) => {
        if(err) {
            return res.status(400).json({
                error: err
            })
        }
        res.json(pres)
    })
})

router.get('/getprescription', (req, res) => {
    Prescription.find({}).exec((err, data) => {
        if (err) {
            return res.status(400).json({
                error: 'ERROR'
            });
        }
        res.json(data);
    });
})


module.exports = router;