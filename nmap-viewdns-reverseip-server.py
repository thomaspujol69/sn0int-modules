from flask import Flask, request
import os,re

app = Flask(__name__)

@app.get("/getDNS")
async def getDNS():
    ip = request.args.get('ip')
    stream = os.popen(f"nmap -R --noninteractive -sn -oG - {ip}")
    output = stream.read()
    domain = re.search(f'Host: {ip} \((.*)\)\tStatus', output)
    print(domain)
    if domain==None or domain.group(1)=="":
        raise Exception()
    return domain.group(1)

