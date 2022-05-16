Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45857C433FE
	for <linux-security-module@archiver.kernel.org>; Mon, 16 May 2022 18:14:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244301AbiEPSOq (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 16 May 2022 14:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344792AbiEPSOi (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 16 May 2022 14:14:38 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D2B3DA65;
        Mon, 16 May 2022 11:14:36 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:35888)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nqfEo-00DVWz-9p; Mon, 16 May 2022 12:14:34 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:38392 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nqfEl-007IPY-AV; Mon, 16 May 2022 12:14:33 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Yongzhi Liu <lyz_cs@pku.edu.cn>
Cc:     serge@hallyn.com, jmorris@namei.org, viro@zeniv.linux.org.uk,
        dhowells@redhat.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1652722802-66170-1-git-send-email-lyz_cs@pku.edu.cn>
Date:   Mon, 16 May 2022 13:14:03 -0500
In-Reply-To: <1652722802-66170-1-git-send-email-lyz_cs@pku.edu.cn> (Yongzhi
        Liu's message of "Mon, 16 May 2022 10:40:02 -0700")
Message-ID: <87y1z1bb10.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nqfEl-007IPY-AV;;;mid=<87y1z1bb10.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1/qAznHaVwLGdxqAtm8rl5W3J7vvA4ZFdM=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH] commoncap: check return value to avoid null pointer
 dereference
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Yongzhi Liu <lyz_cs@pku.edu.cn> writes:

> The pointer inode is dereferenced before a null pointer
> check on inode, hence if inode is actually null we will
> get a null pointer dereference. Fix this by only dereferencing
> inode after the null pointer check on inode.
>
> Fixes: c6f493d631c ("VFS: security/: d_backing_inode() annotations")
> Fixes: 8db6c34 ("Introduce v3 namespaced file capabilities")

I don't see how this fixes anything.

The dentry should be non-negative so d_backing_inode should always
return true.


> Signed-off-by: Yongzhi Liu <lyz_cs@pku.edu.cn>
> ---
>  security/commoncap.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/security/commoncap.c b/security/commoncap.c
> index 5fc8986..978f011 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -298,6 +298,8 @@ int cap_inode_need_killpriv(struct dentry *dentry)
>  	struct inode *inode = d_backing_inode(dentry);
>  	int error;
>  
> +	if (!inode)
> +		return 0;

How can  dentry->d_inode be valid and d_backing_inode not be valid?

That would seem to be a bug elsewhere in the code if it actually happens.

>  	error = __vfs_getxattr(dentry, inode, XATTR_NAME_CAPS, NULL, 0);
>  	return error > 0;
>  }
> @@ -545,11 +547,13 @@ int cap_convert_nscap(struct user_namespace *mnt_userns, struct dentry *dentry,
>  	const struct vfs_cap_data *cap = *ivalue;
>  	__u32 magic, nsmagic;
>  	struct inode *inode = d_backing_inode(dentry);
> -	struct user_namespace *task_ns = current_user_ns(),
> -		*fs_ns = inode->i_sb->s_user_ns;
> +	struct user_namespace *task_ns = current_user_ns(), *fs_ns;
>  	kuid_t rootid;
>  	size_t newsize;
>  
> +	if (!inode)
> +		return -EINVAL;
> +	fs_ns = inode->i_sb->s_user_ns;
>  	if (!*ivalue)
>  		return -EINVAL;
>  	if (!validheader(size, cap))

Same with this one.  Short of a negative dentry I don't see how
d_backing_inode can be NULL, and we are talking about negative
dentries that should have been handled long before these two functions
are called.

Eric
