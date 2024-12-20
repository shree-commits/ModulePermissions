
CREATE TABLE IF NOT EXISTS test2.UGroups (
    group_id VARCHAR(255) PRIMARY KEY,
    group_name VARCHAR(255) NOT NULL,
    description VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by VARCHAR(255),
    updated_by VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS test2.Users (
    user_id VARCHAR(255) PRIMARY KEY,
    user_name VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,  -- Store hashed passwords for security
    role VARCHAR(255),
    email VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by VARCHAR(255),
    updated_by VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS test2.Modules (
    module_id VARCHAR(255) PRIMARY KEY,
    module_name VARCHAR(255) NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    description VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS test2.Permissions (
    permission_id VARCHAR(255) PRIMARY KEY,
    action VARCHAR(255) NOT NULL,
    level VARCHAR(255) DEFAULT 'user',  -- Levels could be 'admin', 'user', 'guest'
    description VARCHAR(255),
    is_default BOOLEAN DEFAULT FALSE
);

CREATE TABLE IF NOT EXISTS test2.GroupModulePermissions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    group_id VARCHAR(255),
    module_id VARCHAR(255),
    permission_id VARCHAR(255),
    priority INTEGER,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (group_id) REFERENCES UGroups(group_id),
    FOREIGN KEY (module_id) REFERENCES Modules(module_id),
    FOREIGN KEY (permission_id) REFERENCES Permissions(permission_id),
    INDEX (group_id),
    INDEX (module_id),
    INDEX (permission_id)
);

CREATE TABLE IF NOT EXISTS test2.UserGroups (
    usergroup_id VARCHAR(255) PRIMARY KEY,
    user_id VARCHAR(255),
    group_id VARCHAR(255),
    assigned_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by VARCHAR(255),
    updated_by VARCHAR(255),
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (group_id) REFERENCES UGroups(group_id),
    INDEX (user_id),
    INDEX (group_id)
);

CREATE TABLE IF NOT EXISTS test2.customers (
    customer_id VARCHAR(255) PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    phone VARCHAR(255),
    address VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS test2.sales_orders(
	order_id VARCHAR(255) PRIMARY KEY,
    customer_id VARCHAR(255),
    order_date TIMESTAMP,
    status VARCHAR(255) DEFAULT 'Pending',
    total_amount FLOAT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
    );


-- Insert sample data into Users table
INSERT INTO test2.Users (user_id, user_name, password, role, email, created_at, updated_at, created_by, updated_by)
VALUES 
    ('user1', 'John Doe', 'hashed_password_1', 'Admin', 'mailto:john.doe@example.com', '2024-01-01 10:00:00', '2024-01-01 10:00:00', 'admin_user', 'admin_user'),
    ('user2', 'Jane Smith', 'hashed_password_2', 'User', 'mailto:jane.smith@example.com', '2024-01-02 11:00:00', '2024-01-02 11:00:00', 'admin_user', 'admin_user');

-- Insert sample data into UGroups table
INSERT INTO test2.UGroups (group_id, group_name, description, created_at, updated_at, created_by, updated_by)
VALUES 
    ('group1', 'Admin', 'Administrator group with full permissions', '2024-01-01 10:00:00', '2024-01-01 10:00:00', 'admin_user', 'admin_user'),
    ('group2', 'User', 'Regular user group with limited permissions', '2024-01-02 11:00:00', '2024-01-02 11:00:00', 'admin_user', 'admin_user');

-- Insert modules into the Modules table
INSERT INTO test2.Modules (module_id, module_name, is_active, description)
VALUES 
    ('module1', 'Dashboard', 1, 'Manage dashboards, widgets, and layout'),
    ('module2', 'Customer Management', 1, 'Manage customer records and activities'),
    ('module3', 'Sales', 1, 'Handle sales orders and performance'),
    ('module4', 'Marketing', 1, 'Manage marketing campaigns and performance'),
    ('module5', 'Reports', 1, 'Generate and view reports'),
    ('module6', 'User Management', 1, 'Manage users and roles'),
    ('module7', 'Settings', 1, 'Configure settings and integrations');
    
-- Insert permissions into the Permissions table
INSERT INTO test2.Permissions (permission_id, action, level, description, is_default)
VALUES 
    -- Dashboard Permissions
    ('perm1', 'View Dashboard', 'Admin', 'View dashboard', 1),
    ('perm2', 'Manage Widgets', 'Admin', 'Manage dashboard widgets', 0),
    ('perm3', 'Customize Layout', 'Admin', 'Customize dashboard layout', 0),
    
    -- Customer Management Permissions
    ('perm4', 'View Customers', 'Admin', 'View customer records', 1),
    ('perm5', 'Add Customer', 'Admin', 'Add new customer', 0),
    ('perm6', 'Edit Customer', 'Admin', 'Edit customer records', 0),
    ('perm7', 'Delete Customer', 'Admin', 'Delete customer records', 0),
    ('perm8', 'View Customer Activity', 'Admin', 'View customer activities', 0),
    
    -- Sales Permissions
    ('perm9', 'View Sales Orders', 'Admin', 'View sales orders', 1),
    ('perm10', 'Create Sales Orders', 'Admin', 'Create sales orders', 0),
    ('perm11', 'Edit Sales Orders', 'Admin', 'Edit sales orders', 0),
    ('perm12', 'Delete Sales Orders', 'Admin', 'Delete sales orders', 0),
    ('perm13', 'View Sales Performance', 'Admin', 'View sales performance data', 0),
    
    -- Marketing Permissions
    ('perm14', 'View Campaigns', 'Admin', 'View marketing campaigns', 1),
    ('perm15', 'Create Campaigns', 'Admin', 'Create marketing campaigns', 0),
    ('perm16', 'Edit Campaigns', 'Admin', 'Edit marketing campaigns', 0),
    ('perm17', 'Delete Campaigns', 'Admin', 'Delete marketing campaigns', 0),
    ('perm18', 'View Campaign Performance', 'Admin', 'View campaign performance data', 0),
    
    -- Reports Permissions
    ('perm19', 'View Reports', 'Admin', 'View reports', 1),
    ('perm20', 'Generate Reports', 'Admin', 'Generate reports', 0),
    ('perm21', 'Export Reports', 'Admin', 'Export reports', 0),
    ('perm22', 'Schedule Reports', 'Admin', 'Schedule reports', 0),
    
    -- User Management Permissions
    ('perm23', 'View Users', 'Admin', 'View user records', 1),
    ('perm24', 'Add User', 'Admin', 'Add new users', 0),
    ('perm25', 'Edit User', 'Admin', 'Edit user details', 0),
    ('perm26', 'Delete User', 'Admin', 'Delete user accounts', 0),
    ('perm27', 'Assign Roles', 'Admin', 'Assign roles to users', 0),
    
    -- Settings Permissions
    ('perm28', 'View Settings', 'Admin', 'View system settings', 1),
    ('perm29', 'Edit Settings', 'Admin', 'Edit system settings', 0),
    ('perm30', 'Manage Integrations', 'Admin', 'Manage integrations', 0),
    ('perm31', 'Manage Permissions', 'Admin', 'Manage user permissions', 0);
    
    -- Insert permissions into the GroupModulePermissions table for Admin group
INSERT INTO test2.GroupModulePermissions (group_id, module_id, permission_id, priority)
VALUES 
    -- Dashboard Permissions for Admin group
    ('group1', 'module1', 'perm1', 1),  -- View Dashboard
    ('group1', 'module1', 'perm2', 2),  -- Manage Widgets
    ('group1', 'module1', 'perm3', 3),  -- Customize Layout
    
    -- Customer Management Permissions for Admin group
    ('group1', 'module2', 'perm4', 1),  -- View Customers
    ('group1', 'module2', 'perm5', 2),  -- Add Customer
    ('group1', 'module2', 'perm6', 3),  -- Edit Customer
    ('group1', 'module2', 'perm7', 4),  -- Delete Customer
    ('group1', 'module2', 'perm8', 5),  -- View Customer Activity
    
    -- Sales Permissions for Admin group
    ('group1', 'module3', 'perm9', 1),  -- View Sales Orders
    ('group1', 'module3', 'perm10', 2),  -- Create Sales Orders
    ('group1', 'module3', 'perm11', 3),  -- Edit Sales Orders
    ('group1', 'module3', 'perm12', 4),  -- Delete Sales Orders
    ('group1', 'module3', 'perm13', 5),  -- View Sales Performance
    
    -- Marketing Permissions for Admin group
    ('group1', 'module4', 'perm14', 1),  -- View Campaigns
    ('group1', 'module4', 'perm15', 2),  -- Create Campaigns
    ('group1', 'module4', 'perm16', 3),  -- Edit Campaigns
    ('group1', 'module4', 'perm17', 4),  -- Delete Campaigns
    ('group1', 'module4', 'perm18', 5),  -- View Campaign Performance
    
    -- Reports Permissions for Admin group
    ('group1', 'module5', 'perm19', 1),  -- View Reports
    ('group1', 'module5', 'perm20', 2),  -- Generate Reports
    ('group1', 'module5', 'perm21', 3),  -- Export Reports
    ('group1', 'module5', 'perm22', 4),  -- Schedule Reports
    
    -- User Management Permissions for Admin group
    ('group1', 'module6', 'perm23', 1),  -- View Users
    ('group1', 'module6', 'perm24', 2),  -- Add User
    ('group1', 'module6', 'perm25', 3),  -- Edit User
    ('group1', 'module6', 'perm26', 4),  -- Delete User
    ('group1', 'module6', 'perm27', 5),  -- Assign Roles
    
    -- Settings Permissions for Admin group
    ('group1', 'module7', 'perm28', 1),  -- View Settings
    ('group1', 'module7', 'perm29', 2),  -- Edit Settings
    ('group1', 'module7', 'perm30', 3),  -- Manage Integrations
    ('group1', 'module7', 'perm31', 4);  -- Manage Permissions
    
    -- Insert sample data into UserGroups table
INSERT INTO test2.UserGroups (usergroup_id, user_id, group_id, assigned_at, updated_at)
VALUES 
    ('ug1', 'user1', 'group1', '2024-01-01 10:00:00', '2024-01-01 10:00:00'),
    ('ug2', 'user2', 'group2', '2024-01-02 11:00:00', '2024-01-02 11:00:00');


-- Add a customer to the `customers` table
INSERT INTO customers (customer_id, first_name, last_name, email, phone, address)
VALUES ('customer2', 'Alice', 'Smith', 'mailto:alice.smith@example.com', '0987654321', '123 Main Street');










