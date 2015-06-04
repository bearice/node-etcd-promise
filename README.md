# node-etcd-promise

A promise wrapper of [node-etcd](https://github.com/stianeikeland/node-etcd).

## example
```coffee
etcd = new EtcdPromise(etcdServers, etcdOpts)
etcd.mkdir(path, {ttl: 60, prevExist: false}).then =>
  Promise.all [
    etcd.set("#{path}/raw",   JSON.stringify(@info)),
    etcd.set("#{path}/host",  HOST_NAME),
    etcd.set("#{path}/ports", JSON.stringify(@_ports)),
  ]
.catch =>
  etcd.mkdir(path, {ttl: 60, prevExist: true})

```
