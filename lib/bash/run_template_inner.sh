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
	script="$(basename "$0")"
	title_name="$title_col$script$1:$reset_col"
}

function completion_vars() {
	completion_enable=true
	completion_path="$HOME/.bash_completion.d"
}

######################
#   HELP FUNCTIONS   #
######################

function completion_parse() {
	completion_src="$(pwd)/$script"
	completion_script="$script"

	completion_format="$(pwd | cut -c 2- | tr / -)"
	completion_file="$completion_path/$completion_format-completion_file_$script"
	completion_func="$completion_format-completion_func_$script"

	mkdir -p "$completion_path"
	touch $completion_file
}

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

	usage_arr=("./$script [OPTIONS]")

	options_arr=()
	options_arr_singles=()
	options_arr_multies=()
	options_arr_infos=()
	options_arr_datas=()
	completion_flags=""

	add_option -s h -m help -i "Print this help message."
	add_option -m print_args -i "Print argument values."
}

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

function help() {
	help_strings
	help_print
	exit 0
}

# Creating printable strings
function help_strings() {
	for key in "${!headers[@]}"; do
		headers[$key]="$header_col${headers[$key]}:$reset_col"
	done
	usage="${headers[u]}"
	for u in "${usage_arr[@]}"; do
		usage="$usage\n\t$u"
	done

	options="${headers[o]}"
	for ((i = 0; i < "${#options_arr_singles[@]}"; i += 1)); do
		local single=true
		if [ ! -z "${options_arr_singles[i]}" ]; then
			options="$options\n\t${option_col}-${options_arr_singles[i]}$reset_col"
		else
			options="$options\n\t\t"
			single=false
		fi
		if [ ! -z "${options_arr_multies[i]}" ]; then
			if $single; then
				options="$options, "
			fi
			options="$options${option_col}--${options_arr_multies[i]}$reset_col"
		fi
		if [ ! -z "${options_arr_datas[i]}" ]; then
			options="$options${option_col} <${options_arr_datas[i]}>$reset_col"
		fi
		if [ ! -z "${options_arr_infos[i]}" ]; then
			lines="$(echo -e "${options_arr_infos[$i]}")"
			while IFS= read -r line; do
				options="$options\n\t\t\t$line"
			done <<< "$lines"
		fi
	done
}

# Printing help menu
function help_print() {
	echo -e "$title\n"
	echo -e "$usage\n"
	echo -e "$options"
}

#########################
#   Argument parsing	#
#########################

function generate_completion_file() {
	echo -e "#!/usr/bin/env bash
function $completion_func() {
	local src=\"$completion_src\"
	local caller=\"\$(readlink -f \"\$1\")\"
	local in_path=\"$(which $script)\"

	if [ \"\$caller\" == \"\$src\" ] || [ -x \"\$in_path\" ]; then
		local flags=\"$completion_flags\"
		COMPREPLY=(\$(compgen -W \"\$flags\" -- \"\${COMP_WORDS[COMP_CWORD]}\"))
	fi
}

complete -o nosort -F $completion_func $completion_script
complete -o nosort -F $completion_func ./$completion_script
" > $completion_file
}

function arg_parse_pre() {
	if $completion_enable; then
		generate_completion_file
	fi
	POSITIONAL=()
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
	local single=""
	local multi=""
	local data=""
	local hit=false
	declare -gA args=()
	while [[ $# -gt 0 ]]; do
		local hit=false
		opt="$1"
		local opt_flag
		local opt_data
		IFS='=' read -r opt_flag opt_data <<< "$opt"
		if [ ! -z "$opt_data" ]; then
			opt="$opt_flag"
		fi

		# echo "OPT: $opt"
		for ((i = 0; i < "${#options_arr_singles[@]}"; i += 1)); do
			local single="${options_arr_singles[i]}"
			local multi="${options_arr_multies[i]}"
			local data="${options_arr_datas[i]}"
			# echo "-$single, --$multi <$data>"

			if ([ ! -z "$single" ] && [ "$opt" == "-$single" ]) || [ "$opt" == "--$multi" ]; then
				if [ ${args[$multi]+true} ]; then
					echo -e "Argument already exists: '$opt'\n" >&2
					help
				fi
				if [ ! -z "$data" ]; then
					if [ ! -z "$opt_data" ]; then
						args[$multi]="$opt_data"
					elif [ -z "$2" ]; then
						echo -e "Data option must have an argument: $opt" >&2
						help
					else
						args[$multi]="$2"
						shift
					fi
				else
					if [ ! -z "$opt_data" ]; then
						echo -e "Non data option cannot have an argument: $opt" >&2
						help
					fi
					args[$multi]=true
				fi
				local hit=true
			fi
		done

		if ! $hit; then
			echo -e "Invalid argument: '$opt'\n" >&2
			help
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
	arg_parse_pre "$@"
	arg_parse "$@"
	arg_parse_post "$@"
}
