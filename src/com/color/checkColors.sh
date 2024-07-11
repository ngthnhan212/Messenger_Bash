#!/bin/bash
function checkColors() {
	for i in {0..255}
	do
		tput setaf $i
		echo "This color | ID $i"
	done
}
