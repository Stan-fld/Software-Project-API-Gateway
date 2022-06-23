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
VALUES ('3fb72eec-3307-4a72-9f28-36b2de52a86e', 'techServ', 'Technical services', '2022-06-23 08:50:16',
        '2022-06-23 08:50:16'),
       ('47ed7c0d-b835-4b26-938c-794ff764313c', 'restau', 'Restaurant', '2022-06-23 08:50:16', '2022-06-23 08:50:16'),
       ('66869ff0-f4e1-4c24-8718-fd9665ea996a', 'extDev', 'External developer', '2022-06-23 08:50:16',
        '2022-06-23 08:50:16'),
       ('7f1ecd88-a6af-441d-a5e0-a995fea51b3e', 'apiUser', 'API user', '2022-06-23 08:50:16', '2022-06-23 08:50:16'),
       ('b319fc5a-0b05-4e77-8980-07693a8ba7b6', 'client', 'Client', '2022-06-23 08:50:16', '2022-06-23 08:50:16'),
       ('ef31c95f-1b96-446e-9a8a-387dc92c1094', 'deliverer', 'Deliverer', '2022-06-23 08:50:16', '2022-06-23 08:50:16'),
       ('f10763f0-ee18-4352-b855-63a3ca330d70', 'commServ', 'Commercial services', '2022-06-23 08:50:16',
        '2022-06-23 08:50:16');

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
VALUES ('63f229e2-8342-4e27-b12d-565738628402', 'deliverers', '2022-06-23 08:50:16', '2022-06-23 08:50:16'),
       ('82546b89-be40-435e-a7e2-e833dcb734f6', 'restaurants', '2022-06-23 08:50:16', '2022-06-23 08:50:16'),
       ('ddb5539b-be12-4d0c-a7ed-1a5f670b887a', 'users', '2022-06-23 08:50:16', '2022-06-23 08:50:16'),
       ('eed74c5c-ab5f-4bca-834f-b9abb29fcd22', 'orders', '2022-06-23 08:50:16', '2022-06-23 08:50:16');

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
VALUES ('00646365-48f6-4792-979d-6152a042f2e7', 'DU', 'DELETE', 'deleteUser', 'Delete user', '2022-06-23 08:50:16',
        '2022-06-23 08:50:16', '47ed7c0d-b835-4b26-938c-794ff764313c', 'ddb5539b-be12-4d0c-a7ed-1a5f670b887a'),
       ('0123585d-0c06-4494-9bb1-d9f06f6ace36', 'UU', 'PATCH', 'updateUser', 'Update user', '2022-06-23 08:50:16',
        '2022-06-23 08:50:16', '7f1ecd88-a6af-441d-a5e0-a995fea51b3e', 'ddb5539b-be12-4d0c-a7ed-1a5f670b887a'),
       ('025a6a12-7e74-49d2-9dd0-541681497df9', 'DU', 'DELETE', 'deleteUser', 'Delete user', '2022-06-23 08:50:16',
        '2022-06-23 08:50:16', '7f1ecd88-a6af-441d-a5e0-a995fea51b3e', 'ddb5539b-be12-4d0c-a7ed-1a5f670b887a'),
       ('0e00c9c7-5caf-46fd-bf5f-c3c232e79391', 'UU', 'PATCH', 'updateUser', 'Update user', '2022-06-23 08:50:16',
        '2022-06-23 08:50:16', '66869ff0-f4e1-4c24-8718-fd9665ea996a', 'ddb5539b-be12-4d0c-a7ed-1a5f670b887a'),
       ('14f5e9f7-3fea-4ab4-8991-2e1296e71516', 'GUS', 'GET', 'getUsers', 'Get users', '2022-06-23 08:50:16',
        '2022-06-23 08:50:16', '3fb72eec-3307-4a72-9f28-36b2de52a86e', 'ddb5539b-be12-4d0c-a7ed-1a5f670b887a'),
       ('18bcff46-b2e5-4acb-8dc2-662a44cb2ddb', 'CD', 'POST', 'createDeliverer', 'Create deliverer',
        '2022-06-23 08:50:16', '2022-06-23 08:50:16', 'b319fc5a-0b05-4e77-8980-07693a8ba7b6',
        '63f229e2-8342-4e27-b12d-565738628402'),
       ('1a38feae-1561-422d-a7fe-aed652762e9b', 'UD', 'PATCH', 'updateDeliverer', 'Update deliverer',
        '2022-06-23 08:50:16', '2022-06-23 08:50:16', 'ef31c95f-1b96-446e-9a8a-387dc92c1094',
        '63f229e2-8342-4e27-b12d-565738628402'),
       ('21c35b4a-7c94-42ce-917c-454d52772047', 'GRS', 'GET', 'getRestaurants', 'Get restaurants for client',
        '2022-06-23 08:50:16', '2022-06-23 08:50:16', 'b319fc5a-0b05-4e77-8980-07693a8ba7b6',
        '82546b89-be40-435e-a7e2-e833dcb734f6'),
       ('2524eb03-e189-4fb8-95b7-5d3c426b9c16', 'UR', 'PATCH', 'updateRestaurant', 'Update restaurant',
        '2022-06-23 08:50:16', '2022-06-23 08:50:16', '47ed7c0d-b835-4b26-938c-794ff764313c',
        '82546b89-be40-435e-a7e2-e833dcb734f6'),
       ('2aece86a-e4de-4ce2-9a7a-6846b08acf92', 'GI', 'GET', 'getItem', 'Get item for restaurant',
        '2022-06-23 08:50:16', '2022-06-23 08:50:16', '47ed7c0d-b835-4b26-938c-794ff764313c',
        '82546b89-be40-435e-a7e2-e833dcb734f6'),
       ('2ea2e0e3-ac8a-4f8b-ad9a-598fb709ddc0', 'CR', 'POST', 'createRestaurant', 'Create restaurant',
        '2022-06-23 08:50:16', '2022-06-23 08:50:16', 'b319fc5a-0b05-4e77-8980-07693a8ba7b6',
        '82546b89-be40-435e-a7e2-e833dcb734f6'),
       ('45d22955-1448-4fac-b42a-e2101393150f', 'GIS', 'GET', 'getItems', 'Get restaurant items for client',
        '2022-06-23 08:50:16', '2022-06-23 08:50:16', 'b319fc5a-0b05-4e77-8980-07693a8ba7b6',
        '82546b89-be40-435e-a7e2-e833dcb734f6'),
       ('45fad115-b6f1-473a-a192-1114419df7c5', 'AO', 'PATCH', 'acceptOrder', 'Accept order for deliverer',
        '2022-06-23 08:50:16', '2022-06-23 08:50:16', 'ef31c95f-1b96-446e-9a8a-387dc92c1094',
        'eed74c5c-ab5f-4bca-834f-b9abb29fcd22'),
       ('4786afa3-3311-4566-9715-be2a86c8a79d', 'UU', 'PATCH', 'updateUser', 'Update user', '2022-06-23 08:50:16',
        '2022-06-23 08:50:16', '3fb72eec-3307-4a72-9f28-36b2de52a86e', 'ddb5539b-be12-4d0c-a7ed-1a5f670b887a'),
       ('5b5f78f1-df07-4d84-886a-b37d2fc603c3', 'GIS', 'GET', 'getItems', 'Get restaurant items for commercial service',
        '2022-06-23 08:50:16', '2022-06-23 08:50:16', 'f10763f0-ee18-4352-b855-63a3ca330d70',
        '82546b89-be40-435e-a7e2-e833dcb734f6'),
       ('5f08195a-6d6f-4318-836e-7b5d69e80469', 'UI', 'PATCH', 'updateItem', 'Update item', '2022-06-23 08:50:16',
        '2022-06-23 08:50:16', '47ed7c0d-b835-4b26-938c-794ff764313c', '82546b89-be40-435e-a7e2-e833dcb734f6'),
       ('636591bd-35e4-4e67-8ab9-1d6478334fa8', 'UU', 'PATCH', 'updateUser', 'Update user', '2022-06-23 08:50:16',
        '2022-06-23 08:50:16', 'f10763f0-ee18-4352-b855-63a3ca330d70', 'ddb5539b-be12-4d0c-a7ed-1a5f670b887a'),
       ('64eea98d-fcba-454f-817d-749eb9ab094c', 'GO', 'GET', 'getOrder', 'Get order for restaurant',
        '2022-06-23 08:50:16', '2022-06-23 08:50:16', '47ed7c0d-b835-4b26-938c-794ff764313c',
        'eed74c5c-ab5f-4bca-834f-b9abb29fcd22'),
       ('693374c5-5a0b-40d6-8ef5-e2cc9a056d8a', 'GIS', 'GET', 'getMyItems', 'Get items for restaurant',
        '2022-06-23 08:50:16', '2022-06-23 08:50:16', '47ed7c0d-b835-4b26-938c-794ff764313c',
        '82546b89-be40-435e-a7e2-e833dcb734f6'),
       ('7062e44f-799d-47f1-9fd8-d788e5fc4387', 'AO', 'PATCH', 'acceptOrder', 'Accept order for restaurant',
        '2022-06-23 08:50:16', '2022-06-23 08:50:16', '47ed7c0d-b835-4b26-938c-794ff764313c',
        'eed74c5c-ab5f-4bca-834f-b9abb29fcd22'),
       ('7383f83b-867c-48dd-9d58-e0a7b25a3490', 'UU', 'PATCH', 'updateUser', 'Update user', '2022-06-23 08:50:16',
        '2022-06-23 08:50:16', 'b319fc5a-0b05-4e77-8980-07693a8ba7b6', 'ddb5539b-be12-4d0c-a7ed-1a5f670b887a'),
       ('7fad8ab1-1c66-498d-9d6c-b6a29d32b079', 'UU', 'PATCH', 'updateUser', 'Update user', '2022-06-23 08:50:16',
        '2022-06-23 08:50:16', '47ed7c0d-b835-4b26-938c-794ff764313c', 'ddb5539b-be12-4d0c-a7ed-1a5f670b887a'),
       ('87376799-9903-4ea0-b658-3873c56d7df8', 'DO', 'DELETE', 'deleteOrder', 'Delete order for client',
        '2022-06-23 08:50:16', '2022-06-23 08:50:16', 'b319fc5a-0b05-4e77-8980-07693a8ba7b6',
        'eed74c5c-ab5f-4bca-834f-b9abb29fcd22'),
       ('8b5354d9-243d-492c-a2aa-2397698e4657', 'GRS', 'GET', 'getRestaurants', 'Get restaurants for deliverer',
        '2022-06-23 08:50:16', '2022-06-23 08:50:16', 'ef31c95f-1b96-446e-9a8a-387dc92c1094',
        '82546b89-be40-435e-a7e2-e833dcb734f6'),
       ('a0744e7b-4ff7-462a-9d34-55259ee8b10b', 'CO', 'POST', 'createOrder', 'Create order for client',
        '2022-06-23 08:50:16', '2022-06-23 08:50:16', 'b319fc5a-0b05-4e77-8980-07693a8ba7b6',
        'eed74c5c-ab5f-4bca-834f-b9abb29fcd22'),
       ('a0da08cc-090a-491b-bcf6-9deb28d840d0', 'DU', 'DELETE', 'deleteUser', 'Delete user', '2022-06-23 08:50:16',
        '2022-06-23 08:50:16', '66869ff0-f4e1-4c24-8718-fd9665ea996a', 'ddb5539b-be12-4d0c-a7ed-1a5f670b887a'),
       ('ab5948fa-dac2-481d-bdb7-027a5bbc498c', 'GR', 'GET', 'getRestaurant', 'Get a restaurant for deliverer',
        '2022-06-23 08:50:16', '2022-06-23 08:50:16', 'ef31c95f-1b96-446e-9a8a-387dc92c1094',
        '82546b89-be40-435e-a7e2-e833dcb734f6'),
       ('afb0f591-8499-4174-85f3-1d4127f6dd4f', 'DD', 'DELETE', 'deleteDeliverer', 'Delete deliverer',
        '2022-06-23 08:50:16', '2022-06-23 08:50:16', 'ef31c95f-1b96-446e-9a8a-387dc92c1094',
        '63f229e2-8342-4e27-b12d-565738628402'),
       ('b01f2802-b7ec-4e11-98a8-77db45953600', 'DU', 'DELETE', 'deleteUser', 'Delete user', '2022-06-23 08:50:16',
        '2022-06-23 08:50:16', 'b319fc5a-0b05-4e77-8980-07693a8ba7b6', 'ddb5539b-be12-4d0c-a7ed-1a5f670b887a'),
       ('baf37110-f2f6-4bf2-8771-d732734328cc', 'DU', 'DELETE', 'deleteUser', 'Delete user', '2022-06-23 08:50:16',
        '2022-06-23 08:50:16', '3fb72eec-3307-4a72-9f28-36b2de52a86e', 'ddb5539b-be12-4d0c-a7ed-1a5f670b887a'),
       ('be071d06-1e5a-4bf3-a715-19de2cdc109f', 'GRS', 'GET', 'getRestaurants', 'Get restaurants for technical service',
        '2022-06-23 08:50:16', '2022-06-23 08:50:16', '3fb72eec-3307-4a72-9f28-36b2de52a86e',
        '82546b89-be40-435e-a7e2-e833dcb734f6'),
       ('c138d8e5-4e8f-4fa6-ab6e-ae1cad4984b0', 'DI', 'DELETE', 'deleteItem', 'Delete item', '2022-06-23 08:50:16',
        '2022-06-23 08:50:16', '47ed7c0d-b835-4b26-938c-794ff764313c', '82546b89-be40-435e-a7e2-e833dcb734f6'),
       ('c603bb70-ecb1-4814-85d7-b92c49d79b75', 'GR', 'GET', 'getRestaurant', 'Get a restaurant for technical service',
        '2022-06-23 08:50:16', '2022-06-23 08:50:16', '3fb72eec-3307-4a72-9f28-36b2de52a86e',
        '82546b89-be40-435e-a7e2-e833dcb734f6'),
       ('ca7c173e-9c54-43e9-b9b8-61204e455aa4', 'UU', 'PATCH', 'updateUser', 'Update user', '2022-06-23 08:50:16',
        '2022-06-23 08:50:16', 'ef31c95f-1b96-446e-9a8a-387dc92c1094', 'ddb5539b-be12-4d0c-a7ed-1a5f670b887a'),
       ('dd63124f-0e8a-49a7-9e42-8198d6317f64', 'CI', 'POST', 'createItem', 'Create item', '2022-06-23 08:50:16',
        '2022-06-23 08:50:16', '47ed7c0d-b835-4b26-938c-794ff764313c', '82546b89-be40-435e-a7e2-e833dcb734f6'),
       ('e29c3228-613d-45d7-8aa8-5a91c4835895', 'GR', 'GET', 'getRestaurant', 'Get a restaurant for client',
        '2022-06-23 08:50:16', '2022-06-23 08:50:16', 'b319fc5a-0b05-4e77-8980-07693a8ba7b6',
        '82546b89-be40-435e-a7e2-e833dcb734f6'),
       ('edce8554-56a7-454e-8fc0-7fe9a27fcc59', 'GO', 'GET', 'getOrder', 'Get order for client', '2022-06-23 08:50:16',
        '2022-06-23 08:50:16', 'b319fc5a-0b05-4e77-8980-07693a8ba7b6', 'eed74c5c-ab5f-4bca-834f-b9abb29fcd22'),
       ('ee1096d8-ca84-419c-b766-a100fa523980', 'DU', 'DELETE', 'deleteUser', 'Delete user', '2022-06-23 08:50:16',
        '2022-06-23 08:50:16', 'ef31c95f-1b96-446e-9a8a-387dc92c1094', 'ddb5539b-be12-4d0c-a7ed-1a5f670b887a'),
       ('ee7fc0f7-9068-4ac0-a74b-fac3e5e906a8', 'DR', 'DELETE', 'deleteRestaurant', 'Delete restaurant',
        '2022-06-23 08:50:16', '2022-06-23 08:50:16', '47ed7c0d-b835-4b26-938c-794ff764313c',
        '82546b89-be40-435e-a7e2-e833dcb734f6'),
       ('f0f28a44-3bf3-40bb-888d-4187b5d5e07e', 'UO', 'PATCH', 'updateOrder', 'Update order for client',
        '2022-06-23 08:50:16', '2022-06-23 08:50:16', 'b319fc5a-0b05-4e77-8980-07693a8ba7b6',
        'eed74c5c-ab5f-4bca-834f-b9abb29fcd22'),
       ('f65c273d-aece-4f9f-96d3-ae34a693adad', 'GO', 'GET', 'getOrder', 'Get order for deliverer',
        '2022-06-23 08:50:16', '2022-06-23 08:50:16', 'ef31c95f-1b96-446e-9a8a-387dc92c1094',
        'eed74c5c-ab5f-4bca-834f-b9abb29fcd22'),
       ('faa1ea88-cf5b-46d4-9ffa-c12524f521ce', 'DU', 'DELETE', 'deleteUser', 'Delete user', '2022-06-23 08:50:16',
        '2022-06-23 08:50:16', 'f10763f0-ee18-4352-b855-63a3ca330d70', 'ddb5539b-be12-4d0c-a7ed-1a5f670b887a');

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
    `accessToken`  varchar(255)                                       NOT NULL,
    `refreshToken` varchar(255)                                       NOT NULL,
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
        '2022-06-23 08:50:17', '2022-06-23 08:50:17', '3fb72eec-3307-4a72-9f28-36b2de52a86e'),
       ('7b731286-138a-4240-a4f9-0438a6ddaf59', 'Bastien', 'Reynaud', 'bastien.reynaud@admin.com', '123 soleil',
        '+33606060606', '$2b$10$fWG8PgzX4xBYnTsLKxQv5ejSOgdIkqlrQ1anPMclznQuGpUufEfOC', 'noToken', 'noToken',
        '2022-06-23 08:50:17', '2022-06-23 08:50:17', '3fb72eec-3307-4a72-9f28-36b2de52a86e'),
       ('a998b86a-1436-4987-9560-ed5c15589bdf', 'Hugo', 'Nahmias', 'hugo.nahmias@admin.com', '123 soleil',
        '+33606060606', '$2b$10$fyIh9FQYrNVj9dGDE8KbtO9tQQ7dYf6LJKFGhUL24KiHi/F.nH6ke', 'noToken', 'noToken',
        '2022-06-23 08:50:17', '2022-06-23 08:50:17', '3fb72eec-3307-4a72-9f28-36b2de52a86e');

--
-- Table structure for table `TransactionTokens`
--

CREATE TABLE `TransactionTokens` (
                                     `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
                                     `token` varchar(255) NOT NULL,
                                     `createdAt` datetime NOT NULL,
                                     `updatedAt` datetime NOT NULL,
                                     `userId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
                                     `transactionId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


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
