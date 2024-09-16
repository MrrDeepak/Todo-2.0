const express = require('express');
const path = require('path');

const routes= require('./routes/routes')
const app = express();
const cors = require('cors');
app.use(cors());
app.use(express.json());



const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
app.use("/api",routes);
