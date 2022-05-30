module.exports = {
    apps: [{
        name: 'Nodejs TypeScript API',
        script: 'build/server.js',
        exec_mode: 'cluster',
        instances: 2,
        autorestart: true,
        watch: true,
        env_production: {
            NODE_ENV: 'production'
        }
    }],
};
