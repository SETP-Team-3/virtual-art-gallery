# Virtual Art Gallery

## SETP Team 3: Team Members
- Colin Chia - CT0379777
- Justin Kwan - CT0376857
- Thalhan - CT0378426
- Mak Jun Kit - CT0337394
- Haziq - CTO367416
- Desmond Goh - CT378428

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

### 3. Configure Application Properties
1. The `application.properties` file in the repository contains placeholder values for sensitive information:
    ```properties
    spring.application.name=vartgallery

    jwt.secret=${JWT_SECRET}
    stripe.secret=${STRIPE_SECRET}
    stripe.public=${STRIPE_PUBLIC}

    spring.datasource.url=${DB_URL}
    spring.datasource.username=${DB_USERNAME}
    spring.datasource.password=${DB_PASSWORD}

    spring.mail.host=smtp.gmail.com
    spring.mail.port=587
    spring.mail.username=your.email@gmail.com
    spring.mail.password=your_mail_password
    spring.mail.properties.mail.smtp.auth=true
    spring.mail.properties.mail.smtp.starttls.enable=true
    spring.mail.properties.mail.smtp.starttls.required=true
    spring.mail.properties.mail.smtp.connectiontimeout=5000
    spring.mail.properties.mail.smtp.timeout=5000
    spring.mail.properties.mail.smtp.writetimeout=5000

    spring.mvc.view.prefix=/WEB-INF/jsp/
    spring.mvc.view.suffix=.jsp

    spring.servlet.multipart.max-file-size=5MB
    spring.servlet.multipart.max-request-size=10MB
    ```
2. Download the actual `application.properties` file from our private Google Drive folder.
3. Replace the placeholder `application.properties` file in the `src/main/resources` directory with the actual file from Google Drive.

### 4. Build and Run the Application
1. Open your IDE and import the project.
2. Navigate to the main application class `src/main/java/com/setpteam3/vartgallery/VartgalleryApplication.java`.
3. Run the application from the main method.

Alternatively, you can use the terminal to run the application:
```
./mvnw spring-boot:run
```

### 5. Access the Application
Open your web browser and navigate to `http://localhost:8080`.

## Additional Information

### Troubleshooting
- **Database Connection Issues**: Ensure your MySQL server is running and that the connection properties in `application.properties` are correct.
- **Dependencies Issues**: Run `./mvnw clean install` to ensure all dependencies are downloaded and the project is built correctly.
- **Mailing**: You will need to have a Gmail account.

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