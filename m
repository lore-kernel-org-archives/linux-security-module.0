Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD062C10F1E
	for <linux-security-module@archiver.kernel.org>; Thu,  8 Dec 2022 16:46:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbiLHQqk (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 8 Dec 2022 11:46:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbiLHQqj (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 8 Dec 2022 11:46:39 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E28AD9AF
        for <linux-security-module@vger.kernel.org>; Thu,  8 Dec 2022 08:46:37 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id hd14-20020a17090b458e00b0021909875bccso6127853pjb.1
        for <linux-security-module@vger.kernel.org>; Thu, 08 Dec 2022 08:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M5g9x1VwrktuopxwMZHjOgJ8tHfMh8aN/AqahvEyUyc=;
        b=U2b9lM71DR7CIe1jVRJVDqcCVhIQHrqrw/uvbLFZM9bDhCqODmtXgLThl7qogxizyH
         LHX+6BExWkAsbrHdlV59CE1zTXObbdVbPVjURA6GJFFKmtA6dpDCKmVME2CfPTDIysXO
         78uEvSSKu9kDFFKutu9isCrAh0vezxIhwguWU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M5g9x1VwrktuopxwMZHjOgJ8tHfMh8aN/AqahvEyUyc=;
        b=HFLOyQMsUrr9PMuv3Nsis8fDtHJmxXAxfyEO53F18IwBUeRWSqcSrWKwXEOW/9IcUY
         Ht2LfyNiiIh2LElCOw9LSM/VQPVlkaXC77r0DdVjmqyc13VsVrYS+6+v3paw0plIS83K
         VAgJ7d7RldNxa+ID60+i+8E4pG1ZfimgbOsAEl9KJkMJqRu4czapDhedGUjbD0ctF2GD
         C9aYZ9TExyTTMNFreLEoFYX+XNYMal78yA8/qyHLm8WV7fw5BhcapAcPdfAsVAyWo7+f
         4Mu9GYGN4SbM3yJG/OKOjermzb77mJPEsLTZ8TE9TnVe37b3LARKsprTbrA/CcID67F4
         KAKw==
X-Gm-Message-State: ANoB5plNNDyK6nO7jb10+xHKNEv2zpds4uq+ywOgs5QRto6oVcJbhsQm
        bXMnIgtCLv1IQYNN0ryfRkemdA==
X-Google-Smtp-Source: AA0mqf7rJ3anr4Kc+n7+Zjin6BYJYXJCfq/+N+XN/qjcSVRqcGe1qoouE4guqX4TOa/NYXtzAAEA9A==
X-Received: by 2002:a17:902:dacd:b0:189:6889:c30a with SMTP id q13-20020a170902dacd00b001896889c30amr61854329plx.6.1670517997289;
        Thu, 08 Dec 2022 08:46:37 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f6-20020a170902ce8600b001743ba85d39sm16877857plg.110.2022.12.08.08.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 08:46:36 -0800 (PST)
Date:   Thu, 8 Dec 2022 08:46:35 -0800
From:   Kees Cook <keescook@chromium.org>
To:     jeffxu@chromium.org
Cc:     skhan@linuxfoundation.org, akpm@linux-foundation.org,
        dmitry.torokhov@gmail.com, dverkamp@chromium.org, hughd@google.com,
        jeffxu@google.com, jorgelo@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, jannh@google.com,
        linux-hardening@vger.kernel.org, kernel test robot <lkp@intel.com>,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v6 6/6] mm/memfd: security hook for memfd_create
Message-ID: <202212080845.8E9D894B@keescook>
References: <20221207154939.2532830-1-jeffxu@google.com>
 <20221207154939.2532830-7-jeffxu@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221207154939.2532830-7-jeffxu@google.com>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Dec 07, 2022 at 03:49:39PM +0000, jeffxu@chromium.org wrote:
> From: Jeff Xu <jeffxu@google.com>
> 
> The new security_memfd_create allows lsm to check flags of
> memfd_create.
> 
> The security by default system (such as chromeos) can use this
> to implement system wide lsm to allow only non-executable memfd
> being created.
> 
> Signed-off-by: Jeff Xu <jeffxu@google.com>
> Reported-by: kernel test robot <lkp@intel.com>

Oh, btw, please CC linux-security-module@vger.kernel.org when adding new
hooks. (I've added the CC here.)

-Kees

> ---
>  include/linux/lsm_hook_defs.h |  1 +
>  include/linux/lsm_hooks.h     |  4 ++++
>  include/linux/security.h      |  6 ++++++
>  mm/memfd.c                    |  5 +++++
>  security/security.c           | 13 +++++++++++++
>  5 files changed, 29 insertions(+)
> 
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index ec119da1d89b..fd40840927c8 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -164,6 +164,7 @@ LSM_HOOK(int, 0, file_alloc_security, struct file *file)
>  LSM_HOOK(void, LSM_RET_VOID, file_free_security, struct file *file)
>  LSM_HOOK(int, 0, file_ioctl, struct file *file, unsigned int cmd,
>  	 unsigned long arg)
> +LSM_HOOK(int, 0, memfd_create, char *name, unsigned int flags)
>  LSM_HOOK(int, 0, mmap_addr, unsigned long addr)
>  LSM_HOOK(int, 0, mmap_file, struct file *file, unsigned long reqprot,
>  	 unsigned long prot, unsigned long flags)
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 4ec80b96c22e..5a18a6552278 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -543,6 +543,10 @@
>   *	simple integer value.  When @arg represents a user space pointer, it
>   *	should never be used by the security module.
>   *	Return 0 if permission is granted.
> + * @memfd_create:
> + *	@name is the name of memfd file.
> + *	@flags is the flags used in memfd_create.
> + *	Return 0 if permission is granted.
>   * @mmap_addr :
>   *	Check permissions for a mmap operation at @addr.
>   *	@addr contains virtual address that will be used for the operation.
> diff --git a/include/linux/security.h b/include/linux/security.h
> index ca1b7109c0db..5b87a780822a 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -384,6 +384,7 @@ int security_file_permission(struct file *file, int mask);
>  int security_file_alloc(struct file *file);
>  void security_file_free(struct file *file);
>  int security_file_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
> +int security_memfd_create(char *name, unsigned int flags);
>  int security_mmap_file(struct file *file, unsigned long prot,
>  			unsigned long flags);
>  int security_mmap_addr(unsigned long addr);
> @@ -963,6 +964,11 @@ static inline int security_file_ioctl(struct file *file, unsigned int cmd,
>  	return 0;
>  }
>  
> +static inline int security_memfd_create(char *name, unsigned int flags)
> +{
> +	return 0;
> +}
> +
>  static inline int security_mmap_file(struct file *file, unsigned long prot,
>  				     unsigned long flags)
>  {
> diff --git a/mm/memfd.c b/mm/memfd.c
> index 92f0a5765f7c..f04ed5f0474f 100644
> --- a/mm/memfd.c
> +++ b/mm/memfd.c
> @@ -356,6 +356,11 @@ SYSCALL_DEFINE2(memfd_create,
>  		goto err_name;
>  	}
>  
> +	/* security hook for memfd_create */
> +	error = security_memfd_create(name, flags);
> +	if (error)
> +		return error;
> +
>  	if (flags & MFD_HUGETLB) {
>  		file = hugetlb_file_setup(name, 0, VM_NORESERVE,
>  					HUGETLB_ANONHUGE_INODE,
> diff --git a/security/security.c b/security/security.c
> index 79d82cb6e469..5c018e080923 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1010,6 +1010,19 @@ int security_sb_clone_mnt_opts(const struct super_block *oldsb,
>  }
>  EXPORT_SYMBOL(security_sb_clone_mnt_opts);
>  
> +int security_add_mnt_opt(const char *option, const char *val, int len,
> +			 void **mnt_opts)
> +{
> +	return call_int_hook(sb_add_mnt_opt, -EINVAL,
> +					option, val, len, mnt_opts);
> +}
> +EXPORT_SYMBOL(security_add_mnt_opt);
> +
> +int security_memfd_create(char *name, unsigned int flags)
> +{
> +	return call_int_hook(memfd_create, 0, name, flags);
> +}
> +
>  int security_move_mount(const struct path *from_path, const struct path *to_path)
>  {
>  	return call_int_hook(move_mount, 0, from_path, to_path);
> -- 
> 2.39.0.rc0.267.gcb52ba06e7-goog
> 

-- 
Kees Cook
