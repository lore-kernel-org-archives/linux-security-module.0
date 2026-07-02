Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA390385509
	for <linux-security-module@vger.kernel.org>; Thu,  2 Jul 2026 19:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783019707; cv=none; b=rM/+qDa4/YXuS9lP0CKvQoNBYpccBI7CLIYHH/XpkcQITs2SnYAei9Ns6dyt/YrqjXf2gDv8Oma16a4djQyc7CUrCX+FQK9k1bBRBzvNZtgDkhw8AEhn6qem6M2ckL7712RIzxVXjkoFXPyt3NG4QAvJZ4+/Q+AIrMWFOZ/za2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783019707; c=relaxed/simple;
	bh=BcKyugM+PcLiryWQeoTXR9pwmhkNOsumV8CmJLf5AzE=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=Fbp9srhqKpgYsy45jJKDGzs7UGQZh0GDxEECpH6Y930tu7XphRqonO4FBBCbZApHU7Ws3jL3CDFInHlcUL6dOHm0kTfVFz2PNwF0T/5Vt1O1VqF96y1bvW8a5UfKyWulVlHSUbOlidQNkMFDOXqiYFx3HXSG7Op/j3e6piWchw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=AaM9HEzO; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="AaM9HEzO"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-51bfbe05683so14254771cf.2
        for <linux-security-module@vger.kernel.org>; Thu, 02 Jul 2026 12:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1783019705; x=1783624505; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S46PvXFOEbrdN0/eD56EqDGtOOvkgCsLWdW5Au37pr0=;
        b=AaM9HEzOIUrkt+bz7RkjuHinWulc1sqQi+6RdVT+/Be88Cx/zuvV5foYT4NLqNe/ZS
         Uul4Na5xslyacJkAgiwAYcmsvd3D8CP+/AVcheFty5M6vcwjlj8Hgl7zSp1E/ZnmHdsA
         N6yxJM9tIvLQPwA78hfm5ugv1Gyk0X6+xhcr2kMS4ZYW7PuR/YwD83+1ooY9q5lwAxGX
         9aIgqY+wbJiXEXG8XMxNnp+8vwKMnUoO/sXLzA2vNPgC+N4QGa+WKbd7bTovSmGlT7KZ
         TfM+OQCV8aUF5Q49T/dWuEE511HzXzyi5IgiIhHrFdJFOIxQfWPSEZvu9Y9Bjwu7OWj7
         q85g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783019705; x=1783624505;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S46PvXFOEbrdN0/eD56EqDGtOOvkgCsLWdW5Au37pr0=;
        b=RIeWlYTae4jO4cRUmnpjYoazoq/9ZtPz3kdDRNNoCWYVGPSK8rLgrNNdptp1wp/gRd
         MWeX4jB9nVC7h89WyMCd8aLXpUprl9tbv+zG6F+1vKdpJrAJkyT+SO1sAkykopgQA4u9
         Bz1UaDjuJBleS2+13yEED+kndcIi1zVowc6tc5dyx3Ce2MnWjGHhEADoOhKRyOamgUik
         B8sAr5FLryR3OdBZVJ0MH8f791TSlbTMJ/j5bVIoIofvB46Fil2V99zB6leAMMsQCgvQ
         ZJzJlUQ/z8Y3AKD4zONAjhIziNH6hAbYIstQp0Necd4BggChU521ZvooWJQg5r8eJHtA
         suOA==
X-Forwarded-Encrypted: i=1; AFNElJ/jwONbRqgB/WEESAgGEabRoi+jqwrJ8wT010QtH7IRN2k9bi6lvd4KXIjXQHO4Atv8wS8kyGdH+OGp2OkDAFUYuFPH8fE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdpHx8rpBZvaMo3wxGEXm91t3sN/LvuQ49SM/la9NeUdogGmYT
	5EgI9yH5lpHitnn/AN+HvaiXN17kMcmKfDK0iWk2vMk/OVUSe0Z7AlOEq1JxpbRH4Q==
X-Gm-Gg: AfdE7ckrdiDNjDfOJOxaXO/Z+9GB78z4ENm2QtfHfrIQsVtLW2TP+1goMdP+YZh1Cvf
	6ANlW9Jd94vmxQECb3iEhLYwpX0vt21XUrhtDTW7JrmZtQdA1BtOqE7PaUUQI2k6tLcOfOQQAEQ
	UGMnP7hXDAlE9WP2keNHCg7kun7JSXZ0Dg6WibvLBLrdsODIzZzj+AROnFzyfVuCuanIn0rm3Pt
	OkWJklagrg/eIy2aklBU5K8jPOi6leyCVRk/Kxb6Q7s3q7tVK2P2hF3BSchg6T8ZnhecXCXBow3
	lfXU1QVqi5Q51IvwkeAEL990mlyBzSuxQ00UJgWKBx760suWsknJt/30bDQn28fXaz5wh8x3ZYw
	so5egkYJ3jCgRB4DF29O4m3dIyXP735rF4IWFPpEfuqFKlURuWOHqxlxAltjM7HvWnqb3QwpDid
	GBlt2cd9dvqySfLQItZRCr0ISE4ylW1w0s2RgXA/hT1PN/2CGMNQIpSod/4//I97kOdXkB
