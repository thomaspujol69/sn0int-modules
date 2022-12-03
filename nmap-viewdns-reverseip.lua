-- Description: Search for a domain pointing to specified ip thanks to nmap
-- Version: 0.1.0
-- Source: ipaddrs
-- License: GPL-3.0

function run(arg)
    local session = http_mksession()
    local req = http_request(session, 'GET', 'http://127.0.0.1:5000/getDNS', {
        query={
            ip=arg['value'],
        }
    })
    local r = http_send(req)
    if last_err() then return end
    if r['status'] ~= 200 then
        return 'http error: ' .. r['status']
    end
    db_add('domain', {
        value=r['text'],
    })
end
