cat > README.md << 'EOF'
# CMPE332 Database Management Systems Project

## Overview

This project contains three comprehensive database management systems developed for CMPE332 (Database Management Systems) course. The project demonstrates practical implementation of relational database design, SQL queries, and web-based database applications.

## Project Structure

```
CMPE332/
├── rental/                    # Rental Management Web Application
│   ├── styles/               # CSS styling files
│   │   ├── images/          # Application images
│   │   ├── style.css        # Main stylesheet
│   │   ├── listings.css     # Listings page styles
│   │   ├── rental-groups.css # Rental groups page styles
│   │   └── average-rent-style.css # Average rent page styles
│   ├── rental.html          # Homepage
│   ├── listings.php         # Property listings functionality
│   ├── rental-groups.php    # Rental group management
│   ├── average-rent.php     # Average rent calculations
│   ├── update-preferences.php # Preference update functionality
│   ├── connectdb.php        # Database connection
│   └── rentalDB.sql         # Rental database schema
├── rentalDB.sql             # Main rental database schema
├── petsDB.sql              # Pet adoption database schema
└── eldercareDB.sql         # Elder care facility database schema
```

## Database Systems

### 1. Rental Management System (`rentalDB.sql`)

A comprehensive rental property management system designed for student housing and property rentals.

#### Key Features:
- **Multi-property Support**: Houses, apartments, and rooms
- **Student Group Management**: Organize students into rental groups
- **Property Management**: Track managers, owners, and property details
- **Preference System**: Allow groups to set rental preferences
- **Lease Management**: Track lease periods and costs

#### Database Schema:

**Core Tables:**
- `rentalGroup`: Rental groups for students
- `student`: Student information and group assignments
- `manager`: Property managers
- `owner`: Property owners
- `preferences`: Group rental preferences

**Property Tables:**
- `house`: House properties with detailed amenities
- `apartment`: Apartment properties with floor and elevator info
- `room`: Room rentals with furnishing details

**Relationship Tables:**
- `ownsProperty`: Links owners to properties
- `roomFurnishing`: Room furnishing details

#### Key Features:
- **Accessibility Support**: Tracks accessibility features
- **Amenity Tracking**: Laundry, parking, kitchen facilities
- **Flexible Property Types**: Houses, apartments, and individual rooms
- **Group-based Rentals**: Students can form rental groups
- **Preference Matching**: System to match properties to group preferences

### 2. Pet Adoption System (`petsDB.sql`)

A pet adoption and care management system for animal shelters.

#### Database Schema:

**Core Tables:**
- `Person`: Adopter information
- `Shelter`: Animal shelter locations
- `Caretaker`: Pet caretakers with credentials
- `Pet`: Pet information and caretaker assignments

**Tracking Tables:**
- `WeightInfo`: Pet weight tracking over time
- `PetColour`: Multiple colors per pet
- `CaretakerShelter`: Caretaker-shelter relationships
- `adopt`: Adoption records

#### Key Features:
- **Multi-shelter Support**: Track pets across multiple shelters
- **Weight Monitoring**: Historical weight tracking for pets
- **Color Tracking**: Support for multi-colored pets
- **Credentialed Caretakers**: Professional pet care management
- **Adoption Records**: Complete adoption history

### 3. Elder Care Facility System (`eldercareDB.sql`)

A comprehensive elder care facility management system.

#### Database Schema:

**Core Tables:**
- `room`: Patient rooms with occupancy and phone
- `resident`: Patient information with OHIP numbers
- `nurse`: Nursing staff with ranks
- `doctor`: Medical doctors
- `Helper`: Care helpers

**Management Tables:**
- `nurseSchedule`: Nurse shift scheduling
- `nextOfKin`: Emergency contacts
- `treats`: Doctor-patient relationships
- `drSpecialization`: Doctor specializations
- `drPhone`: Multiple phone numbers per doctor

#### Key Features:
- **OHIP Integration**: Canadian health insurance number tracking
- **Spouse Relationships**: Track married residents
- **Multi-doctor Care**: Patients can have multiple treating doctors
- **Specialization Tracking**: Doctor expertise areas
- **Emergency Contacts**: Next of kin information
- **Shift Management**: Nurse scheduling system

## Web Application: Rental Management System

### Features

The rental web application provides an intuitive interface for managing rental properties and student groups.

#### 1. Homepage (`rental.html`)
- Clean, modern design with navigation
- Direct access to all application features
- Responsive layout with professional styling

#### 2. Property Listings (`listings.php`)
- **Comprehensive Property Display**: Shows all properties (houses, apartments, rooms)
- **Unified View**: Combines different property types in a single table
- **Owner Information**: Displays property owners
- **Manager Details**: Shows assigned property managers
- **Address Formatting**: Properly formatted addresses for all property types

#### 3. Rental Groups (`rental-groups.php`)
- **Group Selection**: Dropdown to select rental groups
- **Student Roster**: View all students in a selected group
- **Preference Management**: View and edit group rental preferences
- **Real-time Updates**: Dynamic preference editing with form validation

#### 4. Average Rent Calculator (`average-rent.php`)
- **Property Type Analysis**: Separate averages for houses, apartments, and rooms
- **Clean Display**: Tabular format for easy comparison
- **Real-time Calculations**: Dynamic SQL-based calculations

