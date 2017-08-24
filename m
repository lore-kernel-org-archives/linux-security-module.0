From: alexei.starovoitov@gmail.com (Alexei Starovoitov)
Date: Wed, 23 Aug 2017 19:59:02 -0700
Subject: [PATCH net-next v7 08/10] bpf: Add a Landlock sandbox example
In-Reply-To: <20170821000933.13024-9-mic@digikod.net>
References: <20170821000933.13024-1-mic@digikod.net>
	<20170821000933.13024-9-mic@digikod.net>
Message-ID: <20170824025901.cpppy4nn5xv2ao24@ast-mbp>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, Aug 21, 2017 at 02:09:31AM +0200, Micka?l Sala?n wrote:
> Add a basic sandbox tool to create a process isolated from some part of
> the system. This sandbox create a read-only environment. It is only
> allowed to write to a character device such as a TTY:
> 
>   # :> X
>   # echo $?
>   0
>   # ./samples/bpf/landlock1 /bin/sh -i
>   Launching a new sandboxed process.
>   # :> Y
>   cannot create Y: Operation not permitted
> 
> Signed-off-by: Micka?l Sala?n <mic@digikod.net>

...

> +SEC("landlock1")
> +static int landlock_fs_prog1(struct landlock_context *ctx)
> +{
> +	char fmt_error_mode[] = "landlock1: error: get_mode:%lld\n";
> +	char fmt_error_access[] = "landlock1: error: access denied\n";
> +	long long ret;
> +
> +	/*
> +	 * The argument ctx->arg2 contains bitflags of actions for which the
> +	 * rule is run.  The flag LANDLOCK_ACTION_FS_WRITE means that a write
> +	 * is requested by one of the userspace processes restricted by this
> +	 * rule. The following test allows any actions which does not include a
> +	 * write.
> +	 */
> +	if (!(ctx->arg2 & LANDLOCK_ACTION_FS_WRITE))
> +		return 0;
> +
> +	/*
> +	 * The argument ctx->arg1 is a file handle for which the process want
> +	 * to access. The function bpf_handle_fs_get_mode() return the mode of
> +	 * a file (e.g. S_IFBLK, S_IFDIR, S_IFREG...). If there is an error,
> +	 * for example if the argument is not a file handle, then an
> +	 * -errno value is returned. Otherwise the caller get the file mode as
> +	 *  with stat(2).
> +	 */
> +	ret = bpf_handle_fs_get_mode((void *)ctx->arg1);
> +	if (ret < 0) {
> +
> +		/*
> +		 * The bpf_trace_printk() function enable to write in the
> +		 * kernel eBPF debug log, accessible through
> +		 * /sys/kernel/debug/tracing/trace_pipe . To be allowed to call
> +		 * this function, a Landlock rule must have the
> +		 * LANDLOCK_SUBTYPE_ABILITY_DEBUG ability, which is only
> +		 * allowed for CAP_SYS_ADMIN.
> +		 */
> +		bpf_trace_printk(fmt_error_mode, sizeof(fmt_error_mode), ret);
> +		return 1;
> +	}
> +
> +	/*
> +	 * This check allows the action on the file if it is a directory or a
> +	 * pipe. Otherwise, a message is printed to the eBPF log.
> +	 */
> +	if (S_ISCHR(ret) || S_ISFIFO(ret))
> +		return 0;
> +	bpf_trace_printk(fmt_error_access, sizeof(fmt_error_access));
> +	return 1;
> +}
> +
> +/*
> + * This subtype enable to set the ABI, which ensure that the eBPF context and
> + * program behavior will be compatible with this Landlock rule.
> + */
> +SEC("subtype")
> +static const union bpf_prog_subtype _subtype = {
> +	.landlock_rule = {
> +		.abi = 1,
> +		.event = LANDLOCK_SUBTYPE_EVENT_FS,
> +		.ability = LANDLOCK_SUBTYPE_ABILITY_DEBUG,
> +	}
> +};

from rule writer perspective can you somehow merge subtype definition
with the program? It seems they go hand in hand.
Like section name of the program can be:
SEC("landlock_rule1/event=fs/ability=debug")
static int landlock_fs_prog1(struct landlock_context *ctx)...
and the loader can parse this string and prepare appropriate
data structures for the kernel.

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
