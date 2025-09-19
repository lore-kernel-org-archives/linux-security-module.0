Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch [84.16.66.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1BC1F4C8C
	for <linux-security-module@vger.kernel.org>; Fri, 19 Sep 2025 16:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758297779; cv=none; b=AL17I96UNQfIHsnX1OwVRVvpdpaToqnoq1xD6dKKt/tP6351eure49n2fu/aP0jnRyRAdoXqbmBSB/Hyj37R5yVqROV3j+dGNJV2i60e2akhhrb23DG1JHrpfkaILzAchNmeOhQSry6w6GBYmThITNGmMA//BpLYYoH+BHdJVYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758297779; c=relaxed/simple;
	bh=mhdlllPVlImDXnJ0HkHJEt+UXuvDKpkyZsc/FHhu3Go=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B3IEIhrA2hpgpssFqMlQi98dbMW3/EiCvvoUhog94w41bHAYSDTgyQ532wY2ZKqeGg1X47LcK6PRsMXqvcuRFyn2kNsyOt0GPoFXX0Q6TMT/2wK9k2Mchqx38kx+BmkhvcLnnNvhr5fFzyWuvjDiWse750s6/ZNcsnZjdlXj/U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=qx9Rjd1D; arc=none smtp.client-ip=84.16.66.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="qx9Rjd1D"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4cSy2X1JVFzZt9;
	Fri, 19 Sep 2025 18:02:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1758297764;
	bh=0TzWNd4EqEt//E1wzT2OQHw3/9HxWUnl7v881q2ebCI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qx9Rjd1DnXxE/MC7GkEQHlf6Y9Qqwvhoo4BE+USk4K4OaoUxiwlfJosZH7Y3EpO5E
	 Ibyy2fWwz53aCEezTL+ZkBu8Dg6mS+yPPBJnI6tuhbCpLrLbl+tIBH53AP6R64fou2
	 0hhI0eOitALbHvNn2wIJZye40yFxq7eNSsybFOTo=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4cSy2W4y4vz2db;
	Fri, 19 Sep 2025 18:02:43 +0200 (CEST)
Date: Fri, 19 Sep 2025 18:02:43 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tingmao Wang <m@maowtm.org>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Jan Kara <jack@suse.cz>, linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH 2/6] landlock: Add API support for the quiet flag
Message-ID: <20250919.moo3wor7VooJ@digikod.net>
References: <cover.1757376311.git.m@maowtm.org>
 <e9462ee16376d706188d48d8f4b4fd50760432e5.1757376311.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e9462ee16376d706188d48d8f4b4fd50760432e5.1757376311.git.m@maowtm.org>
X-Infomaniak-Routing: alpha

