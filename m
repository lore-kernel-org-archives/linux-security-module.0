Return-Path: <SRS0=vYSA=Q3=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFBABC43381
	for <linux-security-module@archiver.kernel.org>; Wed, 20 Feb 2019 18:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BFED206C0
	for <linux-security-module@archiver.kernel.org>; Wed, 20 Feb 2019 18:59:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sPPzLHAz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbfBTS7b (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 20 Feb 2019 13:59:31 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52042 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbfBTS7a (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 20 Feb 2019 13:59:30 -0500
Received: by mail-wm1-f65.google.com with SMTP id n19so7709526wmi.1;
        Wed, 20 Feb 2019 10:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=pCMkP1QOowY9M43VDV6r8m4uMezeHM6eDrf7s0bA+Q4=;
        b=sPPzLHAzJdrzeg8jmkXQOon3SvdAaEsf6nrXI6HRA8s+BbT1slgQPutbSQXfSRo1l8
         CxuNDFK3rUFzGIvrG0wBcQkWMBojKPOOClAtNLr1gm4Z17F0Qa4oZ65fdxAkRkNTLHfU
         MC3TTQ6TSgMnwGEaJCbr4Occr3EDxlLung9ApTPPg0zkDZ0NJYHjb+AAo+oDy5BdoSiF
         4AVIzFEUI3EjHmvfoph9L4eanqBI1MxiUJ6jvXgRhvey8v8FtyfFmUZJAh9yTpcN9Z8D
         IQbiEMw5QKe+4LJjjlqUwNgT/URA7MUoBzSNsU2oslbALtU1hduFZuAVT0yOCUjTHhqU
         6icw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=pCMkP1QOowY9M43VDV6r8m4uMezeHM6eDrf7s0bA+Q4=;
        b=gWzBQDLfDpqLZIqu3LBVg1Px6mQW50TpYwyKIoDW6A8jWikdbUGu4+8KC5HoaQRvCX
         JytO36XKbnHNlRTjzNJTWYa9kLSDOdQNH8NK9mZqQfOoOn/q+ZbouKNESXXMT/8E0jxj
         BuIGT72H5Gk3sLoikjGRdzIdxnG6sAsueh2HLv1iyWiEx9IjQsDjLv+m0qVM0JftXxQl
         Amjp9ElaO3YBhQtE+8qj+7bVFhWuA6yq2FElTrzQw9uPcOVnghkgL/rbr0Rlo98k/R4K
         g1+WVI2MDQ9cKmJtdQA/siqGSyt35rRlDSA7811Si8QDVpALZ57Ph06IB/vBJW4r0Fek
         HorA==
X-Gm-Message-State: AHQUAuamf6D3gAaOXIKc4qK4DUBzmSbjumGhga49bxinKuIGAQfk8hrs
        jeAoCpmhC3/ZWdsg/OtD50ygD335
X-Google-Smtp-Source: AHgI3IYumHbEcke0rkmg7p3ok26w/YBQycq/V8S1ce+ZpMKicMyxvfQABg9JsWVURUSbkAna4tcETw==
X-Received: by 2002:a1c:a185:: with SMTP id k127mr7546723wme.134.1550689168325;
        Wed, 20 Feb 2019 10:59:28 -0800 (PST)
Received: from [172.16.1.192] (host-78-151-217-103.as13285.net. [78.151.217.103])
        by smtp.gmail.com with ESMTPSA id z16sm20670110wrr.66.2019.02.20.10.59.27
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 10:59:27 -0800 (PST)
From:   Alan Jenkins <alan.christopher.jenkins@gmail.com>
Subject: Re: [PATCH 03/10] teach move_mount(2) to work with OPEN_TREE_CLONE
To:     David Howells <dhowells@redhat.com>, viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org,
        ebiederm@xmission.com, linux-security-module@vger.kernel.org
References: <155059610368.17079.2220554006494174417.stgit@warthog.procyon.org.uk>
 <155059612649.17079.7287713053194562461.stgit@warthog.procyon.org.uk>
Message-ID: <0c084993-d45d-20b3-2709-38bbd12c5936@gmail.com>
Date:   Wed, 20 Feb 2019 18:59:26 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <155059612649.17079.7287713053194562461.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 19/02/2019 17:08, David Howells wrote:
> Allow a detached tree created by open_tree(..., OPEN_TREE_CLONE) to be
> attached by move_mount(2).
>
> If by the time of final fput() of OPEN_TREE_CLONE-opened file its tree is
> not detached anymore, it won't be dissolved.  move_mount(2) is adjusted
> to handle detached source.
>
> That gives us equivalents of mount --bind and mount --rbind.
> Thanks also to Alan Jenkins<alan.christopher.jenkins@gmail.com>  for
> providing a whole bunch of ways to break things using this interface.
>
> Signed-off-by: Al Viro<viro@zeniv.linux.org.uk>
> Signed-off-by: David Howells<dhowells@redhat.com>
> Signed-off-by: Al Viro<viro@zeniv.linux.org.uk>
> ---
>
>   fs/namespace.c |   62 ++++++++++++++++++++++++++++++++++++++++++++++++++------
>   1 file changed, 55 insertions(+), 7 deletions(-)
>
> diff --git a/fs/namespace.c b/fs/namespace.c
> index f10122028a11..56423c60ac7e 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -1840,10 +1840,16 @@ void dissolve_on_fput(struct vfsmount *mnt)
>   	namespace_lock();
>   	lock_mount_hash();
>   	ns = real_mount(mnt)->mnt_ns;
> -	umount_tree(real_mount(mnt), UMOUNT_CONNECTED);
> +	if (ns) {
> +		if (is_anon_ns(ns))
> +			umount_tree(real_mount(mnt), UMOUNT_CONNECTED);
> +		else
> +			ns = NULL;
> +	}
>   	unlock_mount_hash();
>   	namespace_unlock();
> -	free_mnt_ns(ns);
> +	if (ns)
> +		free_mnt_ns(ns);
>   }
>   
>   void drop_collected_mounts(struct vfsmount *mnt)
> @@ -2079,6 +2085,10 @@ static int attach_recursive_mnt(struct mount *source_mnt,
>   		attach_mnt(source_mnt, dest_mnt, dest_mp);
>   		touch_mnt_namespace(source_mnt->mnt_ns);
>   	} else {
> +		if (source_mnt->mnt_ns) {
> +			/* move from anon - the caller will destroy */
> +			list_del_init(&source_mnt->mnt_ns->list);
> +		}
>   		mnt_set_mountpoint(dest_mnt, dest_mp, source_mnt);
>   		commit_tree(source_mnt);
>   	}
> @@ -2537,13 +2547,37 @@ static inline int tree_contains_unbindable(struct mount *mnt)
>   	return 0;
>   }
>   
> +/*
> + * Check that there aren't references to earlier/same mount namespaces in the
> + * specified subtree.  Such references can act as pins for mount namespaces
> + * that aren't checked by the mount-cycle checking code, thereby allowing
> + * cycles to be made.
> + */
> +static bool check_for_nsfs_mounts(struct mount *subtree)
> +{
> +	struct mount *p;
> +	bool ret = false;
> +
> +	lock_mount_hash();
> +	for (p = subtree; p; p = next_mnt(p, subtree))
> +		if (mnt_ns_loop(p->mnt.mnt_root))
> +			goto out;
> +
> +	ret = true;
> +out:
> +	unlock_mount_hash();
> +	return ret;
> +}
> +
>   static int do_move_mount(struct path *old_path, struct path *new_path)
>   {
>   	struct path parent_path = {.mnt = NULL, .dentry = NULL};
> +	struct mnt_namespace *ns;
>   	struct mount *p;
>   	struct mount *old;
>   	struct mountpoint *mp;
>   	int err;
> +	bool attached;
>   
>   	mp = lock_mount(new_path);
>   	if (IS_ERR(mp))
> @@ -2551,12 +2585,19 @@ static int do_move_mount(struct path *old_path, struct path *new_path)
>   
>   	old = real_mount(old_path->mnt);
>   	p = real_mount(new_path->mnt);
> +	attached = mnt_has_parent(old);
> +	ns = old->mnt_ns;
>   
>   	err = -EINVAL;
> -	if (!check_mnt(p) || !check_mnt(old))
> +	/* The mountpoint must be in our namespace. */
> +	if (!check_mnt(p))
>   		goto out;
>   
> -	if (!mnt_has_parent(old))
> +	/* The thing moved should be either ours or completely unattached. */
> +	if (attached && !check_mnt(old))
> +		goto out;
> +
> +	if (!attached && !is_anon_ns(ns))

I think this is missing a check for ns != NULL, before passing it to 
is_anon_ns().

E.g. in case I called umount2(old_path, MNT_DETACH) beforehand.

>   		goto out;
>   
>   	if (old->mnt.mnt_flags & MNT_LOCKED)
> @@ -2571,7 +2612,7 @@ static int do_move_mount(struct path *old_path, struct path *new_path)
>   	/*
>   	 * Don't move a mount residing in a shared parent.
>   	 */
> -	if (IS_MNT_SHARED(old->mnt_parent))
> +	if (attached && IS_MNT_SHARED(old->mnt_parent))
>   		goto out;
>   	/*
>   	 * Don't move a mount tree containing unbindable mounts to a destination
> @@ -2580,12 +2621,14 @@ static int do_move_mount(struct path *old_path, struct path *new_path)
>   	if (IS_MNT_SHARED(p) && tree_contains_unbindable(old))
>   		goto out;
>   	err = -ELOOP;
> +	if (!check_for_nsfs_mounts(old))
> +		goto out;
>   	for (; mnt_has_parent(p); p = p->mnt_parent)
>   		if (p == old)
>   			goto out;
>   
>   	err = attach_recursive_mnt(old, real_mount(new_path->mnt), mp,
> -				   &parent_path);
> +				   attached ? &parent_path : NULL);
>   	if (err)
>   		goto out;
>   
> @@ -2594,8 +2637,11 @@ static int do_move_mount(struct path *old_path, struct path *new_path)
>   	list_del_init(&old->mnt_expire);
>   out:
>   	unlock_mount(mp);
> -	if (!err)
> +	if (!err) {
>   		path_put(&parent_path);
> +		if (!attached)
> +			free_mnt_ns(ns);
> +	}
>   	return err;
>   }
>   
> @@ -3289,6 +3335,8 @@ SYSCALL_DEFINE5(mount, char __user *, dev_name, char __user *, dir_name,
>   
>   /*
>    * Move a mount from one place to another.
> + * In combination with open_tree(OPEN_TREE_CLONE [| AT_RECURSIVE]) it can be
> + * used to copy a mount subtree.
>    *
>    * Note the flags value is a combination of MOVE_MOUNT_* flags.
>    */
>
>

