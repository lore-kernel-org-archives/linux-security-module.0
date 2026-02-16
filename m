Received: from sonic310-30.consmr.mail.ne1.yahoo.com (sonic310-30.consmr.mail.ne1.yahoo.com [66.163.186.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA279223339
	for <linux-security-module@vger.kernel.org>; Mon, 16 Feb 2026 17:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.186.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771263310; cv=none; b=SJyr1oeMkw4RlKmkazZZmEKwXeD5EauyppmzWhTNt58+lNF32XS5ry3FjK/84INOV1Buwx+IlqyZ7jLkm85PvOysSp0vV5jm5twXMhKu+QHbZbv9bDHuPCtaNBOxuPS3FLXB3QUWUBgubbfhVO9QN7mhf0BBlO+QnYWHOPY4lps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771263310; c=relaxed/simple;
	bh=qPcy2wYZC5XbxJvIISDXHCE60hXC9uhTJX27NZNqwD0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RkwnD7Oykwk6qMHx5iDLJ3+S00TGPYeJt9f5uZJkK99Xy4L6wpAiSWKmrwok/n64T6Kb/JJWTz7ujRwbfhnUWF83q4LajnUw+y2h2PQeKuCj6lwnRKJf4t4PikHLpksxOgQHFBpHXroizkBywmELiJs4cDLMHn+LXq6B9bROA4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=neIWQ54M; arc=none smtp.client-ip=66.163.186.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="neIWQ54M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1771263301; bh=ivVODCCSA5z2Sp6aleC3KUwEgstZeLaM+NBfYB6LRnQ=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=neIWQ54MRhTFD8BvW0TLIV23MJ0SLbuq4D+Qf0HZECavHdTi567KyuaUJ/55jvzxlan8gjnOMQ+rOpZOgYUzC9LJs7QWr5FKTbVMpQhvhz0Nx2sswC10PwVL4vOomLDORwG5wMMXe5pgJKx45E6XuxkrgAugIpM0EjFGxY+qNr7J1E0r/mYqXDnqkmmbHh9bNSjUb3GZt8Z3OpFExkrzYW2HecbElDwcSYP0J9iL1JfMKQN9ZN/8/cyNfr8y8IFKPilKlLFo7jx/DlpNfrUAEa0RRGdAnw4tVMzML/hJY1P+d7uCwp/ummr36RQ+hEiqnPo8gpNBoFaZhFYjRhYMlA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1771263301; bh=kEP88P4dnLUCMz2e5x05YWGCYTx8YSAnZ8EuUJOJbwg=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=ETVNK9SsJZJ0OxL30Vz1eWlPmBFrNnMwV37YfMqWy0wwp0m50Sd0DhLQDaYmhe9kEo307HqFZgWAIWjEeyC6ndNkQuPdH3YhB27UE5oVmtkWSoDmuRWknQjmQ0Z01iJfwl7HvqzzSUphXDDMLkP2RVacHlbfYNAOlvwx00K2RMtO5USmMrFUU/hj6aJX/5Dmotbn6TsfOEipsy9my+AuGnvo+q/nFAkdfrJdBADHxt/MkKwicW4ng1FCXTqo+7ia7+tNeAFHuH32Y6razLMo9TjwB+w7BN2f4FCPPFlPVsSiCMmMuf6e9ZN+WgxOsYNApzAMQDY0dbehKtIKPEArPg==
X-YMail-OSG: psMNs2EVM1lIKmfr15TXuOzFQZmAQ7CGEroD3V.0pSaXJ.0i0VLiE1eWVTA47gH
 upB_wQBuMv45PfHeFqgCaGMsLiV6LSmvJ0lzIxZhZr11bbTiNNyvbTpI8VEzr7kvdxTCENj.d5PJ
 LdC652AxCUHyTYxPradiJeVqQv7JdF9T9bOHQSiJeYsJtuNb1Imur9XNmrtqCPcM1CQLkq.hP.5V
 dbO8WqksugHLc.NYyI_4PLmdp72Yx7cxuLiEiAshJwu36xVgPyXPlOUL3PLKDQltEYDGRwDwAgWw
 hFQuF1vPgK4N6djRbcg2ps3L1ItNzqxgczgbHy4_rtzYvzSeVDGtdO2a_0TziZG8_xtFg3PUhrs0
 ze3Q4xXTcjdiJ2nY7sE5OMTVvUD3q11ZFz5FFwtxgS0YfqNittoiCwpf1EIEDZQSPk_h7OYDQiGn
 x8ZHyNtM0xXf3yezkenU0MUyGtIABbsYBaC05oum.gocxgbLVffyRLrfJBPlfK67m2F6thiHWXDu
 Ej66tTwBuiEEhEkTwd1KO1lva559FRW3fEZxGKETL2j1xGKsxVCEHuIRcuZvT1HrCWKPqfhX5cYU
 Oxs63wu3N3OhU..uWJCFNsSjWjetMXfVnxEPXLnILnO4x0wB2HmozbVP1R_G9ZIvZwks5nw3vzQ3
 TtAMrCuyF1fnFaT1wSA7uqA_en5NA77xuwHyGsBiXU.joP3gLgx_1VLuwsMaVU6SewVQbBN3xQw9
 S97u_o3.ussa_QAwMLAQPZ5SHyLSUR1Rtg60RH5Qcp4Vc4zjSQt1Md7CsTOVtarv9tSL9VOCSzl_
 3jrbw7FDcX7CoPT4EmRyBOzg2IV.pj1XZKYOtjhF7xlkH8bLHtO0ZgFhXJfjvF3tyY1yy8te5CJz
 XdFnACtxGwejfCslUa9Gh_EUQr3RfOu8YpusmYwfjyxEOwZx.sW4h3y65J12gJgzHXyhVHnKe7WZ
 Y0If8nNrw1aO7uxbzoUxoThBnMRMhdkcm_O385SJKqXuvao1tRKCbTCWN6QORfjlmgRZvQqdxIbU
 TjW1tPcwBEoIEaBUIxXnLnJ1HNv.hSfYEbAbh46OQ25PREWqHOXPtNMk4sESMvn075kwkPT_1r5D
 CA0LO6Bmtl.8wggohQljV14X_LtJY8HzmwU73IhRgq3TopKP6NaYy18RyrQgIpMxjU9h66yAgW97
 D2Vgl2tEV1z2fZKES13hwGqTgCK3tCNOncISUZ.7VZN8C.1FgORGZ8Zvka5A10g6ip6IpAltFdcd
 CTKNH0hLOyol1R_W2sM8xtDvdRfDbe9fe2C91wlMSZsa.5E2SijgGlbsWJZpGIxfI07E1VYcOTFO
 06BVvI6fFCGBQc2b6Lk.OsulT2EqOuyt3wgDvnQkZUsg9ATW_wbvsUq3hF4zveDKm37fYsRa7uie
 T.Pk6OLMf.IT0A45wLy0bVRDKPNaEvAJDFAQ.H5Jbb5Cny_WFkZVT0KpR0X5uGdnZ6zS6MP2YKwe
 5MJoJbMZEEu6C7XC.TyUBBq_U9HF84uTWr4hPXYSyQ8dO72lKAfQNcg7d3vfj7kEgPGppRK61vpX
 bNwuViDWmleguQ2JuE_oHql.viUnfZ_LF9FkxhKXtvESoMfeQkRo9Ok3tRSE4vQHQTDnqDefPnfT
 8XJT8LugpECx128BDd_ifVGAHgy3Tj720FTU3bHMJuYAQIZE43k_XZ.PCP_cYO8RqfAHIWGiaqaB
 KwdrU5IjL1Ol134_vJzJiODUmdoy0t3ojCUZ0W7fjgo9N4kJjxwGgDqq9bz1m3huMqvl6DkHe2X7
 t9VkTGR0OfTb_pusHX2Lue28LAGM7gspDHGdgu3oo7o2PzYHhBA4Wxl4GX0hsIhtQZadA1PQg13b
 ZKtZbXFs0FV_I4HtODs0C8IdrQi4TP5g4QilYpaX8f.qmztW.z3kK43JjTToI3SnDEl7XaGhdyWl
 3VGEkiFo4TlCc2idGPkfTJzBNEbJ.9aBUkJMhAaLWrJwS6Dkw_..MJi5JmVehoS9.V5X9i6l995h
 xEwNYZM9i0z3uEZd9XOwc3HdroMz6xLkQzjm3Go36hN5.7EvnvQscipJZg8aP7V63Ql7qTw2be3T
 Kob4wBrlUuJBSBeg0tkibpoqoMU_x9QCmGXKAsLkEC1iPzKVioXZMSd6g4_x.dsV_UBqw3WsCz0f
 THENgy5qb_3jz6zkgWY5J_AB0IiAc7NeUEvqeGjSxW5_.AWIdQrbsQW_5IOyTtXx91RWSpJ_QUFx
 7UVQnXMDqKUsMWQq.LhNPXjCr0BHBkWuvu7ba4RMn4RnFFakW8j4_H6mKG.8aU2WSA7SR1TOuOJ2
 .oXTyi0itEUg-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 1034fc12-3fa5-474f-a778-a133d73b6853
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Mon, 16 Feb 2026 17:35:01 +0000
Received: by hermes--production-gq1-6dfcf9f8b-7ggwq (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID c81179ffaf78da595f4c9d15cf1de9bb;
          Mon, 16 Feb 2026 17:34:59 +0000 (UTC)
Message-ID: <fb40e938-f6b2-45cf-b8ab-246cd6939582@schaufler-ca.com>
Date: Mon, 16 Feb 2026 09:34:57 -0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] security: add LSM blob and hooks for namespaces
To: Christian Brauner <brauner@kernel.org>, Paul Moore <paul@paul-moore.com>
Cc: James Morris <jmorris@namei.org>, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>
References: <20260216-work-security-namespace-v1-1-075c28758e1f@kernel.org>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20260216-work-security-namespace-v1-1-075c28758e1f@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.25198 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 2/16/2026 5:52 AM, Christian Brauner wrote:
> All namespace types now share the same ns_common infrastructure. Extend
> this to include a security blob so LSMs can start managing namespaces
> uniformly without having to add one-off hooks or security fields to
> every individual namespace type.

The implementation appears sound.

I have to question whether having LSM controls on namespaces is reasonable.
I suppose that you could have a system where (for example) SELinux runs
in permissive mode except within a specific user namespace, where it would
enforce policy. Do you have a use case in mind? 

>
> Add a ns_security pointer to ns_common and the corresponding lbs_ns
> blob size to lsm_blob_sizes. Allocation and freeing hooks are called
> from the common __ns_common_init() and __ns_common_free() paths so
> every namespace type gets covered in one go. All information about the
> namespace type and the appropriate casting helpers to get at the
> containing namespace are available via ns_common making it
> straightforward for LSMs to differentiate when they need to.
>
> A namespace_install hook is called from validate_ns() during setns(2)
> giving LSMs a chance to enforce policy on namespace transitions.
>
> Individual namespace types can still have their own specialized security
> hooks when needed. This is just the common baseline that makes it easy
> to track and manage namespaces from the security side without requiring
> every namespace type to reinvent the wheel.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  include/linux/lsm_hook_defs.h      |  3 ++
>  include/linux/lsm_hooks.h          |  1 +
>  include/linux/ns/ns_common_types.h |  3 ++
>  include/linux/security.h           | 20 ++++++++++
>  kernel/nscommon.c                  | 12 ++++++
>  kernel/nsproxy.c                   |  8 +++-
>  security/lsm_init.c                |  2 +
>  security/security.c                | 76 ++++++++++++++++++++++++++++++++++++++
>  8 files changed, 124 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index 8c42b4bde09c..fefd3aa6d8f4 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -260,6 +260,9 @@ LSM_HOOK(int, -ENOSYS, task_prctl, int option, unsigned long arg2,
>  LSM_HOOK(void, LSM_RET_VOID, task_to_inode, struct task_struct *p,
>  	 struct inode *inode)
>  LSM_HOOK(int, 0, userns_create, const struct cred *cred)
> +LSM_HOOK(int, 0, namespace_alloc, struct ns_common *ns)
> +LSM_HOOK(void, LSM_RET_VOID, namespace_free, struct ns_common *ns)
> +LSM_HOOK(int, 0, namespace_install, const struct nsset *nsset, struct ns_common *ns)
>  LSM_HOOK(int, 0, ipc_permission, struct kern_ipc_perm *ipcp, short flag)
>  LSM_HOOK(void, LSM_RET_VOID, ipc_getlsmprop, struct kern_ipc_perm *ipcp,
>  	 struct lsm_prop *prop)
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index d48bf0ad26f4..3e7afe76e86c 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -111,6 +111,7 @@ struct lsm_blob_sizes {
>  	unsigned int lbs_ipc;
>  	unsigned int lbs_key;
>  	unsigned int lbs_msg_msg;
> +	unsigned int lbs_ns;
>  	unsigned int lbs_perf_event;
>  	unsigned int lbs_task;
>  	unsigned int lbs_xattr_count; /* num xattr slots in new_xattrs array */
> diff --git a/include/linux/ns/ns_common_types.h b/include/linux/ns/ns_common_types.h
> index 0014fbc1c626..170288e2e895 100644
> --- a/include/linux/ns/ns_common_types.h
> +++ b/include/linux/ns/ns_common_types.h
> @@ -115,6 +115,9 @@ struct ns_common {
>  	struct dentry *stashed;
>  	const struct proc_ns_operations *ops;
>  	unsigned int inum;
> +#ifdef CONFIG_SECURITY
> +	void *ns_security;
> +#endif
>  	union {
>  		struct ns_tree;
>  		struct rcu_head ns_rcu;
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 83a646d72f6f..611b9098367d 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -67,6 +67,7 @@ enum fs_value_type;
>  struct watch;
>  struct watch_notification;
>  struct lsm_ctx;
> +struct nsset;
>  
>  /* Default (no) options for the capable function */
>  #define CAP_OPT_NONE 0x0
> @@ -80,6 +81,7 @@ struct lsm_ctx;
>  
>  struct ctl_table;
>  struct audit_krule;
> +struct ns_common;
>  struct user_namespace;
>  struct timezone;
>  
> @@ -533,6 +535,9 @@ int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
>  			unsigned long arg4, unsigned long arg5);
>  void security_task_to_inode(struct task_struct *p, struct inode *inode);
>  int security_create_user_ns(const struct cred *cred);
> +int security_namespace_alloc(struct ns_common *ns);
> +void security_namespace_free(struct ns_common *ns);
> +int security_namespace_install(const struct nsset *nsset, struct ns_common *ns);
>  int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag);
>  void security_ipc_getlsmprop(struct kern_ipc_perm *ipcp, struct lsm_prop *prop);
>  int security_msg_msg_alloc(struct msg_msg *msg);
> @@ -1407,6 +1412,21 @@ static inline int security_create_user_ns(const struct cred *cred)
>  	return 0;
>  }
>  
> +static inline int security_namespace_alloc(struct ns_common *ns)
> +{
> +	return 0;
> +}
> +
> +static inline void security_namespace_free(struct ns_common *ns)
> +{
> +}
> +
> +static inline int security_namespace_install(const struct nsset *nsset,
> +					     struct ns_common *ns)
> +{
> +	return 0;
> +}
> +
>  static inline int security_ipc_permission(struct kern_ipc_perm *ipcp,
>  					  short flag)
>  {
> diff --git a/kernel/nscommon.c b/kernel/nscommon.c
> index bdc3c86231d3..de774e374f9d 100644
> --- a/kernel/nscommon.c
> +++ b/kernel/nscommon.c
> @@ -4,6 +4,7 @@
>  #include <linux/ns_common.h>
>  #include <linux/nstree.h>
>  #include <linux/proc_ns.h>
> +#include <linux/security.h>
>  #include <linux/user_namespace.h>
>  #include <linux/vfsdebug.h>
>  
> @@ -59,6 +60,9 @@ int __ns_common_init(struct ns_common *ns, u32 ns_type, const struct proc_ns_ope
>  
>  	refcount_set(&ns->__ns_ref, 1);
>  	ns->stashed = NULL;
> +#ifdef CONFIG_SECURITY
> +	ns->ns_security = NULL;
> +#endif
>  	ns->ops = ops;
>  	ns->ns_id = 0;
>  	ns->ns_type = ns_type;
> @@ -77,6 +81,13 @@ int __ns_common_init(struct ns_common *ns, u32 ns_type, const struct proc_ns_ope
>  		ret = proc_alloc_inum(&ns->inum);
>  	if (ret)
>  		return ret;
> +
> +	ret = security_namespace_alloc(ns);
> +	if (ret) {
> +		proc_free_inum(ns->inum);
> +		return ret;
> +	}
> +
>  	/*
>  	 * Tree ref starts at 0. It's incremented when namespace enters
>  	 * active use (installed in nsproxy) and decremented when all
> @@ -91,6 +102,7 @@ int __ns_common_init(struct ns_common *ns, u32 ns_type, const struct proc_ns_ope
>  
>  void __ns_common_free(struct ns_common *ns)
>  {
> +	security_namespace_free(ns);
>  	proc_free_inum(ns->inum);
>  }
>  
> diff --git a/kernel/nsproxy.c b/kernel/nsproxy.c
> index 259c4b4f1eeb..f0b30d1907e7 100644
> --- a/kernel/nsproxy.c
> +++ b/kernel/nsproxy.c
> @@ -379,7 +379,13 @@ static int prepare_nsset(unsigned flags, struct nsset *nsset)
>  
>  static inline int validate_ns(struct nsset *nsset, struct ns_common *ns)
>  {
> -	return ns->ops->install(nsset, ns);
> +	int ret;
> +
> +	ret = ns->ops->install(nsset, ns);
> +	if (ret)
> +		return ret;
> +
> +	return security_namespace_install(nsset, ns);
>  }
>  
>  /*
> diff --git a/security/lsm_init.c b/security/lsm_init.c
> index 573e2a7250c4..637c2d65e131 100644
> --- a/security/lsm_init.c
> +++ b/security/lsm_init.c
> @@ -301,6 +301,7 @@ static void __init lsm_prepare(struct lsm_info *lsm)
>  	lsm_blob_size_update(&blobs->lbs_ipc, &blob_sizes.lbs_ipc);
>  	lsm_blob_size_update(&blobs->lbs_key, &blob_sizes.lbs_key);
>  	lsm_blob_size_update(&blobs->lbs_msg_msg, &blob_sizes.lbs_msg_msg);
> +	lsm_blob_size_update(&blobs->lbs_ns, &blob_sizes.lbs_ns);
>  	lsm_blob_size_update(&blobs->lbs_perf_event,
>  			     &blob_sizes.lbs_perf_event);
>  	lsm_blob_size_update(&blobs->lbs_sock, &blob_sizes.lbs_sock);
> @@ -446,6 +447,7 @@ int __init security_init(void)
>  		lsm_pr("blob(ipc) size %d\n", blob_sizes.lbs_ipc);
>  		lsm_pr("blob(key) size %d\n", blob_sizes.lbs_key);
>  		lsm_pr("blob(msg_msg)_size %d\n", blob_sizes.lbs_msg_msg);
> +		lsm_pr("blob(ns) size %d\n", blob_sizes.lbs_ns);
>  		lsm_pr("blob(sock) size %d\n", blob_sizes.lbs_sock);
>  		lsm_pr("blob(superblock) size %d\n", blob_sizes.lbs_superblock);
>  		lsm_pr("blob(perf_event) size %d\n", blob_sizes.lbs_perf_event);
> diff --git a/security/security.c b/security/security.c
> index 67af9228c4e9..dcf073cac848 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -26,6 +26,7 @@
>  #include <linux/string.h>
>  #include <linux/xattr.h>
>  #include <linux/msg.h>
> +#include <linux/ns_common.h>
>  #include <linux/overflow.h>
>  #include <linux/perf_event.h>
>  #include <linux/fs.h>
> @@ -355,6 +356,19 @@ static int lsm_superblock_alloc(struct super_block *sb)
>  			      GFP_KERNEL);
>  }
>  
> +/**
> + * lsm_ns_alloc - allocate a composite namespace blob
> + * @ns: the namespace that needs a blob
> + *
> + * Allocate the namespace blob for all the modules
> + *
> + * Returns 0, or -ENOMEM if memory can't be allocated.
> + */
> +static int lsm_ns_alloc(struct ns_common *ns)
> +{
> +	return lsm_blob_alloc(&ns->ns_security, blob_sizes.lbs_ns, GFP_KERNEL);
> +}
> +
>  /**
>   * lsm_fill_user_ctx - Fill a user space lsm_ctx structure
>   * @uctx: a userspace LSM context to be filled
> @@ -3255,6 +3269,68 @@ int security_create_user_ns(const struct cred *cred)
>  	return call_int_hook(userns_create, cred);
>  }
>  
> +/**
> + * security_namespace_alloc() - Allocate LSM security data for a namespace
> + * @ns: the namespace being allocated
> + *
> + * Allocate and attach security data to the namespace. The namespace type
> + * is available via ns->ns_type, and the owning user namespace (if any)
> + * via ns->ops->owner(ns).
> + *
> + * Return: Returns 0 if successful, otherwise < 0 error code.
> + */
> +int security_namespace_alloc(struct ns_common *ns)
> +{
> +	int rc;
> +
> +	rc = lsm_ns_alloc(ns);
> +	if (unlikely(rc))
> +		return rc;
> +
> +	rc = call_int_hook(namespace_alloc, ns);
> +	if (unlikely(rc))
> +		security_namespace_free(ns);
> +
> +	return rc;
> +}
> +
> +/**
> + * security_namespace_free() - Release LSM security data from a namespace
> + * @ns: the namespace being freed
> + *
> + * Release security data attached to the namespace. Called before the
> + * namespace structure is freed.
> + *
> + * Note: The namespace may be freed via kfree_rcu(). LSMs must use
> + * RCU-safe freeing for any data that might be accessed by concurrent
> + * RCU readers.
> + */
> +void security_namespace_free(struct ns_common *ns)
> +{
> +	if (!ns->ns_security)
> +		return;
> +
> +	call_void_hook(namespace_free, ns);
> +
> +	kfree(ns->ns_security);
> +	ns->ns_security = NULL;
> +}
> +
> +/**
> + * security_namespace_install() - Check permission to install a namespace
> + * @nsset: the target nsset being configured
> + * @ns: the namespace being installed
> + *
> + * Check permission before allowing a namespace to be installed into the
> + * process's set of namespaces via setns(2).
> + *
> + * Return: Returns 0 if permission is granted, otherwise < 0 error code.
> + */
> +int security_namespace_install(const struct nsset *nsset, struct ns_common *ns)
> +{
> +	return call_int_hook(namespace_install, nsset, ns);
> +}
> +
>  /**
>   * security_ipc_permission() - Check if sysv ipc access is allowed
>   * @ipcp: ipc permission structure
>
> ---
> base-commit: 72c395024dac5e215136cbff793455f065603b06
> change-id: 20260206-work-security-namespace-d6a736082bcf
>
>
