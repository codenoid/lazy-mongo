# LazyMongo

Mongo Insert raw data

## Installation

MongoC Driver

```
wget https://github.com/mongodb/mongo-c-driver/releases/download/1.1.0/mongo-c-driver-1.1.0.tar.gz
tar -zxvf mongo-c-driver-1.1.0.tar.gz && cd mongo-c-driver-1.1.0/
./configure --prefix=/usr --libdir=/usr/lib64
make
sudo make install
```

Qt & Install

```
sudo apt-get install libsdl2-dev
sudo apt-get install libsdl2-mixer-*
sudo apt-get install libsdl2-image-*
sudo apt-get install qt5-default
git clone https://github.com/Muonyet/lazy-mongo
cd lazy-mongo
shards install
shards build
./bin/lazy-mongo
```

## Usage

1. Insert or Load text file
2. select / highlight 1 separator
3. Execute !

## Development

- [ ] More Validation
- [ ] Friendly Alert
- [ ] Code Structure
- [ ] Test
 
## Contributing

1. Fork it (<https://github.com/Muonyet/lazy-mongo/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [codenoid](https://github.com/codenoid) codenoid - creator, maintainer
