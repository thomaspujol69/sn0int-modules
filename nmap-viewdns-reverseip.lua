-- Description: Search for a domain pointing to specified ip thanks to nmap
-- Version: 0.1.0
-- Source: ipaddrs
-- License: GPL-3.0

function run(arg)
    local handle = io.popen("nmap -R --noninteractive -sn -oG - " .. arg['value'])
    local result = handle:read("*a")
    handle:close()
    local domain = string.match(result, arg['value'] .. " \((%a+)\) \tStatus")
    if domain~="" then
        db_add('domain', {
            value=domain,
        })
    end
end
