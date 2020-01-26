#!/usr/bin/env bash
cd "$(dirname "$0")"

# Bash script for gitlab-runner commands

########################
#   CONFIG VARIABLES   #
########################

# Help menu variables
function help_vars() {
	title_col="\e[36m"
	header_col="\e[33m"
	option_col="\e[32m"
	reset_col="\e[m"
	tab_len=4
	script="$(basename "$0")"
	title_name="$title_col$script$1:$reset_col"
}

function completion_vars() {
	completion_enable=false
	completion_path="$HOME/.bash_completion.d"
}

#################
#   HELP INIT   #
#################

function help_init() {
	help_vars

	completion_vars
	if $completion_enable; then
		completion_parse
	fi

	title_body="Example title body"
	if [ ! -z "$1" ]; then
		title_body="$1"
	fi
	title="$title_name $title_body"

	declare -gA headers=([u]="USAGE"
						[o]="OPTIONS"
						[s]="SUBCOMMANDS"
	)

	usage_arr=("$script [OPTIONS]")

	options_arr=()
	options_arr_singles=()
	options_arr_multies=()
	options_arr_infos=()
	options_arr_datas=()
	completion_flags=""

	add_option -s h -m help -i "Print this help message."
	add_option -m print_args -i "Print argument values."
}

####################
#   OPTION PARSE   #
####################

function add_option_help() {
	echo -e "add_option ⁻(smid)"
	echo -e "-m: String text of option, required."
	exit
}

function add_option() {
	local _single=""
	local _multi=""
	local _info=""
	local _data=""

	while [[ $# -gt 0 ]]; do
		opt="$1"
		case $opt in
			-h|--help)
				add_option_help
				;;
			-s)
				if [ -z "$2" ]; then
					return
				fi
				_single="$2"
				shift
				shift
				;;
			-m)
				if [ -z "$2" ]; then
					return
				fi
				_multi="$2"
				shift
				shift
				;;
			-i)
				if [ -z "$2" ]; then
					return
				fi
				_info="$2"
				shift
				shift
				;;
			-d)
				if [ -z "$2" ]; then
					return
				fi
				_data="$2"
				shift
				shift
				;;
			*)
				add_option_help
				;;
		esac
	done

	if [ -z "$_single" ] && [ -z "$_multi" ]; then
		add_option_help
	elif [ -z "$_multi" ]; then
		add_option_help
	fi

	if [ ! -z "$_single" ]; then
		completion_flags+="-$_single "
	fi
	completion_flags+="--$_multi "

	options_arr_singles+=("$_single")
	options_arr_multies+=("$_multi")
	options_arr_infos+=("$_info")
	options_arr_datas+=("$_data")
}

#################
#   HELP PRINT  #
#################

function help() {
	help_strings $@
	help_print $@
	exit 0
}

# Creating printable strings
function help_strings() {
	if [ "$1" == "short" ]; then
		local short=true
		short_delimiter="/"
	else
		local short=false
	fi

	for key in "${!headers[@]}"; do
		headers[$key]="$header_col${headers[$key]}:$reset_col"
	done
	usage="${headers[u]}"
	for u in "${usage_arr[@]}"; do
		usage="$usage\n\t$u"
	done

	options="${headers[o]}"
	if $short; then
		options+="\n"
	fi
	for ((i = 0; i < "${#options_arr_singles[@]}"; i += 1)); do
		local _single=true
		if [ ! -z "${options_arr_singles[i]}" ]; then
			options+="\n\t${option_col}-${options_arr_singles[i]}$reset_col"
		else
			options+="\n\t$option_col$reset_col\t"
			_single=false
		fi

		if [ ! -z "${options_arr_multies[i]}" ]; then
			if $_single; then
				options+=", "
			fi
			options+="${option_col}--${options_arr_multies[i]}$reset_col"
		fi

		if [ ! -z "${options_arr_datas[i]}" ]; then
			options+="${option_col} <${options_arr_datas[i]}>$reset_col"
		else
			options+="${option_col}$reset_col"
		fi

		if [ ! -z "${options_arr_infos[i]}" ]; then
			lines="$(echo -e "${options_arr_infos[$i]}")"
			while IFS= read -r line; do
				if $short; then
					options+="\n$short_delimiter$line"
					break
				fi
				options+="\n\t\t\t$line"
			done <<< "$lines"
		fi
	done
}

