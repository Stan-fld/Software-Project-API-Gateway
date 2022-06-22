-- phpMyAdmin SQL Dump
-- version 5.1.4
-- https://www.phpmyadmin.net/
--
-- Host: mysql-projetcesi.alwaysdata.net
-- Generation Time: Jun 22, 2022 at 05:15 PM
-- Server version: 10.6.7-MariaDB
-- PHP Version: 7.4.19

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `projetcesi_authentication_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `Roles`
--

CREATE TABLE `Roles` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `name` varchar(255) NOT NULL,
  `desc` varchar(255) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `Roles`
--

INSERT INTO `Roles` (`id`, `name`, `desc`, `createdAt`, `updatedAt`) VALUES
('14ffee91-edd3-485e-9ca8-4cf82b6f1dfb', 'techServ', 'Technical services', '2022-06-22 15:13:22', '2022-06-22 15:13:22'),
('193d279d-f699-46f6-af26-2d1421d2ae86', 'extDev', 'External developer', '2022-06-22 15:13:22', '2022-06-22 15:13:22'),
('76704e4c-49f7-4bbb-90f2-b9e4772a87e0', 'deliverer', 'Deliverer', '2022-06-22 15:13:22', '2022-06-22 15:13:22'),
('879fc7e8-863f-4a46-aa6a-9bb2dacc15d0', 'client', 'Client', '2022-06-22 15:13:22', '2022-06-22 15:13:22'),
('934e1057-c214-4556-bfab-7d3762ed2836', 'commServ', 'Commercial services', '2022-06-22 15:13:22', '2022-06-22 15:13:22'),
('a93d4bac-fde0-4bd4-b25c-02793783e93b', 'apiUser', 'API user', '2022-06-22 15:13:22', '2022-06-22 15:13:22'),
('bfb0c9ce-990b-47c7-8bfc-a5deea941acf', 'restau', 'Restaurant', '2022-06-22 15:13:22', '2022-06-22 15:13:22');

-- --------------------------------------------------------

--
-- Table structure for table `Services`
--

CREATE TABLE `Services` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `domain` varchar(255) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `Services`
--

INSERT INTO `Services` (`id`, `domain`, `createdAt`, `updatedAt`) VALUES
('3045f50b-808e-4eee-97f6-61a40c808e57', 'orders', '2022-06-22 15:13:23', '2022-06-22 15:13:23'),
('49affece-f2d0-4972-a215-026020f5d546', 'users', '2022-06-22 15:13:23', '2022-06-22 15:13:23'),
('98cdf2c9-e65a-497e-b49a-6731ca53072e', 'deliverers', '2022-06-22 15:13:23', '2022-06-22 15:13:23'),
('d0fb76c9-242a-4609-bbd1-683d65eac65b', 'restaurants', '2022-06-22 15:13:23', '2022-06-22 15:13:23');

-- --------------------------------------------------------

--
-- Table structure for table `Transactions`
--

CREATE TABLE `Transactions` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `code` varchar(255) NOT NULL,
  `method` enum('GET','PUT','PATCH','POST','DELETE') NOT NULL,
  `name` varchar(255) NOT NULL,
  `desc` varchar(255) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `roleId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `serviceId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `Transactions`
--

INSERT INTO `Transactions` (`id`, `code`, `method`, `name`, `desc`, `createdAt`, `updatedAt`, `roleId`, `serviceId`) VALUES
('0876428f-d303-4a69-bd3a-be9fe714ace1', 'GRS', 'GET', 'getRestaurants', 'Get restaurants for client', '2022-06-22 15:13:23', '2022-06-22 15:13:23', '879fc7e8-863f-4a46-aa6a-9bb2dacc15d0', 'd0fb76c9-242a-4609-bbd1-683d65eac65b'),
('0f6e4c8c-33ea-430d-b794-f997b2d03daf', 'UU', 'PATCH', 'updateUser', 'Update user', '2022-06-22 15:13:23', '2022-06-22 15:13:23', '193d279d-f699-46f6-af26-2d1421d2ae86', '49affece-f2d0-4972-a215-026020f5d546'),
('0fcb347a-5878-4650-a5ee-8759950317e7', 'GIS', 'GET', 'getItems', 'Get restaurant items for client', '2022-06-22 15:13:23', '2022-06-22 15:13:23', '879fc7e8-863f-4a46-aa6a-9bb2dacc15d0', 'd0fb76c9-242a-4609-bbd1-683d65eac65b'),
('248b3ba3-fecd-4909-8a07-03fa561c3933', 'DU', 'DELETE', 'deleteUser', 'Delete user', '2022-06-22 15:13:23', '2022-06-22 15:13:23', '14ffee91-edd3-485e-9ca8-4cf82b6f1dfb', '49affece-f2d0-4972-a215-026020f5d546'),
('2d2ec9ed-e53b-40f5-b03a-0fa8b632ae95', 'DU', 'DELETE', 'deleteUser', 'Delete user', '2022-06-22 15:13:23', '2022-06-22 15:13:23', '879fc7e8-863f-4a46-aa6a-9bb2dacc15d0', '49affece-f2d0-4972-a215-026020f5d546'),
('2edc4f13-f96e-49ea-ad7c-a36aa33de9ed', 'UI', 'PATCH', 'updateItem', 'Update item', '2022-06-22 15:13:23', '2022-06-22 15:13:23', 'bfb0c9ce-990b-47c7-8bfc-a5deea941acf', 'd0fb76c9-242a-4609-bbd1-683d65eac65b'),
('34ff5946-d37b-4f67-975e-4e2869c1736a', 'GIS', 'GET', 'getMyItems', 'Get items for restaurant', '2022-06-22 15:13:23', '2022-06-22 15:13:23', 'bfb0c9ce-990b-47c7-8bfc-a5deea941acf', 'd0fb76c9-242a-4609-bbd1-683d65eac65b'),
('36a6f8a4-9158-4865-a945-4222dd49e62d', 'DU', 'DELETE', 'deleteUser', 'Delete user', '2022-06-22 15:13:23', '2022-06-22 15:13:23', '193d279d-f699-46f6-af26-2d1421d2ae86', '49affece-f2d0-4972-a215-026020f5d546'),
('3baa4268-11a4-4ebd-8bc4-2b427fb8a45d', 'GRS', 'GET', 'getRestaurants', 'Get restaurants for technical service', '2022-06-22 15:13:23', '2022-06-22 15:13:23', '14ffee91-edd3-485e-9ca8-4cf82b6f1dfb', 'd0fb76c9-242a-4609-bbd1-683d65eac65b'),
('433bceab-a58d-4791-91fb-9d100d54978e', 'DU', 'DELETE', 'deleteUser', 'Delete user', '2022-06-22 15:13:23', '2022-06-22 15:13:23', '76704e4c-49f7-4bbb-90f2-b9e4772a87e0', '49affece-f2d0-4972-a215-026020f5d546'),
('44771b61-690b-40a1-aed9-a617c94a3e73', 'AO', 'PATCH', 'acceptOrder', 'Accept order for deliverer', '2022-06-22 15:13:23', '2022-06-22 15:13:23', '76704e4c-49f7-4bbb-90f2-b9e4772a87e0', '3045f50b-808e-4eee-97f6-61a40c808e57'),
('45a1dc56-7799-4ad9-a5dc-e0f84ef0262a', 'GO', 'GET', 'getOrder', 'Get order for deliverer', '2022-06-22 15:13:23', '2022-06-22 15:13:23', '76704e4c-49f7-4bbb-90f2-b9e4772a87e0', '3045f50b-808e-4eee-97f6-61a40c808e57'),
('4ea13d3e-f54e-44fa-b26c-7c0d2da8b656', 'UU', 'PATCH', 'updateUser', 'Update user', '2022-06-22 15:13:23', '2022-06-22 15:13:23', '14ffee91-edd3-485e-9ca8-4cf82b6f1dfb', '49affece-f2d0-4972-a215-026020f5d546'),
('555823c3-3809-4b41-9a43-54c282b816e0', 'DR', 'DELETE', 'deleteRestaurant', 'Delete restaurant', '2022-06-22 15:13:23', '2022-06-22 15:13:23', 'bfb0c9ce-990b-47c7-8bfc-a5deea941acf', 'd0fb76c9-242a-4609-bbd1-683d65eac65b'),
('583ee4ef-2a7e-4801-92e1-b2a6463c257f', 'CI', 'POST', 'createItem', 'Create item', '2022-06-22 15:13:23', '2022-06-22 15:13:23', 'bfb0c9ce-990b-47c7-8bfc-a5deea941acf', 'd0fb76c9-242a-4609-bbd1-683d65eac65b'),
('589a0f89-4c56-44dd-b035-49fbc9458e38', 'GR', 'GET', 'getRestaurant', 'Get a restaurant for technical service', '2022-06-22 15:13:23', '2022-06-22 15:13:23', '14ffee91-edd3-485e-9ca8-4cf82b6f1dfb', 'd0fb76c9-242a-4609-bbd1-683d65eac65b'),
('590a1e5f-02f1-4485-be44-8bec368641c2', 'UU', 'PATCH', 'updateUser', 'Update user', '2022-06-22 15:13:23', '2022-06-22 15:13:23', '879fc7e8-863f-4a46-aa6a-9bb2dacc15d0', '49affece-f2d0-4972-a215-026020f5d546'),
('5b5d1583-5b65-45ae-b867-55a9fbfe07ff', 'DI', 'DELETE', 'deleteItem', 'Delete item', '2022-06-22 15:13:23', '2022-06-22 15:13:23', 'bfb0c9ce-990b-47c7-8bfc-a5deea941acf', 'd0fb76c9-242a-4609-bbd1-683d65eac65b'),
('6423577c-2de0-4033-b5a6-7d219a088b65', 'CR', 'POST', 'createRestaurant', 'Create restaurant', '2022-06-22 15:13:23', '2022-06-22 15:13:23', '879fc7e8-863f-4a46-aa6a-9bb2dacc15d0', 'd0fb76c9-242a-4609-bbd1-683d65eac65b'),
('66f943b0-6e5d-40b5-b9b8-b889bce976b9', 'DD', 'DELETE', 'deleteDeliverer', 'Delete deliverer', '2022-06-22 15:13:23', '2022-06-22 15:13:23', '76704e4c-49f7-4bbb-90f2-b9e4772a87e0', '98cdf2c9-e65a-497e-b49a-6731ca53072e'),
('6defb852-21d6-4da0-84d6-7e6ec327f487', 'UU', 'PATCH', 'updateUser', 'Update user', '2022-06-22 15:13:23', '2022-06-22 15:13:23', 'a93d4bac-fde0-4bd4-b25c-02793783e93b', '49affece-f2d0-4972-a215-026020f5d546'),
('7f9745ce-3d76-48e8-a423-3d20f506625c', 'GO', 'GET', 'getOrder', 'Get order for restaurant', '2022-06-22 15:13:23', '2022-06-22 15:13:23', 'bfb0c9ce-990b-47c7-8bfc-a5deea941acf', NULL),
('80c35eda-d986-407b-9942-7cf597c3e4a8', 'GUS', 'GET', 'getUsers', 'Get users', '2022-06-22 15:13:23', '2022-06-22 15:13:23', '14ffee91-edd3-485e-9ca8-4cf82b6f1dfb', '49affece-f2d0-4972-a215-026020f5d546'),
('830f0b31-ff28-4fbe-8506-9fc45e659975', 'UR', 'PATCH', 'updateRestaurant', 'Update restaurant', '2022-06-22 15:13:23', '2022-06-22 15:13:23', 'bfb0c9ce-990b-47c7-8bfc-a5deea941acf', 'd0fb76c9-242a-4609-bbd1-683d65eac65b'),
('87525c8e-d9a7-4353-817f-437f46b74e13', 'CD', 'POST', 'createDeliverer', 'Create deliverer', '2022-06-22 15:13:23', '2022-06-22 15:13:23', '879fc7e8-863f-4a46-aa6a-9bb2dacc15d0', '98cdf2c9-e65a-497e-b49a-6731ca53072e'),
('878662fb-2087-4109-8687-38f95f08914a', 'DU', 'DELETE', 'deleteUser', 'Delete user', '2022-06-22 15:13:23', '2022-06-22 15:13:23', 'bfb0c9ce-990b-47c7-8bfc-a5deea941acf', '49affece-f2d0-4972-a215-026020f5d546'),
('8a5a57ce-dcf0-494e-b198-f5c4e163671e', 'GR', 'GET', 'getRestaurant', 'Get a restaurant for deliverer', '2022-06-22 15:13:23', '2022-06-22 15:13:23', '76704e4c-49f7-4bbb-90f2-b9e4772a87e0', 'd0fb76c9-242a-4609-bbd1-683d65eac65b'),
('9fc9bfa6-62dd-40f2-a0d4-f1b631f2278d', 'DU', 'DELETE', 'deleteUser', 'Delete user', '2022-06-22 15:13:23', '2022-06-22 15:13:23', 'a93d4bac-fde0-4bd4-b25c-02793783e93b', '49affece-f2d0-4972-a215-026020f5d546'),
('a8cc264f-7807-4667-8eaa-2e2b48691510', 'UD', 'PATCH', 'updateDeliverer', 'Update deliverer', '2022-06-22 15:13:23', '2022-06-22 15:13:23', '76704e4c-49f7-4bbb-90f2-b9e4772a87e0', '98cdf2c9-e65a-497e-b49a-6731ca53072e'),
('b092d497-0b78-4a97-ba6f-96e3ebdc5b84', 'GO', 'GET', 'getOrder', 'Get order for client', '2022-06-22 15:13:23', '2022-06-22 15:13:23', '879fc7e8-863f-4a46-aa6a-9bb2dacc15d0', '3045f50b-808e-4eee-97f6-61a40c808e57'),
('b4676155-9067-47f4-b956-a3a58c983d91', 'GR', 'GET', 'getRestaurant', 'Get a restaurant for client', '2022-06-22 15:13:23', '2022-06-22 15:13:23', '879fc7e8-863f-4a46-aa6a-9bb2dacc15d0', 'd0fb76c9-242a-4609-bbd1-683d65eac65b'),
('b514ed4f-1fda-42f0-b321-57e48203248a', 'GI', 'GET', 'getItem', 'Get item for restaurant', '2022-06-22 15:13:23', '2022-06-22 15:13:23', 'bfb0c9ce-990b-47c7-8bfc-a5deea941acf', 'd0fb76c9-242a-4609-bbd1-683d65eac65b'),
('baee2b4e-76ab-438c-964d-9213c27d8f70', 'GRS', 'GET', 'getRestaurants', 'Get restaurants for deliverer', '2022-06-22 15:13:23', '2022-06-22 15:13:23', '76704e4c-49f7-4bbb-90f2-b9e4772a87e0', 'd0fb76c9-242a-4609-bbd1-683d65eac65b'),
('bb64af0e-6a63-4f36-ad81-a6af7a74b8ae', 'CO', 'POST', 'createOrder', 'Create order for client', '2022-06-22 15:13:23', '2022-06-22 15:13:23', '879fc7e8-863f-4a46-aa6a-9bb2dacc15d0', '3045f50b-808e-4eee-97f6-61a40c808e57'),
('c546992e-1910-4591-a737-d57913dbf694', 'UU', 'PATCH', 'updateUser', 'Update user', '2022-06-22 15:13:23', '2022-06-22 15:13:23', '934e1057-c214-4556-bfab-7d3762ed2836', '49affece-f2d0-4972-a215-026020f5d546'),
('ca55b7de-adc7-469f-81f9-d379d4a95e91', 'UO', 'PATCH', 'updateOrder', 'Update order for client', '2022-06-22 15:13:23', '2022-06-22 15:13:23', '879fc7e8-863f-4a46-aa6a-9bb2dacc15d0', '3045f50b-808e-4eee-97f6-61a40c808e57'),
('cee67bb9-7e7b-457c-92a4-ba4e6090f6db', 'GIS', 'GET', 'getItems', 'Get restaurant items for commercial service', '2022-06-22 15:13:23', '2022-06-22 15:13:23', NULL, NULL),
('cf1de369-8b7c-4a7d-bc87-6f7bc7b4a67d', 'AO', 'PATCH', 'acceptOrder', 'Accept order for restaurant', '2022-06-22 15:13:23', '2022-06-22 15:13:23', 'bfb0c9ce-990b-47c7-8bfc-a5deea941acf', '3045f50b-808e-4eee-97f6-61a40c808e57'),
('e2735276-00e1-4d68-8d52-353b8e879651', 'UU', 'PATCH', 'updateUser', 'Update user', '2022-06-22 15:13:23', '2022-06-22 15:13:23', 'bfb0c9ce-990b-47c7-8bfc-a5deea941acf', '49affece-f2d0-4972-a215-026020f5d546'),
('f3a6dbaf-2a56-4e86-8c85-3334a24d93e0', 'UU', 'PATCH', 'updateUser', 'Update user', '2022-06-22 15:13:23', '2022-06-22 15:13:23', '76704e4c-49f7-4bbb-90f2-b9e4772a87e0', '49affece-f2d0-4972-a215-026020f5d546'),
('fef92724-7b13-4fdc-a45c-0f513271ac05', 'DU', 'DELETE', 'deleteUser', 'Delete user', '2022-06-22 15:13:23', '2022-06-22 15:13:23', '934e1057-c214-4556-bfab-7d3762ed2836', '49affece-f2d0-4972-a215-026020f5d546'),
('ff4a5bfa-cf0c-400f-ae50-ddb248302dae', 'DO', 'DELETE', 'deleteOrder', 'Delete order for client', '2022-06-22 15:13:23', '2022-06-22 15:13:23', '879fc7e8-863f-4a46-aa6a-9bb2dacc15d0', '3045f50b-808e-4eee-97f6-61a40c808e57');

-- --------------------------------------------------------

--
-- Table structure for table `Users`
--

CREATE TABLE `Users` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `firstName` varchar(255) NOT NULL,
  `lastName` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `phone` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `accessToken` varchar(255) NOT NULL,
  `refreshToken` varchar(255) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `roleId` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `Users`
--

INSERT INTO `Users` (`id`, `firstName`, `lastName`, `email`, `address`, `phone`, `password`, `accessToken`, `refreshToken`, `createdAt`, `updatedAt`, `roleId`) VALUES
('0b5cea8a-09d4-43bf-ad0d-fe9b93b764d9', 'Bastien', 'Reynaud', 'bastien.reynaud@admin.com', '123 soleil', '+33606060606', '$2b$10$K0gC50byBdxesM0jh7Uzqu09DD9yygX7Q7oNi3ZjqKcnKPt8oc4S2', 'noToken', 'noToken', '2022-06-22 15:13:23', '2022-06-22 15:13:23', '14ffee91-edd3-485e-9ca8-4cf82b6f1dfb'),
('7bd9a16a-ee55-44c4-b998-5cbcb55ec4c0', 'Hugo', 'Nahmias', 'hugo.nahmias@admin.com', '123 soleil', '+33606060606', '$2b$10$jQCQ/Mkbr1aQppRp7tEBCeCzS9lEku1ZiKhE2FgoKeFeDVN6KBEQ6', 'noToken', 'noToken', '2022-06-22 15:13:23', '2022-06-22 15:13:23', '14ffee91-edd3-485e-9ca8-4cf82b6f1dfb'),
('7e434587-928b-4712-8640-7ee1c9b973bc', 'Stanislas', 'Foillard', 'stanislas.foillard@admin.com', '123 soleil', '+33606060606', '$2b$10$wjqOG/9Rg9c49.8bMWOdeeq/Dh36Tu2pA7W0hHs2pYCJckEYoz2A.', 'noToken', 'noToken', '2022-06-22 15:13:23', '2022-06-22 15:13:23', '14ffee91-edd3-485e-9ca8-4cf82b6f1dfb');

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

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
