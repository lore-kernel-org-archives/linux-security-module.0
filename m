Received: from smtp-42a9.mail.infomaniak.ch (smtp-42a9.mail.infomaniak.ch [84.16.66.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F65D30C35C
	for <linux-security-module@vger.kernel.org>; Wed, 10 Jun 2026 13:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781098754; cv=none; b=ARhuKbDj+VMwz/azG5VkmRorK3NpV36oI3zDm6kcixCEJddzXUW51ylR18O+cENZ0T9sCiHEgBFHeVVIx/ORj7ijvc6ZCRkZLsIurEpBrN+DabCWrvsThSkzCpPZSbIEWMfbwhJINUN3YCHzMoO+bLTZBel6ys2M3EIAykA1cGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781098754; c=relaxed/simple;
	bh=xyirM9JYeuWy58K586Ld9PiD+foLazEMeL1AVtZXnpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e97ZTuTBeFPUI+JRiY6ArbQxGWQm6K2RRyETiTgH7CvZDbNs9OFm7bSFfLWmLR343ZBwS5whHQhUHLl6mD7t33zfobG3T7cpo10hZMZKHjqpToO4r04Jc5bZKeEgO6BpXH9UbKCoi4MwsGiHsVdxu7FqnTDrlJYZUuQpgY1/ZJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=Jab3FV7q; arc=none smtp.client-ip=84.16.66.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="Jab3FV7q"
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gb6Ls1v68zSC9;
	Wed, 10 Jun 2026 15:39:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1781098741;
	bh=USuC7NRonVBgUloLi4FSyuFH2OeXPDqa2TXlZ4jmlWw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jab3FV7qxTjVwb4ROsvQ1vmL9SiyT5ZEsOhtVcCFSo7USOj8pqGr8TfYHn90TD6oR
	 1hjzAhswIvAkS9/pxOYJk6tkQUpke1nCO2Yzc8c6idZy8dW5bmx1rTE0DJyMbM8osf
	 2teVfZ89R6q5pCLi1RejeMS1cEZP6+iDA7jK1fVw=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4gb6Lr1khVzNmg;
	Wed, 10 Jun 2026 15:39:00 +0200 (CEST)
Date: Wed, 10 Jun 2026 15:38:56 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc: Christian Brauner <brauner@kernel.org>, 
	linux-security-module@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	Serge Hallyn <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: Re: [PATCH v3 1/3] landlock: Require
 LANDLOCK_ACCESS_FS_MAKE_WHITEOUT for RENAME_WHITEOUT
Message-ID: <20260610.uoMee2quoo9k@digikod.net>
References: <20260610092318.3868884-1-gnoack@google.com>
 <20260610092318.3868884-2-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260610092318.3868884-2-gnoack@google.com>
X-Infomaniak-Routing: alpha

Making MAKE_CHAR not covering MAKE_WHITEOUT is not addressed (see
previous discussion).  MAKE_CHAR should not restrict whiteout creation
*if* MAKE_WHITEOUT is handled.  Specific tests should check that all
these cases are proprely handled.

There is no documentation update related to the new feature.  A note
should also explain what exactly is a whiteout and why it is not
considered a character device (see previous discussions).

The sandboxer is not updated.

There is no audit tests.


On Wed, Jun 10, 2026 at 11:23:16AM +0200, Günther Noack wrote:
> renameat2(2) with the RENAME_WHITEOUT flag places a whiteout character
> device file in the source file location in place of the moved file.
> This creates a directory entry even in cases where all
> LANDLOCK_ACCESS_FS_MAKE_* rights are denied.
> 
> Introduce the LANDLOCK_ACCESS_FS_MAKE_WHITEOUT right, which is checked
> for the origin directory if RENAME_WHITEOUT is passed.
> 
> This does not affect normal renames within layered OverlayFS mounts:
> When OverlayFS invokes rename with RENAME_WHITEOUT as part of a
> "normal" rename operation, it does so in ovl_rename() using the
> credentials that were set at the time of mounting the OverlayFS.
> 
> Bump the Landlock ABI version to 10.
> 
> Suggested-by: Christian Brauner <brauner@kernel.org>
> Suggested-by: Mickaël Salaün <mic@digikod.net>
> Signed-off-by: Günther Noack <gnoack@google.com>
> ---
>  include/uapi/linux/landlock.h                |  3 +++
>  security/landlock/audit.c                    |  1 +
>  security/landlock/fs.c                       | 17 ++++++++++++++---
>  security/landlock/limits.h                   |  2 +-
>  security/landlock/syscalls.c                 |  2 +-
>  tools/testing/selftests/landlock/base_test.c |  4 ++--
>  tools/testing/selftests/landlock/fs_test.c   |  5 +++--
>  7 files changed, 25 insertions(+), 9 deletions(-)
> 
> diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
> index 10a346e55e95..1f8a1d6d25f1 100644
> --- a/include/uapi/linux/landlock.h
> +++ b/include/uapi/linux/landlock.h
> @@ -328,6 +328,8 @@ struct landlock_net_port_attr {
>   *
>   *   If multiple requirements are not met, the ``EACCES`` error code takes
>   *   precedence over ``EXDEV``.
> + * - %LANDLOCK_ACCESS_FS_MAKE_WHITEOUT: Create a whiteout object through
> + *   :manpage:`rename(2)` with ``RENAME_WHITEOUT``.
>   *
>   * .. warning::
>   *
> @@ -356,6 +358,7 @@ struct landlock_net_port_attr {
>  #define LANDLOCK_ACCESS_FS_TRUNCATE			(1ULL << 14)
>  #define LANDLOCK_ACCESS_FS_IOCTL_DEV			(1ULL << 15)
>  #define LANDLOCK_ACCESS_FS_RESOLVE_UNIX			(1ULL << 16)
> +#define LANDLOCK_ACCESS_FS_MAKE_WHITEOUT		(1ULL << 17)
>  /* clang-format on */
>  
>  /**
> diff --git a/security/landlock/audit.c b/security/landlock/audit.c
> index 8d0edf94037d..09c97083f599 100644
> --- a/security/landlock/audit.c
> +++ b/security/landlock/audit.c
> @@ -38,6 +38,7 @@ static const char *const fs_access_strings[] = {
>  	[BIT_INDEX(LANDLOCK_ACCESS_FS_TRUNCATE)] = "fs.truncate",
>  	[BIT_INDEX(LANDLOCK_ACCESS_FS_IOCTL_DEV)] = "fs.ioctl_dev",
>  	[BIT_INDEX(LANDLOCK_ACCESS_FS_RESOLVE_UNIX)] = "fs.resolve_unix",
> +	[BIT_INDEX(LANDLOCK_ACCESS_FS_MAKE_WHITEOUT)] = "fs.make_whiteout",
>  };
>  
>  static_assert(ARRAY_SIZE(fs_access_strings) == LANDLOCK_NUM_ACCESS_FS);
> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index c1ecfe239032..67810d5242b2 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c
> @@ -1080,6 +1080,7 @@ static bool collect_domain_accesses(const struct landlock_ruleset *const domain,
>   * @new_dentry: Destination file or directory.
>   * @removable: Sets to true if it is a rename operation.
>   * @exchange: Sets to true if it is a rename operation with RENAME_EXCHANGE.
> + * @whiteout: Sets to true if it is a rename operation with RENAME_WHITEOUT.
>   *
>   * Because of its unprivileged constraints, Landlock relies on file hierarchies
>   * (and not only inodes) to tie access rights to files.  Being able to link or
> @@ -1127,7 +1128,8 @@ static bool collect_domain_accesses(const struct landlock_ruleset *const domain,
>  static int current_check_refer_path(struct dentry *const old_dentry,
>  				    const struct path *const new_dir,
>  				    struct dentry *const new_dentry,
> -				    const bool removable, const bool exchange)
> +				    const bool removable, const bool exchange,
> +				    const bool whiteout)
>  {
>  	const struct landlock_cred_security *const subject =
>  		landlock_get_applicable_subject(current_cred(), any_fs, NULL);
> @@ -1159,6 +1161,14 @@ static int current_check_refer_path(struct dentry *const old_dentry,
>  		access_request_parent2 |= maybe_remove(new_dentry);
>  	}
>  
> +	/*
> +	 * In case of renameat2(2) with RENAME_WHITEOUT, a whiteout object is
> +	 * created in the source location, so we require an additional access
> +	 * right there.
> +	 */
> +	if (whiteout)
> +		access_request_parent1 |= LANDLOCK_ACCESS_FS_MAKE_WHITEOUT;
> +
>  	/* The mount points are the same for old and new paths, cf. EXDEV. */
>  	if (old_dentry->d_parent == new_dir->dentry) {
>  		/*
> @@ -1509,7 +1519,7 @@ static int hook_path_link(struct dentry *const old_dentry,
>  			  struct dentry *const new_dentry)
>  {
>  	return current_check_refer_path(old_dentry, new_dir, new_dentry, false,
> -					false);
> +					false, false);
>  }
>  
>  static int hook_path_rename(const struct path *const old_dir,
> @@ -1520,7 +1530,8 @@ static int hook_path_rename(const struct path *const old_dir,
>  {
>  	/* old_dir refers to old_dentry->d_parent and new_dir->mnt */
>  	return current_check_refer_path(old_dentry, new_dir, new_dentry, true,
> -					!!(flags & RENAME_EXCHANGE));
> +					!!(flags & RENAME_EXCHANGE),
> +					!!(flags & RENAME_WHITEOUT));
>  }
>  
>  static int hook_path_mkdir(const struct path *const dir,
> diff --git a/security/landlock/limits.h b/security/landlock/limits.h
> index b454ad73b15e..e59378e8e897 100644
> --- a/security/landlock/limits.h
> +++ b/security/landlock/limits.h
> @@ -19,7 +19,7 @@
>  #define LANDLOCK_MAX_NUM_LAYERS		16
>  #define LANDLOCK_MAX_NUM_RULES		U32_MAX
>  
> -#define LANDLOCK_LAST_ACCESS_FS		LANDLOCK_ACCESS_FS_RESOLVE_UNIX
> +#define LANDLOCK_LAST_ACCESS_FS		LANDLOCK_ACCESS_FS_MAKE_WHITEOUT
>  #define LANDLOCK_MASK_ACCESS_FS		((LANDLOCK_LAST_ACCESS_FS << 1) - 1)
>  #define LANDLOCK_NUM_ACCESS_FS		__const_hweight64(LANDLOCK_MASK_ACCESS_FS)
>  
> diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
> index accfd2e5a0cd..d45469d5d464 100644
> --- a/security/landlock/syscalls.c
> +++ b/security/landlock/syscalls.c
> @@ -166,7 +166,7 @@ static const struct file_operations ruleset_fops = {
>   * If the change involves a fix that requires userspace awareness, also update
>   * the errata documentation in Documentation/userspace-api/landlock.rst .
>   */
> -const int landlock_abi_version = 9;
> +const int landlock_abi_version = 10;
>  
>  /**
>   * sys_landlock_create_ruleset - Create a new ruleset
> diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing/selftests/landlock/base_test.c
> index 30d37234086c..6c8113c2ded1 100644
> --- a/tools/testing/selftests/landlock/base_test.c
> +++ b/tools/testing/selftests/landlock/base_test.c
> @@ -76,8 +76,8 @@ TEST(abi_version)
>  	const struct landlock_ruleset_attr ruleset_attr = {
>  		.handled_access_fs = LANDLOCK_ACCESS_FS_READ_FILE,
>  	};
> -	ASSERT_EQ(9, landlock_create_ruleset(NULL, 0,
> -					     LANDLOCK_CREATE_RULESET_VERSION));
> +	ASSERT_EQ(10, landlock_create_ruleset(NULL, 0,
> +					      LANDLOCK_CREATE_RULESET_VERSION));
>  
>  	ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr, 0,
>  					      LANDLOCK_CREATE_RULESET_VERSION));
> diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
> index cdb47fc1fc0a..53d1b659849f 100644
> --- a/tools/testing/selftests/landlock/fs_test.c
> +++ b/tools/testing/selftests/landlock/fs_test.c
> @@ -579,7 +579,7 @@ TEST_F_FORK(layout1, inval)
>  	LANDLOCK_ACCESS_FS_IOCTL_DEV | \
>  	LANDLOCK_ACCESS_FS_RESOLVE_UNIX)
>  
> -#define ACCESS_LAST LANDLOCK_ACCESS_FS_RESOLVE_UNIX
> +#define ACCESS_LAST LANDLOCK_ACCESS_FS_MAKE_WHITEOUT
>  
>  #define ACCESS_ALL ( \
>  	ACCESS_FILE | \
> @@ -593,7 +593,8 @@ TEST_F_FORK(layout1, inval)
>  	LANDLOCK_ACCESS_FS_MAKE_FIFO | \
>  	LANDLOCK_ACCESS_FS_MAKE_BLOCK | \
>  	LANDLOCK_ACCESS_FS_MAKE_SYM | \
> -	LANDLOCK_ACCESS_FS_REFER)
> +	LANDLOCK_ACCESS_FS_REFER | \
> +	LANDLOCK_ACCESS_FS_MAKE_WHITEOUT)
>  
>  /* clang-format on */
>  
> -- 
> 2.54.0.1099.g489fc7bff1-goog
> 