On Tue, Sep 09, 2025 at 01:06:36AM +0100, Tingmao Wang wrote:
> Also added documentation.
> 
> As for kselftests, for now we just change add_rule_checks_ordering to use
> a different invalid flag.  I will add tests for the quiet flag in a later
> version.
> 
> Signed-off-by: Tingmao Wang <m@maowtm.org>
> ---
>  include/uapi/linux/landlock.h                | 25 +++++++++++++++++
>  security/landlock/fs.c                       |  4 +--
>  security/landlock/fs.h                       |  2 +-
>  security/landlock/net.c                      |  5 ++--
>  security/landlock/net.h                      |  3 ++-
>  security/landlock/ruleset.c                  |  8 +++++-
>  security/landlock/ruleset.h                  |  2 +-
>  security/landlock/syscalls.c                 | 28 ++++++++++++--------
>  tools/testing/selftests/landlock/base_test.c |  2 +-
>  9 files changed, 59 insertions(+), 20 deletions(-)
> 
> diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
> index f030adc462ee..3e5b2ce0b18b 100644
> --- a/include/uapi/linux/landlock.h
> +++ b/include/uapi/linux/landlock.h
> @@ -69,6 +69,31 @@ struct landlock_ruleset_attr {
>  #define LANDLOCK_CREATE_RULESET_ERRATA			(1U << 1)
>  /* clang-format on */
>  
> +/**
> + * DOC: landlock_add_rule_flags
> + *
> + * **Flags**
> + *
> + * %LANDLOCK_ADD_RULE_QUIET
> + *     This flag controls whether Landlock will log audit messages when
> + *     access to the objects covered by this rule is denied by this layer.
> + *
> + *     When Landlock denies an access, if audit logging is enabled,
> + *     Landlock will check if the youngest layer that denied the access
> + *     has marked the object in question as "quiet".  If so, no audit log
> + *     will be generated.  Note that logging is only suppressed if the
> + *     layer that denied the access is this layer.  This means that a
> + *     sandboxed program cannot use this flag to "hide" access denials,
> + *     unless it denies itself the access.
> + *
> + *     When this flag is present, the caller is allowed to pass in a rule
> + *     with empty allowed_access.
> + */
> +
> +/* clang-format off */
> +#define LANDLOCK_ADD_RULE_QUIET			(1U << 0)
> +/* clang-format on */
> +
>  /**
>   * DOC: landlock_restrict_self_flags
>   *
> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index e7eaf55093e9..b566ae498df5 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c
> @@ -322,7 +322,7 @@ static struct landlock_object *get_inode_object(struct inode *const inode)
>   */
>  int landlock_append_fs_rule(struct landlock_ruleset *const ruleset,
>  			    const struct path *const path,
> -			    access_mask_t access_rights)
> +			    access_mask_t access_rights, const int flags)
>  {
>  	int err;
>  	struct landlock_id id = {
> @@ -343,7 +343,7 @@ int landlock_append_fs_rule(struct landlock_ruleset *const ruleset,
>  	if (IS_ERR(id.key.object))
>  		return PTR_ERR(id.key.object);
>  	mutex_lock(&ruleset->lock);
> -	err = landlock_insert_rule(ruleset, id, access_rights);
> +	err = landlock_insert_rule(ruleset, id, access_rights, flags);
>  	mutex_unlock(&ruleset->lock);
>  	/*
>  	 * No need to check for an error because landlock_insert_rule()
> diff --git a/security/landlock/fs.h b/security/landlock/fs.h
> index bf9948941f2f..cb7e654933ac 100644
> --- a/security/landlock/fs.h
> +++ b/security/landlock/fs.h
> @@ -126,6 +126,6 @@ __init void landlock_add_fs_hooks(void);
>  
>  int landlock_append_fs_rule(struct landlock_ruleset *const ruleset,
>  			    const struct path *const path,
> -			    access_mask_t access_hierarchy);
> +			    access_mask_t access_hierarchy, const int flags);
>  
>  #endif /* _SECURITY_LANDLOCK_FS_H */
> diff --git a/security/landlock/net.c b/security/landlock/net.c
> index fc6369dffa51..bddbe93d69fd 100644
> --- a/security/landlock/net.c
> +++ b/security/landlock/net.c
> @@ -20,7 +20,8 @@
>  #include "ruleset.h"
>  
>  int landlock_append_net_rule(struct landlock_ruleset *const ruleset,
> -			     const u16 port, access_mask_t access_rights)
> +			     const u16 port, access_mask_t access_rights,
> +			     const int flags)
>  {
>  	int err;
>  	const struct landlock_id id = {
> @@ -35,7 +36,7 @@ int landlock_append_net_rule(struct landlock_ruleset *const ruleset,
>  			 ~landlock_get_net_access_mask(ruleset, 0);
>  
>  	mutex_lock(&ruleset->lock);
> -	err = landlock_insert_rule(ruleset, id, access_rights);
> +	err = landlock_insert_rule(ruleset, id, access_rights, flags);
>  	mutex_unlock(&ruleset->lock);
>  
>  	return err;
> diff --git a/security/landlock/net.h b/security/landlock/net.h
> index 09960c237a13..799cedd5d0b7 100644
> --- a/security/landlock/net.h
> +++ b/security/landlock/net.h
> @@ -16,7 +16,8 @@
>  __init void landlock_add_net_hooks(void);
>  
>  int landlock_append_net_rule(struct landlock_ruleset *const ruleset,
> -			     const u16 port, access_mask_t access_rights);
> +			     const u16 port, access_mask_t access_rights,
> +			     const int flags);
>  #else /* IS_ENABLED(CONFIG_INET) */
>  static inline void landlock_add_net_hooks(void)
>  {
> diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
> index 3aa4e33ac95b..990aa1a2c120 100644
> --- a/security/landlock/ruleset.c
> +++ b/security/landlock/ruleset.c
> @@ -21,6 +21,7 @@
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
>  #include <linux/workqueue.h>
> +#include <uapi/linux/landlock.h>
>  
>  #include "access.h"
>  #include "audit.h"
> @@ -251,6 +252,7 @@ static int insert_rule(struct landlock_ruleset *const ruleset,
>  			if (WARN_ON_ONCE(this->layers[0].level != 0))
>  				return -EINVAL;
>  			this->layers[0].access |= (*layers)[0].access;
> +			this->layers[0].flags.quiet |= (*layers)[0].flags.quiet;
>  			return 0;
>  		}
>  
> @@ -297,12 +299,15 @@ static void build_check_layer(void)
>  /* @ruleset must be locked by the caller. */
>  int landlock_insert_rule(struct landlock_ruleset *const ruleset,
>  			 const struct landlock_id id,
> -			 const access_mask_t access)
> +			 const access_mask_t access, const int flags)
>  {
>  	struct landlock_layer layers[] = { {
>  		.access = access,
>  		/* When @level is zero, insert_rule() extends @ruleset. */
>  		.level = 0,
> +		.flags = {
> +			.quiet = flags & LANDLOCK_ADD_RULE_QUIET ? 1 : 0,

This looks better to me (no hardcoded values):

.quiet = !!(flags & LANDLOCK_ADD_RULE_QUIET,


> +		}
>  	} };
>  
>  	build_check_layer();
> @@ -343,6 +348,7 @@ static int merge_tree(struct landlock_ruleset *const dst,
>  			return -EINVAL;
>  
>  		layers[0].access = walker_rule->layers[0].access;
> +		layers[0].flags = walker_rule->layers[0].flags;
>  
>  		err = insert_rule(dst, id, &layers, ARRAY_SIZE(layers));
>  		if (err)
> diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
> index d4b70b6af137..4f184d2da382 100644
> --- a/security/landlock/ruleset.h
> +++ b/security/landlock/ruleset.h
> @@ -224,7 +224,7 @@ DEFINE_FREE(landlock_put_ruleset, struct landlock_ruleset *,
>  
>  int landlock_insert_rule(struct landlock_ruleset *const ruleset,
>  			 const struct landlock_id id,
> -			 const access_mask_t access);
> +			 const access_mask_t access, const int flags);
>  
>  struct landlock_ruleset *
>  landlock_merge_ruleset(struct landlock_ruleset *const parent,
> diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
> index 0116e9f93ffe..e46164246fdb 100644
> --- a/security/landlock/syscalls.c
> +++ b/security/landlock/syscalls.c
> @@ -312,7 +312,7 @@ static int get_path_from_fd(const s32 fd, struct path *const path)
>  }
>  
>  static int add_rule_path_beneath(struct landlock_ruleset *const ruleset,
> -				 const void __user *const rule_attr)
> +				 const void __user *const rule_attr, int flags)
>  {
>  	struct landlock_path_beneath_attr path_beneath_attr;
>  	struct path path;
> @@ -328,8 +328,10 @@ static int add_rule_path_beneath(struct landlock_ruleset *const ruleset,
>  	/*
>  	 * Informs about useless rule: empty allowed_access (i.e. deny rules)
>  	 * are ignored in path walks.
> +	 * (However, the rule is not useless if it is there to hold a quiet
> +	 * flag)

There is no need for parenthesis, please just append to the previous
sentence.

>  	 */
> -	if (!path_beneath_attr.allowed_access)
> +	if (!flags && !path_beneath_attr.allowed_access)
>  		return -ENOMSG;
>  
>  	/* Checks that allowed_access matches the @ruleset constraints. */
> @@ -344,13 +346,13 @@ static int add_rule_path_beneath(struct landlock_ruleset *const ruleset,
>  
>  	/* Imports the new rule. */
>  	err = landlock_append_fs_rule(ruleset, &path,
> -				      path_beneath_attr.allowed_access);
> +				      path_beneath_attr.allowed_access, flags);
>  	path_put(&path);
>  	return err;
>  }
>  
>  static int add_rule_net_port(struct landlock_ruleset *ruleset,
> -			     const void __user *const rule_attr)
> +			     const void __user *const rule_attr, int flags)
>  {
>  	struct landlock_net_port_attr net_port_attr;
>  	int res;
> @@ -364,8 +366,10 @@ static int add_rule_net_port(struct landlock_ruleset *ruleset,
>  	/*
>  	 * Informs about useless rule: empty allowed_access (i.e. deny rules)
>  	 * are ignored by network actions.
> +	 * (However, the rule is not useless if it is there to hold a quiet
> +	 * flag)

ditto

>  	 */
> -	if (!net_port_attr.allowed_access)
> +	if (!flags && !net_port_attr.allowed_access)
>  		return -ENOMSG;
>  
>  	/* Checks that allowed_access matches the @ruleset constraints. */
> @@ -379,7 +383,7 @@ static int add_rule_net_port(struct landlock_ruleset *ruleset,
>  
>  	/* Imports the new rule. */
>  	return landlock_append_net_rule(ruleset, net_port_attr.port,
> -					net_port_attr.allowed_access);
> +					net_port_attr.allowed_access, flags);
>  }
>  
>  /**
> @@ -390,7 +394,7 @@ static int add_rule_net_port(struct landlock_ruleset *ruleset,
>   * @rule_type: Identify the structure type pointed to by @rule_attr:
>   *             %LANDLOCK_RULE_PATH_BENEATH or %LANDLOCK_RULE_NET_PORT.
>   * @rule_attr: Pointer to a rule (matching the @rule_type).
> - * @flags: Must be 0.
> + * @flags: Must be 0 or %LANDLOCK_ADD_RULE_QUIET.
>   *
>   * This system call enables to define a new rule and add it to an existing
>   * ruleset.
> @@ -414,6 +418,9 @@ static int add_rule_net_port(struct landlock_ruleset *ruleset,
>   *   @rule_attr is not the expected file descriptor type;
>   * - %EPERM: @ruleset_fd has no write access to the underlying ruleset;
>   * - %EFAULT: @rule_attr was not a valid address.
> + *
> + * .. kernel-doc:: include/uapi/linux/landlock.h
> + *     :identifiers: landlock_add_rule_flags
>   */
>  SYSCALL_DEFINE4(landlock_add_rule, const int, ruleset_fd,
>  		const enum landlock_rule_type, rule_type,
> @@ -424,8 +431,7 @@ SYSCALL_DEFINE4(landlock_add_rule, const int, ruleset_fd,
>  	if (!is_initialized())
>  		return -EOPNOTSUPP;
>  
> -	/* No flag for now. */
> -	if (flags)
> +	if (flags && flags != LANDLOCK_ADD_RULE_QUIET)
>  		return -EINVAL;
>  
>  	/* Gets and checks the ruleset. */
> @@ -435,9 +441,9 @@ SYSCALL_DEFINE4(landlock_add_rule, const int, ruleset_fd,
>  
>  	switch (rule_type) {
>  	case LANDLOCK_RULE_PATH_BENEATH:
> -		return add_rule_path_beneath(ruleset, rule_attr);
> +		return add_rule_path_beneath(ruleset, rule_attr, flags);
>  	case LANDLOCK_RULE_NET_PORT:
> -		return add_rule_net_port(ruleset, rule_attr);
> +		return add_rule_net_port(ruleset, rule_attr, flags);
>  	default:
>  		return -EINVAL;
>  	}
> diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing/selftests/landlock/base_test.c
> index 7b69002239d7..d07a0bf6927c 100644
> --- a/tools/testing/selftests/landlock/base_test.c
> +++ b/tools/testing/selftests/landlock/base_test.c
> @@ -201,7 +201,7 @@ TEST(add_rule_checks_ordering)
>  	ASSERT_LE(0, ruleset_fd);
>  
>  	/* Checks invalid flags. */
> -	ASSERT_EQ(-1, landlock_add_rule(-1, 0, NULL, 1));
> +	ASSERT_EQ(-1, landlock_add_rule(-1, 0, NULL, 100));
>  	ASSERT_EQ(EINVAL, errno);
>  
>  	/* Checks invalid ruleset FD. */
> -- 
> 2.51.0
> 
> 
