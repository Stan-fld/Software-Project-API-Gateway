import {Sequelize} from 'sequelize';


const sequelize = new Sequelize(process.env.MYSQL_DB_NAME, process.env.MYSQL_DB_USER, process.env.MYSQL_DB_PASS, {
    host: process.env.MYSQL_URI,
    dialect: 'mysql'
});

export default sequelize;
