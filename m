Return-Path: <SRS0=vYSA=Q3=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9366C10F01
	for <linux-security-module@archiver.kernel.org>; Wed, 20 Feb 2019 12:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90BF021848
	for <linux-security-module@archiver.kernel.org>; Wed, 20 Feb 2019 12:32:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qoptCDLp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbfBTMcF (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 20 Feb 2019 07:32:05 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35697 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727607AbfBTMcF (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 20 Feb 2019 07:32:05 -0500
Received: by mail-wr1-f67.google.com with SMTP id t18so25828660wrx.2;
        Wed, 20 Feb 2019 04:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=gb6Od87gbfaFrQMFb1CALO2WQSTOSjMeqTUYCJy+7jA=;
        b=qoptCDLpOHfSuO1uCIXSJfOxKfCo6gX2c9kfyxzOu5ucIQ8ExkfVNZgRyZknUF2pmS
         x5eq8DENOCYL39l/vAMT7qQeEyj+0nT/xh8R4NVFi/SAV1MCG+Xr6AwetrM4MOMB5C4C
         DR8B4jnyNo+idhgvwv2ARVLtVLFoPSdCVFnVhmbHOJWun7mLCbk7j6D6iCS1aEur1GFr
         FnVgPK08ka9ofE7oBisAGHp6wsxuDjrGigVGh8Wuk2nJ4q7Oa/gFFMQTS2Lg+Luj0r+p
         vKcQXdjIzgGMxDMJUorOsnj4Dbd7Wj5ZFwj4sixBNZYDdVyl3sv00hkd0Xxh75g/IEn9
         G42A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=gb6Od87gbfaFrQMFb1CALO2WQSTOSjMeqTUYCJy+7jA=;
        b=bi9S78POXGvr99nw4l25AxBvrXzvhtiSOmkysaxOsu23NC8RFmVD9TQxRPUZwImB1o
         mOBwQsbTo4Kx1B39c4OrCMReUDAipnGqNt4+yE4+ym7N2OQnt5Q8uAk/2vtjNiE6M/gc
         zQHqmiliD503ieGjOrOwV8ukpkHtxh+oUfDb5ciA6j9b7W2cjpsKjdXKIF5kBV11aI9y
         0PW5wZfayewF7VRwDDZmSV4N9HwgPWqLe3COcFJSf5hARV2HsMECFOePiqQjIUKkMxVU
         4TWH9PPdc2hZe1KztkUsULtnDvN4axCBF5EUqRNvT5Y9HTHml2s0eY3RKBamleja0VwK
         66QQ==
X-Gm-Message-State: AHQUAuZNsnvynAYWmsfackdjMiCYxeazmtFqbkRSo89CGVG9+r16GmZV
        FvGakhmpROW0Vt6JbD0KcLAZNx+6
X-Google-Smtp-Source: AHgI3IYroqKijn+D8cScUiNaw41a4b+h+JMvoBLte/xkJpv0CEWL22kVNdgz0DDGfr7U6sIpr1E1Ww==
X-Received: by 2002:adf:fc87:: with SMTP id g7mr23864572wrr.136.1550665922416;
        Wed, 20 Feb 2019 04:32:02 -0800 (PST)
Received: from [172.16.1.192] (host-78-151-217-103.as13285.net. [78.151.217.103])
        by smtp.gmail.com with ESMTPSA id t9sm14792862wrx.73.2019.02.20.04.32.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 04:32:01 -0800 (PST)
Subject: Re: [PATCH 02/10] vfs: syscall: Add move_mount(2) to move mounts
 around
To:     David Howells <dhowells@redhat.com>, viro@zeniv.linux.org.uk
Cc:     linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        torvalds@linux-foundation.org, ebiederm@xmission.com,
        linux-security-module@vger.kernel.org
References: <155059610368.17079.2220554006494174417.stgit@warthog.procyon.org.uk>
 <155059611887.17079.12991580316407924257.stgit@warthog.procyon.org.uk>
From:   Alan Jenkins <alan.christopher.jenkins@gmail.com>
Message-ID: <57a6b419-1541-6f97-6810-d0d376580def@gmail.com>
Date:   Wed, 20 Feb 2019 12:32:00 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <155059611887.17079.12991580316407924257.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 19/02/2019 17:08, David Howells wrote:
> Add a move_mount() system call that will move a mount from one place to
> another and, in the next commit, allow to attach an unattached mount tree.
>
> The new system call looks like the following:
>
> 	int move_mount(int from_dfd, const char *from_path,
> 		       int to_dfd, const char *to_path,
> 		       unsigned int flags);
>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: linux-api@vger.kernel.org
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>
>   arch/x86/entry/syscalls/syscall_32.tbl |    1
>   arch/x86/entry/syscalls/syscall_64.tbl |    1
>   fs/namespace.c                         |  126 ++++++++++++++++++++++++--------
>   include/linux/lsm_hooks.h              |    6 ++
>   include/linux/security.h               |    7 ++
>   include/linux/syscalls.h               |    3 +
>   include/uapi/linux/mount.h             |   11 +++
>   security/security.c                    |    5 +
>   8 files changed, 129 insertions(+), 31 deletions(-)

> diff --git a/fs/namespace.c b/fs/namespace.c
> index 112d46f26fc3..f10122028a11 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -2537,72 +2537,81 @@ static inline int tree_contains_unbindable(struct mount *mnt)
>   	return 0;
>   }
>   
> -static int do_move_mount(struct path *path, const char *old_name)
> +static int do_move_mount(struct path *old_path, struct path *new_path)
>   {
> -	struct path old_path, parent_path;
> +	struct path parent_path = {.mnt = NULL, .dentry = NULL};
>   	struct mount *p;
>   	struct mount *old;
>   	struct mountpoint *mp;
>   	int err;
> -	if (!old_name || !*old_name)
> -		return -EINVAL;
> -	err = kern_path(old_name, LOOKUP_FOLLOW, &old_path);
> -	if (err)
> -		return err;
>   
> -	mp = lock_mount(path);
> -	err = PTR_ERR(mp);
> +	mp = lock_mount(new_path);
>   	if (IS_ERR(mp))
> -		goto out;
> +		return PTR_ERR(mp);
>   
> -	old = real_mount(old_path.mnt);
> -	p = real_mount(path->mnt);
> +	old = real_mount(old_path->mnt);
> +	p = real_mount(new_path->mnt);
>   
>   	err = -EINVAL;
>   	if (!check_mnt(p) || !check_mnt(old))
> -		goto out1;
> +		goto out;
>   
> -	if (old->mnt.mnt_flags & MNT_LOCKED)
> -		goto out1;
> +	if (!mnt_has_parent(old))
> +		goto out;
>   
> -	err = -EINVAL;
> -	if (old_path.dentry != old_path.mnt->mnt_root)
> -		goto out1;
> +	if (old->mnt.mnt_flags & MNT_LOCKED)
> +		goto out;
>   
> -	if (!mnt_has_parent(old))
> -		goto out1;
> +	if (old_path->dentry != old_path->mnt->mnt_root)
> +		goto out;
>   
> -	if (d_is_dir(path->dentry) !=
> -	      d_is_dir(old_path.dentry))
> -		goto out1;
> +	if (d_is_dir(new_path->dentry) !=
> +	    d_is_dir(old_path->dentry))
> +		goto out;
>   	/*
>   	 * Don't move a mount residing in a shared parent.
>   	 */
>   	if (IS_MNT_SHARED(old->mnt_parent))
> -		goto out1;
> +		goto out;
>   	/*
>   	 * Don't move a mount tree containing unbindable mounts to a destination
>   	 * mount which is shared.
>   	 */
>   	if (IS_MNT_SHARED(p) && tree_contains_unbindable(old))
> -		goto out1;
> +		goto out;
>   	err = -ELOOP;
>   	for (; mnt_has_parent(p); p = p->mnt_parent)
>   		if (p == old)
> -			goto out1;
> +			goto out;
>   
> -	err = attach_recursive_mnt(old, real_mount(path->mnt), mp, &parent_path);
> +	err = attach_recursive_mnt(old, real_mount(new_path->mnt), mp,
> +				   &parent_path);
>   	if (err)
> -		goto out1;
> +		goto out;
>   
>   	/* if the mount is moved, it should no longer be expire
>   	 * automatically */
>   	list_del_init(&old->mnt_expire);
> -out1:
> -	unlock_mount(mp);
>   out:
> +	unlock_mount(mp);
>   	if (!err)
>   		path_put(&parent_path);
> +	return err;
> +}
> +
> +static int do_move_mount_old(struct path *path, const char *old_name)
> +{
> +	struct path old_path;
> +	int err;
> +
> +	if (!old_name || !*old_name)
> +		return -EINVAL;
> +
> +	err = kern_path(old_name, LOOKUP_FOLLOW, &old_path);
> +	if (err)
> +		return err;
> +
> +	err = do_move_mount(&old_path, path);
>   	path_put(&old_path);
>   	return err;
>   }
> @@ -3050,7 +3059,7 @@ long do_mount(const char *dev_name, const char __user *dir_name,
>   	else if (flags & (MS_SHARED | MS_PRIVATE | MS_SLAVE | MS_UNBINDABLE))
>   		retval = do_change_type(&path, flags);
>   	else if (flags & MS_MOVE)
> -		retval = do_move_mount(&path, dev_name);
> +		retval = do_move_mount_old(&path, dev_name);
>   	else
>   		retval = do_new_mount(&path, type_page, sb_flags, mnt_flags,
>   				      dev_name, data_page);
> @@ -3278,6 +3287,61 @@ SYSCALL_DEFINE5(mount, char __user *, dev_name, char __user *, dir_name,
>   	return ksys_mount(dev_name, dir_name, type, flags, data);
>   }
>   
> +/*
> + * Move a mount from one place to another.
> + *
> + * Note the flags value is a combination of MOVE_MOUNT_* flags.
> + */
> +SYSCALL_DEFINE5(move_mount,
> +		int, from_dfd, const char *, from_pathname,
> +		int, to_dfd, const char *, to_pathname,
> +		unsigned int, flags)
> +{
> +	struct path from_path, to_path;
> +	unsigned int lflags;
> +	int ret = 0;
> +
> +	if (!may_mount())
> +		return -EPERM;
> +
> +	if (flags & ~MOVE_MOUNT__MASK)
> +		return -EINVAL;
> +
> +	/* If someone gives a pathname, they aren't permitted to move
> +	 * from an fd that requires unmount as we can't get at the flag
> +	 * to clear it afterwards.
> +	 */

Comment is incorrect.

* FMODE_NEED_UNMOUNT is never cleared.

* Technically I don't see anything preventing them giving a pathname, 
but it needs to be "." or equivalent.  Otherwise it will fail the 
"!attached" check in the next patch.

* The only argument I remember for preventing this, was that it might 
confuse users (not the kernel).  If you are allowed to move from a 
sub-mount, then in certain programming styles - like my shell script 
test cases - you might accidentally close the original file too early.  
Then you won't be able to do move_mount() from the tree, because the 
tree was unmounted ("dissolved") when you closed it.

I think the description in the previous patch, for open_tree(), makes it 
clear though. "The detached tree will be dissolved on the final close of 
obtained file".

If there is a good reason, I expect we can simply remove the "!attached" 
part of the check.  If the constraint is generating more confusion than 
the added flexibility, I think that would be a good reason :-).

> +	lflags = 0;
> +	if (flags & MOVE_MOUNT_F_SYMLINKS)	lflags |= LOOKUP_FOLLOW;
> +	if (flags & MOVE_MOUNT_F_AUTOMOUNTS)	lflags |= LOOKUP_AUTOMOUNT;
> +	if (flags & MOVE_MOUNT_F_EMPTY_PATH)	lflags |= LOOKUP_EMPTY;
> +
> +	ret = user_path_at(from_dfd, from_pathname, lflags, &from_path);
> +	if (ret < 0)
> +		return ret;
> +
> +	lflags = 0;
> +	if (flags & MOVE_MOUNT_T_SYMLINKS)	lflags |= LOOKUP_FOLLOW;
> +	if (flags & MOVE_MOUNT_T_AUTOMOUNTS)	lflags |= LOOKUP_AUTOMOUNT;
> +	if (flags & MOVE_MOUNT_T_EMPTY_PATH)	lflags |= LOOKUP_EMPTY;
> +
> +	ret = user_path_at(to_dfd, to_pathname, lflags, &to_path);
> +	if (ret < 0)
> +		goto out_from;
> +
> +	ret = security_move_mount(&from_path, &to_path);
> +	if (ret < 0)
> +		goto out_to;
> +
> +	ret = do_move_mount(&from_path, &to_path);
> +
> +out_to:
> +	path_put(&to_path);
> +out_from:
> +	path_put(&from_path);
> +	return ret;
> +}
> +
>   /*
>    * Return true if path is reachable from root
>    *
>
