Received: from smtp-1908.mail.infomaniak.ch (smtp-1908.mail.infomaniak.ch [185.125.25.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6331C3C11
	for <linux-security-module@vger.kernel.org>; Fri, 21 Nov 2025 15:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763738846; cv=none; b=gJPDmFtfL18Iwjoe/ugltjAXfbKRg4Qy9uz1C5FaDvJ37fyfQJ91A35o5WcqPhtL51IwRnhIVsb7AeDlQiv1lhIMZdwSVm4ZOHZrw5q521SXcUC7QrarSWi6pMQkFQviGS3TksajOsf56zxUmXwd0lE4QLOajnXFn4HC9sDL2yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763738846; c=relaxed/simple;
	bh=wozHYT8X3Go7QZizvM9EchtH7cFQNpJPUgxXXFYlOic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gL5T5n2a+dbPegqRaD74h+XwVGHm93dV+g91RRulZZrSuSaq9FMiISQUVA8GvTJ7dqF7T9eV/JqcAg6yPTvhQVpP0wqPhPyHj4oHiX01NnuN5peH2qmwQy6VSbIZ5ZH/UQvVgA7zHUbKrGy6FgXd8LXuHCe8XIKxI2yrkcSJGbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=D1ZQ+qvz; arc=none smtp.client-ip=185.125.25.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="D1ZQ+qvz"
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dCfGS3Y48zBhf;
	Fri, 21 Nov 2025 16:27:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1763738832;
	bh=xYU7kl7ZheKufs0kccogjPTv96FtNRoFfzOgTeBUW58=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D1ZQ+qvzTt2Ui96F8LPOczeL8Rs1iyvFpW/+zIBHKb5QoE0iNHqC5bUl2wcizrTLz
	 1QUZd86snqSCoOl8O6PSlJ8LNUMfvEsMviDz27bfqUXTLBYbf84VK65as5izu2GF3Z
	 dLDF294shhqHni4ZfOpGdEzkAPsH809YBfcUCXcs=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4dCfGR1JSNzCkq;
	Fri, 21 Nov 2025 16:27:11 +0100 (CET)
Date: Fri, 21 Nov 2025 16:27:02 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tingmao Wang <m@maowtm.org>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Justin Suess <utilityemal77@gmail.com>, Jan Kara <jack@suse.cz>, Abhinav Saxena <xandfury@gmail.com>, 
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v4 02/10] landlock: Add API support and docs for the
 quiet flags
Message-ID: <20251120.Sae4geish0ei@digikod.net>
References: <cover.1763330228.git.m@maowtm.org>
 <cd79fcf71e6d38ab4280c0de2500fa5f6b06cd9d.1763330228.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cd79fcf71e6d38ab4280c0de2500fa5f6b06cd9d.1763330228.git.m@maowtm.org>
X-Infomaniak-Routing: alpha

On Sun, Nov 16, 2025 at 09:59:32PM +0000, Tingmao Wang wrote:
> Adds the UAPI for the quiet flags feature (but not the implementation
> yet).
> 
> According to pahole, even after adding the struct access_masks quiet_masks
> in struct landlock_hierarchy, the u32 log_* bitfield still only has a size
> of 2 bytes, so there's minimal wasted space.
> 
> Signed-off-by: Tingmao Wang <m@maowtm.org>
> ---
> 
> Changes since v3:
> - Minor update to this commit message.
> - Fix minor formatting
> 
> Changes since v2:
> - Updated docs from Mickaël's suggestions.
> 
> Changes since v1:
> - Per suggestion, added support for quieting only certain access bits,
>   controlled by extra quiet_access_* fields in the ruleset_attr.
> - Added docs for the extra fields and made updates to doc changes in v1.
>   In particular, call out that the effect of LANDLOCK_ADD_RULE_QUIET is
>   independent from the access bits passed in rule_attr
> - landlock_add_rule will return -EINVAL when LANDLOCK_ADD_RULE_QUIET is
>   used but the ruleset does not have any quiet access bits set for the
>   given rule type.
> - ABI version bump to v8
> - Syntactic and comment changes per suggestion.
> 
>  include/uapi/linux/landlock.h                | 64 +++++++++++++++++
>  security/landlock/domain.h                   |  5 ++
>  security/landlock/fs.c                       |  4 +-
>  security/landlock/fs.h                       |  2 +-
>  security/landlock/net.c                      |  5 +-
>  security/landlock/net.h                      |  3 +-
>  security/landlock/ruleset.c                  | 10 ++-
>  security/landlock/ruleset.h                  |  8 ++-
>  security/landlock/syscalls.c                 | 72 +++++++++++++++-----
>  tools/testing/selftests/landlock/base_test.c |  4 +-
>  10 files changed, 150 insertions(+), 27 deletions(-)
> 
> diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
> index f030adc462ee..50f0806b7e33 100644
> --- a/include/uapi/linux/landlock.h
> +++ b/include/uapi/linux/landlock.h
> @@ -32,6 +32,19 @@
>   * *handle* a wide range or all access rights that they know about at build time
>   * (and that they have tested with a kernel that supported them all).
>   *
> + * @quiet_access_fs and @quiet_access_net are bitmasks of actions for
> + * which a denial by this layer will not trigger an audit log if the
> + * corresponding object (or its children, for filesystem rules) is marked
> + * with the "quiet" bit via %LANDLOCK_ADD_RULE_QUIET, even if logging
> + * would normally take place per landlock_restrict_self() flags.
> + * quiet_scoped is similar, except that it does not require marking any
> + * objects as quiet - if the ruleset is created with any bits set in
> + * quiet_scoped, then denial of such scoped resources will not trigger any
> + * log.  These 3 fields are available since Landlock ABI version 8.
> + *
> + * @quiet_access_fs, @quiet_access_net and @quiet_scoped must be a subset
> + * of @handled_access_fs, @handled_access_net and @scoped respectively.
> + *
>   * This structure can grow in future Landlock versions.
>   */
>  struct landlock_ruleset_attr {
> @@ -51,6 +64,24 @@ struct landlock_ruleset_attr {
>  	 * resources (e.g. IPCs).
>  	 */
>  	__u64 scoped;
> +
> +	/* Since ABI 8: */
> +
> +	/**
> +	 * @quiet_access_fs: Bitmask of filesystem actions which should not be
> +	 * audit logged if per-object quiet flag is set.
> +	 */
> +	__u64 quiet_access_fs;
> +	/**
> +	 * @quiet_access_net: Bitmask of network actions which should not be
> +	 * audit logged if per-object quiet flag is set.
> +	 */
> +	__u64 quiet_access_net;
> +	/**
> +	 * @quiet_scoped: Bitmask of scoped actions which should not be audit
> +	 * logged.
> +	 */
> +	__u64 quiet_scoped;
>  };
>  
>  /**
> @@ -69,6 +100,39 @@ struct landlock_ruleset_attr {
>  #define LANDLOCK_CREATE_RULESET_ERRATA			(1U << 1)
>  /* clang-format on */
>  
> +/**
> + * DOC: landlock_add_rule_flags
> + *
> + * **Flags**
> + *
> + * %LANDLOCK_ADD_RULE_QUIET
> + *     Together with the quiet_* fields in struct landlock_ruleset_attr,
> + *     this flag controls whether Landlock will log audit messages when
> + *     access to the objects covered by this rule is denied by this layer.
> + *
> + *     If audit logging is enabled, when Landlock denies an access, it will
> + *     suppress the audit log if all of the following are true:
> + *
> + *     - This layer is the innermost layer that denied the access;

Because these items follows ":" they should not start with a capital
letter (e.g. "- this layer ...").

> + *     - All requested accesses are part of the quiet_* fields in the
> + *       related struct landlock_ruleset_attr;

This should be updated to reflect my comment in the next patch about
landlock_log_denial().

> + *     - The object (or one of its parents, for filesystem rules) is
> + *       marked as "quiet" via %LANDLOCK_ADD_RULE_QUIET.
> + *
> + *     Because logging is only suppressed by a layer if the layer denies
> + *     access, a sandboxed program cannot use this flag to "hide" access
> + *     denials, without denying itself the access in the first place.
> + *
> + *     The effect of this flag does not depend on the value of
> + *     allowed_access in the passed in rule_attr.  When this flag is
> + *     present, the caller is also allowed to pass in an empty
> + *     allowed_access.
> + */
> +
> +/* clang-format off */
> +#define LANDLOCK_ADD_RULE_QUIET			(1U << 0)
> +/* clang-format on */
> +
>  /**
>   * DOC: landlock_restrict_self_flags
>   *
> diff --git a/security/landlock/domain.h b/security/landlock/domain.h
> index 7fb70b25f85a..aadbf53505c0 100644
> --- a/security/landlock/domain.h
> +++ b/security/landlock/domain.h
> @@ -114,6 +114,11 @@ struct landlock_hierarchy {
>  		 * %LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON.  Set to false by default.
>  		 */
>  		log_new_exec : 1;
> +	/**
> +	 * @quiet_masks: Bitmasks of access that should be quieted (i.e. not
> +	 * logged) if the related object is marked as quiet.
> +	 */
> +	struct access_masks quiet_masks;

Please update the above @work_free doc.

>  #endif /* CONFIG_AUDIT */
>  };
>  
