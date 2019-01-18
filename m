Return-Path: <SRS0=wNUX=P2=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E403C43387
	for <linux-security-module@archiver.kernel.org>; Fri, 18 Jan 2019 17:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E16682086D
	for <linux-security-module@archiver.kernel.org>; Fri, 18 Jan 2019 17:01:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="MSCAx08G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbfARRBO (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 18 Jan 2019 12:01:14 -0500
Received: from sonic309-27.consmr.mail.gq1.yahoo.com ([98.137.65.153]:46319
        "EHLO sonic309-27.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727491AbfARRBO (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 18 Jan 2019 12:01:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1547830872; bh=9Tl4Uk0BN1aVFByv2UuoTMXQp5eGAf3XLyqE/ii2l3A=; h=Subject:To:References:From:Date:In-Reply-To:From:Subject; b=MSCAx08GFZqlnCpIJofpqYFpXpEXl/5Nove3As8Oj3QydUeO8ffDKwcPlD+tr0m/9TDDGc4PhwyI44VyPAxm1eGy1OOjwIP6x+Dm+4LjvfOvGdsHd2ykHEDBG1gK1xx5fU+1DmtlvWEM1Z4JfyMDChTWvfz8eNsb7NHGjUGqL08LCFg7hLMBwsxxNKT2/7Hw+rIvcDA9n4Qhlf3xd1Jp5n5hwqVAqcX+xPJfdapi5PKLE+AyCYaYRIFSkuHmzOJx/Y8K1h2MwKhZ33xeJ9wYbuFvFV8blNA4zWQDNxsopHCvt5YUuZ2ngKKPiyQb4KCj7o8dQFezIQhLHyawsklywA==
X-YMail-OSG: c2kHzTcVM1kKlTEMyHWhlXNiJHLtuCQlVY5ryoEF76SSHi0tpaFR.E_frPkAllm
 UqnDXOhKuZgYC.hJFGhm.Ge_PzYcm5gpjLi638p1vFcpE1EFX2Fs8KmPDfOLSCbBBsS3igrpQqgR
 y_OcVl.4v_mbYQMibLMB91dYS6bs0z6SV6KIR8vmWnNkVLrCxPrlePVv5FuC5ybsDyBngf9087pf
 aSoWo08xjuzr0qxMOkbg0.oGrpu9DUzgSra.N_I2c.KYVObB4xC.4SvFwnlcfYuOT1Ql61jMpuij
 JwmVuGlt8hipsn3sBB1wGwufNjtUYQcJ2HUmz0a4GLMTlGeoBmT2GeTtCo1lQzBJRFAkB1v3S8I7
 0LHrTAoelE3Wvkj3loXK15PVYyckVG_A4pSF8Abt_D2SICfhWfs28FUo7.d_.WPHt80fD.gxBW78
 gTzZI8CSi2vwBB64ctYsomOudTFB4.MwNZQ_V0cHuNjfW9T2MPaXk.Vr4wYr3ccRbO8vxq8ERoyY
 _3FKXKbV6qoi9G4KL0FarpNQX_HMwGqU9bjQk6qNbCBE.dLD6W_wAP3Ebe5DZ9MuXVRYRuoRqd4V
 1RiexkZaosE.1B7ndwbFXFjRoXG01pEXmGcGPkbvqykKfSXEa_XalNsS0SpiXvHIQN.Cr0XaQBQ4
 0X34DzFzd6tgDocSknihNnKOIUm47iqhJhXJxprMkcgQUvFd3noPViSGuvJUBDeHxTLfAiTJAnIH
 kR78DY..7xe6bgMW2ZiV39LIDZstBDy0PO7.CCtMXt00dJdTpMy.x41IpMHr0ZjyptEQA_octXNa
 IOWc4yVgZolfduM4kdoijdToNn4Sjwy9m4BcnKLMZfIgkw9zNQYfDWaERK1X0.XvO6zmdhrTakqJ
 NMFsa8wg7Mco7GfSlQoSzPP3UAX_CvvqZ0Gmmat7vc_a85r7aupw86tnKQFB_jAY2_3NtTr_2BZb
 Idn3E51gDzREjJdP4Oe2o4IyiKmvVyMqqmnhM2elxinHTxkilciRjaggM.HMZ3SVHBo2j3sDF.3b
 bY0cW.SOaymqrnBW5k57Nzcr8MSeO3SC3tBjkWZFvB4h9W9MQmatAtMSPqrXs19VQgmc4n38zMim
 .FjfYzqa.Mjgz
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.gq1.yahoo.com with HTTP; Fri, 18 Jan 2019 17:01:12 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.100]) ([67.169.65.224])
          by smtp418.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 3dc2a6cae5338304ea3e475b5a5a745a;
          Fri, 18 Jan 2019 17:01:10 +0000 (UTC)