#### 5. Preference Updates (`update-preferences.php`)
- **Secure Updates**: Prepared statements for SQL injection prevention
- **Input Validation**: Proper data sanitization
- **User Feedback**: Success/error handling with redirects

### Technical Implementation

#### Database Connection (`connectdb.php`)
- **PDO Implementation**: Secure database connectivity
- **Error Handling**: Comprehensive error catching and display
- **MySQL Integration**: Optimized for MySQL database

#### Security Features
- **SQL Injection Prevention**: All queries use prepared statements
- **Input Sanitization**: Proper data filtering and validation
- **XSS Protection**: HTML entity encoding for output

#### Styling and UX
- **Responsive Design**: Mobile-friendly layouts
- **Professional Appearance**: Clean, modern CSS styling
- **Consistent Navigation**: Easy navigation between features
- **Visual Feedback**: Hover effects and transitions

## Installation and Setup

### Prerequisites
- MySQL Server (5.7 or higher)
- PHP (7.4 or higher)
- Web server (Apache/Nginx)

### Database Setup

1. **Rental Database:**
   ```sql
   mysql -u root -p < rentalDB.sql
   ```

2. **Pet Adoption Database:**
   ```sql
   mysql -u root -p < petsDB.sql
   ```

3. **Elder Care Database:**
   ```sql
   mysql -u root -p < eldercareDB.sql
   ```

### Web Application Setup

1. **Configure Database Connection:**
   Edit `rental/connectdb.php` to match your MySQL credentials:
   ```php
   $pdo = new PDO('mysql:host=localhost;dbname=rentaldb', "username", "password");
   ```

2. **Deploy Files:**
   Copy the `rental/` directory to your web server's document root.

3. **Set Permissions:**
   Ensure proper file permissions for web server access.

4. **Access Application:**
   Navigate to `http://your-server/rental/rental.html`

## Usage Examples

### Rental System Queries

**Find properties matching group preferences:**
```sql
SELECT p.* FROM house p
JOIN preferences pr ON p.groupID = pr.groupID
WHERE p.rentCost <= pr.maxRent
AND p.accessibility = pr.accessibility
AND p.laundry = pr.laundry;
```

**Calculate average rent by property type:**
```sql
SELECT 'House' as type, AVG(rentCost) as avg_rent FROM house
UNION ALL
SELECT 'Apartment', AVG(rentCost) FROM apartment
UNION ALL
SELECT 'Room', AVG(rentCost) FROM room;
```

### Pet Adoption Queries

**Find pets available for adoption:**
```sql
SELECT p.id, p.type, pc.colour, s.name as shelter_name
FROM Pet p
JOIN PetColour pc ON p.id = pc.petId
JOIN CaretakerShelter cs ON p.caretakerPhone = cs.cphone
JOIN Shelter s ON cs.sName = s.name AND cs.sCity = s.city
WHERE p.id NOT IN (SELECT petId FROM adopt);
```

### Elder Care Queries

**Find residents with their primary care doctors:**
```sql
SELECT r.fname, r.lname, d.fname as doctor_fname, d.lname as doctor_lname
FROM resident r
JOIN doctor d ON r.primaryCareDrId = d.id;
```

## Database Design Principles

### Normalization
- **Third Normal Form (3NF)**: All databases follow 3NF principles
- **Referential Integrity**: Proper foreign key constraints
- **Atomic Values**: All attributes contain atomic values

### Relationships
- **One-to-Many**: Groups to students, owners to properties
- **Many-to-Many**: Doctors to residents, pets to colors
- **Self-Referencing**: Spouse relationships in elder care

### Constraints
- **Primary Keys**: Unique identifiers for all entities
- **Foreign Keys**: Maintain referential integrity
- **Check Constraints**: Data validation at database level
- **Unique Constraints**: Prevent duplicate entries

## Performance Considerations

### Indexing Strategy
- Primary keys automatically indexed
- Foreign keys indexed for join performance
- Consider additional indexes on frequently queried columns

### Query Optimization
- Use prepared statements for repeated queries
- Implement proper JOIN strategies
- Consider view creation for complex queries

## Security Features

### Database Security
- **Prepared Statements**: Prevent SQL injection
- **Input Validation**: Server-side data validation
- **Access Control**: Database user permissions
- **Data Sanitization**: Clean input/output handling

### Web Application Security
- **XSS Prevention**: HTML entity encoding
- **CSRF Protection**: Form token validation (recommended)
- **Session Management**: Secure session handling
- **Error Handling**: No sensitive information in error messages

## Future Enhancements

### Rental System
- [ ] User authentication and authorization
- [ ] Property image uploads
- [ ] Advanced search and filtering
- [ ] Email notifications for new listings
- [ ] Payment tracking system
- [ ] Maintenance request system

### Pet Adoption System
- [ ] Pet photo galleries
- [ ] Adoption application workflow
- [ ] Medical record tracking
- [ ] Vaccination schedules
- [ ] Behavioral assessment tracking

### Elder Care System
- [ ] Medication management
- [ ] Family communication portal
- [ ] Activity scheduling
- [ ] Health monitoring integration
- [ ] Billing and insurance tracking

---