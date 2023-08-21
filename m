Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 911CFEE49A5
	for <linux-security-module@archiver.kernel.org>; Mon, 21 Aug 2023 17:29:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232290AbjHUR3Y (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 21 Aug 2023 13:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232139AbjHUR3Y (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 21 Aug 2023 13:29:24 -0400
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A200F7;
        Mon, 21 Aug 2023 10:29:21 -0700 (PDT)
Received: from jerom (unknown [128.107.241.188])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: serge)
        by mail.hallyn.com (Postfix) with ESMTPSA id 49CC7993;
        Mon, 21 Aug 2023 12:29:16 -0500 (CDT)
Date:   Mon, 21 Aug 2023 12:29:13 -0500
From:   Serge Hallyn <serge@hallyn.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     linux-audit@redhat.com, audit@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        Steve Grubb <sgrubb@redhat.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [PATCH] audit: add task history record
Message-ID: <ZOOe6Tegj0QKpc2w@jerom>
References: <36b65eb1-ccbf-8b81-468f-b8d88c4be5a3@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36b65eb1-ccbf-8b81-468f-b8d88c4be5a3@I-love.SAKURA.ne.jp>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Aug 11, 2023 at 07:58:06PM +0900, Tetsuo Handa wrote:
> When an unexpected system event occurs, the administrator may want to

I think I would at times find this useful, however the audit maintainer
has said no to this patch, and the reasoning is sound (there are other
ways to do or approximate this, and maintainer support burden is
increased - which is why that decision is purely his).  So I'm giving
some technical feedback here, because the code is still out here :), but
I am not arguing with Paul's nack.

> identify which application triggered the event. For example, unexpected
> process termination is still a real concern enough to write articles
> like https://access.redhat.com/solutions/165993 .
> 
> This patch adds a record which emits TOMOYO-like task history information

I don't think you should mention TOMOYO here.  Unless I'm expected
to go read the TOMOYO docs before reviewing this patch.

