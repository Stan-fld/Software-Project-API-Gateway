import sequelize from "./setup/db-mysql-setup";
import {DataTypes, Model} from "sequelize";
import Role from "./role.model";

const config = {
    tableName: 'Transaction',
    timestamps: true,
    sequelize: sequelize,
};

class Transaction extends Model {
    id!: string;
    code!: string;
    reqCat!: string;
    desc!: string;
    role!: string;
}

Transaction.init({
    // Model attributes are defined here
    id: {
        type: DataTypes.UUID,
        defaultValue: DataTypes.UUIDV4,
        allowNull: false,
        primaryKey: true
    },
    code: {
        type: DataTypes.STRING,
        allowNull: false
    },
    reqCat: {
        type: DataTypes.ENUM('GET', 'PUT', 'PATCH', 'POST', 'DELETE', 'OPTION'),
        allowNull: false,
    },
    desc: {
        type: DataTypes.STRING,
        allowNull: false
    },
    role: {
        type: DataTypes.UUID,
        defaultValue: DataTypes.UUIDV4,
        allowNull: false,
        references: {model: Role, key: 'id'}
    }
}, config);

export default Transaction;
