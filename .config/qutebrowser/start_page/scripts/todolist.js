function createTodoListBoard(boardInfo){
  let flexContainer = document.createElement("div");
  flexContainer.classList.add("todoListContainer");

  // Create Board
  let board = document.createElement("div");
  board.classList.add("todoListBoard");

  // Create Head (icon+possible name)
  let headContainer = document.createElement("div");
  headContainer.classList.add("todoListBoardHead");
  var headName = document.createTextNode(boardInfo.name);
  headContainer.append(headName);
  board.append(headContainer);

  // Add Links
  for (const todo of boardInfo.jobs) {
    let anchor = document.createElement("p");
    anchor.classList.add("todoListItem");

    let todoSpan = document.createElement("span");
    var time = document.createElement("b");
    time.innerText = todo.time + ": "
    var work = document.createTextNode(todo.work);

    todoSpan.appendChild(time);
    todoSpan.appendChild(work);
    anchor.append(todoSpan);
    board.append(anchor);
  }

  flexContainer.append(board);
  todoList.appendChild(flexContainer);
}

const createTodoListBoards = () => {
  for (const board of TodoListBoards) {
    createTodoListBoard(board);
  }
}

createTodoListBoards();
