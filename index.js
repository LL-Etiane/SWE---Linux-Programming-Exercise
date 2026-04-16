const express = require("express");
const app = express();
const PORT = 5500;

// Middleware to parse JSON
app.use(express.json());

// array to store tasks
let tasks = [];
let nextId = 1;

// Welcome message
app.get("/", (req, res) => {
  res.json({ message: "Welcome to the Task Manager API" });
});

// CREATE - POST /tasks
app.post("/tasks", (req, res) => {
  const { title, description } = req.body;

  if (!title) {
    return res.status(400).json({ error: "Title is required" });
  }

  const task = {
    id: nextId++,
    title,
    description: description || "",
    completed: false,
  };

  tasks.push(task);
  res.status(201).json(task);
});


app.get("/tasks", (req, res) => {
  res.json(tasks);
});


app.get("/tasks/:id", (req, res) => {
  const task = tasks.find((t) => t.id === parseInt(req.params.id));

  if (!task) {
    return res.status(404).json({ error: "Task not found" });
  }

  res.json(task);
});


app.put("/tasks/:id", (req, res) => {
  const task = tasks.find((t) => t.id === parseInt(req.params.id));

  if (!task) {
    return res.status(404).json({ error: "Task not found" });
  }

  const { title, description, completed } = req.body;

  if (title !== undefined) task.title = title;
  if (description !== undefined) task.description = description;
  if (completed !== undefined) task.completed = completed;

  res.json(task);
});


app.delete("/tasks/:id", (req, res) => {
  const index = tasks.findIndex((t) => t.id === parseInt(req.params.id));

  if (index === -1) {
    return res.status(404).json({ error: "Task not found" });
  }

  const deleted = tasks.splice(index, 1);
  res.json({ message: "Task deleted", task: deleted[0] });
});


app.listen(PORT, "0.0.0.0", () => {
  console.log(`Task Manager API running on http://localhost:${PORT}`);
});
