Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E999C05027
	for <linux-security-module@archiver.kernel.org>; Thu,  9 Feb 2023 11:44:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbjBILoR (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 9 Feb 2023 06:44:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjBILoB (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 9 Feb 2023 06:44:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9396F8F6
        for <linux-security-module@vger.kernel.org>; Thu,  9 Feb 2023 03:31:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9AA0FB82076
        for <linux-security-module@vger.kernel.org>; Thu,  9 Feb 2023 11:30:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D46CEC4339B;
        Thu,  9 Feb 2023 11:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675942254;
        bh=1E2jy5hSlHpiznizGpwF3hWS7exWRqY03vYwkpfaPFk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mhFZ0KCOllEkx+hnkYRTtJ2dZrj4GfXivLBxqxoQPcG9YtsiweCmA6M63ciXvs+Gh
         NdqZc6onmW6G+Ze3IwgAYV52lvI9Bp/Ujq4cy0MntfRtFLya+Z/zW+R8S+3wmOJwfV
         mztzQH2oFXnLiaVkSqL/qd5VJtCHDGQkkQdfLZrU=
Date:   Thu, 9 Feb 2023 12:30:51 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Dr. Greg" <greg@enjellic.com>
Cc:     linux-security-module@vger.kernel.org
Subject: Re: [PATCH 08/14] Implement TSEM control plane.
Message-ID: <Y+TZa60YQlehJtJu@kroah.com>
References: <20230204050954.11583-1-greg@enjellic.com>
 <20230204050954.11583-9-greg@enjellic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230204050954.11583-9-greg@enjellic.com>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Feb 03, 2023 at 11:09:48PM -0600, Dr. Greg wrote:
> The fs.c file contains the implementation of the TSEM control
> plane that is in the form of a pseudo-filesystem mounted on the
> following directory:
> 
> /sys/fs/tsem

Why are you using sysfs to mount this?

> 
> The following file documents the interface provided by the
> control plane:
> 
> Documentation/ABI/testing/tsemfs
> 
> The pseudo-files act on the modeling context of the process that
> is acting on the file.  For example, reading the 'id'
> pseudo-file, returns the modeling domain identifier that the
> process is running in.
> 
> The ExternalTMA directory is used to segreate the pseudo-files
> that are created in order to surface security event descriptions
> to an external trust orchestrator.  The files in this directory
> appear as the numeric value of the modeling domain they were
> created for.
> 
> The 'control' pseudo-file is the only writable file in the plane
> and is used to control the TSEM implementation.  The most
> important and primary roles are to create namespaces and set the
> trust status of a process modeled by an external TMA.
> 
> Signed-off-by: Greg Wettstein <greg@enjellic.com>
> ---
>  security/tsem/fs.c | 894 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 894 insertions(+)
>  create mode 100644 security/tsem/fs.c
> 
> diff --git a/security/tsem/fs.c b/security/tsem/fs.c
> new file mode 100644
> index 000000000000..2898a1cc8c97
> --- /dev/null
> +++ b/security/tsem/fs.c
> @@ -0,0 +1,894 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +/*
> + * Copyright (C) 2022 Enjellic Systems Development, LLC

It's 2023 :)

> + * Author: Dr. Greg Wettstein <greg@enjellic.com>
> + *
> + * Implements the sysfs based control plane.

This is NOT sysfs, it is your own filesystem, please don't confuse the
two.

> + */
> +
> +#include <linux/seq_file.h>
> +#include <linux/sysfs.h>
> +#include <linux/fs_context.h>
> +#include <linux/namei.h>
> +#include <linux/poll.h>
> +#include <uapi/linux/magic.h>
> +
> +#include "tsem.h"
> +
> +static int fs_init_context(struct fs_context *context);
> +static int fs_get_tree(struct fs_context *context);
> +
> +static struct file_system_type fs_definition = {
> +	.name = "tsemfs",
> +	.init_fs_context = fs_init_context,
> +	.kill_sb = kill_litter_super
> +};
> +
> +static struct fs_context_operations fs_operations = {
> +	.get_tree = fs_get_tree
> +};
> +
> +static struct vfsmount *fs_mount;
> +
> +static int fs_mount_cnt;
> +
> +static struct dentry *external_dentry;
> +
> +struct control_commands {
> +	char *cmd;
> +	enum tsem_control_type type;
> +};
> +
> +static struct control_commands commands[9] = {
> +	{"internal", TSEM_CONTROL_INTERNAL},
> +	{"external", TSEM_CONTROL_EXTERNAL},
> +	{"enforce", TSEM_CONTROL_ENFORCE},
> +	{"seal", TSEM_CONTROL_SEAL},
> +	{"trusted ", TSEM_CONTROL_TRUSTED},
> +	{"untrusted ", TSEM_CONTROL_UNTRUSTED},
> +	{"state ", TSEM_CONTROL_MAP_STATE},
> +	{"pseudonym ", TSEM_CONTROL_MAP_PSEUDONYM},
> +	{"base ", TSEM_CONTROL_MAP_BASE}
> +};
> +
> +static bool can_access_fs(void)
> +{
> +	struct tsem_TMA_context *ctx = tsem_context(current);
> +
> +	if (ctx->external)
> +		return false;
> +	if (capable(TSEM_CONTROL_CAPABILITY))
> +		return true;
> +	if (ctx->sealed)
> +		return false;
> +	return true;
> +}
> +
> +static int control_COE(pid_t pid, unsigned long cmd)
> +{
> +	bool wakeup = false;
> +	int retn = -ESRCH;
> +	struct task_struct *COE;
> +	struct tsem_task *task;
> +
> +	rcu_read_lock();
> +	COE = find_task_by_vpid(pid);
> +	if (COE != NULL) {
> +		task = tsem_task(COE);
> +		if (cmd == TSEM_CONTROL_UNTRUSTED)
> +			task->trust_status = TSEM_TASK_UNTRUSTED;
> +		if (cmd == TSEM_CONTROL_TRUSTED) {
> +			task->trust_status &= ~TSEM_TASK_TRUST_PENDING;
> +			if (tsem_task_trusted(COE))
> +				task->trust_status = TSEM_TASK_TRUSTED;
> +		}
> +
> +		retn = 0;
> +		wakeup = true;
> +	}
> +	rcu_read_unlock();
> +
> +	if (wakeup)
> +		wake_up_process(COE);
> +
> +	return retn;
> +}
> +
> +static int config_context(unsigned long cmd, char *bufr)
> +{
> +	int retn = -EINVAL;
> +	unsigned int lp;
> +	struct tsem_TMA_context *ctx = tsem_context(current);
> +
> +	if (ctx->sealed)
> +		return -EPERM;
> +
> +	if (cmd == TSEM_CONTROL_SEAL) {
> +		ctx->sealed = true;
> +		retn = 0;
> +	}
> +
> +	if (cmd == TSEM_CONTROL_ENFORCE) {
> +		for (lp = 0; lp < ARRAY_SIZE(tsem_root_actions); ++lp)
> +			ctx->actions[lp] = TSEM_ACTION_EPERM;
> +		retn = 0;
> +	}
> +
> +	return retn;
> +}
> +
> +static int config_point(enum tsem_control_type type, u8 *arg)
> +{
> +	int retn = -EINVAL;
> +	u8 mapping[WP256_DIGEST_SIZE];
> +
> +	if (*++arg == '\0')
> +		goto done;
> +	if (strlen(arg) != sizeof(mapping) * 2)
> +		goto done;
> +	if (hex2bin(mapping, arg, sizeof(mapping)))
> +		goto done;
> +
> +	if (type == TSEM_CONTROL_MAP_STATE)
> +		retn = tsem_model_load_point(mapping);
> +	else if (type == TSEM_CONTROL_MAP_PSEUDONYM)
> +		retn = tsem_model_load_pseudonym(mapping);
> +	else {
> +		tsem_model_load_base(mapping);
> +		retn = 0;
> +	}
> +
> + done:
> +	return retn;
> +}
> +
> +static void show_event(struct seq_file *c, struct tsem_event *ep, char *file)
> +{
> +	seq_printf(c, "event{process=%s, filename=%s, type=%s, task_id=%*phN}",
> +		   ep->comm, file ? file : "none", tsem_names[ep->event],
> +		   WP256_DIGEST_SIZE, ep->task_id);
> +	seq_printf(c, " COE{uid=%d, euid=%d, suid=%d, gid=%d, egid=%d, sgid=%d, fsuid=%d, fsgid=%d, cap=0x%llx} ",
> +		   ep->COE.uid, ep->COE.euid, ep->COE.suid, ep->COE.gid,
> +		   ep->COE.egid, ep->COE.sgid, ep->COE.fsuid, ep->COE.fsgid,
> +		   ep->COE.capability.value);
> +}

You are printing out a lot of specific data in a specific format that is
documented no where that I can see :(

Also, you are making the same mistake that /proc made decades ago,
creating files that must be parsed and can NEVER be changed in the
future.  Why not make this a one-value-per-file filesystem instead so
that you have flexibility going forward?

> +static void show_file(struct seq_file *c, struct tsem_event *ep)
> +{
> +	seq_printf(c, "file{flags=%u, uid=%d, gid=%d, mode=0%o, name_length=%u, name=%*phN, s_magic=0x%0x, s_id=%s, s_uuid=%*phN, digest=%*phN}\n",
> +		   ep->file.flags, ep->file.uid, ep->file.gid, ep->file.mode,
> +		   ep->file.name_length, WP256_DIGEST_SIZE, ep->file.name,
> +		   ep->file.s_magic, ep->file.s_id,
> +		   (int) sizeof(ep->file.s_uuid), ep->file.s_uuid,
> +		   WP256_DIGEST_SIZE, ep->file.digest);

Same here, where is the documentation for all of this and what userspace
tools parse it?

thanks,

greg k-h
