Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=84.16.66.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793312032;
	b=skyCWYphi7Hzb4VW2wS/RFxWSOch4RGOHvH2Z734TBsmAB1c59lmCfelslDWysBepNtK
	 7DESr7elQRgrl1ogM/KgdkVScOFbZE1Z5KDTdhM6ckvyF99BGrtT7ChdqK9ky13twRL54
	 IuYVj6ylRE89nk2hi9IZY7zT5ZCghVwdsWz+fJzit0nDMZhIy99DiC3OpgqfflENmPrl5
	 LwvySCAoDP4ySjdHkZRZdjFSOt/0slgGZ3WLjZedxdgSCF5SU8w8gsC0A9bopPVfmura3
	 DTNfwKdDFKHom3ViW3WPD0pSzLANwdGlVAswI2ODFEeW5FsyefCdMO5djoBxKaIYMOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793312032;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 X-Infomaniak-Routing;
	bh=Nt4+TvJfMkuxRVj2D8iwH96sQf7kpj74Ylf9aC9EzbY=;
	b=BwW4OIWIMCoojG5LQsnXGaV1PcUruNVkl1ehRjAmhMxD5XxjM9g0GRvMNSlJ1fwERYHE
	 TmIfhesz1R7H5IjkN5eLWPm4RrIbPqIMBVE3tSfkSf7Y9kGhBBohIdp1rLK+5Cn+mp3kR
	 VwltZlWgh/meb4hVpfSUwSwbAdRo5L46DOtHuPIQgHfg+M/FmB4kD+M0tXuWN20NgPNOV
	 ixIZwDVAkrmEKOoGkXi5yyDUcLIefgQzvRyW45RqXuK5LIkLtib+kAtZALMtej4jVzxw+
	 jS3qrI1HRiOCrXsV29VDMAaN2fP2x2xhG9cz3S8KR+d916X6dtcf0CVrklYPWLlciZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=digikod.net;
	spf=pass smtp.mailfrom=digikod.net;
	dkim=pass header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=aeYC+OSf;
	arc=none smtp.remote-ip=84.16.66.172
