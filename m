Return-Path: <SRS0=N8uA=4E=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46451C2BA83
	for <linux-security-module@archiver.kernel.org>; Sun, 16 Feb 2020 19:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0326C2072C
	for <linux-security-module@archiver.kernel.org>; Sun, 16 Feb 2020 19:27:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="ZAiwpY47"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726020AbgBPT1l (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 16 Feb 2020 14:27:41 -0500
Received: from sonic310-30.consmr.mail.ne1.yahoo.com ([66.163.186.211]:33018
        "EHLO sonic310-30.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725989AbgBPT1l (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 16 Feb 2020 14:27:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1581881259; bh=ELDqlQ03NQgB7oI6tUqGsOXSkVISQIcDeP06jk+R0gI=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=ZAiwpY47YwVThcPBpfeBL7wkTnXR3kOUMZFAae2z2lk0/9+QoCWpNpCaVnfg3YYqUprOt0IkyEoEyTcrwkO7itxVtmwfRqGYnLyLR+fGPCkt8Vrlg1okxykTF4+0Fi7Am5L/AuIuLTg6m1h/L8oH5pQRZkcuaBJIm2xpC2nt2ugxnpJvjTNToMRPw50PlP8OBEBlbvlMKjbSnFldpiRQFh8jR1pIoCHiLIdljEN4ctfDcHhqnCaJLRGaMZnJz8tLU3u2YdEPUsYgsBxsRFNok3gc33Wt0zEoolfoq64B3V72wAzda7bF+8slA+q7kVsZJHCYvl70sa7FfblM6hYb2Q==
X-YMail-OSG: z7eH8LkVM1nN9S_30k9rpisoZ8dLKu0MNrtBJIRkS4__2WK5d_gAnQIQl7baTSZ
 utK0Asx0gT4okxVtAe73W_Ikb8k9t86zUJ8UydkVS82TUGLTaqB6JeEULYlk7EkMoj2knw9dolr9
 br2c0RI0M97ESgQxWY_SYk_HOcDtIavhEZRTdvu8vmiqDYZupS1QsH5J1M4Z2iehUxC3HedtAz7m
 OSTeGaXVQJW920f9AzSjgfzYQVHG6Tji.YsoMTpgcByxNN1hIuw1dvL8Sr9y8ShwbumRXTOgVcQ1
 M.tHyZ84UKxNmXDrjbx5.mruMhBge4zmC79mKWyHu_lHEkoy1.NWBLEEQ43n5hB4rM.Zh.Iysqwo
 HB0e5yYM.DqyHw11vqbYtfszWEnvaXBxNUqCelmRNNwQud2ToSoR6KdJp4Ok29UTSerhhUCJ_p4l
 nZgLX45uI6DPRYrZQU3Ama7p.2oF_vix0ELUpfOzSjpDlYmEe23rz_tt4qWjCVSBnZyVoI1bgyfb
 ZQiVX_MQec1Y_ArfBAmqmgkBnsAQH73iPKy07FocYDJN7mTQo2ZPqm8ZAcU7ybeKIsFhT2yr0FMW
 wHrOmx5RavjZHTuVH8I15LoJ9m_OVmh2cPVvgIGKqhP9tPMMhByNwNXAqt_qc1BYpn3TFyAQz3Sm
 ENiswvcMpgeE8J0z.Fr2MwXSJKkI6xnoo8B2XP0vYLhuy4dJwKzsl0vSnjBvUhQxL4SX5JjAx30c
 8k6Plxs8A8wJ5N9w_z5PzJlKXvFrKGuPgVYSxjb931S30HyfvkhfFm7JJNZaPfLx8mYbOM2.UQIR
 srVXrtzgYszSSe.PhNLayCL4RmG7_nR2clB1h21gRZoWizTR5aopOkL0pVgV3Eoq7RwXYuWEYJUj
 ViDSwA1K2ITHDihbogJenVp1BHyS3LhjyHNPQJ88EvEYvMrzdCL_9eCoeQWnfuM3oWvlGIgMQcPq
 XAVf8deDI2Ees.azj6utQdm2ohP78MvAfOYNnL6wquZAEso.W6nOp_JZPdNXJJMaCurku4AaDwK.
 qLe2WJPQnvTg_U6fvA03OftQKNdzYPRu05QZvCJxXQOovqHqDdBZMapUGwe6vp7i0wIurVKsbexu
 trf3emFeZBhqRFtJxfvJMr6Pjm01KDogtsT1NSh6Gj_kHkRN54tna7o0apdN_EYvwyBGemiw.DNv
 03ngyYsuBvN8Ve3U1yU_lkkgXHmsOHny6FqYmRDcQPNVno_IxMI6bgpj3JZY9ZzsccHh7j60ZVqI
 J14tiT6Iapr4PJ.MXxwhnjMCrA6rQwuvwJnO4gDgCzZArji9Jl6MPwLAxAAN93EV77BYz3twwV__
 KC8vLO2dHeKtLlug9O7k.3dacdtTtbNOum2RoIx2_KKT8ZihrB_VgY5giYq3F2IYr2Wcj7htBeyE
 f6VxE5OZPkfJwNlgyIjLxmsYWIANzYmDpko38KPU-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Sun, 16 Feb 2020 19:27:39 +0000
Received: by smtp432.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID a3329b1f484036c1569512c99375b883;
          Sun, 16 Feb 2020 19:27:37 +0000 (UTC)
Subject: Re: [RFC PATCH] security: <linux/lsm_hooks.h>: fix all kernel-doc
 warnings
To:     Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Cc:     John Johansen <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Micah Morton <mortonm@chromium.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
References: <fb2c98bd-b579-6ad0-721a-56a4f81f0d6e@infradead.org>
From:   Casey Schaufler <casey@schaufler-ca.com>
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <16c14750-cbda-892c-c767-ef4e8b9125dd@schaufler-ca.com>
Date:   Sun, 16 Feb 2020 11:27:36 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <fb2c98bd-b579-6ad0-721a-56a4f81f0d6e@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailer: WebService/1.1.15199 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_181)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2/15/2020 11:08 PM, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
>
> Fix all kernel-doc warnings in <linux/lsm_hooks.h>.
> Fixes the following warnings:
>
> ../include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'quotactl' not described in 'security_list_options'
> ../include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'quota_on' not described in 'security_list_options'
> ../include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'sb_free_mnt_opts' not described in 'security_list_options'
> ../include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'sb_eat_lsm_opts' not described in 'security_list_options'
> ../include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'sb_kern_mount' not described in 'security_list_options'
> ../include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'sb_show_options' not described in 'security_list_options'
> ../include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'sb_add_mnt_opt' not described in 'security_list_options'
> ../include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'd_instantiate' not described in 'security_list_options'
> ../include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'getprocattr' not described in 'security_list_options'
> ../include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'setprocattr' not described in 'security_list_options'
> ../include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'locked_down' not described in 'security_list_options'
> ../include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'perf_event_open' not described in 'security_list_options'
> ../include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'perf_event_alloc' not described in 'security_list_options'
> ../include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'perf_event_free' not described in 'security_list_options'
> ../include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'perf_event_read' not described in 'security_list_options'
> ../include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'perf_event_write' not described in 'security_list_options'
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Acked-by: Casey Schaufler <casey@schaufler-ca.com>

Thank you very much.

> Cc: John Johansen <john.johansen@canonical.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Micah Morton <mortonm@chromium.org>
> Cc: James Morris <jmorris@namei.org>
> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> Cc: linux-security-module@vger.kernel.org
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Stephen Smalley <sds@tycho.nsa.gov>
> Cc: Eric Paris <eparis@parisplace.org>
> Cc: Casey Schaufler <casey@schaufler-ca.com>
> Cc: Kentaro Takeda <takedakn@nttdata.co.jp>
> Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
> Notes:
> a. The location for some of these might need to be modified.
> b. 'locked_down' was just missing a final ':'.
> c. Added a new section: Security hooks for perf events.
>
>  include/linux/lsm_hooks.h |   36 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 35 insertions(+), 1 deletion(-)
>
> --- lnx-56-rc1.orig/include/linux/lsm_hooks.h
> +++ lnx-56-rc1/include/linux/lsm_hooks.h
> @@ -103,6 +103,10 @@
>   * @sb_free_security:
>   *	Deallocate and clear the sb->s_security field.
>   *	@sb contains the super_block structure to be modified.
> + * @sb_free_mnt_opts:
> + * 	Free memory associated with @mnt_ops.
> + * @sb_eat_lsm_opts:
> + * 	Eat (scan @orig options) and save them in @mnt_opts.
>   * @sb_statfs:
>   *	Check permission before obtaining filesystem statistics for the @mnt
>   *	mountpoint.
> @@ -136,6 +140,10 @@
>   *	@sb superblock being remounted
>   *	@data contains the filesystem-specific data.
>   *	Return 0 if permission is granted.
> + * @sb_kern_mount:
> + * 	Mount this @sb if allowed by permissions.
> + * @sb_show_options:
> + * 	Show (print on @m) mount options for this @sb.
>   * @sb_umount:
>   *	Check permission before the @mnt file system is unmounted.
>   *	@mnt contains the mounted file system.
> @@ -155,6 +163,8 @@
>   *	Copy all security options from a given superblock to another
>   *	@oldsb old superblock which contain information to clone
>   *	@newsb new superblock which needs filled in
> + * @sb_add_mnt_opt:
> + * 	Add one mount @option to @mnt_opts.
>   * @sb_parse_opts_str:
>   *	Parse a string of security data filling in the opts structure
>   *	@options string containing all mount options known by the LSM
> @@ -451,6 +461,12 @@
>   *	security module does not know about attribute or a negative error code
>   *	to abort the copy up. Note that the caller is responsible for reading
>   *	and writing the xattrs as this hook is merely a filter.
> + * @d_instantiate:
> + * 	Fill in @inode security information for a @dentry if allowed.
> + * @getprocattr:
> + * 	Read attribute @name for process @p and store it into @value if allowed.
> + * @setprocattr:
> + * 	Write (set) attribute @name to @value, size @size if allowed.
>   *
>   * Security hooks for kernfs node operations
>   *
> @@ -1113,6 +1129,7 @@
>   *	In case of failure, @secid will be set to zero.
>   *
>   * Security hooks for individual messages held in System V IPC message queues
> + *
>   * @msg_msg_alloc_security:
>   *	Allocate and attach a security structure to the msg->security field.
>   *	The security field is initialized to NULL when the structure is first
> @@ -1302,6 +1319,10 @@
>   *	@cap contains the capability <include/linux/capability.h>.
>   *	@opts contains options for the capable check <include/linux/security.h>
>   *	Return 0 if the capability is granted for @tsk.
> + * @quotactl:
> + * 	Check whether the quotactl syscall is allowed for this @sb.
> + * @quota_on:
> + * 	Check whether QUOTAON is allowed for this @dentry.
>   * @syslog:
>   *	Check permission before accessing the kernel message ring or changing
>   *	logging to the console.
> @@ -1449,11 +1470,24 @@
>   * @bpf_prog_free_security:
>   *	Clean up the security information stored inside bpf prog.
>   *
> - * @locked_down
> + * @locked_down:
>   *     Determine whether a kernel feature that potentially enables arbitrary
>   *     code execution in kernel space should be permitted.
>   *
>   *     @what: kernel feature being accessed
> + *
> + * Security hooks for perf events
> + *
> + * @perf_event_open:
> + * 	Check whether the @type of perf_event_open syscall is allowed.
> + * @perf_event_alloc:
> + * 	Allocate and save perf_event security info.
> + * @perf_event_free:
> + * 	Release (free) perf_event security info.
> + * @perf_event_read:
> + * 	Read perf_event security info if allowed.
> + * @perf_event_write:
> + * 	Write perf_event security info if allowed.
>   */
>  union security_list_options {
>  	int (*binder_set_context_mgr)(struct task_struct *mgr);
>
