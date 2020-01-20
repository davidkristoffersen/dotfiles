#!/bin/bash
# Bash script for gitlab-runner commands

######################
#   HELP FUNCTIONS   #
######################

# Help menu variables
function help_vars() {
	title_col="\e[36m"
	header_col="\e[33m"
	option_col="\e[32m"
	reset_col="\e[m"
	script="$(basename "$0")"
	title_name="$title_col$script$1:$reset_col"
}

function help_init() {
	help_vars

	title="$title_name A bash script for simplifying gitlab-runner commands"
	declare -gA headers=([u]="USAGE"
						[o]="OPTIONS"
						[s]="SUBCOMMANDS"
	)

	usage_arr=("./$script [OPTIONS]")

	options_arr=()
	# declare -gA options_arr=([s]=()
							 # [m]=()
							 # [i]=()
							 # [a]=()
	# )
	options_arr_singles=()
	options_arr_multies=()
	options_arr_infos=()
	add_option -s h -m help -i "Print this help message."
	add_option -m print_args -i "Print argument values."

	subcmds_arr=()
	subcmds_arr+=("badge")
	subcmds_arr+=("Interract with the gitlab badge api")
}

function add_option_help() {
	echo -e "add_option ⁻(smi)"
	exit
}

function add_option() {
	local single=""
	local multi=""
	local info=""

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
				single="$2"
				shift
				shift
				;;
			-m)
				if [ -z "$2" ]; then
					return
				fi
				multi="$2"
				shift
				shift
				;;
			-i)
				if [ -z "$2" ]; then
					return
				fi
				info="$2"
				shift
				shift
				;;
			*)
				add_option_help
				;;
		esac
	done

	if [ -z "$single" ] && [ -z "$multi" ]; then
		add_option_help
	elif [ -z "$multi" ]; then
		add_option_help
	fi

	options_arr_singles+=("$single")
	options_arr_multies+=("$multi")
	options_arr_infos+=("$info")
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
		if [ ! -z "${options_arr_infos[i]}" ]; then
			options="$options\n\t\t\t${options_arr_infos[i]}"
		fi
	done

	if [ -z $subcmds_arr ]; then
		subcmds=""
	else
		subcmds="\n${headers[s]}"
		for ((i = 0; i < "${#subcmds_arr[@]}"; i += 2)); do
			subcmds="$subcmds\n\t${option_col}${subcmds_arr[i]}$reset_col"
			subcmds="$subcmds\t${subcmds_arr[i + 1]}"
		done
	fi
}

# Printing help menu
function help_print() {
	echo -e "$title\n"
	echo -e "$usage\n"
	echo -e "$options"
	echo -e "$subcmds"
}

function badge_help() {
	help_vars " badge"
	
	title="$title_name Subcommand to interract with the gitlab badge api"
	declare -A headers=(	[u]="USAGE"
							[o]="OPTIONS"
							[a]="SUBCOMMANDS"
	)

	usage_arr=( "./$script badge [OPTIONS]")
	options_arr=(   "-h,\t--help"
					"Print this help message."
					"-l,\t--list"
					"List all badges"
					"-g,\t--get [badge_id]"
					"Get info of a badge"
					"-e,\t--edit [badge_id]"
					"Edit a badge"
					"-r,\t--remove [badge_id]"
					"Remove a badge"
					"-a,\t--add"
					"Add a badge"
					"-p,\t--pipeline [commit_sha] [branch_ref]"
					"Get pipeline id by commit sha and branch ref"
					"--group"
					"Use group badge"
					"-x,\t--xtrace"
					"Trace execution"
	)
	subcmds_arr=""

	help_strings
	help_print
	exit 0
}

#########################
#   Argument parsing	#
#########################

function arg_parse_pre() {
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

function arg_parse() {
	local single=""
	local multi=""
	local hit=false
	declare -gA args=()
	while [[ $# -gt 0 ]]; do
		local hit=false
		opt="$1"
		for ((i = 0; i < "${#options_arr_singles[@]}"; i += 1)); do
			local single="${options_arr_singles[i]}"
			local multi="${options_arr_multies[i]}"
			if [ "$opt" == "-$single" ] || [ "$opt" == "--$multi" ]; then
				if [ ${args[$multi]+true} ] && ${args[$multi]}; then
					echo -e "Argument already exists: '$opt'\n" >&2
					help
				fi
				args[$multi]=true
				local hit=true
			elif ! [ ${args[$multi]+true} ]; then
				args[$multi]=false
			fi
		done

		if ! $hit; then
			echo -e "Invalid argument: '$opt'\n" >&2
			help
		elif ${args[help]}; then
			help
		fi
		shift
	done

	if ${args[print_args]}; then
		print_args
	fi
	# badge)
		# shift
		# if [ "$#" -lt "1" ]; then
			# badge_help
		# fi
		# badge_arg_parse $@
		# exit
}

function badge_arg_parse() {
	badge_vars
	while [[ $# -gt 0 ]]; do
		opt="$1"
		case $opt in
			-h|--help)
				badge_help
				;;
			-l|--list)
				echo "HEI"
				shift
				;;
			-g|--get)
				if [ -z "$2" ]; then
					badge_help
				fi
				badge_get $2
				shift; shift
				;;
			-e|--edit)
				if [ -z "$2" ]; then
					badge_help
				fi
				badge_edit $2
				shift; shift
				;;
			-r|--remove)
				if [ -z "$2" ]; then
					badge_help
				fi
				badge_remove $2
				shift; shift
				;;
			-a|--add)
				badge_add
				shift
				;;
			-p|--pipeline)
				if [ -z "$2" ] || [ -z "$3" ]; then
					badge_help
				fi
				badge_pipeline $2 $3
				shift; shift; shift
				;;
			--group)
				api_path="api/v4/groups"
				project="oskarco"
				shift
				;;
			-x|--xtrace)
				set -o xtrace
				shift
				;;
			*)
				echo -e "Invalid argument: '$opt'\n" >&2
				badge_help
				;;
		esac
	done
}

function parse() {
	arg_parse_pre $@
	arg_parse $@
	arg_parse_post $@
}

help_init
