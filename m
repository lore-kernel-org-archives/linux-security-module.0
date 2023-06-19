Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1764DEB64D9
	for <linux-security-module@archiver.kernel.org>; Mon, 19 Jun 2023 14:42:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231724AbjFSOmO (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 19 Jun 2023 10:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231690AbjFSOmM (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 19 Jun 2023 10:42:12 -0400
Received: from smtp-1909.mail.infomaniak.ch (smtp-1909.mail.infomaniak.ch [185.125.25.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CCE592
        for <linux-security-module@vger.kernel.org>; Mon, 19 Jun 2023 07:42:10 -0700 (PDT)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4QlCCN5JvbzMpqyW;
        Mon, 19 Jun 2023 14:42:08 +0000 (UTC)
Received: from unknown by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4QlCCN102gzMq0NJ;
        Mon, 19 Jun 2023 16:42:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1687185728;
        bh=6tuwMD9cV1IMVuSZGIDAbmmV7xdryNkyy5icH1lTiVw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=eUb+Ps0u6rc6jSElA7dopoc6uLsEToNnokTEugWuW2zeW6tT6HSa7eSDjWcwnyhwY
         80l2DlMSi9HFI+tqo4I+Xw5dauQgJtvLfpfguwjQ+lAJm8fkRk4+yPbVOB1ALlURle
         PwnlYRnTgfYBP2iLVrQ2eksqMmqfCaOM+67OFwm8=
Message-ID: <09c6939f-c9e4-d1ed-bef1-3b1f05f81522@digikod.net>
Date:   Mon, 19 Jun 2023 16:42:07 +0200
MIME-Version: 1.0
User-Agent: 
Subject: Re: [RFC 2/4] landlock: Add LANDLOCK_ACCESS_FS_IOCTL access right
Content-Language: en-US
To:     =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack3000@gmail.com>,
        linux-security-module@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
References: <20230502171755.9788-1-gnoack3000@gmail.com>
 <20230502171755.9788-3-gnoack3000@gmail.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <20230502171755.9788-3-gnoack3000@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


On 02/05/2023 19:17, Günther Noack wrote:
> Like the truncate right, this right is associated with a file
> descriptor at the time of open(2), and gets respected even when the
> file descriptor is used outside of the thread which it was originally
> created in.
> 
> In particular, this happens for the commonly inherited file
> descriptors stdin, stdout and stderr, if these are bound to a tty.

s/tty/TTY/

> This means that programs using tty ioctls can drop the ioctl access

s/ioctl/IOCTLs/

> right, but continue using these ioctls on the already opened input and
> output file descriptors.

I'd like a new documentation paragraph explaining the limitation of 
LANDLOCK_ACCESS_FS_IOCTL (not fine-grained; should be careful about 
fscrypt-like features for regular files; compatibility with TTY and 
other common IOCTLs), a way to get more guarantees (e.g. using nodev 
mount points when possible), and a sentence explaining that future work 
will enable a more fine-grained access control.


> 
> Signed-off-by: Günther Noack <gnoack3000@gmail.com>
> ---
>   include/uapi/linux/landlock.h              | 19 ++++++++++++-------
>   security/landlock/fs.c                     | 20 ++++++++++++++++++--
>   security/landlock/limits.h                 |  2 +-
>   tools/testing/selftests/landlock/fs_test.c |  5 +++--
>   4 files changed, 34 insertions(+), 12 deletions(-)
> 
> diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
> index f3223f96469..d87457a1c22 100644
> --- a/include/uapi/linux/landlock.h
> +++ b/include/uapi/linux/landlock.h
> @@ -102,12 +102,16 @@ struct landlock_path_beneath_attr {
>    * - %LANDLOCK_ACCESS_FS_READ_FILE: Open a file with read access.
>    * - %LANDLOCK_ACCESS_FS_TRUNCATE: Truncate a file with :manpage:`truncate(2)`,
>    *   :manpage:`ftruncate(2)`, :manpage:`creat(2)`, or :manpage:`open(2)` with
> - *   ``O_TRUNC``. Whether an opened file can be truncated with
> - *   :manpage:`ftruncate(2)` is determined during :manpage:`open(2)`, in the
> - *   same way as read and write permissions are checked during
> - *   :manpage:`open(2)` using %LANDLOCK_ACCESS_FS_READ_FILE and
> - *   %LANDLOCK_ACCESS_FS_WRITE_FILE. This access right is available since the
> - *   third version of the Landlock ABI.
> + *   ``O_TRUNC``.  This access right is available since the third version of the
> + *   Landlock ABI.
> + * - %LANDLOCK_ACCESS_FS_IOCTL: Invoke :manpage:`ioctl(2)` on the opened file.
> + *   This access right is available since the fourth version of the Landlock
> + *   ABI.
> + *
> + * Whether an opened file can be truncated with :manpage:`ftruncate(2)` or used
> + * with `ioctl(2)` is determined during :manpage:`open(2)`, in the same way as
> + * read and write permissions are checked during :manpage:`open(2)` using
> + * %LANDLOCK_ACCESS_FS_READ_FILE and %LANDLOCK_ACCESS_FS_WRITE_FILE.
>    *
>    * A directory can receive access rights related to files or directories.  The
>    * following access right is applied to the directory itself, and the
> @@ -152,7 +156,7 @@ struct landlock_path_beneath_attr {
>    *   accessible through these syscall families: :manpage:`chdir(2)`,
>    *   :manpage:`stat(2)`, :manpage:`flock(2)`, :manpage:`chmod(2)`,
>    *   :manpage:`chown(2)`, :manpage:`setxattr(2)`, :manpage:`utime(2)`,
> - *   :manpage:`ioctl(2)`, :manpage:`fcntl(2)`, :manpage:`access(2)`.
> + *   :manpage:`fcntl(2)`, :manpage:`access(2)`.
>    *   Future Landlock evolutions will enable to restrict them.
>    */
>   /* clang-format off */
> @@ -171,6 +175,7 @@ struct landlock_path_beneath_attr {
>   #define LANDLOCK_ACCESS_FS_MAKE_SYM			(1ULL << 12)
>   #define LANDLOCK_ACCESS_FS_REFER			(1ULL << 13)
>   #define LANDLOCK_ACCESS_FS_TRUNCATE			(1ULL << 14)
> +#define LANDLOCK_ACCESS_FS_IOCTL			(1ULL << 15)
>   /* clang-format on */
>   
>   #endif /* _UAPI_LINUX_LANDLOCK_H */
> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index adcea0fe7e6..b13c765733c 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c
> @@ -147,7 +147,8 @@ static struct landlock_object *get_inode_object(struct inode *const inode)
>   	LANDLOCK_ACCESS_FS_EXECUTE | \
>   	LANDLOCK_ACCESS_FS_WRITE_FILE | \
>   	LANDLOCK_ACCESS_FS_READ_FILE | \
> -	LANDLOCK_ACCESS_FS_TRUNCATE)
> +	LANDLOCK_ACCESS_FS_TRUNCATE | \
> +	LANDLOCK_ACCESS_FS_IOCTL)
>   /* clang-format on */
>   
>   /*
> @@ -1207,7 +1208,8 @@ static int hook_file_open(struct file *const file)
>   {
>   	layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_FS] = {};
>   	access_mask_t open_access_request, full_access_request, allowed_access;
> -	const access_mask_t optional_access = LANDLOCK_ACCESS_FS_TRUNCATE;
> +	const access_mask_t optional_access = LANDLOCK_ACCESS_FS_TRUNCATE |
> +					      LANDLOCK_ACCESS_FS_IOCTL;
>   	const struct landlock_ruleset *const dom =
>   		landlock_get_current_domain();
>   
> @@ -1280,6 +1282,19 @@ static int hook_file_truncate(struct file *const file)
>   	return -EACCES;
>   }
>   
> +static int hook_file_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> +{
> +	/*
> +	 * It is the access rights at the time of opening the file which
> +	 * determine whether ioctl can be used on the opened file later.
> +	 *
> +	 * The access right is attached to the opened file in hook_file_open().
> +	 */
> +	if (landlock_file(file)->allowed_access & LANDLOCK_ACCESS_FS_IOCTL)
> +		return 0;

Please add a new line here.

> +	return -EACCES;
> +}
> +
>   static struct security_hook_list landlock_hooks[] __lsm_ro_after_init = {
>   	LSM_HOOK_INIT(inode_free_security, hook_inode_free_security),
>   
> @@ -1302,6 +1317,7 @@ static struct security_hook_list landlock_hooks[] __lsm_ro_after_init = {
>   	LSM_HOOK_INIT(file_alloc_security, hook_file_alloc_security),
>   	LSM_HOOK_INIT(file_open, hook_file_open),
>   	LSM_HOOK_INIT(file_truncate, hook_file_truncate),
> +	LSM_HOOK_INIT(file_ioctl, hook_file_ioctl),
>   };
>   
>   __init void landlock_add_fs_hooks(void)
> diff --git a/security/landlock/limits.h b/security/landlock/limits.h
> index 82288f0e9e5..40d8f17698b 100644
> --- a/security/landlock/limits.h
> +++ b/security/landlock/limits.h
> @@ -18,7 +18,7 @@
>   #define LANDLOCK_MAX_NUM_LAYERS		16
>   #define LANDLOCK_MAX_NUM_RULES		U32_MAX
>   
> -#define LANDLOCK_LAST_ACCESS_FS		LANDLOCK_ACCESS_FS_TRUNCATE
> +#define LANDLOCK_LAST_ACCESS_FS		LANDLOCK_ACCESS_FS_IOCTL
>   #define LANDLOCK_MASK_ACCESS_FS		((LANDLOCK_LAST_ACCESS_FS << 1) - 1)
>   #define LANDLOCK_NUM_ACCESS_FS		__const_hweight64(LANDLOCK_MASK_ACCESS_FS)
>   
> diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
> index b6c4be3faf7..fdd7d439ce4 100644
> --- a/tools/testing/selftests/landlock/fs_test.c
> +++ b/tools/testing/selftests/landlock/fs_test.c
> @@ -446,9 +446,10 @@ TEST_F_FORK(layout1, inval)
>   	LANDLOCK_ACCESS_FS_EXECUTE | \
>   	LANDLOCK_ACCESS_FS_WRITE_FILE | \
>   	LANDLOCK_ACCESS_FS_READ_FILE | \
> -	LANDLOCK_ACCESS_FS_TRUNCATE)
> +	LANDLOCK_ACCESS_FS_TRUNCATE | \
> +	LANDLOCK_ACCESS_FS_IOCTL)
>   
> -#define ACCESS_LAST LANDLOCK_ACCESS_FS_TRUNCATE
> +#define ACCESS_LAST LANDLOCK_ACCESS_FS_IOCTL
>   
>   #define ACCESS_ALL ( \
>   	ACCESS_FILE | \