Received: from smtp-42ac.mail.infomaniak.ch (smtp-42ac.mail.infomaniak.ch [84.16.66.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890FD606A31C
	for <linux-security-module@vger.kernel.org>; Thu, 29 Oct 2026 22:13:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 890FD606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=aeYC+OSf
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jFz5d6c2hz1bx8;
	Thu, 29 Oct 2026 23:13:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1793312021;
	bh=Nt4+TvJfMkuxRVj2D8iwH96sQf7kpj74Ylf9aC9EzbY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aeYC+OSf3U2IgiM6ZOPN26zhpBzS79NEBDypkumWca2aXb/wVB9if8RgW/XLQrGAy
	 lqTTqk1MxNR2qsZ4qRPM8fD1/LQPyl0wvAf0SlciqZD3+/d9hOEtGbEMbygwftYB76
	 M3zhtal5wL5t+MlH9RkyzWJnuhtTWVfWzWBKowA8=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4jFz5c5dGFzdbK;
	Thu, 29 Oct 2026 23:13:40 +0100 (CET)
Date: Thu, 29 Oct 2026 23:13:37 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Paul Moore <paul@paul-moore.com>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, netdev@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, stable@kernel.org
Subject: Re: [PATCH v2 4/7] ns: allocate the namespace id before the
 namespace_init hook
Message-ID: <20261029.Eu4Ohquaixoh@digikod.net>
References: <20261029-work-security-namespace_free-v2-0-65591dbba7b3@kernel.org>
 <20261029-work-security-namespace_free-v2-4-65591dbba7b3@kernel.org>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261029-work-security-namespace_free-v2-4-65591dbba7b3@kernel.org>
X-Infomaniak-Routing: alpha

On Thu, Oct 29, 2026 at 05:40:59PM +0100, Christian Brauner wrote:
> Currently the namespace id is allocated only after __ns_common_init()
> has called the namespace_init LSM hook. Most namespace types allocate it
> in ns_tree_add() right before the namespace is added to the namespace
> trees. So the namespace_init hook always sees an id of zero.
> 
> The namespace id is the only identifier of a namespace that is never
> recycled. A bpf LSM wants to use it to track a namespace from
> namespace_init until namespace_free, e.g., by using it as the key into a
> map that associates data with the namespace. The inode number doesn't
> work for that as it is quickly recycled.
> 
> So allocate the id in __ns_common_init() before calling the
> namespace_init hook. Every namespace then has its id by the time it is
> added to the namespace trees. The initial namespaces still get their
> fixed ids, either statically from NS_COMMON_INIT() or for init_net from
> ns_common_init(). So ns_tree_add() doesn't need to allocate an id
> anymore. Ids are still handed out in creation order so mnt_ns_loop()
> keeps working. Mount and ipc namespaces already allocated their id right
> after ns_common_init() anyway.
> 
> If creating the namespace fails after the id has been allocated the id
> is simply never used.
> 
> Landlock logs the namespace id when it denies the use of a namespace.
> For a denied namespace creation that used to be zero. Now it's the id
> that was allocated for the new namespace. That namespace never becomes
> visible to userspace but it's the same id that other LSMs see in
> namespace_init. Update the Landlock documentation and selftests
> accordingly. The selftests can't know the id of a namespace whose
> creation was denied so they only check that it isn't zero.
> 
> While at it, drop ns_tree_gen_id() as it has no users left.
> 
> Reproducer, 100 user and uts namespaces:
> 
>   bpftrace -e 'fentry:bpf_lsm_namespace_init {
>       @[args.ns->ns_id ? "set" : "zero"] = count(); }' &
>   for i in $(seq 100); do unshare -Uu true; done
> 
>   before: @[zero]: 200
>   after:  @[set]: 200
> 
> Fixes: f675d2e95569 ("lsm: add LSM blob and hooks for namespaces")
> Cc: <stable@kernel.org> # mainline only
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Mickaël Salaün <mic@digikod.net> # Landlock changes

> ---
>  Documentation/admin-guide/LSM/landlock.rst |  5 +++--
>  Documentation/trace/events-landlock.rst    |  5 +++--
>  fs/namespace.c                             |  2 --
>  include/linux/ns_common.h                  | 16 +++++++++-------
>  include/linux/nstree.h                     | 18 +++---------------
>  include/trace/events/landlock.h            |  3 ++-
>  ipc/namespace.c                            |  1 -
>  kernel/nscommon.c                          |  7 +++++--
>  net/core/net_namespace.c                   |  2 +-
>  security/landlock/ns.c                     |  3 ++-
>  tools/testing/selftests/landlock/ns_test.c |  7 +++++--
>  11 files changed, 33 insertions(+), 36 deletions(-)
> 
> diff --git a/Documentation/admin-guide/LSM/landlock.rst b/Documentation/admin-guide/LSM/landlock.rst
> index 718e0d23ffb5..946f3bf89650 100644
> --- a/Documentation/admin-guide/LSM/landlock.rst
> +++ b/Documentation/admin-guide/LSM/landlock.rst
> @@ -73,8 +73,9 @@ AUDIT_LANDLOCK_ACCESS
>            :manpage:`open_tree(2)`, or :manpage:`fsmount(2)`, or joining via
>            :manpage:`setns(2)`);
>            ``namespace_type`` indicates the type (hex ``CLONE_NEW*`` bitmask),
> -          and ``namespace_id`` identifies the target namespace for
> -          :manpage:`setns(2)` operations (zero for creation)
> +          and ``namespace_id`` identifies the target namespace (for a denied
> +          creation, the namespace never becomes reachable so its ID is not
> +          directly visible from user space)
>  
>      **capability.*** - Capability restrictions (ABI 12+):
>          - capability.use - Capability use was denied;
> diff --git a/Documentation/trace/events-landlock.rst b/Documentation/trace/events-landlock.rst
> index 9ccf2769a2d5..dc5f05a17c2c 100644
> --- a/Documentation/trace/events-landlock.rst
> +++ b/Documentation/trace/events-landlock.rst
> @@ -187,8 +187,9 @@ therefore appears as zero while still advancing the ruleset version, and adding
>  a member already present still emits an event.
>  
>  ``landlock_deny_permission_namespace`` reports the denied raw
> -``CLONE_NEW*`` value.  ``namespace_id`` is zero for namespace creation and is
> -the exact target namespace ID for :manpage:`setns(2)`.
> +``CLONE_NEW*`` value.  ``namespace_id`` is the exact target namespace ID.  For
> +a denied namespace creation, the namespace never becomes reachable so its ID
> +is not directly visible from user space.
>  ``landlock_deny_permission_capability`` reports the denied ``CAP_*`` number.
>  Like every denial event, both include the denying domain, ``same_exec``, and
>  ``logged``.
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 9f6ec35c7b9c..f81d6a4bc3fe 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -4394,8 +4394,6 @@ static struct mnt_namespace *alloc_mnt_ns(struct user_namespace *user_ns, bool a
>  		dec_mnt_namespaces(ucounts);
>  		return ERR_PTR(ret);
>  	}
> -	ns_tree_gen_id(new_ns);
> -
>  	new_ns->is_anon = anon;
>  	refcount_set(&new_ns->passive, 1);
>  	new_ns->mounts = RB_ROOT;
> diff --git a/include/linux/ns_common.h b/include/linux/ns_common.h
> index c8e227a3f9e2..e8b2bf0da5ed 100644
> --- a/include/linux/ns_common.h
> +++ b/include/linux/ns_common.h
> @@ -9,7 +9,8 @@
>  #include <uapi/linux/nsfs.h>
>  
>  bool is_current_namespace(struct ns_common *ns);
> -int __ns_common_init(struct ns_common *ns, u32 ns_type, const struct proc_ns_operations *ops, int inum);
> +int __ns_common_init(struct ns_common *ns, u32 ns_type, const struct proc_ns_operations *ops,
> +		     int inum, u64 ns_id);
>  void __ns_common_free(struct ns_common *ns);
>  struct ns_common *__must_check ns_owner(struct ns_common *ns);
>  
> @@ -41,17 +42,18 @@ static __always_inline bool is_ns_init_id(const struct ns_common *ns)
>  	.ns_owner_root.ns_list_head	= LIST_HEAD_INIT(nsname.ns.ns_owner_root.ns_list_head),		\
>  }
>  
> -#define ns_common_init(__ns)                     \
> -	__ns_common_init(to_ns_common(__ns),     \
> -			 ns_common_type(__ns),   \
> -			 to_ns_operations(__ns), \
> -			 (((__ns) == ns_init_ns(__ns)) ? ns_init_inum(__ns) : 0))
> +#define ns_common_init(__ns)						\
> +	__ns_common_init(to_ns_common(__ns),				\
> +			 ns_common_type(__ns),				\
> +			 to_ns_operations(__ns),			\
> +			 (((__ns) == ns_init_ns(__ns)) ? ns_init_inum(__ns) : 0), \
> +			 (((__ns) == ns_init_ns(__ns)) ? ns_init_id(__ns) : 0))
>  
>  #define ns_common_init_inum(__ns, __inum)        \
>  	__ns_common_init(to_ns_common(__ns),     \
>  			 ns_common_type(__ns),   \
>  			 to_ns_operations(__ns), \
> -			 __inum)
> +			 __inum, 0)
>  
>  #define ns_common_free(__ns) __ns_common_free(to_ns_common((__ns)))
>  
> diff --git a/include/linux/nstree.h b/include/linux/nstree.h
> index 5b64d4572881..3293df17397d 100644
> --- a/include/linux/nstree.h
> +++ b/include/linux/nstree.h
> @@ -41,10 +41,6 @@ void ns_tree_node_del(struct ns_tree_node *node, struct ns_tree_root *root);
>  		struct user_namespace *:   &(user_ns_tree),	\
>  		struct uts_namespace *:    &(uts_ns_tree))
>  
> -#define ns_tree_gen_id(__ns)                 \
> -	__ns_tree_gen_id(to_ns_common(__ns), \
> -			 (((__ns) == ns_init_ns(__ns)) ? ns_init_id(__ns) : 0))
> -
>  u64 __ns_tree_gen_id(struct ns_common *ns, u64 id);
>  void __ns_tree_add_raw(struct ns_common *ns, struct ns_tree_root *ns_tree);
>  void __ns_tree_remove(struct ns_common *ns, struct ns_tree_root *ns_tree);
> @@ -53,12 +49,6 @@ struct ns_common *__ns_tree_adjoined_rcu(struct ns_common *ns,
>  					 struct ns_tree_root *ns_tree,
>  					 bool previous);
>  
> -static inline void __ns_tree_add(struct ns_common *ns, struct ns_tree_root *ns_tree, u64 id)
> -{
> -	__ns_tree_gen_id(ns, id);
> -	__ns_tree_add_raw(ns, ns_tree);
> -}
> -
>  /**
>   * ns_tree_add_raw - Add a namespace to a namespace
>   * @__ns: Namespace to add
> @@ -72,12 +62,10 @@ static inline void __ns_tree_add(struct ns_common *ns, struct ns_tree_root *ns_t
>   * ns_tree_add - Add a namespace to a namespace tree
>   * @__ns: Namespace to add
>   *
> - * This function assigns a new id to the namespace and adds it to the
> - * appropriate namespace tree and list.
> + * This function adds a namespace to the appropriate namespace tree and
> + * list. The namespace must already have been assigned an id.
>   */
> -#define ns_tree_add(__ns)                                   \
> -	__ns_tree_add(to_ns_common(__ns), to_ns_tree(__ns), \
> -		      (((__ns) == ns_init_ns(__ns)) ? ns_init_id(__ns) : 0))
> +#define ns_tree_add(__ns) __ns_tree_add_raw(to_ns_common(__ns), to_ns_tree(__ns))
>  
>  /**
>   * ns_tree_remove - Remove a namespace from a namespace tree
> diff --git a/include/trace/events/landlock.h b/include/trace/events/landlock.h
> index 6d9d9e7c7ca2..b6fdc6e2eef8 100644
> --- a/include/trace/events/landlock.h
> +++ b/include/trace/events/landlock.h
> @@ -987,7 +987,8 @@ TRACE_EVENT(landlock_deny_access_net,
>   * @logged: Whether this denial was selected for audit logging.
>   * @blockers: Request type and final missing permission subset (never NULL).
>   * @namespace_type: CLONE_NEW* namespace type that was denied.
> - * @namespace_id: Namespace ID, or 0 when creation was denied.
> + * @namespace_id: Namespace ID, not directly visible from user space when
> + *                creation was denied.
>   *
>   * Emitted when a Landlock domain denies namespace use.
>   */
> diff --git a/ipc/namespace.c b/ipc/namespace.c
> index 75aa7b469348..9084e0643017 100644
> --- a/ipc/namespace.c
> +++ b/ipc/namespace.c
> @@ -66,7 +66,6 @@ static struct ipc_namespace *create_ipc_ns(struct user_namespace *user_ns,
>  	if (err)
>  		goto fail_free;
>  
> -	ns_tree_gen_id(ns);
>  	ns->user_ns = get_user_ns(user_ns);
>  	ns->ucounts = ucounts;
>  
> diff --git a/kernel/nscommon.c b/kernel/nscommon.c
> index e72426bba29a..4438c6b663f9 100644
> --- a/kernel/nscommon.c
> +++ b/kernel/nscommon.c
> @@ -54,7 +54,8 @@ static void ns_debug(struct ns_common *ns, const struct proc_ns_operations *ops)
>  }
>  #endif
>  
> -int __ns_common_init(struct ns_common *ns, u32 ns_type, const struct proc_ns_operations *ops, int inum)
> +int __ns_common_init(struct ns_common *ns, u32 ns_type, const struct proc_ns_operations *ops,
> +		     int inum, u64 ns_id)
>  {
>  	int ret = 0;
>  
> @@ -64,7 +65,6 @@ int __ns_common_init(struct ns_common *ns, u32 ns_type, const struct proc_ns_ope
>  	ns->ns_security = NULL;
>  #endif
>  	ns->ops = ops;
> -	ns->ns_id = 0;
>  	ns->ns_type = ns_type;
>  	ns_tree_node_init(&ns->ns_tree_node);
>  	ns_tree_node_init(&ns->ns_unified_node);
> @@ -82,6 +82,9 @@ int __ns_common_init(struct ns_common *ns, u32 ns_type, const struct proc_ns_ope
>  	if (ret)
>  		return ret;
>  
> +	/* Allocate the id before the LSM hook so it can track the namespace by it. */
> +	__ns_tree_gen_id(ns, ns_id);
> +
>  	ret = security_namespace_init(ns);
>  	if (ret) {
>  		if (!inum)
> diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
> index da5f881fbd3b..ec4077b81389 100644
> --- a/net/core/net_namespace.c
> +++ b/net/core/net_namespace.c
> @@ -437,7 +437,7 @@ static __net_init int setup_net(struct net *net)
>  	LIST_HEAD(net_exit_list);
>  	int error = 0;
>  
> -	net->net_cookie = ns_tree_gen_id(net);
> +	net->net_cookie = to_ns_common(net)->ns_id;
>  
>  	list_for_each_entry(ops, &pernet_list, list) {
>  		error = ops_init(ops, net);
> diff --git a/security/landlock/ns.c b/security/landlock/ns.c
> index cd44c927f83a..06d9784746fe 100644
> --- a/security/landlock/ns.c
> +++ b/security/landlock/ns.c
> @@ -94,7 +94,8 @@ static const struct access_masks ns_permission = {
>   * Shared check for namespace_init (creation via clone(2), unshare(2),
>   * open_tree(2), or fsmount(2)) and namespace_install (use via setns(2)): denies
>   * when the namespace type is not in the domain's allowed set.  At allocation
> - * time @ns->ns_id is still zero and is logged as such.
> + * time @ns->ns_id is already set even though the namespace is not reachable
> + * from user space yet.
>   *
>   * Return: 0 if allowed, -EPERM if denied.
>   */
> diff --git a/tools/testing/selftests/landlock/ns_test.c b/tools/testing/selftests/landlock/ns_test.c
> index f5d4b86edd30..8f387fc47e21 100644
> --- a/tools/testing/selftests/landlock/ns_test.c
> +++ b/tools/testing/selftests/landlock/ns_test.c
> @@ -1899,8 +1899,9 @@ TEST(setns_inherited_fd)
>  
>  static int matches_log_ns_create(int audit_fd, __u64 ns_type)
>  {
> +	/* A denied creation logs the ID allocated for the new namespace. */
>  	static const char log_template[] = REGEX_LANDLOCK_PREFIX
> -		" blockers=namespace\\.use namespace_type=0x%x namespace_id=0$";
> +		" blockers=namespace\\.use namespace_type=0x%x namespace_id=[1-9][0-9]*$";
>  	char log_match[sizeof(log_template) + 10];
>  	int log_match_len;
>  
> @@ -2538,7 +2539,9 @@ static void test_ns_trace_denial(struct __test_metadata *const _metadata,
>  	ASSERT_EQ(0, tracefs_extract_field(
>  			     buf, REGEX_DENY_PERMISSION_NAMESPACE(TRACE_TASK),
>  			     "namespace_id", field, sizeof(field)));
> -	EXPECT_EQ(use_setns ? expected_ns_id : 0, strtoull(field, NULL, 10));
> +	EXPECT_STRNE("0", field);
> +	if (use_setns)
> +		EXPECT_EQ(expected_ns_id, strtoull(field, NULL, 10));
>  
>  	free(buf);
>  }
> 
> -- 
> 2.53.0
> 
