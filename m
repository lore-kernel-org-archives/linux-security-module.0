Return-Path: <SRS0=wNUX=P2=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E1AC07EBF
	for <linux-security-module@archiver.kernel.org>; Fri, 18 Jan 2019 19:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA6682086D
	for <linux-security-module@archiver.kernel.org>; Fri, 18 Jan 2019 19:20:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="iAqwyMRp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728457AbfARTUA (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 18 Jan 2019 14:20:00 -0500
Received: from sonic309-27.consmr.mail.gq1.yahoo.com ([98.137.65.153]:38992
        "EHLO sonic309-27.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728288AbfARTUA (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 18 Jan 2019 14:20:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1547839198; bh=WIyFm99781bcRUJDtd4EbsDAVt0IMOV/KW+hwNszvY8=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=iAqwyMRpRzmM8OjtfD7iKHe2GDas7hUkAtcx2ek5X23mrnq9gZ7lNzrMM6s+rZw16RB8e/eW8atgJcBl4nBMEk/+lnNJ13BatAnE+5Bch1NH9PBNrQn6X4r2xAiFSmIpy7NNuftA9Vi3ibtRXYy12CtscRDEtbYO9Gjyd2l7HKiZrRvJebLgKh7/oo+k8JHsuO5FGR8STCEJ3V5I7uVs6BUz96W720QNcGnZI1CGysQWLzizjIdouimSk5Pbw5dtBNqMJVqPaT85rAQrYE2WI8XLMFwmxbWV0VxlQEVLJKaO4Cnhy5hPXIda+uWXcOdFauMFC3w23Esjme4D7P127g==
X-YMail-OSG: xj46g2UVM1lgK4VDwUvVfcVD1WgPiNBwrNNN4TU1.CuAcUe2JgoV5K8BMGoGka0
 HqgLdy77iTl2Ys8upjQ7Jp31gWHcwh8b5RFux9_1eggQuthphEmfL52n9fbarxTwN5QVjamrvtRT
 n8O5oJhuY.8MWf8DMQ6Hr9R7DNUCbBv384qvqaew7TC_ayLXlYCHxDlHklZum5oKpn7uBuqnFKb8
 gETOj6CDD2KtsHekyYBjXBIH3XUzbqPlWn8dYxTsc50yf1T.OmU7wLwnae4sK6_WNrCKtiw3gxOp
 gvTr6deTV.ALS0ofgI.Tr2xtx45XDmOVZiWh.iWh8NNwXRhwdZDumrS9ENsgf0g9rm1351ZQgnV3
 ZyTiU_wk8TSepqW84MvwBWcZyW6WrvV7N.frgIooEcxjzZ3cPqm0rU9OIoe500Yq5yDggoQHJ3_K
 dnIG_tJHI3QI8CDwN6WQfY5y5tPV6jLGX9SV5y.rWki.IjcJUu.O0iCh6Iu3EjrRodHxDX4M5Diw
 MTiCEHySOnH0NvvzmGPFvTm3DoLciUouXNLSyxapOXFgTSITQ77tD_UNx8ubjxrrjgpP2HlNoU8r
 jml8bznPrAU_8Y8RfxhcwuNlfKbxCoQsdciz5XF._ovMAZDdXvRHYDqw6dFLxkXQWfb2HL8FNhnX
 uRz3xZiqnp66z.mndAX..b2SnRtEkDTIKxCnmXz9tzXEr_4oxll2yKor7raRKn9hCF3NiZRjSNem
 f.jykw4JQgVSm6s_bq9.fScul6UumUKQo4dqKc8dFlecofT7GI0zOaFZLVMuZTyVO2hw4lo.EWNC
 UZOXGxu62YZWMw2YjYIBEuc233n4flUHs8ofPFUhc65nlRQAYvZr7dTrOJaRKyRXcijiiVE3Eojq
 jQBxV6kN11JM1eBiKr8GmK9MYe75_AByC38zGiv88PenrCykHdbQOAavq6fuJShDS8meS5x5cqmR
 eZX1kZ_sOOmnfS9Fu_7fEs2fu3PJQ3a0KCVSX0ig3PESzuDVn61JgvN3RbjGmjUZv0RtJw0_04rt
 r05mwvVjY1vteOzBBVhsXDFFpFWNZ8c3V7Ixwt2CHFvO1Z1B3DAC5izHwGVHLohG_6xd6myuv94M
 aF3AHttp1Tmp3XclXDyET4Jd2NUpSKyhp9ZP6sW3VzsTraf7SZ2Ou
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.gq1.yahoo.com with HTTP; Fri, 18 Jan 2019 19:19:58 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.100]) ([67.169.65.224])
          by smtp404.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 3ca02b9df408c4d2e0c7c0ee537d9512;
          Fri, 18 Jan 2019 19:19:55 +0000 (UTC)
Subject: Re: [PATCH] LSM: Make lsm_early_cred() and lsm_early_task() local
 functions.
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-security-module@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
References: <1547806559-12097-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <95665863-5ac8-99d0-bb58-48481399b88a@schaufler-ca.com>
Date:   Fri, 18 Jan 2019 11:19:54 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1547806559-12097-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 1/18/2019 2:15 AM, Tetsuo Handa wrote:
> Since current->cred == current->real_cred when ordered_lsm_init()
> is called, and lsm_early_cred()/lsm_early_task() need to be called
> between the amount of required bytes is determined and module specific
> initialization function is called, we can move these calls from
> individual modules to ordered_lsm_init().
>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

