# Expanded Story: The Mars Mission - Advanced Crew Management System

## The Situation So Far
Congratulations, engineers! You have successfully set up the communication between Mars and Earth. Your initial work of building a back-end with Node.js, Express, and SQLite to fetch astronaut data has stabilized the operations, and the command center on Earth is thrilled to see the "Hello, Mars!" message confirming the system's health.

However, the mission is expanding, and managing the growing crew on Mars is becoming more complex. To keep everything organized and ready for potential emergencies or operational changes, the mission directors have tasked you with enhancing the system significantly.

---

## Important Update from the Command Center!
During your initial implementation, some of you chose to store astronaut data in a JSON file. While this worked well for initial testing and validating communication between Mars and Earth, the mission has entered a more advanced phase, and our data management needs have evolved.

### The Issue with Using JSON:
Storing data in a JSON file is simple and effective for early development, but it has limitations:
- **Scalability:** As the mission grows, and more astronauts and data are added, managing a large JSON file becomes difficult and inefficient.
- **Concurrency & Data Integrity:** JSON files do not handle multiple updates simultaneously well. There is a risk of data corruption or loss, especially as more users interact with the system.

The command center has decided that all crew data must be stored in a structured database that can scale, handle multiple interactions, and ensure the integrity of our mission-critical data.

**Therefore, if you previously used a JSON file to store astronaut data, you are now required to switch to using a SQLite database for this phase of development.**

---

## Your Next Mission: Full CRUD Operations and Management Interface
You will now expand the existing system to include full CRUD (Create, Read, Update, Delete) operations for astronauts in the SQLite database. Additionally, you'll build a front-end interface to allow the command center to easily interact with and manage the data. Remember, as the mission progresses, it's vital that all operations are handled securely and efficiently, and that the front-end interface is simple and user-friendly.

---

## Requirements: Phase 2 of Development

### Part 1: Back-End Enhancements with CRUD and Validation

#### CRUD Operations for Astronauts:
Expand the current back-end (Node.js + Express + SQLite) to support full CRUD operations for astronauts:

1. **GET All & One Astronaut**
   - **GET `/api/astronauts`:** Return a list of all astronauts from the SQLite database.
   - **GET `/api/astronauts/:id`:** Return details of a specific astronaut by `id`.

2. **Create a New Astronaut**
   - **POST `/api/astronauts`:** Allow the command center to add a new astronaut to the database.
   - **Validation Requirements:** The `name` and `role` fields must be non-empty strings, between 3-50 characters long, and should not contain any numbers.

3. **Update an Astronaut's Details**
   - **PUT `/api/astronauts/:id`:** Update an existing astronaut’s `name` or `role`.
   - **Validation Requirements:** Validate the provided fields (`name` and `role`) in the same way as for creating a new astronaut.

4. **Delete an Astronaut**
   - **DELETE `/api/astronauts/:id`:** Allow deletion of an astronaut by `id`.

#### Error Handling & Validation:
- Ensure that appropriate HTTP status codes are returned (e.g., `200` for success, `400` for validation errors, `404` for not found).
- Provide meaningful error messages when validation fails or a resource is not found.
- Make sure that each `id` is unique and that all required fields are validated properly.

---

### Part 2: Front-End Panel for Astronaut Management

#### Build the User Interface:
- Create a simple front-end application to manage astronauts. You can use any framework or library (e.g., React, Vue, or plain HTML/CSS/JavaScript). **We recommend using React.**
- The UI should allow users to perform all CRUD operations, interactively connected to the back-end API.

#### Display the Astronauts:
- **List View:** Fetch and display all astronauts from the `/api/astronauts` endpoint. Each astronaut should be shown with their `name` and `role`.

#### Create, Update, and Delete Operations:
- **Add a New Astronaut:** Provide a form to add a new astronaut. The form should include input fields for `name` and `role`, and on submission, send a `POST` request to the back-end.
- **Edit an Astronaut:** Add an "Edit" button next to each astronaut entry. When clicked, allow updating their `name` or `role`. Send a `PUT` request to update the details.
- **Delete an Astronaut:** Add a "Delete" button next to each astronaut, which, when clicked, sends a `DELETE` request to remove the astronaut.

#### Form Validation on the Front-End:
- Implement form validation to prevent users from submitting empty fields or entering numbers in the `name` and `role` fields.

#### User Feedback on Success or Error:
- Display a visible message on the screen for both success and error actions.
   - **Success Example:** "Astronaut added successfully!" or "Astronaut updated successfully!"
   - **Error Example:** "Invalid input: Name cannot contain numbers" or "Failed to delete astronaut: Astronaut not found."
- The messages should be styled to be easily noticeable (e.g., success in green, errors in red).

---

## Additional Challenges for Students Seeking a Deeper Challenge

### \* Extra Tasks (Optional):

#### CSV Export:
- Implement functionality to export the list of astronauts to a CSV file.
- Add a button labeled "Export to CSV" on the front-end that, when clicked, generates and downloads a CSV file with the current list of astronauts.

#### Filtering and Search:
- Add a search bar on the front-end that allows filtering astronauts by `name` or `role`.
- Make sure the search is responsive (e.g., filters the list as the user types).

---

### \*\* Advanced Task (Optional):

#### Write Tests for Your Application Using Vitest
- Set up Vitest to write unit and integration tests for your back-end and front-end functionalities.

---

### \*\*\* SuperAdvanced Task (Optional):

#### Rewrite in TypeScript:
- Convert both the back-end and front-end codebases to TypeScript for improved type safety and developer experience.
- Use TypeScript features such as interfaces for defining models (e.g., for astronauts) and utility types for handling the API response shapes.

---

## Example API Responses

Here are some examples of expected API responses for the main CRUD operations:

### **GET `/api/astronauts/:id`** - Find an astronaut by ID
**Error for invalid ID(404):**
```json
{
    "error": "Astronaut not found with the provided ID."
}
```

### **POST `/api/astronauts`** - Add a New Astronaut
**Request Body:**
```json
{
    "name": "John Doe",
    "role": "Engineer"
}
```
**Response:**
```json
{
    "message": "Astronaut added successfully!",
    "astronaut": {
        "id": 1,
        "name": "John Doe",
        "role": "Engineer"
    }
}
```
**Validation error(400):**
```json
{
    "error": "Invalid input: Role must be a non-empty string and should not contain numbers."
}
```
**Server error(500):**
```json
{
    "error": "Unexpected server issue {error}"
}
```
### **PUT`/api/astronauts/:id`** - Update an Astronaut's Details
**Request Body:**
```json
{
    "role": "Lead Engineer"
}
```
**Succesfull response(200):**
```json
{
    "message": "Astronaut updated successfully!",
    "astronaut": {
        "id": 1,
        "name": "John Doe",
        "role": "Lead Engineer"
    }
}
```
**Error for invalid ID(404):**
```json
{
    "error": "Astronaut not found with the provided ID."
}
```
**Validation error(400):**
```json
{
    "error": "Invalid input: Role must be a non-empty string and should not contain numbers."
}
```
### **DELETE`/api/astronauts/:id`** - Delete an Astronaut
**Succesfull response(200):**
```json
{
    "message": "Astronaut deleted successfully!"
}
```
**Error for invalid ID(404):**
```json
{
    "error": "Astronaut not found with the provided ID."
}
```