X-Received: by 2002:a05:622a:4d05:b0:519:e020:6087 with SMTP id d75a77b69052e-51c26a5382fmr111769261cf.11.1783019704092;
        Thu, 02 Jul 2026 12:15:04 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c30c4c3c8sm20569961cf.23.2026.07.02.12.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 12:15:03 -0700 (PDT)
Date: Thu, 02 Jul 2026 15:15:02 -0400
Message-ID: <dde355196558210f6ca87c1a0745a3a8@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260701_1640/pstg-lib:20260701_1540/pstg-pwork:20260701_1640
From: Paul Moore <paul@paul-moore.com>
To: Matt Bobrowski <mattbobrowski@google.com>, linux-security-module@vger.kernel.org
Cc: James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, Matt Bobrowski <mattbobrowski@google.com>
Subject: Re: [PATCH] lsm: cleanup repeated lsm_blob_size_update() calls in  lsm_prepare()
References: <20260629210150.832576-1-mattbobrowski@google.com>
In-Reply-To: <20260629210150.832576-1-mattbobrowski@google.com>

On Jun 29, 2026 Matt Bobrowski <mattbobrowski@google.com> wrote:
> 
> Centralize the definition of LSM security blob fields using an X-macro
> (LSM_BLOBS_LIST). This reduces repetitive boilerplate code across
> struct lsm_blob_sizes, blob size registration in lsm_prepare(), and
> debug log printing in security_init().
> 
> Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
> ---
>  include/linux/lsm_hooks.h | 42 ++++++++++++++++------------
>  security/lsm_init.c       | 59 ++++++++++-----------------------------
>  2 files changed, 38 insertions(+), 63 deletions(-)
> 
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index b4f8cad53ddb..0e73b22bdeea 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -98,28 +98,34 @@ struct security_hook_list {
>  	const struct lsm_id *lsmid;
>  } __randomize_layout;
>  
> +#define LSM_BLOBS_LIST(X) \
> +	X(cred)          \
> +	X(file)          \
> +	X(backing_file)  \
> +	X(ib)            \
> +	X(inode)         \
> +	X(sock)          \
> +	X(superblock)    \
> +	X(ipc)           \
> +	X(key)           \
> +	X(msg_msg)       \
> +	X(perf_event)    \
> +	X(task)          \
> +	X(tun_dev)       \
> +	X(xattr_count)   \
> +	X(bdev)          \
> +	X(bpf_map)       \
> +	X(bpf_prog)      \
> +	X(bpf_token)
> +
>  /*
>   * Security blob size or offset data.
> + * Note: lbs_xattr_count is the number of xattr slots in new_xattrs array.
>   */
>  struct lsm_blob_sizes {
> -	unsigned int lbs_cred;
> -	unsigned int lbs_file;
> -	unsigned int lbs_backing_file;
> -	unsigned int lbs_ib;
> -	unsigned int lbs_inode;
> -	unsigned int lbs_sock;
> -	unsigned int lbs_superblock;
> -	unsigned int lbs_ipc;
> -	unsigned int lbs_key;
> -	unsigned int lbs_msg_msg;
> -	unsigned int lbs_perf_event;
> -	unsigned int lbs_task;
> -	unsigned int lbs_xattr_count; /* num xattr slots in new_xattrs array */
> -	unsigned int lbs_tun_dev;
> -	unsigned int lbs_bdev;
> -	unsigned int lbs_bpf_map;
> -	unsigned int lbs_bpf_prog;
> -	unsigned int lbs_bpf_token;
> +#define LSM_BLOB_SIZE(name) unsigned int lbs_##name;
> +	LSM_BLOBS_LIST(LSM_BLOB_SIZE);
> +#undef LSM_BLOB_SIZE
>  };

Generally speaking I greatly prefer to see the structure fields typed out
as it makes it easier to find them using grep, code indexers, etc.  There
is a similar argument for the security_init() changes (below).