# Printing help menu
function help_print() {
	if [ "$1" == "short" ]; then
		local _short=true
	else
		local _short=false
	fi

	local _title="$title"
	local _usage="$usage"
	local _options="$options"

	echo -e "$_title\n"
	echo -e "$_usage\n"

	if $_short; then
		echo -e "$_options" | xargs -d "\n" -n 2 | column -s "$short_delimiter" -t
	else
		oIFS="$IFS"
		printf -v _options "$_options"
		IFS=$'\n' _options=($_options)
		IFS="$oIFS"

		for ((i = 0; i < ${#_options[@]}; i++)); do
			local _line="${_options[i]}"
			if [[ "${_line:0:3}" == $'\t\t\t' ]] && ((${#_line} + ($tab_len * 3) > $COLUMNS)); then
				_line="${_line:3:${#_line}}"
				local _width=$(($COLUMNS - $tab_len * 5))
				echo -en "\t\t\t"
				local _len=0
				local _word
				for _word in $_line; do
					_len=$((_len+${#_word}+1))
					if (($_len > $_width)); then
						echo -en "\n\t\t\t"
						_len=$((${#_word}+1))
					fi
					echo -n "$_word "
				done
				echo
			else
				echo -e "$_line"
			fi
		done
	fi
}

#########################
#   Completion funcs	#
#########################

function completion_parse() {
	completion_src="$(pwd)/$script"
	completion_script="$script"

	completion_format="$(pwd | cut -c 2- | tr / -)"
	completion_file="$completion_path/$completion_format-completion_file_$script"
	completion_func="$completion_format-completion_func_$script"

	mkdir -p "$completion_path"
	touch $completion_file
}

function generate_completion_file() {
	echo -e "#!/usr/bin/env bash
function $completion_func() {
	local _src=\"$completion_src\"
	local _caller=\"\$(readlink -f \"\$1\")\"
	local _in_path=\"$(which $script 2>&1)\"

	if [ \"\$_caller\" == \"\$_src\" ] || [ -x \"\$_in_path\" ]; then
		local _flags=\"$completion_flags\"
		COMPREPLY=(\$(compgen -W \"\$_flags\" -- \"\${COMP_WORDS[COMP_CWORD]}\"))
	fi
}

complete -o nosort -F $completion_func $completion_script
complete -o nosort -F $completion_func ./$completion_script
" > $completion_file
}

#########################
#   Argument parsing	#
#########################

function arg_parse_pre() {
	if $completion_enable; then
		generate_completion_file
	fi
	POSITIONAL=()
}

function vcp() {
	eval "$2_string=\$(declare -p $2)"
	eval "declare -gA $1=\"\${$2_string#*=}\""
}

function arg_parse_post() {
	set -- "${POSITIONAL[@]}"
}

function print_args() {
	for x in "${!args[@]}"; do
		echo -e "$x:\t${args[$x]}"
	done
}

function key_exists() {
	eval '[ ${'args'[$1]+true} ]'
}

function get_key() {
	if key_exists $1; then
		echo "${args[$1]}"
	else
		echo false
	fi
}

function arg_parse() {
	if $recurse; then
		recurse=false
		arg_parse $@
	fi

	# Tmp global vars
	declare -A _args=()
	# declare -n options_arr_singles=()
	# declare -n options_arr_singles=()
	# declare -n options_arr_singles=()

	# Local variables
	local _single=""
	local _multi=""
	local _data=""
	local _hit=false

	while [[ $# -gt 0 ]]; do
		local _opt="$1"
		local _opt_flag
		local _opt_data
		_hit=false
		IFS='=' read -r _opt_flag _opt_data <<< "$_opt"
		if [ ! -z "$_opt_data" ]; then
			_opt="$_opt_flag"
		fi

		# echo "OPT: $_opt"
		for ((i = 0; i < "${#options_arr_singles[@]}"; i += 1)); do
			_single="${options_arr_singles[i]}"
			_multi="${options_arr_multies[i]}"
			_data="${options_arr_datas[i]}"
			# echo "-$_single, --$_multi <$_data>"

			if ([ ! -z "$_single" ] && [ "$_opt" == "-$_single" ]) || [ "$_opt" == "--$_multi" ]; then
				if [ ${_args[$_multi]+true} ]; then
					echo -e "Argument already exists: '$_opt'\n" >&2
					help
				fi
				if [ ! -z "$_data" ]; then
					if [ ! -z "$_opt_data" ]; then
						_args[$_multi]="$_opt_data"
					elif [ -z "$2" ]; then
						echo -e "Data option must have an argument: $_opt" >&2
						help
					else
						_args[$_multi]="$2"
						shift
					fi
				else
					if [ ! -z "$_opt_data" ]; then
						echo -e "Non data option cannot have an argument: $_opt" >&2
						help
					fi
					_args[$_multi]=true
					if [ "$_opt" == "-h" ]; then
						_args[$_single]=true
					fi
				fi
				_hit=true
			fi
		done

		# Tmp global args
		vcp args _args

		if ! $_hit; then
			echo -e "Invalid argument: '$_opt'\n" >&2
			help
		elif key_exists h; then
			help "short"
		elif key_exists help; then
			help
		fi
		shift
	done

	if key_exists print_args; then
		print_args
	fi

}

function parse() {
	recurse=false
	arg_parse_pre "$@"
	arg_parse "$@"
	arg_parse_post "$@"
}
