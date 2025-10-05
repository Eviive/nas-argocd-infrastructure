const { dirname, resolve } = require("path");
const { issueCookie } = require(resolve(dirname(require.resolve("n8n")), "auth/jwt"));
const Layer = require("router/lib/layer");

const ignoreAuthRegexp = /^\/(assets|healthz|webhook|rest\/oauth2-credential)/;

const middleware = async (config, req, res, next) => {
    console.log(req.headers);

    if (ignoreAuthRegexp.test(req.url)) {
        return next();
    }

    if (!config.get("userManagement.isInstanceOwnerSetUp", false)) {
        return next();
    }

    if (req.cookies?.["n8n-auth"]) {
        return next();
    }

    const forwardAuthHeader = process.env.N8N_FORWARD_AUTH_HEADER;
    if (!forwardAuthHeader) {
        return next();
    }

    const email = req.headers[forwardAuthHeader.toLowerCase()];
    if (!email) {
        return next();
    }

    const user = await this.dbCollections.User.findOneBy({ email });
    if (!user) {
        res.statusCode = 401;
        res.end(`User ${email} not found, please have an admin invite the user first.`);
        return;
    }

    if (!user.role) {
        user.role = {};
    }

    issueCookie(res, user);
    return next();
};

module.exports = {
    n8n: {
        ready: [
            async function ({ app }, config) {
                const { stack } = app.router;
                const index = stack.findIndex(l => l.name === "cookieParser");
                
                const layer = new Layer(
                    "/",
                    {
                        strict: false,
                        end: false
                    },
                    (...args) => middleware.call(this, config, ...args)
                );
                
                stack.splice(index + 1, 0, layer);
            }
        ]
    }
};
