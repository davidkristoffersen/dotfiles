#!/usr/bin/env bash
pre_lib_cd="$(pwd)"
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
	default_col="\e[35m"
	reset_col="\e[m"
	tab_len=4
	num_tabs=3
	script="$(basename "$0")"
	title_name="$title_col$script$1:$reset_col"
}

function completion_vars() {
	completion_enable=true
	completion_path="$HOME/.bash_completion.d"
}

#################
#   HELP INIT   #
#################

function help_init() {
	help_vars
	printf -v info_tabs '\t%.0s' $(seq 1 $num_tabs)

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
	options_arr_defaults=()
	options_arrs_string="options_arr_singles options_arr_multies options_arr_infos options_arr_datas options_arr_defaults"
	completion_flags=""
	declare -gA args=()

	options_max_len=0
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
	local _value=""
	local _default=""

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
			-v)
				if [ -z "$2" ]; then
					return
				fi
				_value="$2"
				shift
				shift
				;;
			-d)
				if [ -z "$2" ]; then
					return
				fi
				_default="$2"
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

	local new_len="$(($tab_len + 4 + ${#_multi} + 3))"
	if [ ! -z "$_value" ]; then
		new_len="$(($new_len + 2 + ${#_value}))"
	fi
	if (($new_len > $options_max_len)); then
		options_max_len=$new_len
	fi

	if [ ! -z "$_default" ]; then
		if [ -z "$_value" ]; then
			if [ ! -z "$(grep -o "^true$\|^0$" <<< "$_default")" ]; then
				_default=true
			elif [ ! -z "$(grep -o "^false$\|^1$" <<< "$_default")" ]; then
				_default=false
			else
				echo "Bool argument can only have true and false as default value: $_default"
				add_option_help
			fi
		fi
		args[$_multi]="$_default"

		if [ ! -z "$_info" ]; then
			_info+=" "
		fi
		_info+="$default_col[default: $_default]$reset_col"
	fi

	options_arr_singles+=("$_single")
	options_arr_multies+=("$_multi")
	options_arr_infos+=("$_info")
	options_arr_datas+=("$_value")
	options_arr_defaults+=("$_default")
}

#################
#   HELP PRINT  #
#################

function help() {
	help_strings $# $@ $options_arrs_string
	help_print $@
	exit 0
}

# Creating printable strings
function help_strings() {
	if $help_short; then
		local _short=true
	else
		local _short=false
	fi

	for key in "${!headers[@]}"; do
		headers[$key]="$header_col${headers[$key]}:$reset_col"
	done
	usage="${headers[u]}"
	for u in "${usage_arr[@]}"; do
		usage="$usage\n\t$u"
	done

	options="${headers[o]}"
	for ((i = 0; i < "${#options_arr_singles[@]}"; i += 1)); do
		local _single=true
		if [ ! -z "${options_arr_singles[i]}" ]; then
			printf -v options "$options\n\t${option_col}-${options_arr_singles[i]}$reset_col"
		else
			printf -v options "$options\n    $option_col$reset_col\t"
			_single=false
		fi

		if [ ! -z "${options_arr_multies[i]}" ]; then
			if $_single; then
				options+=", "
			fi
			printf -v options "$options${option_col}--${options_arr_multies[i]}$reset_col"
		fi

		if [ ! -z "${options_arr_datas[i]}" ]; then
			printf -v options "$options${option_col} <${options_arr_datas[i]}>$reset_col"
		else
			printf -v options "$options${option_col}$reset_col"
		fi

		if [ ! -z "${options_arr_infos[i]}" ]; then
			lines="$(echo -e "${options_arr_infos[$i]}")"
			while IFS= read -r line; do
				options+="\n$info_tabs$line"
				if $_short; then
					break
				fi
			done <<< "$lines"
		fi
	done
}

