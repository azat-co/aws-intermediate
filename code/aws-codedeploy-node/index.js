require('http').createServer((req, res) => {res.end('hello world')}).listen(3000, (error)=>{console.log('server is running on 3000')})
