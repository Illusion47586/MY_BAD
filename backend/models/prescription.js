const mongoose=require("mongoose");

var prescriptionSchema=new mongoose.Schema({
    diagnosedWith: String,
    prescribedOn: Date,
    revisitDate: Date,
    med1Medname:String,
    med1Quantity:Number,
    med1Timing:String,
    med1Duration:String,

    med1Type:{
        type: String,
        enum:['pill','syrup','syringe','test']

    },
    med2Medname:String,
    med2Quantity:Number,
    med2Timing:String,
    med2Duration:String,

    med2Type:{
        type: String,
        enum:['pill','syrup','syringe','test']

    },
    med3Medname:String,
    med3Quantity:Number,
    Med3Timing:String,
    med3Duration:String,

    med3Type:{
        type: String,
        enum:['pill','syrup','syringe','test']

    },

    patientId:{
        type: String,
        default: 'dff'
    },

    doctorId:{
        type: String,
        default: 'dff'
    }

});

module.exports=mongoose.model("Prescription",prescriptionSchema);