# Printing help menu
function help_print() {
	if $help_short; then
		local _short=true
	else
		local _short=false
	fi

	local _title="$title"
	local _usage="$usage"
	local _options="$options"

	echo -e "$_title\n"
	echo -e "$_usage\n"

	oIFS="$IFS"
	printf -v _options_arr "$_options"
	IFS=$'\n' _options_arr=($_options_arr)
	IFS="$oIFS"

	local _pre_tabs
	local _prev_len=0
	local _prev_option_len=0
	local _option_col_len=$((${#option_col} * 2 + ${#reset_col} * 2))
	local _width

	for ((i = 0; i < ${#_options_arr[@]}; i++)); do

		printf -v _pre_tabs "$info_tabs"

		local _line="${_options_arr[i]}"
		if [[ "${_line:0:${#_pre_tabs}}" == $_pre_tabs ]]; then
			_line="${_line:3:${#_line}}"

			if $_short; then
				printf -v _pre_tabs ' %.0s' $(seq 1 $_prev_len)
				printf -v _pre_option ' %.0s' $(seq 1 $_prev_option_len)
			fi

			if ((${#_line} + ($tab_len * 3) + ($_prev_len) > $COLUMNS)); then
				if $_short; then
					_width=$(($COLUMNS - $tab_len * 2 - $_prev_option_len))
				else
					_width=$(($COLUMNS - $tab_len * 5))
				fi
				echo -en "$_pre_tabs"
				local _len=0
				local _word
				for _word in $_line; do
					_len=$((_len+${#_word}+1))
					if (($_len > $_width)); then
						if $_short; then
							echo -en "\n$_pre_option"
						else
							echo -en "\n$_pre_tabs"
						fi
						_len=$((${#_word}+1))
					fi
					echo -n "$_word "
				done
				echo
			else
				echo -e "$_pre_tabs$_line"
			fi
		else
			if (($i == 0)); then
				echo -e "$_line"
				_prev_len="$(($tab_len * 3))"
			else
				((_info_iter++))
				if $_short; then
					echo -ne "$_line"
					local _line_len=${#_line}
					_prev_len=$(($_line_len - $_option_col_len - 1))
					_prev_len=$(($options_max_len - $_prev_len + $tab_len))
					_prev_option_len=$(($options_max_len + $tab_len))
				else
					echo -e "$_line"
					_prev_len="$(($tab_len * 3))"
				fi
			fi
		fi
	done
}

#########################
#   COMPLETION FUNCS	#
#########################

function path_to_var() {
	echo -e "$1" | xxd -p | tr -d '\n'
}

function var_to_path() {
	echo -e "$1" | xxd -r -p
}

function completion_parse() {
	completion_src="$(pwd)/$script"
	completion_script="$script"

	local path="$(pwd)"
	completion_format="$(path_to_var "$path")"
	completion_file="$completion_path/completion_file-$completion_format-$script"
	completion_func="completion_func-$completion_format-$script"

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
#   CLIENT FUNCTIONS	#
#########################

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

function set_key() {
	if key_exists $1; then
		eval "$1=${args[$1]}"
	fi
}

#########################
#   ARGUMENT PARSING	#
#########################

function arg_parse_pre() {
	if $completion_enable; then
		generate_completion_file
	fi
	POSITIONAL=()
}

function agcp() {
	local _string=$(declare -p $2)
	eval "declare -gA $1=\${_string#*=}"
}
function alcp() {
	local _string=$(declare -p $2)
	echo "declare -A $1=${_string#*=}"
}
function igcp() {
	local _string=$(declare -p $2)
	eval "declare -ga $1=\${_string#*=}"
}
function ilcp() {
	local _string=$(declare -p $2)
	echo "declare -a $1=${_string#*=}"
}

function arg_parse_post() {
	set -- "${POSITIONAL[@]}"
}

function print_args() {
	local out=""
	for x in "${!args[@]}"; do
		out+="\n$x:${args[$x]}"
	done
	echo -e "$out" | tail +2 | sort | column -t -s ":"
}

function arg_parse() {
	if $recurse; then
		recurse=false
		arg_parse $@
	fi

	local _option_num=$1
	shift
	local _arg_num=$#
	local _var_num=$(($# - $_option_num))
	local _var_args="${@:$(($_option_num + 1)):$_var_num}"
	local _option_last=false
	for _var in $_var_args; do
		eval $(ilcp _$_var $_var)
	done

	# Local variables
	local _single=""
	local _multi=""
	local _data=""
	local _hit=false
	help_short=false
	local _debug=false

	eval $(alcp _args args)

	while [[ $# -gt 0 ]]; do
		if (($_arg_num - $# == $_option_num)); then
			break
		fi
		if (($_arg_num - $# == $_option_num - 1)); then
			_option_last=true
		fi
		$_debug && echo "_option_last: $_option_last"

		local _opt="$1"
		local _opt_flag
		local _opt_data
		local _opt_single=false
		local _opt_multi=false

		_hit=false
		IFS='=' read -r _opt_flag _opt_data <<< "$_opt"
		if [ ! -z "$_opt_data" ]; then
			_opt="$_opt_flag"
		fi

		$_debug && echo -e "\n=============\nOPT: $_opt\n============="
		if [ "${_opt:0:2}" == "--" ]; then
			local _opt_is_single=false
			local _opt_singles="."
			local _opt_single="$_opt"
		elif [ "${_opt:0:1}" == "-" ]; then
			local _opt_is_single=true
		fi

		for ((i = 0; i < "${#_options_arr_singles[@]}"; i += 1)); do
			_single="${_options_arr_singles[i]}"
			_multi="${_options_arr_multies[i]}"
			_data="${_options_arr_datas[i]}"
			_default="${_options_arr_defaults[i]}"
			$_debug && echo -e "\n-$_single, --$_multi <$_data> [default: $_default]"

			if $_opt_is_single; then
				_opt_singles="$(echo "${_opt:1:${#_opt}}")"
			fi

			for ((k = 0; k < ${#_opt_singles}; k++)); do
				local _opt_old="$_opt"
				if $_opt_is_single; then
					local _opt_single="${_opt_singles:$k:1}"
				fi
				$_debug && echo "single: $_opt_single"
				if ([ ! -z "$_single" ] && [ "-$_opt_single" == "-$_single" ]) || [ "$_opt" == "--$_multi" ]; then
					if $_opt_is_single; then
						if [ ! -z "$_data" ] && (($k < ${#_opt_singles} - 1)); then
							echo "Single combined data flag has to be at the end: $_opt"
							help $_var_args
						fi
						_opt="$_opt_single"
					fi
					$_debug && echo "opt: $_opt"

					if [ -z "$_default" ] && [ ${_args[$_multi]+true} ]; then
						echo -e "Argument already exists: '$_opt'\n" >&2
						help $_var_args
					fi
					if [ ! -z "$_data" ]; then
						if [ ! -z "$_opt_data" ]; then
							$_debug && echo "Data=: hit"
							_args[$_multi]="$_opt_data"
							agcp args _args
						elif [ -z "$2" ] || $_option_last; then
							echo -e "Data option must have an argument: $_opt" >&2
							help $_var_args
						else
							$_debug && echo "Data: hit"
							_args[$_multi]="$2"
							agcp args _args
							_hit=true
							shift
							break
						fi
					else
						if [ ! -z "$_opt_data" ]; then
							echo -e "Non data option cannot have an argument: $_opt" >&2
							help $_var_args
						fi
						if [ ! -z "$_default" ] && $_default; then
							$_debug && echo "Bool default: hit"
							_args[$_multi]=false
							agcp args _args
						else
							$_debug && echo "Bool: hit"
							_args[$_multi]=true
							agcp args _args
						fi

						if [ "-$_opt" == "-h" ]; then
							_args[h]=true
							agcp args _args
						fi
					fi
					_hit=true
				fi
				local _opt="$_opt_old"
			done
			if $_hit; then
				break
			fi
		done

		# Tmp global args
		for _var in $_var_args; do
			igcp $_var _$_var
		done

		if ! $_hit; then
			echo -e "Invalid argument: '$_opt'\n" >&2
			help $_var_args
		elif key_exists h; then
			help_short=true
			help $_var_args
		elif key_exists help; then
			help
		fi
		shift
	done

	if key_exists print_args; then
		print_args
	fi

	echo $@
}

function parse() {
	recurse=false
	arg_parse_pre "$@"
	arg_parse $# "$@" $options_arrs_string
	arg_parse_post "$@"

	cd "$pre_lib_cd"
}
