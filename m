Received: from sonic315-20.consmr.mail.ne1.yahoo.com (sonic315-20.consmr.mail.ne1.yahoo.com [66.163.190.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEB41714AC
	for <linux-security-module@vger.kernel.org>; Wed, 21 May 2025 16:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.190.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747843705; cv=none; b=dXCD8Jmb+59lKKsybwNzmEYzISco4+g70Mf75UBCOVasoe99WiFMwBy0+HBhhdxjYZ1gs2wDJ3i9Mnp1VYacGxRqQuxYLIDtX7DGyjeF6IoC0JMqBBJg1Lh7NyOLlREriBzVOuzqY3rdGFiBtmZNPq7757TyLzk6lE0uTc3XxpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747843705; c=relaxed/simple;
	bh=BGgcqRuU13Vh++D4w49Yy7U8WDceLk5GAUaKFmIp5xw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I+c8xMi474wYsp8EtGpQ14owU0c9kqxKOogWv2Cs8n8Z34xz5OmwAkDUYbJ/Dhf/4/DKsSazyQq9hU1NMW5RRJrnNE1YTV9pADD/AEsfiN/f1eE9i+t+O8DLqcn9/kqo77QQM+AbINyacLGYwtf8wslk8ddZQb4GRYu2Yi4PyPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=ocIw6ZcQ; arc=none smtp.client-ip=66.163.190.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="ocIw6ZcQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1747843697; bh=yOmpglE/0iE5Dkli7Rq/91RmE/Ae1zpfw90UnkxLyJE=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=ocIw6ZcQpK7pw9s+OL8P04qt/XC8Ki7ggtyFeoG/mGIjtNoEmLZOblQUgvdi0Mp6aXxeuyszoTiE6RZjDuY2LIssPHEc1slnHUdumPCeHSe+vUv0t6AW3RsqVvfbiwprP9Pd2jK8QELVIY17jpQjaNAhfQMavk6Hb2v7Bprc+1GJBJQsysZtnmRKUos4dJFWwr7VRjYhPRszKxmvW8A+kn+ymc8NkEFN2vgKGoQNUzxpAfb1TAnfSYnlSm8V4hmdyZ9fG1wgf+YoreihS+ybhDBcciwQNsxUWWEoZtwBntFvLoAdL5WQzRqpGCiAFPNV9ijAOO76A7wO8PjCjHIzcA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1747843697; bh=Ragd3I2+zkUUZ7WqiWXM0C68Pgpl8Zo5saE/vOG0OqG=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=iuV1N/nEw85EP+cPGR82Im7MvKbmb9jhJwAw0IhZxlyQTqeCj2fzfNIc2oqJ7pC7cBzvXr7MP2J0DVXmSGiQZvlRo6orIvwQTlfsH+p3iJ8Wq9F4WsK4yKW781dZefktjWqbfVIOCfQ2A3HeobXBCdlFZaJhG8SMryAFas3FYEErmbplufyinjU7nr8X9mqMfWtP6AD2jJGH07Spl2DzQj6WgFuo8CkCqc62dXUgm7MukLPpufgAvPGP5+9sV55TA702nwmVF3QkVI/r8OK3bjhCBvmE/CDU5Oj4LmraSRdMva55B21/nbNJ96Ux8ln0/JZE5bRUCWCgSMoskJ/Wag==
X-YMail-OSG: clByqJoVM1moRTe52CSJ83UXr1yauiFENOkLifcwnyG6f5cKkKdfmnpo9yqeNfA
 6nAaknoo9mJJ4syusfV9q9BDEQih1IRYInV9PzewRbmc0icvU1.MEuIq7vkhxTNtxX23iyvnjAbM
 nNUO7IHJJ4gjtygdnPh_6QqLolqs2qWyXKowwJ9MM8kOq7mWQHXyxoWb7usWB0Robx11v3Qax5TI
 6Gn2dKIVv06XFi52FyIFHE8p8nAqh2GEWxmatPtMm6XygnaFVA7F5fDtVjvs5tjtv_IkdZePsC.l
 mrDiHYIa82zVo.zPdwKxblTk0ofs2JREbuGaFXK7.mQIKLIn4uodfpZrzfMg3cVSNS8UH7DiMuKS
 AWhWmQJzBNDUucyi0MmEKM8_OE4QVZo67hvInHNLNlKs7QwpMU23Nrc0KDzpBuamRbXP9e.8fwnm
 Faqu2YZpRi2Ho6cXVWScZOKveXFXnitMWdhYPNwdVQAoHW8C.ZjBLdeN60mtjmUaG_oLr7NodEof
 6us2vWafytDEB_A8wMx.VfzLGa8SczM6cq7kIOr2VtGbOeHAFfRoV37FVWLrADBFaIn4zo4wRoI7
 A41Mz5kreczCDBq8SEwlhb17PQqq5XIyzfnth3HO9QOaUS.B.MoeFHwT8i0uRTq21RB1LOqkokVI
 6QbyNkiEBIwnElisPFPYMGF8jVE1LfelNkvnVvMcMqndziBC8aYzRrf6E35dq9d7NbFMUEOTa1YM
 pFZs8N90cdl5JJctOlee9g5GaWxRYaXeondJlvGfqnzevQfMhqdWjH20js6GvEQRf1NHnkdmEIr7
 RgARLH9OsS__.FZEaKyV_oanjgX.Tky79SdYASgoTCUkoWzTCPvRYtbgP8qMTT4c.Psjojr_HXAb
 VeJmIbAu_tCUiizFzcX8D5rM9PSzzVtklzW3JU31E40Z42vi0uFBHBq67k3rqnYCKzJ53iYrNxTk
 9_as4N.dJ8BpJ0kKr8vAwYeVzGmRc60TVpUI8Ig5PE5R7a9J_VZutv9DYrfh3ZW.xWJ7xiS.ztPE
 UYs1.yX3pS0wvQr8hagSzSty4AK_4ettxb22xZP58Oi01UNfqHlmIGnNo0qRK2J_WiuKyYDwZUev
 iAwL5kg0F4LjJpmmtcIi8H_hZU4egIftqzZQCdssWrrDdmyRfADSdMVz7ZOsXu8.9cLbLh1J4LcA
 gUqpkVVvMmQNuQYroQuiB2.TADdG5W9Jlf8ZvlmK0rVqL.alCa0fwYbklrc8sunjCjm4eRjrUNeS
 Aw9fSxPlMQsXkUE_7TA7Zu7O4HeJZHXdksnRFvi4SYQvtA7oahSGJT8pHSVirW0ZkM32StU0gHHq
 uTAEjl56ZFlcGILdF2KdODAugxcJHFmSZpQ9AaBw7aimLegYhfPlFapKvHINjwWGdjnfsoUVAZUy
 VIAEBocBxUUJQvK5EAqUJJ9e2o1x0JL43dk5yrISZbbBm5W6WGhi2baKsfawiUUhy41b1RTMpcvE
 ZG9T0fA4XMjNKdZ6roYlb7FTtruxC0lgcpuQsmLc6557LUZEYf2AX2pt4snGEN8pZFyKArcYZuEk
 0JIi8HHzwWZojxJL43oZpLwTypzQobksA1qce_kHBucMWf0QK2DnRfCUh6XFUV.X9bV6FombXx9H
 qCnvlnXpzDQHDxpk9w.Ejzwq9Jpn3vv4FCDYwxVuWgroY_n0dU2WgF5XrKXFAUeDYLtolS1zvrpA
 mH99Cp4Rntdy0J6gvTyKET2CtGCP8aNB2o3uPWAYSNP1VQWHfJje_femBOh9nceG6GQOAt3HR2RI
 zi8Amj_vr9zi0C4MeW0Mtq3ZSSnQ3GB9JC8Sjx0FRfZFMzheE4nV5NbsV2lP1Z.flZTs15bpbmTr
 XajYhaOLQW69bTpVGEF.orx1rHSRmWil4kkHy3UgZLc4rQlef.Psh3f9EBumCjgcHpEDDpgHD_ay
 KgFuHUVx4W2a5h9O8_VfxJAgeJ0xIN.gqN3aqiY1A2vAEd758VzJT.6bswfymfTpsLdRZHBjzNya
 TcvKSxpRqTjXtzxTH8xCF7jFm
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: b8629f42-b60d-43ff-9800-f898e860a3c8
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Wed, 21 May 2025 16:08:17 +0000
Received: by hermes--production-gq1-74d64bb7d7-x7xzm (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID ee12a9316542bcda0cf8edd5de5dde10;
          Wed, 21 May 2025 15:48:01 +0000 (UTC)
Message-ID: <518c8bdd-4f73-4b8b-bdb9-be3294723c99@schaufler-ca.com>
Date: Wed, 21 May 2025 08:47:59 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/9] Loadpol LSM: filter kernel module request
 according to the policy
To: Simon THOBY <git@nightmared.fr>, linux-security-module@vger.kernel.org
Cc: linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20250521140121.591482-1-git@nightmared.fr>
 <20250521140121.591482-4-git@nightmared.fr>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20250521140121.591482-4-git@nightmared.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.23840 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 5/21/2025 7:01 AM, Simon THOBY wrote:
> When a kernel module is loaded, the LSM accepts or rejects the demand
> according to its policy.
>
> Signed-off-by: Simon THOBY <git@nightmared.fr>
> ---
>  security/loadpol/Makefile         |  2 +-
>  security/loadpol/loadpol.c        | 22 ++++++++++++
>  security/loadpol/loadpol.h        | 27 ++++++++++++++
>  security/loadpol/loadpol_policy.c | 59 +++++++++++++++++++++++++++++++
>  4 files changed, 109 insertions(+), 1 deletion(-)
>  create mode 100644 security/loadpol/loadpol_policy.c
>
> diff --git a/security/loadpol/Makefile b/security/loadpol/Makefile
> index a794c8cfbfee..062215e1f831 100644
> --- a/security/loadpol/Makefile
> +++ b/security/loadpol/Makefile
> @@ -1 +1 @@
> -obj-$(CONFIG_SECURITY_LOADPOL) := loadpol.o
> +obj-$(CONFIG_SECURITY_LOADPOL) := loadpol.o loadpol_policy.o
> diff --git a/security/loadpol/loadpol.c b/security/loadpol/loadpol.c
> index 3fc29263e2f8..4d1a495a1462 100644
> --- a/security/loadpol/loadpol.c
> +++ b/security/loadpol/loadpol.c
> @@ -6,6 +6,15 @@
>  
>  #include "loadpol.h"
>  
> +// default policy: allow all modules
> +static struct loadpol_policy_entry default_policy_entries[] __ro_after_init = {
> +	{
> +		.origin = (ORIGIN_KERNEL | ORIGIN_USERSPACE),
> +		.action = ACTION_ALLOW,
> +		.module_name = NULL,
> +	},
> +};
> +
>  static int __init loadpol_init(void);
>  
>  static const struct lsm_id loadpol_lsmid = {
> @@ -14,6 +23,7 @@ static const struct lsm_id loadpol_lsmid = {
>  };
>  
>  static struct security_hook_list loadpol_hooks[] __ro_after_init = {
> +	LSM_HOOK_INIT(kernel_module_load, loadpol_kernel_module_load),
>  };
>  
>  DEFINE_LSM(LOADPOL_NAME) = {
> @@ -23,6 +33,18 @@ DEFINE_LSM(LOADPOL_NAME) = {
>  
>  static int __init loadpol_init(void)
>  {
> +	for (int i = 0; i < ARRAY_SIZE(default_policy_entries); i++) {
> +		struct loadpol_policy_entry *entry = kmemdup(
> +			&default_policy_entries[i],
> +			sizeof(struct loadpol_policy_entry),
> +			GFP_KERNEL
> +		);
> +		if (!entry)
> +			return -ENOMEM;
> +
> +		list_add_tail(&entry->list, loadpol_policy);
> +	}
> +
>  	security_add_hooks(loadpol_hooks, ARRAY_SIZE(loadpol_hooks), &loadpol_lsmid);
>  	pr_info("Loadpol started.\n");
>  	return 0;
> diff --git a/security/loadpol/loadpol.h b/security/loadpol/loadpol.h
> index 5e11474191f0..a81d52f6d4da 100644
> --- a/security/loadpol/loadpol.h
> +++ b/security/loadpol/loadpol.h
> @@ -3,6 +3,33 @@
>  #ifndef _SECURITY_LOADPOL_LOADPOL_H
>  #define _SECURITY_LOADPOL_LOADPOL_H
>  
> +#include "linux/list.h"
> +
>  #define LOADPOL_NAME "loadpol"
>  
> +enum policy_entry_origin {
> +	ORIGIN_KERNEL = 1 << 0,
> +	ORIGIN_USERSPACE = 1 << 1,
> +};
> +
> +enum __packed policy_entry_action {
> +	ACTION_UNDEFINED,
> +	ACTION_ALLOW,
> +	ACTION_DENY
> +};
> +
> +struct loadpol_policy_entry {
> +	struct list_head list;
> +	// bitfield of policy_entry_origin

The // comment style is not used in the kernel.

> +	u8 origin;
> +	enum policy_entry_action action;
> +	// when NULL, the policy apply to every module
> +	char *module_name;
> +};
> +
> +extern struct list_head __rcu *loadpol_policy;
> +
> +// evaluate if a kernel module called 'kmod' is allowed to be loaded in the kernel
> +int loadpol_kernel_module_load(const char *kmod);
> +
>  #endif /* _SECURITY_LOADPOL_LOADPOL_H */
> diff --git a/security/loadpol/loadpol_policy.c b/security/loadpol/loadpol_policy.c
> new file mode 100644
> index 000000000000..6ba5ab600e3e
> --- /dev/null
> +++ b/security/loadpol/loadpol_policy.c
> @@ -0,0 +1,59 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include "linux/rculist.h"
> +#include <linux/sched.h>
> +#include <linux/sysctl.h>
> +#include <linux/parser.h>
> +
> +#include "loadpol.h"
> +
> +/*  use A/B policy entries: switch from one to the next every time the policy get overwritten */
> +static LIST_HEAD(loadpol_policy_a);
> +static LIST_HEAD(loadpol_policy_b);
> +struct list_head __rcu *loadpol_policy = (struct list_head __rcu *)(&loadpol_policy_a);
> +
> +int loadpol_kernel_module_load(const char *kmod)
> +{
> +	struct task_struct *parent_task;
> +	struct loadpol_policy_entry *entry;
> +	struct list_head *policy_list_tmp;
> +	enum policy_entry_origin orig = ORIGIN_USERSPACE;
> +	bool allowed = false;
> +
> +	rcu_read_lock();
> +	parent_task = rcu_dereference(current->parent);
> +	/* the parent of the current task is a workqueue -> the request comes from the kernel */
> +	if (parent_task && (parent_task->flags & PF_WQ_WORKER))
> +		orig = ORIGIN_KERNEL;
> +	rcu_read_unlock();
> +
> +	pr_debug("Loadpol: trying to load '%s' (asked by %s)",
> +		 kmod,
> +		 orig == ORIGIN_KERNEL ? "kernel" : "userspace");
> +
> +	rcu_read_lock();
> +	policy_list_tmp = rcu_dereference(loadpol_policy);
> +	list_for_each_entry_rcu(entry, policy_list_tmp, list) {
> +		/* the requestor does not match */
> +		if ((orig & entry->origin) == 0)
> +			continue;
> +
> +		allowed = entry->action == ACTION_ALLOW;
> +
> +		if (!entry->module_name)
> +			goto unlock_and_exit;
> +
> +		if (entry->module_name && match_wildcard(entry->module_name, kmod))
> +			goto unlock_and_exit;
> +	}
> +
> +	/* No match -> reject the demand */
> +	allowed = false;
> +
> +unlock_and_exit:
> +	rcu_read_unlock();
> +
> +	pr_debug("Loadpol: load of module '%s' %s", kmod, allowed ? "allowed" : "blocked");
> +
> +	return allowed ? 0 : -EPERM;
> +}
