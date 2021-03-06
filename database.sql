SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT = @@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS = @@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION = @@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `authentication_db`
--

-- --------------------------------------------------------

--
-- Deleting existing tables if they exist
--

DROP TABLE IF EXISTS TransactionTokens;

DROP TABLE IF EXISTS Users;

DROP TABLE IF EXISTS Transactions;

DROP TABLE IF EXISTS Services;

DROP TABLE IF EXISTS Roles;


--
-- Table structure for table `Roles`
--

CREATE TABLE `Roles`
(
    `id`        char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
    `name`      varchar(255)                                       NOT NULL,
    `desc`      varchar(255)                                       NOT NULL,
    `createdAt` datetime                                           NOT NULL,
    `updatedAt` datetime                                           NOT NULL
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4;

--
-- Dumping data for table `Roles`
--

INSERT INTO `Roles` (`id`, `name`, `desc`, `createdAt`, `updatedAt`)
VALUES ('3fb72eec-3307-4a72-9f28-36b2de52a86e', 'techServ', 'Technical services', NOW(), NOW()),
       ('47ed7c0d-b835-4b26-938c-794ff764313c', 'restau', 'Restaurant', NOW(), NOW()),
       ('66869ff0-f4e1-4c24-8718-fd9665ea996a', 'extDev', 'External developer', NOW(), NOW()),
       ('7f1ecd88-a6af-441d-a5e0-a995fea51b3e', 'apiUser', 'API user', NOW(), NOW()),
       ('b319fc5a-0b05-4e77-8980-07693a8ba7b6', 'client', 'Client', NOW(), NOW()),
       ('ef31c95f-1b96-446e-9a8a-387dc92c1094', 'deliverer', 'Deliverer', NOW(), NOW()),
       ('f10763f0-ee18-4352-b855-63a3ca330d70', 'commServ', 'Commercial services', NOW(), NOW());

-- --------------------------------------------------------

--
-- Table structure for table `Services`
--

CREATE TABLE `Services`
(
    `id`        char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
    `domain`    varchar(255)                                       NOT NULL,
    `createdAt` datetime                                           NOT NULL,
    `updatedAt` datetime                                           NOT NULL
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4;

--
-- Dumping data for table `Services`
--

INSERT INTO `Services` (`id`, `domain`, `createdAt`, `updatedAt`)
VALUES ('63f229e2-8342-4e27-b12d-565738628402', 'deliverers', NOW(), NOW()),
       ('82546b89-be40-435e-a7e2-e833dcb734f6', 'restaurants', NOW(), NOW()),
       ('ddb5539b-be12-4d0c-a7ed-1a5f670b887a', 'users', NOW(), NOW()),
       ('eed74c5c-ab5f-4bca-834f-b9abb29fcd22', 'orders', NOW(), NOW());

-- --------------------------------------------------------

--
-- Table structure for table `Transactions`
--

CREATE TABLE `Transactions`
(
    `id`        char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
    `code`      varchar(255)                                       NOT NULL,
    `method`    enum ('GET','PUT','PATCH','POST','DELETE')         NOT NULL,
    `name`      varchar(255)                                       NOT NULL,
    `desc`      varchar(255)                                       NOT NULL,
    `createdAt` datetime                                           NOT NULL,
    `updatedAt` datetime                                           NOT NULL,
    `roleId`    char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
    `serviceId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4;

--
-- Dumping data for table `Transactions`
--

INSERT INTO `Transactions` (`id`, `code`, `method`, `name`, `desc`, `createdAt`, `updatedAt`, `roleId`, `serviceId`)
VALUES ('00646365-48f6-4792-979d-6152a042f2e7', 'DU', 'DELETE', 'deleteUser', 'Delete user', NOW(), NOW(),
        '47ed7c0d-b835-4b26-938c-794ff764313c', 'ddb5539b-be12-4d0c-a7ed-1a5f670b887a'),
       ('0123585d-0c06-4494-9bb1-d9f06f6ace36', 'UU', 'PATCH', 'updateUser', 'Update user', NOW(), NOW(),
        '7f1ecd88-a6af-441d-a5e0-a995fea51b3e', 'ddb5539b-be12-4d0c-a7ed-1a5f670b887a'),
       ('025a6a12-7e74-49d2-9dd0-541681497df9', 'DU', 'DELETE', 'deleteUser', 'Delete user', NOW(), NOW(),
        '7f1ecd88-a6af-441d-a5e0-a995fea51b3e', 'ddb5539b-be12-4d0c-a7ed-1a5f670b887a'),
       ('0e00c9c7-5caf-46fd-bf5f-c3c232e79391', 'UU', 'PATCH', 'updateUser', 'Update user', NOW(), NOW(),
        '66869ff0-f4e1-4c24-8718-fd9665ea996a', 'ddb5539b-be12-4d0c-a7ed-1a5f670b887a'),
       ('14f5e9f7-3fea-4ab4-8991-2e1296e71516', 'GUS', 'GET', 'getUsers', 'Get users', NOW(), NOW(),
        '3fb72eec-3307-4a72-9f28-36b2de52a86e', 'ddb5539b-be12-4d0c-a7ed-1a5f670b887a'),
       ('18bcff46-b2e5-4acb-8dc2-662a44cb2ddb', 'CD', 'POST', 'deliverer', 'Create deliverer account',
        NOW(), NOW(), 'b319fc5a-0b05-4e77-8980-07693a8ba7b6',
        '63f229e2-8342-4e27-b12d-565738628402'),
       ('21c35b4a-7c94-42ce-917c-454d52772047', 'GRS', 'GET', 'getRestaurantsOpened',
        'Get restaurants opened for client',
        NOW(), NOW(), 'b319fc5a-0b05-4e77-8980-07693a8ba7b6',
        '82546b89-be40-435e-a7e2-e833dcb734f6'),
       ('2524eb03-e189-4fb8-95b7-5d3c426b9c16', 'UR', 'PATCH', 'updateMyRestaurant', 'Update restaurant',
        NOW(), NOW(), '47ed7c0d-b835-4b26-938c-794ff764313c',
        '82546b89-be40-435e-a7e2-e833dcb734f6'),
       ('2aece86a-e4de-4ce2-9a7a-6846b08acf92', 'GI', 'GET', 'item', 'Get item for restaurant',
        NOW(), NOW(), '47ed7c0d-b835-4b26-938c-794ff764313c',
        '82546b89-be40-435e-a7e2-e833dcb734f6'),
       ('2ea2e0e3-ac8a-4f8b-ad9a-598fb709ddc0', 'CR', 'POST', 'createRestaurant', 'Create restaurant',
        NOW(), NOW(), 'b319fc5a-0b05-4e77-8980-07693a8ba7b6',
        '82546b89-be40-435e-a7e2-e833dcb734f6'),
       ('45d22955-1448-4fac-b42a-e2101393150f', 'GIS', 'GET', 'items', 'Get restaurant items for client',
        NOW(), NOW(), 'b319fc5a-0b05-4e77-8980-07693a8ba7b6',
        '82546b89-be40-435e-a7e2-e833dcb734f6'),
       ('45fad115-b6f1-473a-a192-1114419df7c5', 'AO', 'PATCH', 'deliverer/accept', 'Accept order for deliverer',
        NOW(), NOW(), 'ef31c95f-1b96-446e-9a8a-387dc92c1094',
        'eed74c5c-ab5f-4bca-834f-b9abb29fcd22'),
       ('8fdb6e36-8e6b-4b36-8fdc-d207e22b3645', 'DO', 'PATCH', 'deliverer/delivered', 'Delivered order for deliverer',
        NOW(), NOW(), 'ef31c95f-1b96-446e-9a8a-387dc92c1094',
        'eed74c5c-ab5f-4bca-834f-b9abb29fcd22'),
       ('4786afa3-3311-4566-9715-be2a86c8a79d', 'UU', 'PATCH', 'updateUser', 'Update user', NOW(), NOW(),
        '3fb72eec-3307-4a72-9f28-36b2de52a86e', 'ddb5539b-be12-4d0c-a7ed-1a5f670b887a'),
       ('5b5f78f1-df07-4d84-886a-b37d2fc603c3', 'GIS', 'GET', 'items', 'Get restaurant items for technical service',
        NOW(), NOW(), '3fb72eec-3307-4a72-9f28-36b2de52a86e',
        '82546b89-be40-435e-a7e2-e833dcb734f6'),
       ('27067d27-c970-422c-b0cd-5787f42ff911', 'GD', 'GET', 'deliverer', 'Get deliverer for technical service',
        NOW(), NOW(), '3fb72eec-3307-4a72-9f28-36b2de52a86e',
        '63f229e2-8342-4e27-b12d-565738628402'),
       ('81d9c03a-8505-4944-9435-b0615db5c97a', 'GDS', 'GET', '', 'Get deliverers for technical service',
        NOW(), NOW(), '3fb72eec-3307-4a72-9f28-36b2de52a86e',
        '63f229e2-8342-4e27-b12d-565738628402'),
       ('5f08195a-6d6f-4318-836e-7b5d69e80469', 'UI', 'PATCH', 'item', 'Update item', NOW(), NOW(),
        '47ed7c0d-b835-4b26-938c-794ff764313c', '82546b89-be40-435e-a7e2-e833dcb734f6'),
       ('636591bd-35e4-4e67-8ab9-1d6478334fa8', 'UU', 'PATCH', 'updateUser', 'Update user', NOW(), NOW(),
        'f10763f0-ee18-4352-b855-63a3ca330d70', 'ddb5539b-be12-4d0c-a7ed-1a5f670b887a'),
       ('64eea98d-fcba-454f-817d-749eb9ab094c', 'GOS', 'GET', 'restaurant', 'Get orders for restaurant',
        NOW(), NOW(), '47ed7c0d-b835-4b26-938c-794ff764313c',
        'eed74c5c-ab5f-4bca-834f-b9abb29fcd22'),
       ('27017f0f-ca98-499b-956f-447e6ac30c18', 'GPOS', 'GET', 'restaurant/pending',
        'Get pending orders for restaurant',
        NOW(), NOW(), '47ed7c0d-b835-4b26-938c-794ff764313c',
        'eed74c5c-ab5f-4bca-834f-b9abb29fcd22'),
       ('693374c5-5a0b-40d6-8ef5-e2cc9a056d8a', 'GMIS', 'GET', 'myItems', 'Get items for restaurant',
        NOW(), NOW(), '47ed7c0d-b835-4b26-938c-794ff764313c',
        '82546b89-be40-435e-a7e2-e833dcb734f6'),
       ('7062e44f-799d-47f1-9fd8-d788e5fc4387', 'AO', 'PATCH', 'restaurant/accept', 'Accept order for restaurant',
        NOW(), NOW(), '47ed7c0d-b835-4b26-938c-794ff764313c',
        'eed74c5c-ab5f-4bca-834f-b9abb29fcd22'),
       ('7383f83b-867c-48dd-9d58-e0a7b25a3490', 'UU', 'PATCH', 'updateUser', 'Update user', NOW(), NOW(),
        'b319fc5a-0b05-4e77-8980-07693a8ba7b6', 'ddb5539b-be12-4d0c-a7ed-1a5f670b887a'),
       ('7fad8ab1-1c66-498d-9d6c-b6a29d32b079', 'UU', 'PATCH', 'updateUser', 'Update user', NOW(), NOW(),
        '47ed7c0d-b835-4b26-938c-794ff764313c', 'ddb5539b-be12-4d0c-a7ed-1a5f670b887a'),
       ('8b5354d9-243d-492c-a2aa-2397698e4657', 'GRS', 'GET', 'getRestaurantsOpened',
        'Get restaurants opened for deliverer',
        NOW(), NOW(), 'ef31c95f-1b96-446e-9a8a-387dc92c1094',
        '82546b89-be40-435e-a7e2-e833dcb734f6'),
       ('a0744e7b-4ff7-462a-9d34-55259ee8b10b', 'CO', 'POST', 'order', 'Create order for client',
        NOW(), NOW(), 'b319fc5a-0b05-4e77-8980-07693a8ba7b6',
        'eed74c5c-ab5f-4bca-834f-b9abb29fcd22'),
       ('a0da08cc-090a-491b-bcf6-9deb28d840d0', 'DU', 'DELETE', 'deleteUser', 'Delete user', NOW(), NOW(),
        '66869ff0-f4e1-4c24-8718-fd9665ea996a', 'ddb5539b-be12-4d0c-a7ed-1a5f670b887a'),
       ('ab5948fa-dac2-481d-bdb7-027a5bbc498c', 'GR', 'GET', 'getRestaurant', 'Get a restaurant for deliverer',
        NOW(), NOW(), 'ef31c95f-1b96-446e-9a8a-387dc92c1094',
        '82546b89-be40-435e-a7e2-e833dcb734f6'),
       ('afb0f591-8499-4174-85f3-1d4127f6dd4f', 'DD', 'PATCH', 'deliverer/revoke',
        'Revoke my deliverer account', NOW(), NOW(), 'ef31c95f-1b96-446e-9a8a-387dc92c1094',
        '63f229e2-8342-4e27-b12d-565738628402'),
       ('b01f2802-b7ec-4e11-98a8-77db45953600', 'DU', 'DELETE', 'deleteUser', 'Delete user', NOW(), NOW(),
        'b319fc5a-0b05-4e77-8980-07693a8ba7b6', 'ddb5539b-be12-4d0c-a7ed-1a5f670b887a'),
       ('baf37110-f2f6-4bf2-8771-d732734328cc', 'DU', 'DELETE', 'deleteUser', 'Delete user', NOW(), NOW(),
        '3fb72eec-3307-4a72-9f28-36b2de52a86e', 'ddb5539b-be12-4d0c-a7ed-1a5f670b887a'),
       ('be071d06-1e5a-4bf3-a715-19de2cdc109f', 'GRS', 'GET', 'getRestaurants',
        'Get restaurants for technical service',
        NOW(), NOW(), '3fb72eec-3307-4a72-9f28-36b2de52a86e',
        '82546b89-be40-435e-a7e2-e833dcb734f6'),
       ('c138d8e5-4e8f-4fa6-ab6e-ae1cad4984b0', 'DI', 'DELETE', 'item', 'Delete item', NOW(), NOW(),
        '47ed7c0d-b835-4b26-938c-794ff764313c', '82546b89-be40-435e-a7e2-e833dcb734f6'),
       ('c603bb70-ecb1-4814-85d7-b92c49d79b75', 'GR', 'GET', 'getRestaurant', 'Get a restaurant for technical service',
        NOW(), NOW(), '3fb72eec-3307-4a72-9f28-36b2de52a86e',
        '82546b89-be40-435e-a7e2-e833dcb734f6'),
       ('ca7c173e-9c54-43e9-b9b8-61204e455aa4', 'UU', 'PATCH', 'updateUser', 'Update user', NOW(), NOW(),
        'ef31c95f-1b96-446e-9a8a-387dc92c1094', 'ddb5539b-be12-4d0c-a7ed-1a5f670b887a'),
       ('dd63124f-0e8a-49a7-9e42-8198d6317f64', 'CI', 'POST', 'item', 'Create item', NOW(), NOW(),
        '47ed7c0d-b835-4b26-938c-794ff764313c', '82546b89-be40-435e-a7e2-e833dcb734f6'),
       ('e29c3228-613d-45d7-8aa8-5a91c4835895', 'GR', 'GET', 'getRestaurant', 'Get a restaurant for client',
        NOW(), NOW(), 'b319fc5a-0b05-4e77-8980-07693a8ba7b6',
        '82546b89-be40-435e-a7e2-e833dcb734f6'),
       ('edce8554-56a7-454e-8fc0-7fe9a27fcc59', 'GOS', 'GET', 'client', 'Get orders for client', NOW(), NOW(),
        'b319fc5a-0b05-4e77-8980-07693a8ba7b6', 'eed74c5c-ab5f-4bca-834f-b9abb29fcd22'),
       ('a1c020eb-d3c0-4ac3-ad03-03ad184d8386', 'GO', 'GET', 'client/order', 'Get order for client', NOW(), NOW(),
        'b319fc5a-0b05-4e77-8980-07693a8ba7b6', 'eed74c5c-ab5f-4bca-834f-b9abb29fcd22'),
       ('ee1096d8-ca84-419c-b766-a100fa523980', 'DU', 'DELETE', 'deleteUser', 'Delete user', NOW(), NOW(),
        'ef31c95f-1b96-446e-9a8a-387dc92c1094', 'ddb5539b-be12-4d0c-a7ed-1a5f670b887a'),
       ('ee7fc0f7-9068-4ac0-a74b-fac3e5e906a8', 'DR', 'PATCH', 'closeMyRestaurant', 'Close user restaurant',
        NOW(), NOW(), '47ed7c0d-b835-4b26-938c-794ff764313c',
        '82546b89-be40-435e-a7e2-e833dcb734f6'),
       ('50976b68-a11c-408a-adb9-0347160c3586', 'GMR', 'GET', 'getMyRestaurant', 'Get his restaurant',
        NOW(), NOW(), '47ed7c0d-b835-4b26-938c-794ff764313c',
        '82546b89-be40-435e-a7e2-e833dcb734f6'),
       ('f65c273d-aece-4f9f-96d3-ae34a693adad', 'GOS', 'GET', 'deliverer', 'Get orders for deliverer',
        NOW(), NOW(), 'ef31c95f-1b96-446e-9a8a-387dc92c1094',
        'eed74c5c-ab5f-4bca-834f-b9abb29fcd22'),
       ('a3cfb3dd-fd8b-450c-8483-fb277a84448a', 'GIOS', 'GET', 'deliverer/inProgress',
        'Get in progress orders for deliverer',
        NOW(), NOW(), 'ef31c95f-1b96-446e-9a8a-387dc92c1094',
        'eed74c5c-ab5f-4bca-834f-b9abb29fcd22'),
       ('faa1ea88-cf5b-46d4-9ffa-c12524f521ce', 'DU', 'DELETE', 'deleteUser', 'Delete user', NOW(), NOW(),
        'f10763f0-ee18-4352-b855-63a3ca330d70', 'ddb5539b-be12-4d0c-a7ed-1a5f670b887a'),
       ('d24f7117-c871-4082-bbfe-a5bc67c0cd0e', 'CUP', 'PATCH', 'changeUserPassword', 'Change user password', NOW(),
        NOW(),
        'f10763f0-ee18-4352-b855-63a3ca330d70', 'ddb5539b-be12-4d0c-a7ed-1a5f670b887a'),
       ('ea1e1dcc-88a8-4c7e-9056-4234296aee71', 'CUP', 'PATCH', 'changeUserPassword', 'Change user password', NOW(),
        NOW(),
        'ef31c95f-1b96-446e-9a8a-387dc92c1094', 'ddb5539b-be12-4d0c-a7ed-1a5f670b887a'),
       ('40360fcc-33ca-4d66-b9ad-2  dec4402b9bc', 'CUP', 'PATCH', 'changeUserPassword', 'Change user password', NOW(),
        NOW(),
        'b319fc5a-0b05-4e77-8980-07693a8ba7b6', 'ddb5539b-be12-4d0c-a7ed-1a5f670b887a'),
       ('1ff325cf-a3c0-44e2-92c4-3efe44e50ba7', 'CUP', 'PATCH', 'changeUserPassword', 'Change user password', NOW(),
        NOW(),
        '3fb72eec-3307-4a72-9f28-36b2de52a86e', 'ddb5539b-be12-4d0c-a7ed-1a5f670b887a'),
       ('8415c445-bf9a-46dd-86c4-9284a59b657b', 'CUP', 'PATCH', 'changeUserPassword', 'Change user password', NOW(),
        NOW(),
        '66869ff0-f4e1-4c24-8718-fd9665ea996a', 'ddb5539b-be12-4d0c-a7ed-1a5f670b887a'),
       ('1e3faee0-beca-4cd1-b888-579f3d7115f5', 'CUP', 'PATCH', 'changeUserPassword', 'Change user password', NOW(),
        NOW(),
        '7f1ecd88-a6af-441d-a5e0-a995fea51b3e', 'ddb5539b-be12-4d0c-a7ed-1a5f670b887a'),
       ('8aacb565-d858-4942-b74a-39f0877149c6', 'CUP', 'PATCH', 'changeUserPassword', 'Change user password', NOW(),
        NOW(),
        '47ed7c0d-b835-4b26-938c-794ff764313c', 'ddb5539b-be12-4d0c-a7ed-1a5f670b887a'),
       ('542daabe-1a64-4569-ac8a-6e0d743f1e31', 'CUR', 'PATCH', 'changeUserRole', 'Change user role', NOW(),
        NOW(), '3fb72eec-3307-4a72-9f28-36b2de52a86e', 'ddb5539b-be12-4d0c-a7ed-1a5f670b887a'),
       ('1237fa98-8f50-4d81-a9c8-ee785e8ead24', 'OR', 'PATCH', 'openRestaurant', 'Open user restaurant', NOW(),
        NOW(), '3fb72eec-3307-4a72-9f28-36b2de52a86e', '82546b89-be40-435e-a7e2-e833dcb734f6'),
       ('32384488-66b6-4c8d-8138-6764ece91349', 'AD', 'PATCH', 'deliverer/allow', 'Allow deliverer account', NOW(),
        NOW(), '3fb72eec-3307-4a72-9f28-36b2de52a86e', '63f229e2-8342-4e27-b12d-565738628402'),
       ('8b01de53-39d3-4420-bf16-5b415cdb9cc9', 'GRC', 'GET', 'getRestaurantCategories',
        'Get restaurant categories for technical services', NOW(),
        NOW(), '3fb72eec-3307-4a72-9f28-36b2de52a86e', '82546b89-be40-435e-a7e2-e833dcb734f6'),
       ('2c9c48b5-6ff3-4a4c-9235-3087ba08ce8c', 'GRC', 'GET', 'getRestaurantCategories',
        'Get restaurant categories for restaurant', NOW(),
        NOW(), '47ed7c0d-b835-4b26-938c-794ff764313c', '82546b89-be40-435e-a7e2-e833dcb734f6'),
       ('994c3201-b8c1-4114-83b3-11eed3391e8a', 'GRC', 'GET', 'getRestaurantCategories',
        'Get restaurant categories for external developer', NOW(),
        NOW(), '66869ff0-f4e1-4c24-8718-fd9665ea996a', '82546b89-be40-435e-a7e2-e833dcb734f6'),
       ('541b44c2-5da4-485f-b115-71f35d0deff5', 'GRC', 'GET', 'getRestaurantCategories',
        'Get restaurant categories for API user', NOW(),
        NOW(), '7f1ecd88-a6af-441d-a5e0-a995fea51b3e', '82546b89-be40-435e-a7e2-e833dcb734f6'),
       ('627e8fc8-36ea-46bf-b9d2-dd640e1b0ead', 'GRC', 'GET', 'getRestaurantCategories',
        'Get restaurant categories for client', NOW(),
        NOW(), 'b319fc5a-0b05-4e77-8980-07693a8ba7b6', '82546b89-be40-435e-a7e2-e833dcb734f6'),
       ('818d2c9d-2b96-4366-b9fc-01ef34270a9f', 'GRC', 'GET', 'getRestaurantCategories',
        'Get restaurant categories for deliverer', NOW(),
        NOW(), 'ef31c95f-1b96-446e-9a8a-387dc92c1094', '82546b89-be40-435e-a7e2-e833dcb734f6'),
       ('6dcfd9dd-a863-4882-a78c-26669e7177f5', 'GRC', 'GET', 'getRestaurantCategories',
        'Get restaurant categories for commercial services', NOW(),
        NOW(), 'f10763f0-ee18-4352-b855-63a3ca330d70', '82546b89-be40-435e-a7e2-e833dcb734f6');

-- --------------------------------------------------------

--
-- Table structure for table `Users`
--

CREATE TABLE `Users`
(
    `id`           char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
    `firstName`    varchar(255)                                       NOT NULL,
    `lastName`     varchar(255)                                       NOT NULL,
    `email`        varchar(255)                                       NOT NULL,
    `address`      varchar(255)                                       NOT NULL,
    `phone`        varchar(255)                                       NOT NULL,
    `password`     varchar(255)                                       NOT NULL,
    `accessToken`  varchar(255)                                       DEFAULT NULL,
    `refreshToken` varchar(255)                                       DEFAULT NULL,
    `createdAt`    datetime                                           NOT NULL,
    `updatedAt`    datetime                                           NOT NULL,
    `roleId`       char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4;

--
-- Dumping data for table `Users`
--

INSERT INTO `Users` (`id`, `firstName`, `lastName`, `email`, `address`, `phone`, `password`, `accessToken`,
                     `refreshToken`, `createdAt`, `updatedAt`, `roleId`)
VALUES ('691e33d1-62c5-424e-9339-a766a35871fc', 'Stanislas', 'Foillard', 'stanislas.foillard@admin.com', '123 soleil',
        '+33606060606', '$2b$10$tNRSeAD/E.EmGzZfXUK0o.Z3GiJA6fM/h1nTSQyMIDT6g/o5ko55q', 'noToken', 'noToken',
        NOW(), NOW(), '3fb72eec-3307-4a72-9f28-36b2de52a86e'),
       ('99b072e1-4c86-4d1b-96bf-e3ac6d2958c3', 'Stanislas', 'Foillard', 'stanislas.foillard@client.com', '123 soleil',
        '+33606060606', '$2b$10$tNRSeAD/E.EmGzZfXUK0o.Z3GiJA6fM/h1nTSQyMIDT6g/o5ko55q', 'noToken', 'noToken',
        NOW(), NOW(), 'b319fc5a-0b05-4e77-8980-07693a8ba7b6'),
       ('f924c160-87af-445d-a599-fe2055c4adc2', 'Stanislas', 'Foillard', 'stanislas.foillard@restau.com', '123 soleil',
        '+33606060606', '$2b$10$tNRSeAD/E.EmGzZfXUK0o.Z3GiJA6fM/h1nTSQyMIDT6g/o5ko55q', 'noToken', 'noToken',
        NOW(), NOW(), '47ed7c0d-b835-4b26-938c-794ff764313c'),
       ('348923ac-2bc3-4084-93fa-3d03301b2525', 'Stanislas', 'Foillard', 'stanislas.foillard@deliverer.com',
        '123 soleil',
        '+33606060606', '$2b$10$tNRSeAD/E.EmGzZfXUK0o.Z3GiJA6fM/h1nTSQyMIDT6g/o5ko55q', 'noToken', 'noToken',
        NOW(), NOW(), 'ef31c95f-1b96-446e-9a8a-387dc92c1094'),
       ('7b731286-138a-4240-a4f9-0438a6ddaf59', 'Bastien', 'Reynaud', 'bastien.reynaud@admin.com', '123 soleil',
        '+33606060606', '$2b$10$fWG8PgzX4xBYnTsLKxQv5ejSOgdIkqlrQ1anPMclznQuGpUufEfOC', 'noToken', 'noToken',
        NOW(), NOW(), '3fb72eec-3307-4a72-9f28-36b2de52a86e'),
       ('a3250cf8-82a3-4b14-96ff-f14ae4f71daf', 'Bastien', 'Reynaud', 'bastien.reynaud@client.com', '123 soleil',
        '+33606060606', '$2b$10$fWG8PgzX4xBYnTsLKxQv5ejSOgdIkqlrQ1anPMclznQuGpUufEfOC', 'noToken', 'noToken',
        NOW(), NOW(), 'b319fc5a-0b05-4e77-8980-07693a8ba7b6'),
       ('a998b86a-1436-4987-9560-ed5c15589bdf', 'Hugo', 'Nahmias', 'hugo.nahmias@admin.com', '123 soleil',
        '+33606060606', '$2b$10$fyIh9FQYrNVj9dGDE8KbtO9tQQ7dYf6LJKFGhUL24KiHi/F.nH6ke', 'noToken', 'noToken',
        NOW(), NOW(), '3fb72eec-3307-4a72-9f28-36b2de52a86e'),
       ('3088cfc1-e602-43e7-8162-2b2397422c97', 'Hugo', 'Nahmias', 'hugo.nahmias@client.com', '123 soleil',
        '+33606060606', '$2b$10$fyIh9FQYrNVj9dGDE8KbtO9tQQ7dYf6LJKFGhUL24KiHi/F.nH6ke', 'noToken', 'noToken',
        NOW(), NOW(), 'b319fc5a-0b05-4e77-8980-07693a8ba7b6'),
       ('b44b4091-e159-424d-8bb8-da9bdbcec0d9', 'Hugo', 'Nahmias', 'hugo.nahmias@restau.com', '123 soleil',
        '+33606060606', '$2b$10$fyIh9FQYrNVj9dGDE8KbtO9tQQ7dYf6LJKFGhUL24KiHi/F.nH6ke', 'noToken', 'noToken',
        NOW(), NOW(), '47ed7c0d-b835-4b26-938c-794ff764313c');

--
-- Table structure for table `TransactionTokens`
--

CREATE TABLE `TransactionTokens`
(
    `id`            char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
    `token`         varchar(255)                                       NOT NULL,
    `createdAt`     datetime                                           NOT NULL,
    `updatedAt`     datetime                                           NOT NULL,
    `userId`        char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
    `transactionId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4;


--
-- Indexes for dumped tables
--

--
-- Indexes for table `Roles`
--
ALTER TABLE `Roles`
    ADD PRIMARY KEY (`id`),
    ADD UNIQUE KEY `id` (`id`);

--
-- Indexes for table `Services`
--
ALTER TABLE `Services`
    ADD PRIMARY KEY (`id`),
    ADD UNIQUE KEY `id` (`id`);

--
-- Indexes for table `Transactions`
--
ALTER TABLE `Transactions`
    ADD PRIMARY KEY (`id`),
    ADD UNIQUE KEY `id` (`id`),
    ADD KEY `roleId` (`roleId`),
    ADD KEY `serviceId` (`serviceId`);

--
-- Indexes for table `Users`
--
ALTER TABLE `Users`
    ADD PRIMARY KEY (`id`),
    ADD UNIQUE KEY `id` (`id`),
    ADD UNIQUE KEY `email` (`email`),
    ADD KEY `roleId` (`roleId`);

--
-- Indexes for table `TransactionTokens`
--
ALTER TABLE `TransactionTokens`
    ADD PRIMARY KEY (`id`),
    ADD UNIQUE KEY `id` (`id`),
    ADD KEY `userId` (`userId`),
    ADD KEY `transactionId` (`transactionId`);


--
-- Constraints for dumped tables
--

--
-- Constraints for table `Transactions`
--
ALTER TABLE `Transactions`
    ADD CONSTRAINT `Transactions_ibfk_1` FOREIGN KEY (`roleId`) REFERENCES `Roles` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
    ADD CONSTRAINT `Transactions_ibfk_2` FOREIGN KEY (`serviceId`) REFERENCES `Services` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `Users`
--
ALTER TABLE `Users`
    ADD CONSTRAINT `Users_ibfk_1` FOREIGN KEY (`roleId`) REFERENCES `Roles` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;
COMMIT;

--
-- Constraints for table `TransactionTokens`
--
ALTER TABLE `TransactionTokens`
    ADD CONSTRAINT `TransactionTokens_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `Users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
    ADD CONSTRAINT `TransactionTokens_ibfk_2` FOREIGN KEY (`transactionId`) REFERENCES `Transactions` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT = @OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS = @OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION = @OLD_COLLATION_CONNECTION */;