Subject: Re: [PATCH] tomoyo: Swicth from cred->security to
 task_struct->security.
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        linux-security-module@vger.kernel.org
References: <1547806711-13571-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <ae8a9cbb-bca6-f850-d4c4-6abe61a4d9bf@schaufler-ca.com>
Date:   Fri, 18 Jan 2019 09:01:05 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1547806711-13571-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 1/18/2019 2:18 AM, Tetsuo Handa wrote:
> TOMOYO security module is designed to use "struct task_struct"->security
> in order to allow per "struct task_struct" tracking without being disturbed
> by unable to update "struct cred"->security due to override mechanism.
>
> Now that infrastructure-managed security blob is ready, this patch updates
> TOMOYO to use "struct task_struct"->security.
>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
>  security/tomoyo/common.c        |   4 +-
>  security/tomoyo/common.h        |  43 ++++--------
>  security/tomoyo/domain.c        |  11 +--
>  security/tomoyo/securityfs_if.c |  22 +++---
>  security/tomoyo/tomoyo.c        | 144 ++++++++++++++++++----------------------
>  5 files changed, 95 insertions(+), 129 deletions(-)
>
> diff --git a/security/tomoyo/common.c b/security/tomoyo/common.c
> index c598aa0..877cf8a 100644
> --- a/security/tomoyo/common.c
> +++ b/security/tomoyo/common.c
> @@ -986,7 +986,7 @@ static bool tomoyo_select_domain(struct tomoyo_io_buffer *head,
>  		else
>  			p = find_task_by_vpid(pid);
>  		if (p)
> -			domain = tomoyo_real_domain(p);
> +			domain = tomoyo_security(p)->domain_info;
>  		rcu_read_unlock();
>  	} else if (!strncmp(data, "domain=", 7)) {
>  		if (tomoyo_domain_def(data + 7))
> @@ -1668,7 +1668,7 @@ static void tomoyo_read_pid(struct tomoyo_io_buffer *head)
>  	else
>  		p = find_task_by_vpid(pid);
>  	if (p)
> -		domain = tomoyo_real_domain(p);
> +		domain = tomoyo_security(p)->domain_info;
>  	rcu_read_unlock();
>  	if (!domain)
>  		return;
> diff --git a/security/tomoyo/common.h b/security/tomoyo/common.h
> index 4fc1729..f19ed53 100644
> --- a/security/tomoyo/common.h
> +++ b/security/tomoyo/common.h
> @@ -686,7 +686,7 @@ struct tomoyo_domain_info {
>  	u8 group;          /* Group number to use.   */
>  	bool is_deleted;   /* Delete flag.           */
>  	bool flags[TOMOYO_MAX_DOMAIN_INFO_FLAGS];
> -	atomic_t users; /* Number of referring credentials. */
> +	atomic_t users; /* Number of referring tasks. */
>  };
>  
>  /*
> @@ -913,6 +913,12 @@ struct tomoyo_policy_namespace {
>  	const char *name;
>  };
>  
> +/* Structure for "struct task_struct"->security. */
> +struct tomoyo_security {
> +	struct tomoyo_domain_info *domain_info;
> +	struct tomoyo_domain_info *old_domain_info;
> +};
> +
>  /********** Function prototypes. **********/
>  
>  bool tomoyo_address_matches_group(const bool is_ipv6, const __be32 *address,
> @@ -1021,6 +1027,7 @@ ssize_t tomoyo_write_control(struct tomoyo_io_buffer *head,
>  struct tomoyo_condition *tomoyo_get_condition(struct tomoyo_acl_param *param);
>  struct tomoyo_domain_info *tomoyo_assign_domain(const char *domainname,
>  						const bool transit);
> +struct tomoyo_domain_info *tomoyo_domain(void);
>  struct tomoyo_domain_info *tomoyo_find_domain(const char *domainname);
>  struct tomoyo_group *tomoyo_get_group(struct tomoyo_acl_param *param,
>  				      const u8 idx);
> @@ -1200,41 +1207,15 @@ static inline void tomoyo_put_group(struct tomoyo_group *group)
>  }
>  
>  /**
> - * tomoyo_cred - Get a pointer to the tomoyo cred security blob
> - * @cred - the relevant cred
> - *
> - * Returns pointer to the tomoyo cred blob.
> - */
> -static inline struct tomoyo_domain_info **tomoyo_cred(const struct cred *cred)
> -{
> -	return cred->security + tomoyo_blob_sizes.lbs_cred;
> -}
> -
> -/**
> - * tomoyo_domain - Get "struct tomoyo_domain_info" for current thread.
> + * tomoyo_security - Get "struct tomoyo_security" for specified thread.
>   *
> - * Returns pointer to "struct tomoyo_domain_info" for current thread.
> - */
> -static inline struct tomoyo_domain_info *tomoyo_domain(void)
> -{
> -	struct tomoyo_domain_info **blob = tomoyo_cred(current_cred());
> -
> -	return *blob;
> -}
> -
> -/**
> - * tomoyo_real_domain - Get "struct tomoyo_domain_info" for specified thread.
> - *
> - * @task: Pointer to "struct task_struct".
> + * @task - Pointer to "struct task_struct".
>   *
>   * Returns pointer to "struct tomoyo_security" for specified thread.
>   */
> -static inline struct tomoyo_domain_info *tomoyo_real_domain(struct task_struct
> -							    *task)
> +static inline struct tomoyo_security *tomoyo_security(struct task_struct *task)

Could you use tomoyo_task() instead of tomoyo_security()?
To the extent that it's been possible I've worked to add
consistency in the security modules, and this breaks it.

>  {
> -	struct tomoyo_domain_info **blob = tomoyo_cred(get_task_cred(task));
> -
> -	return *blob;
> +	return task->security + tomoyo_blob_sizes.lbs_task;
>  }
>  
>  /**
> diff --git a/security/tomoyo/domain.c b/security/tomoyo/domain.c
> index b7469fd..05f470e 100644
> --- a/security/tomoyo/domain.c
> +++ b/security/tomoyo/domain.c
> @@ -678,7 +678,6 @@ static int tomoyo_environ(struct tomoyo_execve *ee)
>   */
>  int tomoyo_find_next_domain(struct linux_binprm *bprm)
>  {
> -	struct tomoyo_domain_info **blob;
>  	struct tomoyo_domain_info *old_domain = tomoyo_domain();
>  	struct tomoyo_domain_info *domain = NULL;
>  	const char *original_name = bprm->filename;
> @@ -843,9 +842,13 @@ int tomoyo_find_next_domain(struct linux_binprm *bprm)
>  	if (!domain)
>  		domain = old_domain;
>  	/* Update reference count on "struct tomoyo_domain_info". */
> -	atomic_inc(&domain->users);
> -	blob = tomoyo_cred(bprm->cred);
> -	*blob = domain;
> +	{
> +		struct tomoyo_security *s = tomoyo_security(current);
> +
> +		s->old_domain_info = s->domain_info;
> +		s->domain_info = domain;
> +		atomic_inc(&domain->users);
> +	}
>  	kfree(exename.name);
>  	if (!retval) {
>  		ee->r.domain = domain;
> diff --git a/security/tomoyo/securityfs_if.c b/security/tomoyo/securityfs_if.c
> index 768dff9..2bf634c 100644
> --- a/security/tomoyo/securityfs_if.c
> +++ b/security/tomoyo/securityfs_if.c
> @@ -67,21 +67,15 @@ static ssize_t tomoyo_write_self(struct file *file, const char __user *buf,
>  			if (!new_domain) {
>  				error = -ENOENT;
>  			} else {
> -				struct cred *cred = prepare_creds();
> -				if (!cred) {
> -					error = -ENOMEM;
> -				} else {
> -					struct tomoyo_domain_info **blob;
> -					struct tomoyo_domain_info *old_domain;
> +				struct tomoyo_security *s =
> +					tomoyo_security(current);
> +				struct tomoyo_domain_info *old_domain =
> +					s->domain_info;
>  
> -					blob = tomoyo_cred(cred);
> -					old_domain = *blob;
> -					*blob = new_domain;
> -					atomic_inc(&new_domain->users);
> -					atomic_dec(&old_domain->users);
> -					commit_creds(cred);
> -					error = 0;
> -				}
> +				s->domain_info = new_domain;
> +				atomic_inc(&new_domain->users);
> +				atomic_dec(&old_domain->users);
> +				error = 0;
>  			}
>  		}
>  		tomoyo_read_unlock(idx);
> diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
> index 2b3eee0..77da989 100644
> --- a/security/tomoyo/tomoyo.c
> +++ b/security/tomoyo/tomoyo.c
> @@ -9,19 +9,19 @@
>  #include "common.h"
>  
>  /**
> - * tomoyo_cred_alloc_blank - Target for security_cred_alloc_blank().
> + * tomoyo_domain - Get "struct tomoyo_domain_info" for current thread.
>   *
> - * @new: Pointer to "struct cred".
> - * @gfp: Memory allocation flags.
> - *
> - * Returns 0.
> + * Returns pointer to "struct tomoyo_domain_info" for current thread.
>   */
> -static int tomoyo_cred_alloc_blank(struct cred *new, gfp_t gfp)
> +struct tomoyo_domain_info *tomoyo_domain(void)
>  {
> -	struct tomoyo_domain_info **blob = tomoyo_cred(new);
> +	struct tomoyo_security *s = tomoyo_security(current);
>  
> -	*blob = NULL;
> -	return 0;
> +	if (s->old_domain_info && !current->in_execve) {
> +		atomic_dec(&s->old_domain_info->users);
> +		s->old_domain_info = NULL;
> +	}
> +	return s->domain_info;
>  }
>  
>  /**
> @@ -36,85 +36,36 @@ static int tomoyo_cred_alloc_blank(struct cred *new, gfp_t gfp)
>  static int tomoyo_cred_prepare(struct cred *new, const struct cred *old,
>  			       gfp_t gfp)
>  {
> -	struct tomoyo_domain_info **old_blob = tomoyo_cred(old);
> -	struct tomoyo_domain_info **new_blob = tomoyo_cred(new);
> -	struct tomoyo_domain_info *domain;
> -
> -	domain = *old_blob;
> -	*new_blob = domain;
> -
> -	if (domain)
> -		atomic_inc(&domain->users);
> +	/* To clear old_domain_info saved by previous execve() request. */
> +	tomoyo_domain();
>  	return 0;
>  }
>  
> -/**
> - * tomoyo_cred_transfer - Target for security_transfer_creds().
> - *
> - * @new: Pointer to "struct cred".
> - * @old: Pointer to "struct cred".
> - */
> -static void tomoyo_cred_transfer(struct cred *new, const struct cred *old)
> -{
> -	tomoyo_cred_prepare(new, old, 0);
> -}
> -
> -/**
> - * tomoyo_cred_free - Target for security_cred_free().
> - *
> - * @cred: Pointer to "struct cred".
> - */
> -static void tomoyo_cred_free(struct cred *cred)
> -{
> -	struct tomoyo_domain_info **blob = tomoyo_cred(cred);
> -	struct tomoyo_domain_info *domain = *blob;
> -
> -	if (domain)
> -		atomic_dec(&domain->users);
> -}
> -
> +#ifndef CONFIG_SECURITY_TOMOYO_OMIT_USERSPACE_LOADER
>  /**
>   * tomoyo_bprm_set_creds - Target for security_bprm_set_creds().
>   *
>   * @bprm: Pointer to "struct linux_binprm".
>   *
> - * Returns 0 on success, negative value otherwise.
> + * Returns 0.
>   */
>  static int tomoyo_bprm_set_creds(struct linux_binprm *bprm)
>  {
> -	struct tomoyo_domain_info **blob;
> -	struct tomoyo_domain_info *domain;
> -
>  	/*
>  	 * Do only if this function is called for the first time of an execve
>  	 * operation.
>  	 */
>  	if (bprm->called_set_creds)
>  		return 0;
> -#ifndef CONFIG_SECURITY_TOMOYO_OMIT_USERSPACE_LOADER
>  	/*
>  	 * Load policy if /sbin/tomoyo-init exists and /sbin/init is requested
>  	 * for the first time.
>  	 */
>  	if (!tomoyo_policy_loaded)
>  		tomoyo_load_policy(bprm->filename);
> -#endif
> -	/*
> -	 * Release reference to "struct tomoyo_domain_info" stored inside
> -	 * "bprm->cred->security". New reference to "struct tomoyo_domain_info"
> -	 * stored inside "bprm->cred->security" will be acquired later inside
> -	 * tomoyo_find_next_domain().
> -	 */
> -	blob = tomoyo_cred(bprm->cred);
> -	domain = *blob;
> -	atomic_dec(&domain->users);
> -	/*
> -	 * Tell tomoyo_bprm_check_security() is called for the first time of an
> -	 * execve operation.
> -	 */
> -	*blob = NULL;
>  	return 0;
>  }
> +#endif
>  
>  /**
>   * tomoyo_bprm_check_security - Target for security_bprm_check().
> @@ -125,16 +76,13 @@ static int tomoyo_bprm_set_creds(struct linux_binprm *bprm)
>   */
>  static int tomoyo_bprm_check_security(struct linux_binprm *bprm)
>  {
> -	struct tomoyo_domain_info **blob;
> -	struct tomoyo_domain_info *domain;
> +	struct tomoyo_security *s = tomoyo_security(current);
>  
> -	blob = tomoyo_cred(bprm->cred);
> -	domain = *blob;
>  	/*
>  	 * Execute permission is checked against pathname passed to do_execve()
>  	 * using current domain.
>  	 */
> -	if (!domain) {
> +	if (!s->old_domain_info) {
>  		const int idx = tomoyo_read_lock();
>  		const int err = tomoyo_find_next_domain(bprm);
>  		tomoyo_read_unlock(idx);
> @@ -143,8 +91,8 @@ static int tomoyo_bprm_check_security(struct linux_binprm *bprm)
>  	/*
>  	 * Read permission is checked against interpreters using next domain.
>  	 */
> -	return tomoyo_check_open_permission(domain, &bprm->file->f_path,
> -					    O_RDONLY);
> +	return tomoyo_check_open_permission(s->domain_info,
> +					    &bprm->file->f_path, O_RDONLY);
>  }
>  
>  /**
> @@ -510,19 +458,59 @@ static int tomoyo_socket_sendmsg(struct socket *sock, struct msghdr *msg,
>  }
>  
>  struct lsm_blob_sizes tomoyo_blob_sizes __lsm_ro_after_init = {
> -	.lbs_cred = sizeof(struct tomoyo_domain_info *),
> +	.lbs_task = sizeof(struct tomoyo_security),
>  };
>  
> +/**
> + * tomoyo_task_alloc - Target for security_task_alloc().
> + *
> + * @task:  Pointer to "struct task_struct".
> + * @flags: clone() flags.
> + *
> + * Returns 0.
> + */
> +static int tomoyo_task_alloc(struct task_struct *task,
> +			     unsigned long clone_flags)
> +{
> +	struct tomoyo_security *old = tomoyo_security(current);
> +	struct tomoyo_security *new = tomoyo_security(task);
> +
> +	new->domain_info = old->domain_info;
> +	atomic_inc(&new->domain_info->users);
> +	new->old_domain_info = NULL;
> +	return 0;
> +}
> +
> +/**
> + * tomoyo_task_free - Target for security_task_free().
> + *
> + * @task: Pointer to "struct task_struct".
> + */
> +static void tomoyo_task_free(struct task_struct *task)
> +{
> +	struct tomoyo_security *s = tomoyo_security(task);
> +
> +	if (s->domain_info) {
> +		atomic_dec(&s->domain_info->users);
> +		s->domain_info = NULL;
> +	}
> +	if (s->old_domain_info) {
> +		atomic_dec(&s->old_domain_info->users);
> +		s->old_domain_info = NULL;
> +	}
> +}
> +
>  /*
>   * tomoyo_security_ops is a "struct security_operations" which is used for
>   * registering TOMOYO.
>   */
>  static struct security_hook_list tomoyo_hooks[] __lsm_ro_after_init = {
> -	LSM_HOOK_INIT(cred_alloc_blank, tomoyo_cred_alloc_blank),
>  	LSM_HOOK_INIT(cred_prepare, tomoyo_cred_prepare),
> -	LSM_HOOK_INIT(cred_transfer, tomoyo_cred_transfer),
> -	LSM_HOOK_INIT(cred_free, tomoyo_cred_free),
> +	LSM_HOOK_INIT(task_alloc, tomoyo_task_alloc),
> +	LSM_HOOK_INIT(task_free, tomoyo_task_free),
> +#ifndef CONFIG_SECURITY_TOMOYO_OMIT_USERSPACE_LOADER
>  	LSM_HOOK_INIT(bprm_set_creds, tomoyo_bprm_set_creds),
> +#endif
>  	LSM_HOOK_INIT(bprm_check_security, tomoyo_bprm_check_security),
>  	LSM_HOOK_INIT(file_fcntl, tomoyo_file_fcntl),
>  	LSM_HOOK_INIT(file_open, tomoyo_file_open),
> @@ -560,14 +548,14 @@ struct lsm_blob_sizes tomoyo_blob_sizes __lsm_ro_after_init = {
>   */
>  static int __init tomoyo_init(void)
>  {
> -	struct cred *cred = (struct cred *) current_cred();
> -	struct tomoyo_domain_info **blob;
> +	struct tomoyo_security *s = tomoyo_security(current);
>  
>  	/* register ourselves with the security framework */
>  	security_add_hooks(tomoyo_hooks, ARRAY_SIZE(tomoyo_hooks), "tomoyo");
>  	printk(KERN_INFO "TOMOYO Linux initialized\n");
> -	blob = tomoyo_cred(cred);
> -	*blob = &tomoyo_kernel_domain;
> +	s->domain_info = &tomoyo_kernel_domain;
> +	atomic_inc(&tomoyo_kernel_domain.users);
> +	s->old_domain_info = NULL;
>  	tomoyo_mm_init();
>  
>  	return 0;
