const express = require('express');
const route = express.Router();
const fs = require('fs');
const path = require('path');

const dataFilePath = path.join(__dirname, '../data.json');

const readItems = () => {
    if (!fs.existsSync(dataFilePath)) return [];
    const data = fs.readFileSync(dataFilePath);
    return JSON.parse(data);
  };
  
  // Write items to JSON file
  const writeItems = (items) => {
    fs.writeFileSync(dataFilePath, JSON.stringify(items, null, 2));
  };


route.post("/items",(req,res)=>{
    const items = readItems();
  const newItem = req.body;
  if (!newItem.id && !newItem.name) {
    return res.status(400).json({ error: 'Invalid item' });
  }
  items.push(newItem);
  writeItems(items);
  res.status(201).json("Item added");
});
route.get("/items",(req,res)=>{
    const items = readItems();
  res.status(200).json(items);
});
route.delete("/items/:id",(req,res)=>{
    const items = readItems();
  const itemId = req.params.id;
  const newItems = items.filter(item => item.id !== itemId);
  if (items.length === newItems.length) {
    return res.status(404).json({ error: 'Item not found' });
  }
  writeItems(newItems);
  res.status(204).json('${itemId} deleted successfully');
});
module.exports = route;