Seems to work fine to me.

Acked-by: Casey Schaufler <casey@schaufler-ca.com>

> ---
>  include/linux/lsm_hooks.h  |  5 -----
>  security/apparmor/lsm.c    |  2 --
>  security/security.c        | 27 +++++++++++----------------
>  security/selinux/hooks.c   |  1 -
>  security/smack/smack_lsm.c |  2 --
>  security/tomoyo/tomoyo.c   |  1 -
>  6 files changed, 11 insertions(+), 27 deletions(-)
>
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index c753d06..b3e94bc 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -2133,9 +2133,4 @@ static inline void security_delete_hooks(struct security_hook_list *hooks,
>  
>  extern int lsm_inode_alloc(struct inode *inode);
>  
> -#ifdef CONFIG_SECURITY
> -void __init lsm_early_cred(struct cred *cred);
> -void __init lsm_early_task(struct task_struct *task);
> -#endif
> -
>  #endif /* ! __LINUX_LSM_HOOKS_H */
> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index dff7f94..49d664d 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -1484,8 +1484,6 @@ static int __init set_init_ctx(void)
>  {
>  	struct cred *cred = (struct cred *)current->real_cred;
>  
> -	lsm_early_cred(cred);
> -	lsm_early_task(current);
>  	set_cred_label(cred, aa_get_label(ns_unconfined(root_ns)));
>  
>  	return 0;
> diff --git a/security/security.c b/security/security.c
> index 9a98c52..8c09334 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -278,6 +278,9 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
>  	kfree(sep);
>  }
>  
> +static void __init lsm_early_cred(struct cred *cred);
> +static void __init lsm_early_task(struct task_struct *task);
> +
>  static void __init ordered_lsm_init(void)
>  {
>  	struct lsm_info **lsm;
> @@ -312,6 +315,8 @@ static void __init ordered_lsm_init(void)
>  						    blob_sizes.lbs_inode, 0,
>  						    SLAB_PANIC, NULL);
>  
> +	lsm_early_cred((struct cred *) current->cred);
> +	lsm_early_task(current);
>  	for (lsm = ordered_lsms; *lsm; lsm++)
>  		initialize_lsm(*lsm);
>  
> @@ -465,17 +470,12 @@ static int lsm_cred_alloc(struct cred *cred, gfp_t gfp)
>   * lsm_early_cred - during initialization allocate a composite cred blob
>   * @cred: the cred that needs a blob
>   *
> - * Allocate the cred blob for all the modules if it's not already there
> + * Allocate the cred blob for all the modules
>   */
> -void __init lsm_early_cred(struct cred *cred)
> +static void __init lsm_early_cred(struct cred *cred)
>  {
> -	int rc;
> +	int rc = lsm_cred_alloc(cred, GFP_KERNEL);
>  
> -	if (cred == NULL)
> -		panic("%s: NULL cred.\n", __func__);
> -	if (cred->security != NULL)
> -		return;
> -	rc = lsm_cred_alloc(cred, GFP_KERNEL);
>  	if (rc)
>  		panic("%s: Early cred alloc failed.\n", __func__);
>  }
> @@ -589,17 +589,12 @@ int lsm_msg_msg_alloc(struct msg_msg *mp)
>   * lsm_early_task - during initialization allocate a composite task blob
>   * @task: the task that needs a blob
>   *
> - * Allocate the task blob for all the modules if it's not already there
> + * Allocate the task blob for all the modules
>   */
> -void __init lsm_early_task(struct task_struct *task)
> +static void __init lsm_early_task(struct task_struct *task)
>  {
> -	int rc;
> +	int rc = lsm_task_alloc(task);
>  
> -	if (task == NULL)
> -		panic("%s: task cred.\n", __func__);
> -	if (task->security != NULL)
> -		return;
> -	rc = lsm_task_alloc(task);
>  	if (rc)
>  		panic("%s: Early task alloc failed.\n", __func__);
>  }
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 2332243..d0fa81c 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -209,7 +209,6 @@ static void cred_init_security(void)
>  	struct cred *cred = (struct cred *) current->real_cred;
>  	struct task_security_struct *tsec;
>  
> -	lsm_early_cred(cred);
>  	tsec = selinux_cred(cred);
>  	tsec->osid = tsec->sid = SECINITSID_KERNEL;
>  }
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index a326cd9..fa98394 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -4772,8 +4772,6 @@ static __init int smack_init(void)
>  	if (!smack_inode_cache)
>  		return -ENOMEM;
>  
> -	lsm_early_cred(cred);
> -
>  	/*
>  	 * Set the security state for the initial task.
>  	 */
> diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
> index 066c0da..2b3eee0 100644
> --- a/security/tomoyo/tomoyo.c
> +++ b/security/tomoyo/tomoyo.c
> @@ -566,7 +566,6 @@ static int __init tomoyo_init(void)
>  	/* register ourselves with the security framework */
>  	security_add_hooks(tomoyo_hooks, ARRAY_SIZE(tomoyo_hooks), "tomoyo");
>  	printk(KERN_INFO "TOMOYO Linux initialized\n");
> -	lsm_early_cred(cred);
>  	blob = tomoyo_cred(cred);
>  	*blob = &tomoyo_kernel_domain;
>  	tomoyo_mm_init();
