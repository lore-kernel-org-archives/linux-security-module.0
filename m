Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9995EC25B0E
	for <linux-security-module@archiver.kernel.org>; Tue, 16 Aug 2022 19:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233790AbiHPTUO (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 16 Aug 2022 15:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237046AbiHPTUM (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 16 Aug 2022 15:20:12 -0400
Received: from smtp-42ac.mail.infomaniak.ch (smtp-42ac.mail.infomaniak.ch [84.16.66.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE93C8037A
        for <linux-security-module@vger.kernel.org>; Tue, 16 Aug 2022 12:20:09 -0700 (PDT)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4M6gvq3GShzMpw6L;
        Tue, 16 Aug 2022 21:20:07 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4M6gvp4p8DzlqwsR;
        Tue, 16 Aug 2022 21:20:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1660677607;
        bh=/Sgf95Pc1zb2WgcW4ZIdBYTzhUolJbzlXZIdEuWH42U=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=NfCF93U1JM/ZyeEGfAgVKqEQRRwFPJE3QDhWAA4Sy29q2T1OWf/XGf/lXxBYGkNIw
         IxW9DH6kwoKI9v32nHKEZdmWMwkcUK7Gi3jON4LQbTtTMC/yTDK7SpQdCA9pETFGgo
         5pyxQrsS6fZDfABgOzR4CnW9FgNQKudMdXnT9+84=
Message-ID: <90883a01-4d32-c3d0-4334-563ba9a5a39d@digikod.net>
Date:   Tue, 16 Aug 2022 21:20:06 +0200
MIME-Version: 1.0
User-Agent: 
Content-Language: en-US
To:     =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack3000@gmail.com>,
        linux-security-module@vger.kernel.org
Cc:     James Morris <jmorris@namei.org>, Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>
References: <20220814192603.7387-1-gnoack3000@gmail.com>
 <20220814192603.7387-2-gnoack3000@gmail.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Subject: Re: [PATCH v4 1/4] landlock: Support file truncation
In-Reply-To: <20220814192603.7387-2-gnoack3000@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


On 14/08/2022 21:26, Günther Noack wrote:
> Introduce the LANDLOCK_ACCESS_FS_TRUNCATE flag for file truncation.
> 
> This flag hooks into the path_truncate LSM hook and covers file
> truncation using truncate(2), ftruncate(2), open(2) with O_TRUNC, as
> well as creat().
> 
> This change also increments the Landlock ABI version, updates
> corresponding selftests, and includes minor documentation changes to
> document the flag.
> 
> Signed-off-by: Günther Noack <gnoack3000@gmail.com>
> ---
>   Documentation/userspace-api/landlock.rst     | 10 ++++++++++
>   include/uapi/linux/landlock.h                | 17 ++++++++++++-----
>   security/landlock/fs.c                       |  9 ++++++++-
>   security/landlock/limits.h                   |  2 +-
>   security/landlock/syscalls.c                 |  2 +-
>   tools/testing/selftests/landlock/base_test.c |  2 +-
>   tools/testing/selftests/landlock/fs_test.c   |  7 ++++---
>   7 files changed, 37 insertions(+), 12 deletions(-)
> 
> diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
> index b8ea59493964..6648e59fabe7 100644
> --- a/Documentation/userspace-api/landlock.rst
> +++ b/Documentation/userspace-api/landlock.rst
> @@ -380,6 +380,16 @@ by the Documentation/admin-guide/cgroup-v1/memory.rst.
>   Previous limitations
>   ====================
>   
> +File truncation (ABI < 3)
> +-------------------------
> +
> +File truncation could not be denied before the third Landlock ABI, so it is
> +always allowed when using a kernel that only supports the first or second ABI.
> +
> +Starting with the Landlock ABI version 3, it is now possible to securely
> +control truncation thanks to the new `LANDLOCK_ACCESS_FS_TRUNCATE` access
> +right.
> +

This should be in the forth patch, below the file renaming and linking 
section.


>   File renaming and linking (ABI 1)
>   ---------------------------------
>   
> diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
> index 23df4e0e8ace..a2fef267bf34 100644
> --- a/include/uapi/linux/landlock.h
> +++ b/include/uapi/linux/landlock.h
> @@ -95,8 +95,15 @@ struct landlock_path_beneath_attr {
>    * A file can only receive these access rights:
>    *
>    * - %LANDLOCK_ACCESS_FS_EXECUTE: Execute a file.
> - * - %LANDLOCK_ACCESS_FS_WRITE_FILE: Open a file with write access.
> + * - %LANDLOCK_ACCESS_FS_WRITE_FILE: Open a file with write access. Note that
> + *   you might additionally need the `LANDLOCK_ACCESS_FS_TRUNCATE` right in
> + *   order to overwrite files with :manpage:`open(2)` using `O_TRUNC` or
> + *   :manpage:`creat(2)`.
>    * - %LANDLOCK_ACCESS_FS_READ_FILE: Open a file with read access.
> + * - %LANDLOCK_ACCESS_FS_TRUNCATE: Truncate a file through file truncation APIs
> + *   like :manpage:`truncate(2)`, :manpage:`ftruncate(2)`, or

s/through file truncation APIs like/with/


> + *   :manpage:`open(2)` with `O_TRUNC` or :manpage:`creat(2)`. This access right

:manpage:`creat(2)`, or :manpage:`open(2)` using `O_TRUNC`.

With only one "or".


> + *   is available since the third version of the Landlock ABI.
>    *
>    * A directory can receive access rights related to files or directories.  The
>    * following access right is applied to the directory itself, and the
> @@ -139,10 +146,9 @@ struct landlock_path_beneath_attr {
>    *
>    *   It is currently not possible to restrict some file-related actions
>    *   accessible through these syscall families: :manpage:`chdir(2)`,
> - *   :manpage:`truncate(2)`, :manpage:`stat(2)`, :manpage:`flock(2)`,
> - *   :manpage:`chmod(2)`, :manpage:`chown(2)`, :manpage:`setxattr(2)`,
> - *   :manpage:`utime(2)`, :manpage:`ioctl(2)`, :manpage:`fcntl(2)`,
> - *   :manpage:`access(2)`.
> + *   :manpage:`stat(2)`, :manpage:`flock(2)`, :manpage:`chmod(2)`,
> + *   :manpage:`chown(2)`, :manpage:`setxattr(2)`, :manpage:`utime(2)`,
> + *   :manpage:`ioctl(2)`, :manpage:`fcntl(2)`, :manpage:`access(2)`.
>    *   Future Landlock evolutions will enable to restrict them.
>    */
>   /* clang-format off */
> @@ -160,6 +166,7 @@ struct landlock_path_beneath_attr {
>   #define LANDLOCK_ACCESS_FS_MAKE_BLOCK			(1ULL << 11)
>   #define LANDLOCK_ACCESS_FS_MAKE_SYM			(1ULL << 12)
>   #define LANDLOCK_ACCESS_FS_REFER			(1ULL << 13)
> +#define LANDLOCK_ACCESS_FS_TRUNCATE			(1ULL << 14)
>   /* clang-format on */
>   
>   #endif /* _UAPI_LINUX_LANDLOCK_H */
> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index ec5a6247cd3e..c57f581a9cd5 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c
> @@ -146,7 +146,8 @@ static struct landlock_object *get_inode_object(struct inode *const inode)
>   #define ACCESS_FILE ( \
>   	LANDLOCK_ACCESS_FS_EXECUTE | \
>   	LANDLOCK_ACCESS_FS_WRITE_FILE | \
> -	LANDLOCK_ACCESS_FS_READ_FILE)
> +	LANDLOCK_ACCESS_FS_READ_FILE | \
> +	LANDLOCK_ACCESS_FS_TRUNCATE)
>   /* clang-format on */
>   
>   /*
> @@ -1140,6 +1141,11 @@ static int hook_path_rmdir(const struct path *const dir,
>   	return current_check_access_path(dir, LANDLOCK_ACCESS_FS_REMOVE_DIR);
>   }
>   
> +static int hook_path_truncate(const struct path *const path)
> +{
> +	return current_check_access_path(path, LANDLOCK_ACCESS_FS_TRUNCATE);
> +}
> +
>   /* File hooks */
>   
>   static inline access_mask_t get_file_access(const struct file *const file)
> @@ -1192,6 +1198,7 @@ static struct security_hook_list landlock_hooks[] __lsm_ro_after_init = {
>   	LSM_HOOK_INIT(path_symlink, hook_path_symlink),
>   	LSM_HOOK_INIT(path_unlink, hook_path_unlink),
>   	LSM_HOOK_INIT(path_rmdir, hook_path_rmdir),
> +	LSM_HOOK_INIT(path_truncate, hook_path_truncate),
>   
>   	LSM_HOOK_INIT(file_open, hook_file_open),
>   };
> diff --git a/security/landlock/limits.h b/security/landlock/limits.h
> index b54184ab9439..82288f0e9e5e 100644
> --- a/security/landlock/limits.h
> +++ b/security/landlock/limits.h
> @@ -18,7 +18,7 @@
>   #define LANDLOCK_MAX_NUM_LAYERS		16
>   #define LANDLOCK_MAX_NUM_RULES		U32_MAX
>   
> -#define LANDLOCK_LAST_ACCESS_FS		LANDLOCK_ACCESS_FS_REFER
> +#define LANDLOCK_LAST_ACCESS_FS		LANDLOCK_ACCESS_FS_TRUNCATE
>   #define LANDLOCK_MASK_ACCESS_FS		((LANDLOCK_LAST_ACCESS_FS << 1) - 1)
>   #define LANDLOCK_NUM_ACCESS_FS		__const_hweight64(LANDLOCK_MASK_ACCESS_FS)
>   
> diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
> index 735a0865ea11..f4d6fc7ed17f 100644
> --- a/security/landlock/syscalls.c
> +++ b/security/landlock/syscalls.c
> @@ -129,7 +129,7 @@ static const struct file_operations ruleset_fops = {
>   	.write = fop_dummy_write,
>   };
>   
> -#define LANDLOCK_ABI_VERSION 2
> +#define LANDLOCK_ABI_VERSION 3
>   
>   /**
>    * sys_landlock_create_ruleset - Create a new ruleset
> diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing/selftests/landlock/base_test.c
> index da9290817866..72cdae277b02 100644
> --- a/tools/testing/selftests/landlock/base_test.c
> +++ b/tools/testing/selftests/landlock/base_test.c
> @@ -75,7 +75,7 @@ TEST(abi_version)
>   	const struct landlock_ruleset_attr ruleset_attr = {
>   		.handled_access_fs = LANDLOCK_ACCESS_FS_READ_FILE,
>   	};
> -	ASSERT_EQ(2, landlock_create_ruleset(NULL, 0,
> +	ASSERT_EQ(3, landlock_create_ruleset(NULL, 0,
>   					     LANDLOCK_CREATE_RULESET_VERSION));
>   
>   	ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr, 0,
> diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
> index 21a2ce8fa739..cb77eaa01c91 100644
> --- a/tools/testing/selftests/landlock/fs_test.c
> +++ b/tools/testing/selftests/landlock/fs_test.c
> @@ -399,9 +399,10 @@ TEST_F_FORK(layout1, inval)
>   #define ACCESS_FILE ( \
>   	LANDLOCK_ACCESS_FS_EXECUTE | \
>   	LANDLOCK_ACCESS_FS_WRITE_FILE | \
> -	LANDLOCK_ACCESS_FS_READ_FILE)
> +	LANDLOCK_ACCESS_FS_READ_FILE | \
> +	LANDLOCK_ACCESS_FS_TRUNCATE)
>   
> -#define ACCESS_LAST LANDLOCK_ACCESS_FS_REFER
> +#define ACCESS_LAST LANDLOCK_ACCESS_FS_TRUNCATE
>   
>   #define ACCESS_ALL ( \
>   	ACCESS_FILE | \
> @@ -415,7 +416,7 @@ TEST_F_FORK(layout1, inval)
>   	LANDLOCK_ACCESS_FS_MAKE_FIFO | \
>   	LANDLOCK_ACCESS_FS_MAKE_BLOCK | \
>   	LANDLOCK_ACCESS_FS_MAKE_SYM | \
> -	ACCESS_LAST)
> +	LANDLOCK_ACCESS_FS_REFER)
>   
>   /* clang-format on */
>   
