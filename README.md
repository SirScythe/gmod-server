## Running the Container
Running simple sandbox game server:

    docker run -d --name gmod -t \
    		-p 27015:27015/udp \
    		-p 27005:27005 \
    		sirscythe/gmod-server

Example running Trouble in Terrorist Town gamemode:

    docker run -d --name gmod -t \
    		-p 27015:27015/udp \
    		-p 27005:27005 \
    		-e MAP=ttt_minecraft_b5 \
    		-e EXTRAARGS="+gamemode terrortown +host_workshop_collection 209590337 -authkey YOURAUTHKEYHERE" \
    		sirscythe/gmod-server

## Variables

`MAP` : gmod Map Name  
Default: `gm_construct`

`EXTRAARGS` : additional server start arguments  
Default: none