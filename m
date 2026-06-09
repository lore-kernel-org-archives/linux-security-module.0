Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch [84.16.66.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC407370AF8
	for <linux-security-module@vger.kernel.org>; Tue,  9 Jun 2026 16:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781021402; cv=none; b=hVsIb7zDS64FcB9PhAPHKjHDpwxg43rOPB8cuczFzeuQ8loQ0G1Cj4MQoT/dbUr/RLK+oapwgfYedKMZow7jvjZWqi58G1RtnTvOcaBPqyH3s9/F9A+bysFoO5UjMT+tGA/urIFr/ht9pzHUcBax9u6K6b2Xy7gMS/u5YzomcnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781021402; c=relaxed/simple;
	bh=b5Ng9zKFrDNDJKyThyckMG0zSSTU1a9U6PXK4/0rZJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BvkrMYtLNUIvB78g+p0rOxlZim4alxcaGmycukw8X2FA01Pp0XkoZg4xBmVbQj95UjDNozEzt9+4pUG5K8Tc2H1JfTNE6tlDUeBp/NLjoBZHUlF5pNq7IFpReDJiDVHAaPnRWudpzwmv8RTfqJwkyb264O1GSj9BLTskFyHXCYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=HGuc/Meu; arc=none smtp.client-ip=84.16.66.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="HGuc/Meu"
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gZYlS6xbgzS0C;
	Tue,  9 Jun 2026 18:09:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1781021396;
	bh=lR+iiy1KlmORrLOLM88wLPKChs0lEm2FTswEKEr4m1k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HGuc/MeumYiqNu373iat2m2X9x0fmYGEbxIATw7TW7PHuuJwVb4uojL9+B+mYyPuv
	 ZiU9hWpx+SAummQTY+QvI4mOvHpUa9T5Q9RrjRTLZME1JfQIhmy3Tf6B+l2xakyEwI
	 TWQsLY0lnnfuTCPERur9KiFvN2rgTa1fAydAVYh4=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4gZYlR5n76zR2M;
	Tue,  9 Jun 2026 18:09:55 +0200 (CEST)
Date: Tue, 9 Jun 2026 18:09:51 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc: Christian Brauner <brauner@kernel.org>, 
	linux-security-module@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	Serge Hallyn <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: Re: [PATCH v2 1/3] landlock: Require
 LANDLOCK_ACCESS_FS_MAKE_WHITEOUT for RENAME_WHITEOUT
Message-ID: <20260609.pait5oaTheHi@digikod.net>
References: <20260513160552.4022649-1-gnoack@google.com>
 <20260513160552.4022649-2-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260513160552.4022649-2-gnoack@google.com>
X-Infomaniak-Routing: alpha

On Wed, May 13, 2026 at 06:05:50PM +0200, Günther Noack wrote:
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
>  security/landlock/fs.c                       | 15 +++++++++++++++
>  security/landlock/limits.h                   |  2 +-
>  security/landlock/syscalls.c                 |  2 +-
>  tools/testing/selftests/landlock/base_test.c |  4 ++--
>  tools/testing/selftests/landlock/fs_test.c   |  5 +++--
>  7 files changed, 26 insertions(+), 6 deletions(-)
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
> index c1ecfe239032..09de6ba5c3a3 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c
> @@ -1519,6 +1519,21 @@ static int hook_path_rename(const struct path *const old_dir,
>  			    const unsigned int flags)
>  {
>  	/* old_dir refers to old_dentry->d_parent and new_dir->mnt */
> +	if (flags & RENAME_WHITEOUT) {
> +		int err;
> +
> +		/*
> +		 * Rename with RENAME_WHITEOUT creates a whiteout object in the
> +		 * old location, so we check the access right for creating that.
> +		 *
> +		 * See Documentation/filesystems/overlayfs.rst and renameat2(2).
> +		 */
> +		err = current_check_access_path(
> +			old_dir, LANDLOCK_ACCESS_FS_MAKE_WHITEOUT);

We should not need a second path walk, even if whiteouts are rare.
Please propose another way.

> +		if (err)
> +			return err;
> +	}
> +
>  	return current_check_refer_path(old_dentry, new_dir, new_dentry, true,
>  					!!(flags & RENAME_EXCHANGE));
>  }
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
> 2.54.0.563.g4f69b47b94-goog
> 
> 
