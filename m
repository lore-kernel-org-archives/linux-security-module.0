Return-Path: <SRS0=vYSA=Q3=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39BBDC43381
	for <linux-security-module@archiver.kernel.org>; Wed, 20 Feb 2019 12:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4FC12086C
	for <linux-security-module@archiver.kernel.org>; Wed, 20 Feb 2019 12:41:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pVDKAPGU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbfBTMl4 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 20 Feb 2019 07:41:56 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46705 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726693AbfBTMlz (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 20 Feb 2019 07:41:55 -0500
Received: by mail-wr1-f65.google.com with SMTP id i16so17549905wrs.13;
        Wed, 20 Feb 2019 04:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=NGkx5noM8Bvjh5SFuRyY3YUKCV9qLs8yA5LmYp9Jcpk=;
        b=pVDKAPGUTnYNoATV6AVI79keET6c6/qLaUZ+S8Fh2xYt1jOWwtF2N+gm3dKt71DdqR
         mJDg3MS2VEYYhQZSyD4QLXW5fdtlfFUtrgRYb4LztUL44O1u4AYgtEF39/bJzXqv10l0
         jQH86zOjVhboqj0Wkz73M8Lx2vbNL+ars51A2zcstxTk/tKF2ZwK7gkdTT5zED83Rh6B
         p+3rKzRCndab/bNkeqTtPMu3irlMdHB0bnyEyJdnoZsv/75FpTRIOLRwsA9EZ/ncgsqC
         tF5IsAXFBdJqq9JqccJLCH51fEOR1CnB03bwPI5/J9IvhWP1pwtSu038S2TWM8AkuLuP
         U6ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=NGkx5noM8Bvjh5SFuRyY3YUKCV9qLs8yA5LmYp9Jcpk=;
        b=t4A9iPvs8NtGY7aDfViLteGmUGfi0haRTnNb9WD/E2XINx65GP7JAfyIT3ACpR9zlY
         tUqHbuW9cUFv0mgzQQnE7BkHwJEE3TybivX6NYN+4Dt655fbhGl/j8LPxIm8j4op80iE
         6XVQ3xkudb+R9KQdXkP2LGFAGZbGJ55AVyYuTJv9ewClFkL6iQQ26ujhZLda6g/+0KsB
         AEsCLQXM1cWXvMod5Myxaovcv05aEugDRVNxlBXfpdpkut0pRctWl0G7rAgsx+wHkWGc
         XexjcVcpm3Kahc/ckLHfZJePriJNjZZhl/CmUIVuMeXbo5mo2RBXN7NgvRSEGVbCj9N0
         mAAQ==
X-Gm-Message-State: AHQUAuaUHMoVdumIsyE8kMzf6Qxj7jYfQotzpmvMAKDLtLfGuIHDKi2m
        FxNsaiMrDSEajPWXjjGNYt7joojDh98=
X-Google-Smtp-Source: AHgI3IYzBLDoiU6imzLp4atrstscGDUVv0sRXGCTzbXiVwW+MLpdx02eDucXebGsHh/6N1Z99LoTRQ==
X-Received: by 2002:adf:f410:: with SMTP id g16mr25419546wro.246.1550666512996;
        Wed, 20 Feb 2019 04:41:52 -0800 (PST)
Received: from [172.16.1.192] (host-78-151-217-103.as13285.net. [78.151.217.103])
        by smtp.gmail.com with ESMTPSA id q17sm9978921wrx.38.2019.02.20.04.41.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 04:41:52 -0800 (PST)
Subject: Re: [PATCH 02/10] vfs: syscall: Add move_mount(2) to move mounts
 around
From:   Alan Jenkins <alan.christopher.jenkins@gmail.com>
To:     David Howells <dhowells@redhat.com>, viro@zeniv.linux.org.uk
Cc:     linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        torvalds@linux-foundation.org, ebiederm@xmission.com,
        linux-security-module@vger.kernel.org
References: <155059610368.17079.2220554006494174417.stgit@warthog.procyon.org.uk>
 <155059611887.17079.12991580316407924257.stgit@warthog.procyon.org.uk>
 <57a6b419-1541-6f97-6810-d0d376580def@gmail.com>
Message-ID: <45432256-ceca-41ae-c695-d9788470f1f1@gmail.com>
Date:   Wed, 20 Feb 2019 12:41:51 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <57a6b419-1541-6f97-6810-d0d376580def@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 20/02/2019 12:32, Alan Jenkins wrote:
> On 19/02/2019 17:08, David Howells wrote:
>> Add a move_mount() system call that will move a mount from one place to
>> another and, in the next commit, allow to attach an unattached mount 
>> tree.
>>
>> The new system call looks like the following:
>>
>>     int move_mount(int from_dfd, const char *from_path,
>>                int to_dfd, const char *to_path,
>>                unsigned int flags);
>>
>> Signed-off-by: David Howells <dhowells@redhat.com>
>> cc: linux-api@vger.kernel.org
>> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
>> ---
>>
>>   arch/x86/entry/syscalls/syscall_32.tbl |    1
>>   arch/x86/entry/syscalls/syscall_64.tbl |    1
>>   fs/namespace.c                         |  126 
>> ++++++++++++++++++++++++--------
>>   include/linux/lsm_hooks.h              |    6 ++
>>   include/linux/security.h               |    7 ++
>>   include/linux/syscalls.h               |    3 +
>>   include/uapi/linux/mount.h             |   11 +++
>>   security/security.c                    |    5 +
>>   8 files changed, 129 insertions(+), 31 deletions(-)
>
>> diff --git a/fs/namespace.c b/fs/namespace.c
>> index 112d46f26fc3..f10122028a11 100644
>> --- a/fs/namespace.c
>> +++ b/fs/namespace.c
>> @@ -2537,72 +2537,81 @@ static inline int 
>> tree_contains_unbindable(struct mount *mnt)
>>       return 0;
>>   }
>>   -static int do_move_mount(struct path *path, const char *old_name)
>> +static int do_move_mount(struct path *old_path, struct path *new_path)
>>   {
>> -    struct path old_path, parent_path;
>> +    struct path parent_path = {.mnt = NULL, .dentry = NULL};
>>       struct mount *p;
>>       struct mount *old;
>>       struct mountpoint *mp;
>>       int err;
>> -    if (!old_name || !*old_name)
>> -        return -EINVAL;
>> -    err = kern_path(old_name, LOOKUP_FOLLOW, &old_path);
>> -    if (err)
>> -        return err;
>>   -    mp = lock_mount(path);
>> -    err = PTR_ERR(mp);
>> +    mp = lock_mount(new_path);
>>       if (IS_ERR(mp))
>> -        goto out;
>> +        return PTR_ERR(mp);
>>   -    old = real_mount(old_path.mnt);
>> -    p = real_mount(path->mnt);
>> +    old = real_mount(old_path->mnt);
>> +    p = real_mount(new_path->mnt);
>>         err = -EINVAL;
>>       if (!check_mnt(p) || !check_mnt(old))
>> -        goto out1;
>> +        goto out;
>>   -    if (old->mnt.mnt_flags & MNT_LOCKED)
>> -        goto out1;
>> +    if (!mnt_has_parent(old))
>> +        goto out;
>>   -    err = -EINVAL;
>> -    if (old_path.dentry != old_path.mnt->mnt_root)
>> -        goto out1;
>> +    if (old->mnt.mnt_flags & MNT_LOCKED)
>> +        goto out;
>>   -    if (!mnt_has_parent(old))
>> -        goto out1;
>> +    if (old_path->dentry != old_path->mnt->mnt_root)
>> +        goto out;
>>   -    if (d_is_dir(path->dentry) !=
>> -          d_is_dir(old_path.dentry))
>> -        goto out1;
>> +    if (d_is_dir(new_path->dentry) !=
>> +        d_is_dir(old_path->dentry))
>> +        goto out;
>>       /*
>>        * Don't move a mount residing in a shared parent.
>>        */
>>       if (IS_MNT_SHARED(old->mnt_parent))
>> -        goto out1;
>> +        goto out;
>>       /*
>>        * Don't move a mount tree containing unbindable mounts to a 
>> destination
>>        * mount which is shared.
>>        */
>>       if (IS_MNT_SHARED(p) && tree_contains_unbindable(old))
>> -        goto out1;
>> +        goto out;
>>       err = -ELOOP;
>>       for (; mnt_has_parent(p); p = p->mnt_parent)
>>           if (p == old)
>> -            goto out1;
>> +            goto out;
>>   -    err = attach_recursive_mnt(old, real_mount(path->mnt), mp, 
>> &parent_path);
>> +    err = attach_recursive_mnt(old, real_mount(new_path->mnt), mp,
>> +                   &parent_path);
>>       if (err)
>> -        goto out1;
>> +        goto out;
>>         /* if the mount is moved, it should no longer be expire
>>        * automatically */
>>       list_del_init(&old->mnt_expire);
>> -out1:
>> -    unlock_mount(mp);
>>   out:
>> +    unlock_mount(mp);
>>       if (!err)
>>           path_put(&parent_path);
>> +    return err;
>> +}
>> +
>> +static int do_move_mount_old(struct path *path, const char *old_name)
>> +{
>> +    struct path old_path;
>> +    int err;
>> +
>> +    if (!old_name || !*old_name)
>> +        return -EINVAL;
>> +
>> +    err = kern_path(old_name, LOOKUP_FOLLOW, &old_path);
>> +    if (err)
>> +        return err;
>> +
>> +    err = do_move_mount(&old_path, path);
>>       path_put(&old_path);
>>       return err;
>>   }
>> @@ -3050,7 +3059,7 @@ long do_mount(const char *dev_name, const char 
>> __user *dir_name,
>>       else if (flags & (MS_SHARED | MS_PRIVATE | MS_SLAVE | 
>> MS_UNBINDABLE))
>>           retval = do_change_type(&path, flags);
>>       else if (flags & MS_MOVE)
>> -        retval = do_move_mount(&path, dev_name);
>> +        retval = do_move_mount_old(&path, dev_name);
>>       else
>>           retval = do_new_mount(&path, type_page, sb_flags, mnt_flags,
>>                         dev_name, data_page);
>> @@ -3278,6 +3287,61 @@ SYSCALL_DEFINE5(mount, char __user *, 
>> dev_name, char __user *, dir_name,
>>       return ksys_mount(dev_name, dir_name, type, flags, data);
>>   }
>>   +/*
>> + * Move a mount from one place to another.
>> + *
>> + * Note the flags value is a combination of MOVE_MOUNT_* flags.
>> + */
>> +SYSCALL_DEFINE5(move_mount,
>> +        int, from_dfd, const char *, from_pathname,
>> +        int, to_dfd, const char *, to_pathname,
>> +        unsigned int, flags)
>> +{
>> +    struct path from_path, to_path;
>> +    unsigned int lflags;
>> +    int ret = 0;
>> +
>> +    if (!may_mount())
>> +        return -EPERM;
>> +
>> +    if (flags & ~MOVE_MOUNT__MASK)
>> +        return -EINVAL;
>> +
>> +    /* If someone gives a pathname, they aren't permitted to move
>> +     * from an fd that requires unmount as we can't get at the flag
>> +     * to clear it afterwards.
>> +     */
>
> Comment is incorrect.
>
> * FMODE_NEED_UNMOUNT is never cleared.
>
> * Technically I don't see anything preventing them giving a pathname, 
> but it needs to be "." or equivalent.  Otherwise it will fail the 
> "!attached" check in the next patch.

>
> * The only argument I remember for preventing this, was that it might 
> confuse users (not the kernel).  If you are allowed to move from a 
> sub-mount, then in certain programming styles - like my shell script 
> test cases - you might accidentally close the original file too 
> early.  Then you won't be able to do move_mount() from the tree, 
> because the tree was unmounted ("dissolved") when you closed it.
>
> I think the description in the previous patch, for open_tree(), makes 
> it clear though. "The detached tree will be dissolved on the final 
> close of obtained file".
>
> If there is a good reason, I expect we can simply remove the 
> "!attached" part of the check.  If the constraint is generating more 
> confusion than the added flexibility, I think that would be a good 
> reason :-).

Sorry, I see it.  Although you are not clearing a flag, you have to free 
the old value of old->mnt_ns.  And that is not being reference-counted, 
it has a single owner, the file which has FMODE_NEED_UNMOUNT.  So it is 
not possible to simply remove the "!attached" check.

I still find the comment confusing, i.e. describing this as clearing a flag.

Alan
