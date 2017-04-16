require('http').createServer((req, res) => {console.log('url:', req.url);res.end('hello world');}).listen(3000, (error)=>{console.log('server is running on 3000')})
