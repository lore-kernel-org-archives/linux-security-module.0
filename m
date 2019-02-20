Return-Path: <SRS0=vYSA=Q3=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C255C43381
	for <linux-security-module@archiver.kernel.org>; Wed, 20 Feb 2019 18:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D86C320859
	for <linux-security-module@archiver.kernel.org>; Wed, 20 Feb 2019 18:55:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CJ9YDnJf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725877AbfBTSzd (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 20 Feb 2019 13:55:33 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40205 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbfBTSzc (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 20 Feb 2019 13:55:32 -0500
Received: by mail-wm1-f66.google.com with SMTP id t15so7397021wmi.5;
        Wed, 20 Feb 2019 10:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=19o3HJBkFlUEm7hCN5qdep2KdRKhJO/iuRNq6cYkcwY=;
        b=CJ9YDnJfh6Qadkg1W/KwnJH+Q5RED5LBO18Rc2gTNn6064J2FoDj+2w5c1jXiA4+IG
         zF3HEHapE5aN1ZkJgNwGfaKvAXikfzGlDKXFpBTu6FjWi7KJbBtYylI5iTGauflY2+UT
         QHvwQaXlnyN3aEKPNZgViPzbUuN7DsYwowHTHNJDiPZDBBKegWARfpCu4+dFc20WlVO8
         zh3TZ7sFzmgokQIJvzcCdC+caSrLOlEMHTqhGcZ7/ZzZcuJTvzPRcUPU6xx13ogXiZ7q
         e8FkEWXe0nQGXbWYnOih/WLZnZ0xXaYJTsFsPHLzDfvpoQ8PeQJOQqvDTy4UiB1vLxxk
         smtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=19o3HJBkFlUEm7hCN5qdep2KdRKhJO/iuRNq6cYkcwY=;
        b=ij8mFx5J8IxLbbqVRYV/vdybqiZQQ6lviHnDL8GkD5J/NImgVyMYs/zar55Q2t9/8s
         RnS+/sBKklc5Hx4YIiolEHdgssET8fDS40xq+3bzuiZTkMquCjsgvfWxeV7MfciQBB+4
         Yy7+UQ7CnE2KFBpl1LImCUJpfB8bJDOrD2NXdu8XNOqPycpo3vNoaWXgetx2OZ8u1/JH
         BghQvKcKixQWdIXo0gpWz5YOUrvcCPwENVSPUnpNdq/HQxE+jdF3juAFVZkD1yiIsVsE
         WKg964AaKMzqN5FEiaAeXCQjnCyt5L0dlFNwEW3DdzddL6ttIj/PRgkZy9wO2qPZYubS
         /oZQ==
X-Gm-Message-State: AHQUAua1Hu4oSolPc7j3/UZHLKejeMCfKq0Z956Lw1hP0gfBk+urh0cf
        vdmbmIy+zJb1iRmW7bPuFBnoJD66
X-Google-Smtp-Source: AHgI3IY5tNc/T4GhAhL7a6ysh3ECKSAAbIvyMpBiHpf+6Tx5Dh58Mb5uW+r+cuZfIOTfrBP1/oSXWw==
X-Received: by 2002:a1c:a5cc:: with SMTP id o195mr7605008wme.67.1550688929908;
        Wed, 20 Feb 2019 10:55:29 -0800 (PST)
Received: from [172.16.1.192] (host-78-151-217-103.as13285.net. [78.151.217.103])
        by smtp.gmail.com with ESMTPSA id x24sm10509405wmi.5.2019.02.20.10.55.28
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 10:55:29 -0800 (PST)
Subject: Re: [PATCH 04/43] separate copying and locking mount tree on
 cross-userns copies
To:     David Howells <dhowells@redhat.com>, viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org,
        ebiederm@xmission.com, linux-security-module@vger.kernel.org
References: <155059366914.12449.4669870128936536848.stgit@warthog.procyon.org.uk>
 <155059371731.12449.5751025556744658291.stgit@warthog.procyon.org.uk>
From:   Alan Jenkins <alan.christopher.jenkins@gmail.com>
Message-ID: <e967b416-dcef-2ce4-8775-2eb67da7d045@gmail.com>
Date:   Wed, 20 Feb 2019 18:55:27 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <155059371731.12449.5751025556744658291.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 19/02/2019 16:28, David Howells wrote:
> From: Al Viro <viro@zeniv.linux.org.uk>
>
> Rather than having propagate_mnt() check doing unprivileged copies,
> lock them before commit_tree().
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>
>   fs/namespace.c |   59 +++++++++++++++++++++++++++++++++++---------------------
>   fs/pnode.c     |    5 -----
>   fs/pnode.h     |    3 +--
>   3 files changed, 38 insertions(+), 29 deletions(-)
>
> diff --git a/fs/namespace.c b/fs/namespace.c
> index a677b59efd74..9ed2f2930dfd 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -1013,27 +1013,6 @@ static struct mount *clone_mnt(struct mount *old, struct dentry *root,
>   
>   	mnt->mnt.mnt_flags = old->mnt.mnt_flags;
>   	mnt->mnt.mnt_flags &= ~(MNT_WRITE_HOLD|MNT_MARKED|MNT_INTERNAL);
> -	/* Don't allow unprivileged users to change mount flags */
> -	if (flag & CL_UNPRIVILEGED) {
> -		mnt->mnt.mnt_flags |= MNT_LOCK_ATIME;
> -
> -		if (mnt->mnt.mnt_flags & MNT_READONLY)
> -			mnt->mnt.mnt_flags |= MNT_LOCK_READONLY;
> -
> -		if (mnt->mnt.mnt_flags & MNT_NODEV)
> -			mnt->mnt.mnt_flags |= MNT_LOCK_NODEV;
> -
> -		if (mnt->mnt.mnt_flags & MNT_NOSUID)
> -			mnt->mnt.mnt_flags |= MNT_LOCK_NOSUID;
> -
> -		if (mnt->mnt.mnt_flags & MNT_NOEXEC)
> -			mnt->mnt.mnt_flags |= MNT_LOCK_NOEXEC;
> -	}
> -
> -	/* Don't allow unprivileged users to reveal what is under a mount */
> -	if ((flag & CL_UNPRIVILEGED) &&
> -	    (!(flag & CL_EXPIRE) || list_empty(&old->mnt_expire)))
> -		mnt->mnt.mnt_flags |= MNT_LOCKED;
>   
>   	atomic_inc(&sb->s_active);
>   	mnt->mnt.mnt_sb = sb;
> @@ -1837,6 +1816,33 @@ int iterate_mounts(int (*f)(struct vfsmount *, void *), void *arg,
>   	return 0;
>   }
>   
> +static void lock_mnt_tree(struct mount *mnt)
> +{
> +	struct mount *p;
> +
> +	for (p = mnt; p; p = next_mnt(p, mnt)) {
> +		int flags = p->mnt.mnt_flags;
> +		/* Don't allow unprivileged users to change mount flags */
> +		flags |= MNT_LOCK_ATIME;
> +
> +		if (flags & MNT_READONLY)
> +			flags |= MNT_LOCK_READONLY;
> +
> +		if (flags & MNT_NODEV)
> +			flags |= MNT_LOCK_NODEV;
> +
> +		if (flags & MNT_NOSUID)
> +			flags |= MNT_LOCK_NOSUID;
> +
> +		if (flags & MNT_NOEXEC)
> +			flags |= MNT_LOCK_NOEXEC;
> +		/* Don't allow unprivileged users to reveal what is under a mount */
> +		if (list_empty(&p->mnt_expire))
> +			flags |= MNT_LOCKED;
> +		p->mnt.mnt_flags = flags;
> +	}
> +}
> +
>   static void cleanup_group_ids(struct mount *mnt, struct mount *end)
>   {
>   	struct mount *p;
> @@ -1954,6 +1960,7 @@ static int attach_recursive_mnt(struct mount *source_mnt,
>   			struct mountpoint *dest_mp,
>   			struct path *parent_path)
>   {
> +	struct user_namespace *user_ns = current->nsproxy->mnt_ns->user_ns;
>   	HLIST_HEAD(tree_list);
>   	struct mnt_namespace *ns = dest_mnt->mnt_ns;
>   	struct mountpoint *smp;
> @@ -2004,6 +2011,9 @@ static int attach_recursive_mnt(struct mount *source_mnt,
>   				 child->mnt_mountpoint);
>   		if (q)
>   			mnt_change_mountpoint(child, smp, q);
> +		/* Notice when we are propagating across user namespaces */
> +		if (child->mnt_parent->mnt_ns->user_ns != user_ns)
> +			lock_mnt_tree(child);
>   		commit_tree(child);
>   	}
>   	put_mountpoint(smp);
> @@ -2941,13 +2951,18 @@ struct mnt_namespace *copy_mnt_ns(unsigned long flags, struct mnt_namespace *ns,
>   	/* First pass: copy the tree topology */
>   	copy_flags = CL_COPY_UNBINDABLE | CL_EXPIRE;
>   	if (user_ns != ns->user_ns)
> -		copy_flags |= CL_SHARED_TO_SLAVE | CL_UNPRIVILEGED;
> +		copy_flags |= CL_SHARED_TO_SLAVE;
>   	new = copy_tree(old, old->mnt.mnt_root, copy_flags);
>   	if (IS_ERR(new)) {
>   		namespace_unlock();
>   		free_mnt_ns(new_ns);
>   		return ERR_CAST(new);
>   	}
> +	if (user_ns != ns->user_ns) {
> +		lock_mount_hash();
> +		lock_mnt_tree(new);
> +		unlock_mount_hash();
> +	}
>   	new_ns->root = new;
>   	list_add_tail(&new_ns->list, &new->mnt_list);
>   
> diff --git a/fs/pnode.c b/fs/pnode.c
> index 1100e810d855..7ea6cfb65077 100644
> --- a/fs/pnode.c
> +++ b/fs/pnode.c
> @@ -214,7 +214,6 @@ static struct mount *next_group(struct mount *m, struct mount *origin)
>   }
>   
>   /* all accesses are serialized by namespace_sem */
> -static struct user_namespace *user_ns;
>   static struct mount *last_dest, *first_source, *last_source, *dest_master;
>   static struct mountpoint *mp;
>   static struct hlist_head *list;
> @@ -260,9 +259,6 @@ static int propagate_one(struct mount *m)
>   			type |= CL_MAKE_SHARED;
>   	}
>   		
> -	/* Notice when we are propagating across user namespaces */
> -	if (m->mnt_ns->user_ns != user_ns)
> -		type |= CL_UNPRIVILEGED;
>   	child = copy_tree(last_source, last_source->mnt.mnt_root, type);
>   	if (IS_ERR(child))
>   		return PTR_ERR(child);
> @@ -303,7 +299,6 @@ int propagate_mnt(struct mount *dest_mnt, struct mountpoint *dest_mp,
>   	 * propagate_one(); everything is serialized by namespace_sem,
>   	 * so globals will do just fine.
>   	 */
> -	user_ns = current->nsproxy->mnt_ns->user_ns;
>   	last_dest = dest_mnt;
>   	first_source = source_mnt;
>   	last_source = source_mnt;
> diff --git a/fs/pnode.h b/fs/pnode.h
> index dc87e65becd2..3960a83666cf 100644
> --- a/fs/pnode.h
> +++ b/fs/pnode.h
> @@ -27,8 +27,7 @@
>   #define CL_MAKE_SHARED 		0x08
>   #define CL_PRIVATE 		0x10
>   #define CL_SHARED_TO_SLAVE	0x20
> -#define CL_UNPRIVILEGED		0x40
> -#define CL_COPY_MNT_NS_FILE	0x80
> +#define CL_COPY_MNT_NS_FILE	0x40
>   
>   #define CL_COPY_ALL		(CL_COPY_UNBINDABLE | CL_COPY_MNT_NS_FILE)
>   
>
>

I can see that this covers copy_mnt_ns().  It should also cover what 
will happen in future, if you pass an OPEN_TREE_CLONE fd to a process 
with a different mnt_ns and mnt_ns->user_ns, and that process mounts the 
fd using move_mount().  However, I can't work out how this covers mount 
propagation across namespaces.

The comment "Notice when we are propagating across user namespaces" is 
moved to attach_recursive_mnt().  I can't find any call to 
attach_recursive_mount() inside the mount propagation code.  Am I 
overlooking something?

Thanks
Alan