> diff --git a/security/lsm_init.c b/security/lsm_init.c
> index 7c0fd17f1601..c256f1c33efa 100644
> --- a/security/lsm_init.c
> +++ b/security/lsm_init.c
> @@ -282,40 +282,24 @@ static void __init lsm_blob_size_update(unsigned int *sz_req,
>   * lsm_prepare - Prepare the LSM framework for a new LSM
>   * @lsm: LSM definition
>   */
> -static void __init lsm_prepare(struct lsm_info *lsm)
> +static void __init lsm_prepare(const struct lsm_info *lsm)
>  {
>  	struct lsm_blob_sizes *blobs = lsm->blobs;
>  
>  	if (!blobs)
>  		return;
>  
> -	/* Register the LSM blob sizes. */
> -	blobs = lsm->blobs;
> -	lsm_blob_size_update(&blobs->lbs_cred, &blob_sizes.lbs_cred);
> -	lsm_blob_size_update(&blobs->lbs_file, &blob_sizes.lbs_file);
> -	lsm_blob_size_update(&blobs->lbs_backing_file,
> -			     &blob_sizes.lbs_backing_file);
> -	lsm_blob_size_update(&blobs->lbs_ib, &blob_sizes.lbs_ib);
> -	/* inode blob gets an rcu_head in addition to LSM blobs. */
> +	/* The inode blob (inode->i_security) gets an rcu_head in addition to
> +	 * LSM blobs.
> +	 */
>  	if (blobs->lbs_inode && blob_sizes.lbs_inode == 0)
>  		blob_sizes.lbs_inode = sizeof(struct rcu_head);
> -	lsm_blob_size_update(&blobs->lbs_inode, &blob_sizes.lbs_inode);
> -	lsm_blob_size_update(&blobs->lbs_ipc, &blob_sizes.lbs_ipc);
> -	lsm_blob_size_update(&blobs->lbs_key, &blob_sizes.lbs_key);
> -	lsm_blob_size_update(&blobs->lbs_msg_msg, &blob_sizes.lbs_msg_msg);
> -	lsm_blob_size_update(&blobs->lbs_perf_event,
> -			     &blob_sizes.lbs_perf_event);
> -	lsm_blob_size_update(&blobs->lbs_sock, &blob_sizes.lbs_sock);
> -	lsm_blob_size_update(&blobs->lbs_superblock,
> -			     &blob_sizes.lbs_superblock);
> -	lsm_blob_size_update(&blobs->lbs_task, &blob_sizes.lbs_task);
> -	lsm_blob_size_update(&blobs->lbs_tun_dev, &blob_sizes.lbs_tun_dev);
> -	lsm_blob_size_update(&blobs->lbs_xattr_count,
> -			     &blob_sizes.lbs_xattr_count);
> -	lsm_blob_size_update(&blobs->lbs_bdev, &blob_sizes.lbs_bdev);
> -	lsm_blob_size_update(&blobs->lbs_bpf_map, &blob_sizes.lbs_bpf_map);
> -	lsm_blob_size_update(&blobs->lbs_bpf_prog, &blob_sizes.lbs_bpf_prog);
> -	lsm_blob_size_update(&blobs->lbs_bpf_token, &blob_sizes.lbs_bpf_token);
> +
> +	/* Register the LSM blob sizes. */
> +#define UPDATE_LSM_BLOB_SIZE(name) \
> +	lsm_blob_size_update(&blobs->lbs_##name, &blob_sizes.lbs_##name);
> +	LSM_BLOBS_LIST(UPDATE_LSM_BLOB_SIZE);
> +#undef UPDATE_LSM_BLOB_SIZE
>  }

This is one case where the macro approach *might* have some value, but as
it is the one instance, and multiple sequential blob operations like this
are going to be *very* limited, I'm not sure there is enough value to
be worth the change.

I appreciate the initiative to search out areas that you think could use
improvement, but for the reasons mentioned, I'm not going to merge this
patch.

> @@ -441,25 +425,10 @@ int __init security_init(void)
>  		lsm_prepare(*lsm);
>  
>  	if (lsm_debug) {
> -		lsm_pr("blob(cred) size %d\n", blob_sizes.lbs_cred);
> -		lsm_pr("blob(file) size %d\n", blob_sizes.lbs_file);
> -		lsm_pr("blob(backing_file) size %d\n",
> -		       blob_sizes.lbs_backing_file);
> -		lsm_pr("blob(ib) size %d\n", blob_sizes.lbs_ib);
> -		lsm_pr("blob(inode) size %d\n", blob_sizes.lbs_inode);
> -		lsm_pr("blob(ipc) size %d\n", blob_sizes.lbs_ipc);
> -		lsm_pr("blob(key) size %d\n", blob_sizes.lbs_key);
> -		lsm_pr("blob(msg_msg)_size %d\n", blob_sizes.lbs_msg_msg);
> -		lsm_pr("blob(sock) size %d\n", blob_sizes.lbs_sock);
> -		lsm_pr("blob(superblock) size %d\n", blob_sizes.lbs_superblock);
> -		lsm_pr("blob(perf_event) size %d\n", blob_sizes.lbs_perf_event);
> -		lsm_pr("blob(task) size %d\n", blob_sizes.lbs_task);
> -		lsm_pr("blob(tun_dev) size %d\n", blob_sizes.lbs_tun_dev);
> -		lsm_pr("blob(xattr) count %d\n", blob_sizes.lbs_xattr_count);
> -		lsm_pr("blob(bdev) size %d\n", blob_sizes.lbs_bdev);
> -		lsm_pr("blob(bpf_map) size %d\n", blob_sizes.lbs_bpf_map);
> -		lsm_pr("blob(bpf_prog) size %d\n", blob_sizes.lbs_bpf_prog);
> -		lsm_pr("blob(bpf_token) size %d\n", blob_sizes.lbs_bpf_token);
> +#define PRINT_LSM_BLOB_SIZE(name) \
> +	lsm_pr("blob(" #name ") size %d\n", blob_sizes.lbs_##name);
> +		LSM_BLOBS_LIST(PRINT_LSM_BLOB_SIZE);
> +#undef PRINT_LSM_BLOB_SIZE

This is another case where having the text string grep'able can be a good
thing.

--
paul-moore.com
