Return-Path: <SRS0=8N7l=D4=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B92CAC56203
	for <linux-security-module@archiver.kernel.org>; Wed, 21 Oct 2020 12:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44C7C2224B
	for <linux-security-module@archiver.kernel.org>; Wed, 21 Oct 2020 12:12:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="M4V61LUv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442214AbgJUMMF (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 21 Oct 2020 08:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2442211AbgJUMME (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 21 Oct 2020 08:12:04 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573E4C0613D2
        for <linux-security-module@vger.kernel.org>; Wed, 21 Oct 2020 05:12:04 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id t4so1101113plq.13
        for <linux-security-module@vger.kernel.org>; Wed, 21 Oct 2020 05:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=v3SI87Cjm2G5EpAaLb2jmxm1cSl4yPQOy4ANEWsTrbY=;
        b=M4V61LUvbhMf9TxB7ZsMhAojSWcURHYOodt0VpLbFBCduE60mpTmsMn/HlJ4WbpTl8
         eSzlEF+AUO14IRzNqIDrBsFRw97RKYf4cT8kP9CvImJHTX1WRY6IbCrNs5eEnUyK1QVu
         nUxog3s9hiYCn/G1Z98v5NFH+WmDYCKIzlPp/vxaw9IR2U6MH3ydoThdBHZaOezABRMp
         zxdIiNT8orSHd08/WdKbq3w2SUKuuayx9pGAV0ZrUCS62yGPc0qQYe8S9TdH5tWotrhn
         intkCn1WB+g5+J9DOiQgCFvKjvegxlWpZxZ/TUb5hdRzC76NBXEPR25vUZHBeNF1aspc
         AB0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=v3SI87Cjm2G5EpAaLb2jmxm1cSl4yPQOy4ANEWsTrbY=;
        b=BSSwq23z6VBf2qijyJKkozsbLDUN6LuXEEOuQhkd33XZH6i8j5jG3iPneviX6/us5B
         1JP0O/w+LE+xtHgDqTX51wqjCaYUsI7ROtRH3VQkmJVTyJpM029/ZAf3CL0dwaGewll+
         VmQJ69vWy+LBYI2RLl2vE6Am1T3Y1Auttuu/e9xTUJaewd9Nn+iE7N8r5NkgvhpQF7tD
         hZaLK8BihPou5WrFCx2LNB9nuuXMHTvGm+gtGpMgl9fguskokH3P7ZMisLPDu6j1btGD
         amWTNyqkQ7Kuoj181TH9t07ycbFaCr7o3Vat5D/sJIVTthLs4529eLS/PBGL1B3nE2zo
         g1kg==
X-Gm-Message-State: AOAM532esSvtlszQcVQo/Q5PRWmgjInDmWsiWqQGQKUB015ijyFJODpm
        +KYzFbtkTJu0F/iNQjUhtk78qCDyBdVH2A==
X-Google-Smtp-Source: ABdhPJy89qDGbo2SbnJkqRTkpw+pYVVTnm/219KVxZgvjBtHEiGcERLGsE/GVeX3gTFCnhUwnOaJYg==
X-Received: by 2002:a17:90a:c28a:: with SMTP id f10mr3138379pjt.30.1603282323585;
        Wed, 21 Oct 2020 05:12:03 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:15c:211:200:4a0f:cfff:fe35:d61b])
        by smtp.googlemail.com with ESMTPSA id o134sm2213198pfg.134.2020.10.21.05.12.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2020 05:12:02 -0700 (PDT)
Subject: Re: [PATCH v17 2/4] overlayfs: handle XATTR_NOSECURITY flag for get
 xattr method
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Stephen Smalley <sds@tycho.nsa.gov>,
        linux-security-module@vger.kernel.org,
        Miklos Szeredi <miklos@szeredi.hu>,
        Jonathan Corbet <corbet@lwn.net>,
        Vivek Goyal <vgoyal@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Amir Goldstein <amir73il@gmail.com>, linux-doc@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <20201020191732.4049987-1-salyzyn@android.com>
 <20201020191732.4049987-3-salyzyn@android.com>
