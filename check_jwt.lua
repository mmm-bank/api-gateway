local jwt = require "resty.jwt"
local jwt_token = ngx.var.http_Authorization
local jwt_secret = "uCgKmX5P5EPfGpaE"


if not jwt_token or jwt_token == "" then
    ngx.status = ngx.HTTP_UNAUTHORIZED
    ngx.say("Missing token")
    return ngx.exit(ngx.HTTP_UNAUTHORIZED)
end

if not jwt_token:find("^Bearer ") then
    ngx.status = ngx.HTTP_UNAUTHORIZED
    ngx.say("Invalid token format")
    return ngx.exit(ngx.HTTP_UNAUTHORIZED)
end

jwt_token = jwt_token:gsub("Bearer%s+", "")

local jwt_obj, err = jwt:verify(jwt_secret, jwt_token)
if err then
    ngx.status = ngx.HTTP_UNAUTHORIZED
    ngx.log(ngx.ERR, "JWT verification error: ", err)
    return ngx.exit(ngx.HTTP_UNAUTHORIZED)
end

if not jwt_obj["verified"] then
    ngx.status = ngx.HTTP_UNAUTHORIZED
    ngx.say("Invalid token")
    return ngx.exit(ngx.HTTP_UNAUTHORIZED)
end
