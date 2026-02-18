Received: from smtp-bc0e.mail.infomaniak.ch (smtp-bc0e.mail.infomaniak.ch [45.157.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADA633C509
	for <linux-security-module@vger.kernel.org>; Wed, 18 Feb 2026 09:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771407444; cv=none; b=esf0EGYzpwVai8O4LUJkN/LkyA6DavV3R3pC+tF/pCB22JKoJgMMBwZlbjH1rIrxZGO6Za2tHE83ug5X2pgwv7fik22FrGdkapCWmpjc0PgrKdrfO+8NYVP0CsCXVVuEUfpSPzboQOzud6Ge/mtqm0BMhqAx9WHOdaSoftv6VQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771407444; c=relaxed/simple;
	bh=osdiW/HmDmYad/JtN7+x+I+Gtf5JEVZ44sUvlC0iDcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gp4dc8PhEq37Co+3kfWF9RrTWllTWzzRdBVGg1G6CtiB6UaTo2v7mReAQ2kCjLfu3E7XdENXBDRdrGz1ZpL0S+piM7xp5E8nJfnPQQVonrnnWQgEsNcvd1UyTr22AHZXWucHTKZ7LzLwwCsDY5JhEknc5cl6euLS6RV4QqItklk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=FB629Jim; arc=none smtp.client-ip=45.157.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="FB629Jim"
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fGBHc4WSSzc5d;
	Wed, 18 Feb 2026 10:37:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1771407436;
	bh=jlGpZueanRysvuX20CFkdtezd4x4i5qt9k3Fb0b9XtI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FB629JimlKUrTNGmNqxSvBLSz1jUyN9ReIwju0KpJVdKKPKomj/yOQ/us0q0ML0nY
	 XzTZqMDLKo/HrksAjRa1rLXGDtknPlZ5+EM9gQw5FcqFFRULqw8/PN0PQi2HO6hYmb
	 6LXrb4CFOw7w7LjNyyenAsohsbXRUx2vO7J+gSOE=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4fGBHc000rz5nP;
	Wed, 18 Feb 2026 10:37:15 +0100 (CET)
Date: Wed, 18 Feb 2026 10:37:14 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>
Cc: John Johansen <john.johansen@canonical.com>, 
	Tingmao Wang <m@maowtm.org>, Justin Suess <utilityemal77@gmail.com>, 
	Jann Horn <jannh@google.com>, linux-security-module@vger.kernel.org, 
	Samasth Norway Ananda <samasth.norway.ananda@oracle.com>, Matthieu Buffet <matthieu@buffet.re>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, konstantin.meskhidze@huawei.com, 
	Demi Marie Obenour <demiobenour@gmail.com>, Alyssa Ross <hi@alyssa.is>, 
	Tahera Fahimi <fahimitahera@gmail.com>
Subject: Re: [PATCH v5 2/9] landlock: Control pathname UNIX domain socket
 resolution by path
Message-ID: <20260217.lievaS8eeng8@digikod.net>
References: <20260215105158.28132-1-gnoack3000@gmail.com>
 <20260215105158.28132-3-gnoack3000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260215105158.28132-3-gnoack3000@gmail.com>
X-Infomaniak-Routing: alpha

On Sun, Feb 15, 2026 at 11:51:50AM +0100, Günther Noack wrote:
> * Add a new access right LANDLOCK_ACCESS_FS_RESOLVE_UNIX, which
>   controls the look up operations for named UNIX domain sockets.  The
>   resolution happens during connect() and sendmsg() (depending on
>   socket type).
> * Hook into the path lookup in unix_find_bsd() in af_unix.c, using a
>   LSM hook.  Make policy decisions based on the new access rights
> * Increment the Landlock ABI version.
> * Minor test adaptions to keep the tests working.
> 
> With this access right, access is granted if either of the following
> conditions is met:
> 
> * The target socket's filesystem path was allow-listed using a
>   LANDLOCK_RULE_PATH_BENEATH rule, *or*:
> * The target socket was created in the same Landlock domain in which
>   LANDLOCK_ACCESS_FS_RESOLVE_UNIX was restricted.
> 
> In case of a denial, connect() and sendmsg() return EACCES, which is
> the same error as it is returned if the user does not have the write
> bit in the traditional Unix file system permissions of that file.
> 
> This feature was created with substantial discussion and input from
> Justin Suess, Tingmao Wang and Mickaël Salaün.
> 
> Cc: Tingmao Wang <m@maowtm.org>
> Cc: Justin Suess <utilityemal77@gmail.com>
> Cc: Mickaël Salaün <mic@digikod.net>
> Suggested-by: Jann Horn <jannh@google.com>
> Link: https://github.com/landlock-lsm/linux/issues/36
> Signed-off-by: Günther Noack <gnoack3000@gmail.com>
> ---
>  include/uapi/linux/landlock.h                |  10 ++
>  security/landlock/access.h                   |  11 +-
>  security/landlock/audit.c                    |   1 +
>  security/landlock/fs.c                       | 102 ++++++++++++++++++-
>  security/landlock/limits.h                   |   2 +-
>  security/landlock/syscalls.c                 |   2 +-
>  tools/testing/selftests/landlock/base_test.c |   2 +-
>  tools/testing/selftests/landlock/fs_test.c   |   5 +-
>  8 files changed, 128 insertions(+), 7 deletions(-)
> 
> diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
> index f88fa1f68b77..3a8fc3af0d64 100644
> --- a/include/uapi/linux/landlock.h
> +++ b/include/uapi/linux/landlock.h
> @@ -248,6 +248,15 @@ struct landlock_net_port_attr {
>   *
>   *   This access right is available since the fifth version of the Landlock
>   *   ABI.
> + * - %LANDLOCK_ACCESS_FS_RESOLVE_UNIX: Look up pathname UNIX domain sockets
> + *   (:manpage:`unix(7)`).  On UNIX domain sockets, this restricts both calls to
> + *   :manpage:`connect(2)` as well as calls to :manpage:`sendmsg(2)` with an
> + *   explicit recipient address.
> + *
> + *   This access right only applies to connections to UNIX server sockets which
> + *   were created outside of the newly created Landlock domain (e.g. from within
> + *   a parent domain or from an unrestricted process).  Newly created UNIX
> + *   servers within the same Landlock domain continue to be accessible.

It might help to add a reference to the explicit scope mechanism.

Please squash patch 9/9 into this one and also add a reference here to
the rationale described in security/landlock.rst

>   *
>   * Whether an opened file can be truncated with :manpage:`ftruncate(2)` or used
>   * with `ioctl(2)` is determined during :manpage:`open(2)`, in the same way as
> @@ -333,6 +342,7 @@ struct landlock_net_port_attr {
>  #define LANDLOCK_ACCESS_FS_REFER			(1ULL << 13)
>  #define LANDLOCK_ACCESS_FS_TRUNCATE			(1ULL << 14)
>  #define LANDLOCK_ACCESS_FS_IOCTL_DEV			(1ULL << 15)
> +#define LANDLOCK_ACCESS_FS_RESOLVE_UNIX			(1ULL << 16)
>  /* clang-format on */
>  
>  /**
> diff --git a/security/landlock/access.h b/security/landlock/access.h
> index 42c95747d7bd..9a2991688835 100644
> --- a/security/landlock/access.h
> +++ b/security/landlock/access.h
> @@ -34,7 +34,7 @@
>  	LANDLOCK_ACCESS_FS_IOCTL_DEV)
>  /* clang-format on */
>  
> -typedef u16 access_mask_t;
> +typedef u32 access_mask_t;
>  
>  /* Makes sure all filesystem access rights can be stored. */
>  static_assert(BITS_PER_TYPE(access_mask_t) >= LANDLOCK_NUM_ACCESS_FS);
> @@ -76,6 +76,15 @@ struct layer_access_masks {
>  	access_mask_t access[LANDLOCK_MAX_NUM_LAYERS];
>  };
>  
> +static inline bool
> +layer_access_masks_empty(const struct layer_access_masks *masks)
> +{
> +	for (size_t i = 0; i < ARRAY_SIZE(masks->access); i++)
> +		if (masks->access[i])
> +			return false;
> +	return true;
> +}
> +
>  /*
>   * Tracks domains responsible of a denied access.  This avoids storing in each
>   * object the full matrix of per-layer unfulfilled access rights, which is
> diff --git a/security/landlock/audit.c b/security/landlock/audit.c
> index 60ff217ab95b..8d0edf94037d 100644
> --- a/security/landlock/audit.c
> +++ b/security/landlock/audit.c
> @@ -37,6 +37,7 @@ static const char *const fs_access_strings[] = {
>  	[BIT_INDEX(LANDLOCK_ACCESS_FS_REFER)] = "fs.refer",
>  	[BIT_INDEX(LANDLOCK_ACCESS_FS_TRUNCATE)] = "fs.truncate",
>  	[BIT_INDEX(LANDLOCK_ACCESS_FS_IOCTL_DEV)] = "fs.ioctl_dev",
> +	[BIT_INDEX(LANDLOCK_ACCESS_FS_RESOLVE_UNIX)] = "fs.resolve_unix",
>  };
>  
>  static_assert(ARRAY_SIZE(fs_access_strings) == LANDLOCK_NUM_ACCESS_FS);
> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index e764470f588c..76035c6f2bf1 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c
> @@ -27,6 +27,7 @@
>  #include <linux/lsm_hooks.h>
>  #include <linux/mount.h>
>  #include <linux/namei.h>
> +#include <linux/net.h>
>  #include <linux/path.h>
>  #include <linux/pid.h>
>  #include <linux/rcupdate.h>
> @@ -314,7 +315,8 @@ static struct landlock_object *get_inode_object(struct inode *const inode)
>  	LANDLOCK_ACCESS_FS_WRITE_FILE | \
>  	LANDLOCK_ACCESS_FS_READ_FILE | \
>  	LANDLOCK_ACCESS_FS_TRUNCATE | \
> -	LANDLOCK_ACCESS_FS_IOCTL_DEV)
> +	LANDLOCK_ACCESS_FS_IOCTL_DEV | \
> +	LANDLOCK_ACCESS_FS_RESOLVE_UNIX)
>  /* clang-format on */
>  
>  /*
> @@ -1561,6 +1563,103 @@ static int hook_path_truncate(const struct path *const path)
>  	return current_check_access_path(path, LANDLOCK_ACCESS_FS_TRUNCATE);
>  }
>  
> +/**
> + * unmask_scoped_access - Remove access right bits in @masks in all layers
> + *                        where @client and @server have the same domain
> + *
> + * This does the same as domain_is_scoped(), but unmasks bits in @masks.
> + * It can not return early as domain_is_scoped() does.
> + *
> + * @client: Client domain
> + * @server: Server domain
> + * @masks: Layer access masks to unmask
> + * @access: Access bit that controls scoping
> + */
> +static void unmask_scoped_access(const struct landlock_ruleset *const client,
> +				 const struct landlock_ruleset *const server,
> +				 struct layer_access_masks *const masks,
> +				 const access_mask_t access)

This helper should be moved to task.c and factored out with
domain_is_scoped().  This should be a dedicated patch.

> +{
> +	int client_layer, server_layer;
> +	const struct landlock_hierarchy *client_walker, *server_walker;
> +
> +	if (WARN_ON_ONCE(!client))
> +		return; /* should not happen */
> +
> +	if (!server)
> +		return; /* server has no Landlock domain; nothing to clear */
> +
> +	client_layer = client->num_layers - 1;
> +	client_walker = client->hierarchy;
> +	server_layer = server->num_layers - 1;
> +	server_walker = server->hierarchy;
> +
> +	/*
> +	 * Clears the access bits at all layers where the client domain is the
> +	 * same as the server domain.  We start the walk at min(client_layer,
> +	 * server_layer).  The layer bits until there can not be cleared because
> +	 * either the client or the server domain is missing.
> +	 */
> +	for (; client_layer > server_layer; client_layer--)
> +		client_walker = client_walker->parent;
> +
> +	for (; server_layer > client_layer; server_layer--)
> +		server_walker = server_walker->parent;
> +
> +	for (; client_layer >= 0; client_layer--) {
> +		if (masks->access[client_layer] & access &&
> +		    client_walker == server_walker)
> +			masks->access[client_layer] &= ~access;
> +
> +		client_walker = client_walker->parent;
> +		server_walker = server_walker->parent;
> +	}
> +}
> +
> +static int hook_unix_find(const struct path *const path, struct sock *other,
> +			  int flags)
> +{
> +	const struct landlock_ruleset *dom_other;
> +	const struct landlock_cred_security *subject;
> +	struct layer_access_masks layer_masks;
> +	struct landlock_request request = {};
> +	static const struct access_masks fs_resolve_unix = {
> +		.fs = LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
> +	};
> +
> +	/* Lookup for the purpose of saving coredumps is OK. */
> +	if (unlikely(flags & SOCK_COREDUMP))
> +		return 0;
> +
> +	/* Access to the same (or a lower) domain is always allowed. */
> +	subject = landlock_get_applicable_subject(current_cred(),
> +						  fs_resolve_unix, NULL);
> +
> +	if (!subject)
> +		return 0;
> +
> +	if (!landlock_init_layer_masks(subject->domain, fs_resolve_unix.fs,
> +				       &layer_masks, LANDLOCK_KEY_INODE))
> +		return 0;
> +
> +	/* Checks the layers in which we are connecting within the same domain. */
> +	dom_other = landlock_cred(other->sk_socket->file->f_cred)->domain;

We need to call unix_state_lock(other) before reading it, and check for
SOCK_DEAD, and check sk_socket before dereferencing it.  Indeed,
the socket can be make orphan (see unix_dgram_sendmsg and
unix_stream_connect).  I *think* a socket cannot be "resurrected" or
recycled once dead, so we may assume there is no race condition wrt
dom_other, but please double check.  This lockless call should be made
clear in the LSM hook.  It's OK to not lock the socket before
security_unix_find() (1) because no LSM might implement and (2) they
might not need to lock the socket (e.g. if the caller is not sandboxed).

The updated code should look something like this:

unix_state_unlock(other);
if (unlikely(sock_flag(other, SOCK_DEAD) || !other->sk_socket)) {
	unix_state_unlock(other);
	return 0;
}

dom_other = landlock_cred(other->sk_socket->file->f_cred)->domain;
unix_state_unlock(other);


> +	unmask_scoped_access(subject->domain, dom_other, &layer_masks,
> +			     fs_resolve_unix.fs);
> +
> +	if (layer_access_masks_empty(&layer_masks))
> +		return 0;
> +
> +	/* Checks the connections to allow-listed paths. */
> +	if (is_access_to_paths_allowed(subject->domain, path,
> +				       fs_resolve_unix.fs, &layer_masks,
> +				       &request, NULL, 0, NULL, NULL, NULL))
> +		return 0;
> +
> +	landlock_log_denial(subject, &request);
> +	return -EACCES;
> +}
> +
>  /* File hooks */
>  
>  /**
> @@ -1838,6 +1937,7 @@ static struct security_hook_list landlock_hooks[] __ro_after_init = {
>  	LSM_HOOK_INIT(path_unlink, hook_path_unlink),
>  	LSM_HOOK_INIT(path_rmdir, hook_path_rmdir),
>  	LSM_HOOK_INIT(path_truncate, hook_path_truncate),
> +	LSM_HOOK_INIT(unix_find, hook_unix_find),
>  
>  	LSM_HOOK_INIT(file_alloc_security, hook_file_alloc_security),
>  	LSM_HOOK_INIT(file_open, hook_file_open),
> diff --git a/security/landlock/limits.h b/security/landlock/limits.h
> index eb584f47288d..b454ad73b15e 100644
> --- a/security/landlock/limits.h
> +++ b/security/landlock/limits.h
> @@ -19,7 +19,7 @@
>  #define LANDLOCK_MAX_NUM_LAYERS		16
>  #define LANDLOCK_MAX_NUM_RULES		U32_MAX
>  
> -#define LANDLOCK_LAST_ACCESS_FS		LANDLOCK_ACCESS_FS_IOCTL_DEV
> +#define LANDLOCK_LAST_ACCESS_FS		LANDLOCK_ACCESS_FS_RESOLVE_UNIX
>  #define LANDLOCK_MASK_ACCESS_FS		((LANDLOCK_LAST_ACCESS_FS << 1) - 1)
>  #define LANDLOCK_NUM_ACCESS_FS		__const_hweight64(LANDLOCK_MASK_ACCESS_FS)
>  
> diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
> index 0d66a68677b7..933902d43241 100644
> --- a/security/landlock/syscalls.c
> +++ b/security/landlock/syscalls.c
> @@ -164,7 +164,7 @@ static const struct file_operations ruleset_fops = {
>   * If the change involves a fix that requires userspace awareness, also update
>   * the errata documentation in Documentation/userspace-api/landlock.rst .
>   */
> -const int landlock_abi_version = 8;
> +const int landlock_abi_version = 9;
>  
>  /**
>   * sys_landlock_create_ruleset - Create a new ruleset
> diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing/selftests/landlock/base_test.c
> index 0fea236ef4bd..30d37234086c 100644
> --- a/tools/testing/selftests/landlock/base_test.c
> +++ b/tools/testing/selftests/landlock/base_test.c
> @@ -76,7 +76,7 @@ TEST(abi_version)
>  	const struct landlock_ruleset_attr ruleset_attr = {
>  		.handled_access_fs = LANDLOCK_ACCESS_FS_READ_FILE,
>  	};
> -	ASSERT_EQ(8, landlock_create_ruleset(NULL, 0,
> +	ASSERT_EQ(9, landlock_create_ruleset(NULL, 0,
>  					     LANDLOCK_CREATE_RULESET_VERSION));
>  
>  	ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr, 0,
> diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
> index 968a91c927a4..b318627e7561 100644
> --- a/tools/testing/selftests/landlock/fs_test.c
> +++ b/tools/testing/selftests/landlock/fs_test.c
> @@ -575,9 +575,10 @@ TEST_F_FORK(layout1, inval)
>  	LANDLOCK_ACCESS_FS_WRITE_FILE | \
>  	LANDLOCK_ACCESS_FS_READ_FILE | \
>  	LANDLOCK_ACCESS_FS_TRUNCATE | \
> -	LANDLOCK_ACCESS_FS_IOCTL_DEV)
> +	LANDLOCK_ACCESS_FS_IOCTL_DEV | \
> +	LANDLOCK_ACCESS_FS_RESOLVE_UNIX)
>  
> -#define ACCESS_LAST LANDLOCK_ACCESS_FS_IOCTL_DEV
> +#define ACCESS_LAST LANDLOCK_ACCESS_FS_RESOLVE_UNIX
>  
>  #define ACCESS_ALL ( \
>  	ACCESS_FILE | \
> -- 
> 2.52.0
> 
> 