From:   Mark Salyzyn <salyzyn@android.com>
Message-ID: <b4372a9a-a0df-fd9c-a2b8-a004e73cce01@android.com>
Date:   Wed, 21 Oct 2020 05:12:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201020191732.4049987-3-salyzyn@android.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 10/20/20 12:17 PM, Mark Salyzyn wrote:
> Because of the overlayfs getxattr recursion, the incoming inode fails
> to update the selinux sid resulting in avc denials being reported
> against a target context of u:object_r:unlabeled:s0.
>
> Solution is to respond to the XATTR_NOSECURITY flag in get xattr
> method that calls the __vfs_getxattr handler instead so that the
> context can be read in, rather than being denied with an -EACCES
> when vfs_getxattr handler is called.
>
> For the use case where access is to be blocked by the security layer.
>
> The path then would be security(dentry) ->
> __vfs_getxattr({dentry...XATTR_NOSECURITY}) ->
> handler->get({dentry...XATTR_NOSECURITY}) ->
> __vfs_getxattr({realdentry...XATTR_NOSECURITY}) ->
> lower_handler->get({realdentry...XATTR_NOSECURITY}) which
> would report back through the chain data and success as expected,
> the logging security layer at the top would have the data to
> determine the access permissions and report back to the logs and
> the caller that the target context was blocked.
>
> For selinux this would solve the cosmetic issue of the selinux log
> and allow audit2allow to correctly report the rule needed to address
> the access problem.
>
> Check impure, opaque, origin & meta xattr with no sepolicy audit
> (using __vfs_getxattr) since these operations are internal to
> overlayfs operations and do not disclose any data.  This became
> an issue for credential override off since sys_admin would have
> been required by the caller; whereas would have been inherently
> present for the creator since it performed the mount.
>
> This is a change in operations since we do not check in the new
> ovl_do_getxattr function if the credential override is off or not.
> Reasoning is that the sepolicy check is unnecessary overhead,
> especially since the check can be expensive.
>
> Because for override credentials off, this affects _everyone_ that
> underneath performs private xattr calls without the appropriate
> sepolicy permissions and sys_admin capability.  Providing blanket
> support for sys_admin would be bad for all possible callers.
>
> For the override credentials on, this will affect only the mounter,
> should it lack sepolicy permissions. Not considered a security
> problem since mounting by definition has sys_admin capabilities,
> but sepolicy contexts would still need to be crafted.
>
> It should be noted that there is precedence, __vfs_getxattr is used
> in other filesystems for their own internal trusted xattr management.
>
> Signed-off-by: Mark Salyzyn <salyzyn@android.com>
> To: linux-fsdevel@vger.kernel.org
> To: linux-unionfs@vger.kernel.org
> Cc: Stephen Smalley <sds@tycho.nsa.gov>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-security-module@vger.kernel.org
> Cc: kernel-team@android.com
> Cc: Miklos Szeredi <miklos@szeredi.hu>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Vivek Goyal <vgoyal@redhat.com>
> Cc: Eric W. Biederman <ebiederm@xmission.com>
> Cc: Amir Goldstein <amir73il@gmail.com>
> Cc: Stephen Smalley <sds@tycho.nsa.gov>
> Cc: linux-doc@vger.kernel.org
>
> v17 - rebase and add inode argument to __Vfs_getxattr
>
> v16 - rebase and merge internal getxattr operations patch
>
> v15 - revert to v13 because xattr_gs_args rejected.
>
> v14 - rebase to use xattr_gs_args.
>
> v13 - rebase to use __vfs_getxattr flags option.
>
> v12 - Added back to patch series as get xattr with flag option.
>
> v11 - Squashed out of patch series and replaced with per-thread flag
>        solution.
>
> v10 - Added to patch series as __get xattr method.
> ---
>   fs/overlayfs/inode.c     | 5 +++--
>   fs/overlayfs/overlayfs.h | 6 ++++--
>   fs/overlayfs/super.c     | 4 ++--
>   3 files changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
> index b584dca845ba..2b14291beb86 100644
> --- a/fs/overlayfs/inode.c
> +++ b/fs/overlayfs/inode.c
> @@ -378,7 +378,7 @@ int ovl_xattr_set(struct dentry *dentry, struct inode *inode, const char *name,
>   }
>   
>   int ovl_xattr_get(struct dentry *dentry, struct inode *inode, const char *name,
> -		  void *value, size_t size)
> +		  void *value, size_t size, int flags)
>   {
>   	ssize_t res;
>   	const struct cred *old_cred;
> @@ -386,7 +386,8 @@ int ovl_xattr_get(struct dentry *dentry, struct inode *inode, const char *name,
>   		ovl_i_dentry_upper(inode) ?: ovl_dentry_lower(dentry);
>   
>   	old_cred = ovl_override_creds(dentry->d_sb);
> -	res = vfs_getxattr(realdentry, name, value, size);
> +	res = __vfs_getxattr(realdentry, d_inode(realdentry), name,
> +			     value, size, flags);
>   	revert_creds(old_cred);
>   	return res;
>   }
> diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> index f8880aa2ba0e..d3bf21bd60ab 100644
> --- a/fs/overlayfs/overlayfs.h
> +++ b/fs/overlayfs/overlayfs.h
> @@ -184,7 +184,9 @@ static inline ssize_t ovl_do_getxattr(struct ovl_fs *ofs, struct dentry *dentry,
>   				      size_t size)
>   {
>   	const char *name = ovl_xattr(ofs, ox);
> -	return vfs_getxattr(dentry, name, value, size);
> +	struct ovl_inode *ip = d_inode(dentry);

      struct inode *ip = d_inode(dentry);

<oops> copy and paste error from testing kernel to main


