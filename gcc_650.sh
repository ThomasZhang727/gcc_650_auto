usr=$1
path=$2
if [ $# -ne 2 ] 
then
    echo "缺少参数 or 过多参数.请正确输入参数,第一个为用户名,第二个为自定目录"
    exit 1
fi

echo "gcc6.5.0编译安,整个过程预计需要2-2.5h,请保持电脑有充足电量,否则请挂后台执行."

cd ~
mkdir $path  # 你自定义的安装路径
cd $path
wget https://ftp.gnu.org/gnu/gcc/gcc-6.5.0/gcc-6.5.0.tar.gz
tar -xzf gcc-6.5.0.tar.gz 
cd gcc-6.5.0/contrib/
cat download_prerequisites  # 输出GCC所需的依赖及其获取方法

cd ~/$path/

# mpfr
wget ftp://gcc.gnu.org/pub/gcc/infrastructure/mpfr-2.4.2.tar.bz2
tar -xjf mpfr-2.4.2.tar.bz2

# gmp
wget ftp://gcc.gnu.org/pub/gcc/infrastructure/gmp-4.3.2.tar.bz2
tar -xjf gmp-4.3.2.tar.bz2

# mpc
wget ftp://gcc.gnu.org/pub/gcc/infrastructure/mpc-0.8.1.tar.gz
tar -xzvf mpc-0.8.1.tar.gz

# isl
wget ftp://gcc.gnu.org/pub/gcc/infrastructure/isl-0.15.tar.bz2
tar -xjf isl-0.15.tar.bz2

cd ~/$path

# gmp-4.3.2
cd gmp-4.3.2/
./configure --prefix=/home1/${usr}/${path}/gmp-4.3.2
make && make install

# mpfr-2.4.2
cd ../mpfr-2.4.2/
./configure --prefix=/home1/${usr}/${path}/mpfr-2.4.2 --with-gmp=/home1/${usr}/${path}/gmp-4.3.2
make && make install

# mpc
cd ../mpc-0.8.1
./configure --prefix=/home1/${usr}/${path}/mpc-0.8.1 --with-gmp=/home1/${usr}/${path}/gmp-4.3.2 --with-mpfr=/home1/${usr}/${path}/mpfr-2.4.2
make && make install

# isl
cd ..
mkdir isl
cd isl-0.15
./configure --prefix=/home1/${usr}/${path}/isl --with-gmp-prefix=/home1/${usr}/${path}/gmp-4.3.2
make && make install

add_context_1="export LD_LIBRARY_PATH=\$LD_LIBRARY_PATH:/home1/${usr}/${path}/gmp-4.3.2/lib/"
add_context_2="export LD_LIBRARY_PATH=\$LD_LIBRARY_PATH:/home1/${usr}/${path}/mpfr-2.4.2/lib/"
add_context_3="export LD_LIBRARY_PATH=\$LD_LIBRARY_PATH:/home1/${usr}/${path}/mpc-0.8.1/lib/"
add_context_4="export LD_LIBRARY_PATH=\$LD_LIBRARY_PATH:/home1/${usr}/${path}/isl/lib/"

echo $add_context_1 >> ~/.bashrc
echo $add_context_2 >> ~/.bashrc
echo $add_context_3 >> ~/.bashrc
echo $add_context_4 >> ~/.bashrc

source ~/.bashrc

cd /home1/$usr/$path
cd gcc-6.5.0
mkdir build && cd build
../configure  --prefix=/home1/${usr}/${path}/gcc-6.5.0 --with-gmp=/home1/${usr}/${path}/gmp-4.3.2 --with-mpfr=/home1/${usr}/${path}/mpfr-2.4.2 --with-mpc=/home1/${usr}/${path}/mpc-0.8.1 --with-isl=/home1/${usr}/${path}/isl --enable-checking=release --enable-languages=c,c++ --disable-multilib
make && make install  # 此过程非常长，请保证电脑电量并耐心等待！

cd ~
add_context_inf="export PATH=/home1/${usr}/${path}/gcc-6.5.0/bin:\$PATH"
echo $add_context_inf >> ~/.bashrc

source .bashrc

gcc --version

echo "感谢姜峰、邱守猛、李志程、叶子逸和小弟张思源同学!"