> into the audit logs for better understanding of unexpected system events.
> 
>   type=UNKNOWN[1340] msg=audit(1691750738.271:108): history="name=swapper/0;pid=1;start=20230811194329=>name=init;pid=1;start=20230811194343=>name=systemd;pid=1;start=20230811194439=>name=sshd;pid=3660;start=20230811104504=>name=sshd;pid=3767;start=20230811104535"
> 
> To be able to avoid bloating audit log files due to this information, this
> patch uses audit_history= kernel command line parameter that controls max
> length of history in bytes (default is 1024, and setting to 0 disables
> recording and emitting).
> 
> Unlike execve()'s argv record, records in this history information is
> emitted as one string in order to reduce bloat of the audit log files.
> This information can be split into an array using => as the tokenizer.
> But don't expect that you can compare array elements throughout the whole
> audit logs by splitting into an array, for old records get removed from
> history when history became too long to append the newest record. This
> history information is meant to be interpreted by humans rather than be
> analyzed by programs.
>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
>  fs/exec.c                  |   1 +
>  include/linux/audit.h      |   5 ++
>  include/linux/sched.h      |   1 +
>  include/uapi/linux/audit.h |   1 +
>  init/init_task.c           |   7 +++
>  kernel/audit.c             |   1 +
>  kernel/auditsc.c           | 108 +++++++++++++++++++++++++++++++++++++
>  7 files changed, 124 insertions(+)
> 
> diff --git a/fs/exec.c b/fs/exec.c
> index 1a827d55ba94..5c8776f692c5 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1381,6 +1381,7 @@ int begin_new_exec(struct linux_binprm * bprm)
>  	commit_creds(bprm->cred);
>  	bprm->cred = NULL;
>  
> +	audit_update_history();
>  	/*
>  	 * Disable monitoring for regular users
>  	 * when executing setuid binaries. Must
> diff --git a/include/linux/audit.h b/include/linux/audit.h
> index 6a3a9e122bb5..6291d0f76541 100644
> --- a/include/linux/audit.h
> +++ b/include/linux/audit.h
> @@ -397,6 +397,8 @@ static inline void audit_ptrace(struct task_struct *t)
>  		__audit_ptrace(t);
>  }
>  
> +extern void audit_update_history(void);
> +
>  				/* Private API (for audit.c only) */
>  extern void __audit_ipc_obj(struct kern_ipc_perm *ipcp);
>  extern void __audit_ipc_set_perm(unsigned long qbytes, uid_t uid, gid_t gid, umode_t mode);
> @@ -701,6 +703,9 @@ static inline void audit_ntp_log(const struct audit_ntp_data *ad)
>  static inline void audit_ptrace(struct task_struct *t)
>  { }
>  
> +static inline void audit_update_history(void)
> +{ }
> +
>  static inline void audit_log_nfcfg(const char *name, u8 af,
>  				   unsigned int nentries,
>  				   enum audit_nfcfgop op, gfp_t gfp)
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 609bde814cb0..f32076b6b733 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1112,6 +1112,7 @@ struct task_struct {
>  #ifdef CONFIG_AUDIT
>  #ifdef CONFIG_AUDITSYSCALL
>  	struct audit_context		*audit_context;
> +	char				*comm_history;
>  #endif
>  	kuid_t				loginuid;
>  	unsigned int			sessionid;
> diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
> index d676ed2b246e..186c0b5ca1b6 100644
> --- a/include/uapi/linux/audit.h
> +++ b/include/uapi/linux/audit.h
> @@ -122,6 +122,7 @@
>  #define AUDIT_OPENAT2		1337	/* Record showing openat2 how args */
>  #define AUDIT_DM_CTRL		1338	/* Device Mapper target control */
>  #define AUDIT_DM_EVENT		1339	/* Device Mapper events */
> +#define AUDIT_PROCHISTORY	1340	/* Commname history emit event */
>  
>  #define AUDIT_AVC		1400	/* SE Linux avc denial or grant */
>  #define AUDIT_SELINUX_ERR	1401	/* Internal SE Linux Errors */
> diff --git a/init/init_task.c b/init/init_task.c
> index ff6c4b9bfe6b..e3d481d1b010 100644
> --- a/init/init_task.c
> +++ b/init/init_task.c
> @@ -57,6 +57,10 @@ unsigned long init_shadow_call_stack[SCS_SIZE / sizeof(long)]
>  };
>  #endif
>  
> +#ifdef CONFIG_AUDITSYSCALL
> +extern char init_task_audit_history[];
> +#endif
> +
>  /*
>   * Set up the first task table, touch at your own risk!. Base=0,
>   * limit=0x1fffff (=2MB)
> @@ -137,6 +141,9 @@ struct task_struct init_task
>  #ifdef CONFIG_AUDIT
>  	.loginuid	= INVALID_UID,
>  	.sessionid	= AUDIT_SID_UNSET,
> +#ifdef CONFIG_AUDITSYSCALL
> +	.comm_history   = init_task_audit_history,
> +#endif
>  #endif
>  #ifdef CONFIG_PERF_EVENTS
>  	.perf_event_mutex = __MUTEX_INITIALIZER(init_task.perf_event_mutex),
> diff --git a/kernel/audit.c b/kernel/audit.c
> index 9bc0b0301198..034952abd83d 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -1674,6 +1674,7 @@ static int __init audit_init(void)
>  {
>  	int i;
>  
> +	audit_update_history();
>  	if (audit_initialized == AUDIT_DISABLED)
>  		return 0;
>  
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index addeed3df15d..6f1b124da2fe 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -80,6 +80,9 @@
>  /* max length to print of cmdline/proctitle value during audit */
>  #define MAX_PROCTITLE_AUDIT_LEN 128
>  
> +/* max length for thread's comm name history */
> +static unsigned int audit_history_size __ro_after_init = 1024;
> +
>  /* number of audit rules */
>  int audit_n_rules;
>  
> @@ -1055,6 +1058,12 @@ int audit_alloc(struct task_struct *tsk)
>  	enum audit_state     state;
>  	char *key = NULL;
>  
> +	if (audit_history_size) {
> +		tsk->comm_history = kmemdup(current->comm_history, audit_history_size, GFP_KERNEL);
> +		if (!tsk->comm_history)
> +			return -ENOMEM;
> +	}
> +
>  	if (likely(!audit_ever_enabled))
>  		return 0;
>  
> @@ -1065,6 +1074,10 @@ int audit_alloc(struct task_struct *tsk)
>  	}
>  
>  	if (!(context = audit_alloc_context(state))) {
> +		if (audit_history_size) {
> +			kfree(tsk->comm_history);
> +			tsk->comm_history = NULL;
> +		}
>  		kfree(key);
>  		audit_log_lost("out of memory in audit_alloc");
>  		return -ENOMEM;
> @@ -1671,6 +1684,18 @@ static void audit_log_uring(struct audit_context *ctx)
>  	audit_log_end(ab);
>  }
>  
> +static void audit_log_history(struct audit_context *context)
> +{
> +	struct audit_buffer *ab;
> +
> +	ab = audit_log_start(context, GFP_KERNEL, AUDIT_PROCHISTORY);
> +	if (!ab)
> +		return; /* audit_panic or being filtered */
> +	audit_log_format(ab, "history=");
> +	audit_log_untrustedstring(ab, current->comm_history);
> +	audit_log_end(ab);
> +}
> +
>  static void audit_log_exit(void)
>  {
>  	int i, call_panic = 0;
> @@ -1805,6 +1830,8 @@ static void audit_log_exit(void)
>  
>  	if (context->context == AUDIT_CTX_SYSCALL)
>  		audit_log_proctitle();
> +	if (audit_history_size)
> +		audit_log_history(context);
>  
>  	/* Send end of event record to help user space know we are finished */
>  	ab = audit_log_start(context, GFP_KERNEL, AUDIT_EOE);
> @@ -1824,6 +1851,10 @@ void __audit_free(struct task_struct *tsk)
>  {
>  	struct audit_context *context = tsk->audit_context;
>  
> +	if (audit_history_size) {
> +		kfree(tsk->comm_history);
> +		tsk->comm_history = NULL;
> +	}
>  	if (!context)
>  		return;
>  
> @@ -3034,3 +3065,80 @@ struct list_head *audit_killed_trees(void)
>  		return NULL;
>  	return &ctx->killed_trees;
>  }
> +
> +char init_task_audit_history[4096];
> +
> +static int __init audit_history_setup(char *str)
> +{
> +	unsigned int size;
> +
> +	if (kstrtouint(str, 10, &size))
> +		return -EINVAL;
> +	if (size > sizeof(init_task_audit_history))
> +		size = sizeof(init_task_audit_history);
> +	audit_history_size = size;
> +	return 0;
> +}
> +early_param("audit_history", audit_history_setup);
> +
> +void audit_update_history(void)
> +{
> +	int i;
> +	int required;
> +	struct tm tm;
> +	char buf[256];
> +	char *cp = buf;
> +
> +	if (!audit_history_size)
> +		return;
> +
> +	cp += snprintf(buf, sizeof(buf) - 1, "name=");

(i don't think -1 is really needed here, snprintf(x, 3, "abcd") will
put 0 into x[2].)

> +	for (i = 0; i < TASK_COMM_LEN; i++) {

Note that while I think it very unlikely that TASK_COMM_LEN would
be increased to > 250, this *is* kind of a timebomb.  Better to
either calculate the size of buf as a fn of TASK_COMM_LEN, or check
for (cp-buf) not getting too large here.

> +		const unsigned char c = current->comm[i];
> +
> +		if (!c)
> +			break;
> +		if (isalnum(c) || c == '.' || c == '_' || c == '-' || c == '/') {
> +			*cp++ = c;
> +			continue;
> +		}
> +		*cp++ = '\\';
> +		*cp++ = (c >> 6) + '0';
> +		*cp++ = ((c >> 3) & 7) + '0';
> +		*cp++ = (c & 7) + '0';
> +	}
> +	/* Append PID. */
> +	cp += snprintf(cp, buf - cp + sizeof(buf) - 1, ";pid=%u",
> +		       current->pid);
> +	/* Append timestamp. */
> +	time64_to_tm(ktime_get_real_seconds(), 0, &tm);
> +	cp += snprintf(cp, buf - cp + sizeof(buf) - 1,
> +		       ";start=%04u%02u%02u%02u%02u%02u", (int) tm.tm_year + 1900,
> +		       tm.tm_mon + 1, tm.tm_mday, tm.tm_hour, tm.tm_min,
> +		       tm.tm_sec);
> +	/* Terminate the buffer. */
> +	if (cp >= buf + sizeof(buf))
> +		cp = buf + sizeof(buf) - 1;
> +	*cp = '\0';
> +	required = cp - buf + 1;
> +	/* Make some room by truncating old history. */
> +	cp = current->comm_history;
> +	i = strlen(cp);
> +	while (i + required >= audit_history_size - 3) {
> +		char *cp2 = memchr(cp, '>', i);
> +
> +		/* Reset history if audit_history_size is too small to truncate. */
> +		if (!cp2++) {
> +			*cp = '\0';
> +			return;
> +		}
> +		i -= cp2 - cp;
> +		memmove(cp, cp2, i + 1);

Would it be better to first calculate the optimal cp2 to use,
then do the memmove, to avoid repeated calls to memmove?

> +	}
> +	/* Emit the buffer. */
> +	if (i) {
> +		cp[i++] = '=';
> +		cp[i++] = '>';
> +	}
> +	memcpy(cp + i, buf, required);
> +}
> -- 
> 2.18.4
> 
> 
