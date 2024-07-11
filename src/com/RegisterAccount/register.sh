#!/bin/bash
clear
createAccount() {
	createUsername() {
		clear
		getName=$(sed -n "1p" data/config_server/server_config.properties | cut -d "=" -f2)
		echo "
Tạo tài khoản nhắn tin server $getName
"
		read -p "Tài khoản: " username
		if [ -e "src/save_player/$username/information.properties" ]
		then
			echo "
Tài khoản đã tồn tại!
"
			echo "Enter để tiếp tục !!!"
			read -p ""
			createUsername
		else
			read -p "Mật khẩu: " password
			if [ "${#password}" -ge 8 ]
			then
				read -p "Họ và tên của bạn: " name
				read -p "Ngày sinh của bạn: " day
				read -p "Tháng sinh của bạn: " month
				read -p "Năm sinh của bạn: " year
				now=$(date +%Y)
				result=$((now - year))
				if [ "$result" -lt 10 ]
				then
					echo "
Xin lỗi nhưng server $getName giới hạn về độ tuổi!
"
					exit
				else
					read -p "Số điện thoại (không bắt buộc): " telephone
					clear
					echo "
Vui lòng soát lại thông tin tài khoản của bạn trước khi tạo:

Tài khoản: $username

Mật khẩu: $password

Họ và tên: $name

Ngày sinh: $day/$month/$year

Số điện thoại: $telephone

Máy chủ: $getName"
					createPropertiesReader() {
						mkdir src/save_player/$username
						echo "
username=$username
password=$password
fullname=$name
day=$day/$month/$year
telephone=$telephone
server=$getName
" > src/save_player/$username/information.properties
						echo "
Tạo tài khoản thành công!
Enter để chuyển hướng tới login!"
						read -p ""
						bash src/com/RegisterAccount/login.sh 
					}
				fi
			clear
			echo "
Bạn có chắc chắn muốn đăng ký tài khoản không?
"
			read -p "Y/N " yn
			case $yn in
			y)
				createPropertiesReader
			;;
			Y)
				createPropertiesReader
			;;
			n)
				exit
			;;
			N)
				exit
			;;
			*)
				createPropertiesReader
			esac
			else
				echo "
Mật khẩu của tài khoản không được dưới 8 ký tự!!"
				echo "Enter  để tiếp tục !!"
				read -p ""
				createUsername
			fi
		fi
	}
	createUsername
}
createAccount
