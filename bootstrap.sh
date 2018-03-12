#!/usr/bin/env bash

function install {
    echo "Інсталюємо" $1
    sudo apt-get install -y "$2" > /dev/null 2>&1
}

echo 'Vagrant успішно залогінився до віртуальної системи.'
echo 'Починаємо встановлення оточення Ruby on Rails'
echo 'Оновлюємо інформацію про apt пакети в репозиторіях'
sudo apt-get update > /dev/null 2>&1

install Git git-core
install "інструменти для збірки пакетів" build-essential
install "заголовочні файли для зв'язку з PostgreSQL" libpq-dev
install PostgreSQL postgresql
install "додаткові файли для PostgreSQL" postgresql-contrib
install "заголовочні файли для Ruby" ruby-dev

sudo apt-add-repository -y ppa:rael-gc/rvm > /dev/null 2>&1
sudo apt-get update > /dev/null 2>&1
install "RVM: Ruby Version Manager" rvm
source /etc/profile.d/rvm.sh

install "пакетний менеджер NPM для JavaScript" npm

curl -sL https://deb.nodesource.com/setup_9.x | sudo -E bash - > /dev/null 2>&1
install nodeJS nodejs

rvm group add rvm $USER > /dev/null 2>&1
sudo chmod -R 777 /usr/share/rvm > /dev/null 2>&1
sudo chmod -R 777 /usr/lib/node_modules > /dev/null 2>&1

echo "Інсталюємо Ruby 2.5.0. Його компіляція може зайняти деякий час..."
rvm install 2.5.0
ruby -v

echo "Інсталюємо Ruby on Rails"
gem install rails --no-ri --no-rdoc
rails -v

echo "Інсталюємо менеджер залежностей Yarn"
sudo apt remove cmdtest -y #> /dev/null 2>&1
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add - > /dev/null 2>&1
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list > /dev/null 2>&1
sudo apt-get update && sudo apt-get install -y --no-install-recommends yarn > /dev/null 2>&1

sudo apt autoremove -y > /dev/null 2>&1
