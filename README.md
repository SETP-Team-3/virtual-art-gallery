# Virtual Art Gallery

## SETP Team 3: Team Members
- Colin - CT0379777
- Desmond - CT378428
- Haziq - CTO367416
- Jun Kit - CT0337394
- Justin - CT0376857
- Thalhan - CT0378426

---

## Overview
The Virtual Art Gallery web application is built using Java Spring Boot, JSP, and MySQL. 

## Prerequisites
Before you begin, ensure you have the following software installed on your local machine:
- Java Development Kit (JDK) 17
- MySQL Server
- Git
- An IDE (IntelliJ IDEA, Eclipse, or similar)

## Getting Started

### 1. Clone the Repository
Open your terminal or command prompt and run the following command to clone the repository:
```
git clone https://github.com/SETP-Team-3/virtual-art-gallery.git
```
Navigate to the project directory:
```
cd virtual-art-gallery
```

### 2. Setting Up the Database
1. Open MySQL Workbench or your preferred MySQL client.
2. Create a new database:
    1. Go to the `Server` menu and select `Data Import`.
    2. Select `Import from Self-Contained File`.
    3. Click the `...` button and navigate to the `sql/01-init-database.sql` file in the cloned repository directory.
        - For example, if you cloned the repository to `C:/Users/yourusername/virtual-art-gallery/`, navigate to `C:/Users/yourusername/virtual-art-gallery/sql/01-init-database.sql`.
    4. Under `Default Target Schema`, create a new schema named `vartgallery` if it doesn't already exist, and select it.
    5. Click `Start Import`.

3. Create a new user and grant privileges:
    1. Open a new SQL tab by going to the `File` menu and selecting `New Query Tab`.
    2. Click the `File` menu and select `Open SQL Script...`.
    3. Navigate to the `sql/02-init-account.sql` file in the cloned repository directory and open it.
    4. Run the SQL script by clicking the lightning bolt icon.

### 3. Configure Environment Variables
1. The `application.properties` file in the repository contains placeholder values for sensitive information.
2. Download the actual `application.properties` file from our private Google Drive folder.
3. Replace the placeholder `application.properties` file in the `src/main/resources` directory with the actual file from Google Drive.
4. Also, replace the placeholder `var stripePublicKey = 'pk_test_your_stripe_public_key'` inside the `vartgallery/src/main/resources/static/js/checkout.js` file with the Stripe public key in our `misc.txt`, in our private Google Drive folder.
5. The `misc.txt` file in our private Google Drive also contains the login credentials for our `setpteam3vartg@gmail.com` Gmail account.

### 4. Build and Run the Application
1. Open your IDE and import the project.
2. Navigate to the main application class `src/main/java/com/setpteam3/vartgallery/VartgalleryApplication.java`.
3. Run the application from the main method.

Alternatively, you can use the terminal to run the application:
```
./mvnw spring-boot:run
```

### 5. Access the Application
Open your web browser and navigate to `http://localhost:8080`. To access the admin dashboard, navigate to `http://localhost:8080/admin/login`.

## Additional Information

### 1. Miscellaneous Notes
- **Database Connection Issues**: Ensure your MySQL server is running and that the connection properties in `application.properties` are correct.
- **Dependencies Issues**: Run `./mvnw clean install` to ensure all dependencies are downloaded and the project is built correctly.
- **Mailing**: You will need to have a Gmail account.
- **Testing User Accounts**: For simplicity's sake, all account passwords are 'test123' and BCrypted.

### Useful Commands
- To start MySQL server:
  ```
  sudo service mysql start
  ```
- To stop MySQL server:
  ```
  sudo service mysql stop
  ```

## License
This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.
