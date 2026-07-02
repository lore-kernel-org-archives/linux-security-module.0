Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246F6230BD5
	for <linux-security-module@vger.kernel.org>; Thu,  2 Jul 2026 20:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783023497; cv=none; b=oINSmXYxbAJeoVlG2nG13hK1X5QzViTZKHoaEL9JzL5K0bwvUk4HZvGPIlbOWyWVHCHhBs0agCUPFEok6MrL8OAusXppFzz8HgCrJ3rvz4PiIFDLoZ6iD8n9lH/NcU7ghoq8sDu/RFz3xlQ9g6m7PmUodCjBd0844NNEnrHvNU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783023497; c=relaxed/simple;
	bh=I/fvXYm5XOSJ/GVZGhbAbu7iDjmwi6bAEq6HiEWbQLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SDXFIT4Q/Ad+hOkvIA4Zq4Rb81ly5cKPvzeKrfxdwngB2/ko2xYTnKX0rDpV0L6Dal/5CyFo/tzdoI65xhgm4Q472Rkaq9tI3J8PVjNrOowuMrb9S9Ad7fGM/VKiW3ATJVFSec8T2p9KzrYNKvHHNGa61DY8t9Pkmb7Sqak6jNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EHZ4N+be; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EHZ4N+be"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-69532288224so723857a12.0
        for <linux-security-module@vger.kernel.org>; Thu, 02 Jul 2026 13:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783023494; x=1783628294; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WamW8Irg4pI/BPqOEKa65MGR6QCtaABgzWRVjCS5/5s=;
        b=EHZ4N+bebvzCL1jUswXbEf1FXMOGwSDDIN4pq/6Y6F7z69lwz5pF13ThsI89VeowZq
         /w8KDWbGfsE/3HTjH9uD9MZvidO3G/J8UZmz5/6w8kYli7d6IRrm/M4dnfOETTanz49/
         SmQT6/4VCD50AZ7zkW7r95Nzjiw/FLieH4O0mGI+NmQhg4QP/4xrpeYXJrDDJ42UEkfl
         N82u31EpQnintMBja0gra5BI7LcnXBAufH7OjPuAMS5bcCg+dWJSnIaOrriCFJm0rV9S
         K4KQ8TvRNcsODEA7fFxVxL0YQ06ddOy5GeBE2bnNPiwpcCGFoNRIEfx2XuYdy6TAaewc
         d8tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783023494; x=1783628294;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WamW8Irg4pI/BPqOEKa65MGR6QCtaABgzWRVjCS5/5s=;
        b=r6gNGrINp+zQCwU2ohZbILCUWPV0ZgFYA4gUpwZhFOPt3pNPOIAsGBXwOPDuGMPt38
         ToVGnnx8A4WzMyYeTK+serzxX3ZYxSbJWMZ4KvLHvVIeqPUfOqHsKEsfKAIbG6xjdmBG
         UDDejltxKNQQ6q4hUIXIEq6j4l7cjo59K5QtYj7tEaBh2QdBH2jFNCQsweckQyYIx4z5
         x+ZhNQ68eOLcyQiBEBAk3dWE81pgXCnGKB9QRB1zRloREJYVjMweXB5Ep4/j//fLD2Q5
         Z9SnPpTImmmYBaJ17hx1sFW1UtmP6BrSKL/D6dyUA7MM5CyN4ON+pIxDww86/tIj73cB
         ecpQ==
X-Gm-Message-State: AOJu0Ywt9+HdqYgkpGmbgq/dgs4wTpOe01sgWR85jViyFWHX+CdAHer1
	9TnKrpb8idIWOvkaOV6F546+lHfIWd1NMBZDim/oaW51schhHT83NhrdVk9vXh8JegRIdqpXLVk
	wPeASMw==
X-Gm-Gg: AfdE7cmtSIGzE8XewMOHR30gY0U5k66yWykdVh1eh4NU+p+ZO4MtYU8YNmIbUD1shK1
	JRcrfYO+gSy+rqJNYPpWgDuxt1qxbZFkC38RnXRCTItPfy4PnTb62x6KWAkFHjlu5lXl0V0LTxL
	u91OqA0C44TPxykxNgSBgBa+M4wT/lJF3pDdPrXxuybxjjFtjf16mJ/8gmHPBzwYngrhmPvziJI
	pNOWmx0bTorqvpZLH+JsJxJb58OxlFWXALyeKwoaGbQbL7Jwq8NTU5w0wF+SJCMj9FnAmprN69s
	x52LJA8VkLf81oiK7JsgfEOTCV14HGcvzLyLiimO+6DsaC68t4Zwn3cnRp/OkllX+CGeEbzw1MH
	DZmYIjeVA1AGrP9t6DZdMxwnDfb8LtZVF0fajZnIUTub5U8qhtKZIgLnrUbDhhuqdrWs/XkyB75
	91Y2lrLrN1HZnpsR+dx53XDwO/S0XWWWJVlC189vvRkJfPd5+YWKu73aLFpQ==
X-Received: by 2002:a05:6402:13d2:b0:698:e595:a54 with SMTP id 4fb4d7f45d1cf-698e595205emr127636a12.25.1783023493784;
        Thu, 02 Jul 2026 13:18:13 -0700 (PDT)
Received: from google.com (136.183.91.34.bc.googleusercontent.com. [34.91.183.136])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-698ad11892asm1434226a12.20.2026.07.02.13.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 13:18:12 -0700 (PDT)
Date: Thu, 2 Jul 2026 20:18:08 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org, James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>
Subject: Re: [PATCH] lsm: cleanup repeated lsm_blob_size_update() calls in
 lsm_prepare()
Message-ID: <akbHgKxaNmRQEfqs@google.com>
References: <20260629210150.832576-1-mattbobrowski@google.com>
 <dde355196558210f6ca87c1a0745a3a8@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dde355196558210f6ca87c1a0745a3a8@paul-moore.com>

On Thu, Jul 02, 2026 at 03:15:02PM -0400, Paul Moore wrote:
> On Jun 29, 2026 Matt Bobrowski <mattbobrowski@google.com> wrote:
> > 
> > Centralize the definition of LSM security blob fields using an X-macro
> > (LSM_BLOBS_LIST). This reduces repetitive boilerplate code across
> > struct lsm_blob_sizes, blob size registration in lsm_prepare(), and
> > debug log printing in security_init().
> > 
> > Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
> > ---
> >  include/linux/lsm_hooks.h | 42 ++++++++++++++++------------
> >  security/lsm_init.c       | 59 ++++++++++-----------------------------
> >  2 files changed, 38 insertions(+), 63 deletions(-)
> > 
> > diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> > index b4f8cad53ddb..0e73b22bdeea 100644
> > --- a/include/linux/lsm_hooks.h
> > +++ b/include/linux/lsm_hooks.h
> > @@ -98,28 +98,34 @@ struct security_hook_list {
> >  	const struct lsm_id *lsmid;
> >  } __randomize_layout;
> >  
> > +#define LSM_BLOBS_LIST(X) \
> > +	X(cred)          \
> > +	X(file)          \
> > +	X(backing_file)  \
> > +	X(ib)            \
> > +	X(inode)         \
> > +	X(sock)          \
> > +	X(superblock)    \
> > +	X(ipc)           \
> > +	X(key)           \
> > +	X(msg_msg)       \
> > +	X(perf_event)    \
> > +	X(task)          \
> > +	X(tun_dev)       \
> > +	X(xattr_count)   \
> > +	X(bdev)          \
> > +	X(bpf_map)       \
> > +	X(bpf_prog)      \
> > +	X(bpf_token)
> > +
> >  /*
> >   * Security blob size or offset data.
> > + * Note: lbs_xattr_count is the number of xattr slots in new_xattrs array.
> >   */
> >  struct lsm_blob_sizes {
> > -	unsigned int lbs_cred;
> > -	unsigned int lbs_file;
> > -	unsigned int lbs_backing_file;
> > -	unsigned int lbs_ib;
> > -	unsigned int lbs_inode;
> > -	unsigned int lbs_sock;
> > -	unsigned int lbs_superblock;
> > -	unsigned int lbs_ipc;
> > -	unsigned int lbs_key;
> > -	unsigned int lbs_msg_msg;
> > -	unsigned int lbs_perf_event;
> > -	unsigned int lbs_task;
> > -	unsigned int lbs_xattr_count; /* num xattr slots in new_xattrs array */
> > -	unsigned int lbs_tun_dev;
> > -	unsigned int lbs_bdev;
> > -	unsigned int lbs_bpf_map;
> > -	unsigned int lbs_bpf_prog;
> > -	unsigned int lbs_bpf_token;
> > +#define LSM_BLOB_SIZE(name) unsigned int lbs_##name;
> > +	LSM_BLOBS_LIST(LSM_BLOB_SIZE);
> > +#undef LSM_BLOB_SIZE
> >  };
> 
> Generally speaking I greatly prefer to see the structure fields typed out
> as it makes it easier to find them using grep, code indexers, etc.  There
> is a similar argument for the security_init() changes (below).
> 
> > diff --git a/security/lsm_init.c b/security/lsm_init.c
> > index 7c0fd17f1601..c256f1c33efa 100644
> > --- a/security/lsm_init.c
> > +++ b/security/lsm_init.c
> > @@ -282,40 +282,24 @@ static void __init lsm_blob_size_update(unsigned int *sz_req,
> >   * lsm_prepare - Prepare the LSM framework for a new LSM
> >   * @lsm: LSM definition
> >   */
> > -static void __init lsm_prepare(struct lsm_info *lsm)
> > +static void __init lsm_prepare(const struct lsm_info *lsm)
> >  {
> >  	struct lsm_blob_sizes *blobs = lsm->blobs;
> >  
> >  	if (!blobs)
> >  		return;
> >  
> > -	/* Register the LSM blob sizes. */
> > -	blobs = lsm->blobs;
> > -	lsm_blob_size_update(&blobs->lbs_cred, &blob_sizes.lbs_cred);
> > -	lsm_blob_size_update(&blobs->lbs_file, &blob_sizes.lbs_file);
> > -	lsm_blob_size_update(&blobs->lbs_backing_file,
> > -			     &blob_sizes.lbs_backing_file);
> > -	lsm_blob_size_update(&blobs->lbs_ib, &blob_sizes.lbs_ib);
> > -	/* inode blob gets an rcu_head in addition to LSM blobs. */
> > +	/* The inode blob (inode->i_security) gets an rcu_head in addition to
> > +	 * LSM blobs.
> > +	 */
> >  	if (blobs->lbs_inode && blob_sizes.lbs_inode == 0)
> >  		blob_sizes.lbs_inode = sizeof(struct rcu_head);
> > -	lsm_blob_size_update(&blobs->lbs_inode, &blob_sizes.lbs_inode);
> > -	lsm_blob_size_update(&blobs->lbs_ipc, &blob_sizes.lbs_ipc);
> > -	lsm_blob_size_update(&blobs->lbs_key, &blob_sizes.lbs_key);
> > -	lsm_blob_size_update(&blobs->lbs_msg_msg, &blob_sizes.lbs_msg_msg);
> > -	lsm_blob_size_update(&blobs->lbs_perf_event,
> > -			     &blob_sizes.lbs_perf_event);
> > -	lsm_blob_size_update(&blobs->lbs_sock, &blob_sizes.lbs_sock);
> > -	lsm_blob_size_update(&blobs->lbs_superblock,
> > -			     &blob_sizes.lbs_superblock);
> > -	lsm_blob_size_update(&blobs->lbs_task, &blob_sizes.lbs_task);
> > -	lsm_blob_size_update(&blobs->lbs_tun_dev, &blob_sizes.lbs_tun_dev);
> > -	lsm_blob_size_update(&blobs->lbs_xattr_count,
> > -			     &blob_sizes.lbs_xattr_count);
> > -	lsm_blob_size_update(&blobs->lbs_bdev, &blob_sizes.lbs_bdev);
> > -	lsm_blob_size_update(&blobs->lbs_bpf_map, &blob_sizes.lbs_bpf_map);
> > -	lsm_blob_size_update(&blobs->lbs_bpf_prog, &blob_sizes.lbs_bpf_prog);
> > -	lsm_blob_size_update(&blobs->lbs_bpf_token, &blob_sizes.lbs_bpf_token);
> > +
> > +	/* Register the LSM blob sizes. */
> > +#define UPDATE_LSM_BLOB_SIZE(name) \
> > +	lsm_blob_size_update(&blobs->lbs_##name, &blob_sizes.lbs_##name);
> > +	LSM_BLOBS_LIST(UPDATE_LSM_BLOB_SIZE);
> > +#undef UPDATE_LSM_BLOB_SIZE
> >  }
> 
> This is one case where the macro approach *might* have some value, but as
> it is the one instance, and multiple sequential blob operations like this
> are going to be *very* limited, I'm not sure there is enough value to
> be worth the change.
> 
> I appreciate the initiative to search out areas that you think could use
> improvement, but for the reasons mentioned, I'm not going to merge this
> patch.

That's not a problem. Perhaps you may want to consider only taking the
minor cleanup targets the redundant lsm->blobs access within
lsm_prepare().

> > @@ -441,25 +425,10 @@ int __init security_init(void)
> >  		lsm_prepare(*lsm);
> >  
> >  	if (lsm_debug) {
> > -		lsm_pr("blob(cred) size %d\n", blob_sizes.lbs_cred);
> > -		lsm_pr("blob(file) size %d\n", blob_sizes.lbs_file);
> > -		lsm_pr("blob(backing_file) size %d\n",
> > -		       blob_sizes.lbs_backing_file);
> > -		lsm_pr("blob(ib) size %d\n", blob_sizes.lbs_ib);
> > -		lsm_pr("blob(inode) size %d\n", blob_sizes.lbs_inode);
> > -		lsm_pr("blob(ipc) size %d\n", blob_sizes.lbs_ipc);
> > -		lsm_pr("blob(key) size %d\n", blob_sizes.lbs_key);
> > -		lsm_pr("blob(msg_msg)_size %d\n", blob_sizes.lbs_msg_msg);
> > -		lsm_pr("blob(sock) size %d\n", blob_sizes.lbs_sock);
> > -		lsm_pr("blob(superblock) size %d\n", blob_sizes.lbs_superblock);
> > -		lsm_pr("blob(perf_event) size %d\n", blob_sizes.lbs_perf_event);
> > -		lsm_pr("blob(task) size %d\n", blob_sizes.lbs_task);
> > -		lsm_pr("blob(tun_dev) size %d\n", blob_sizes.lbs_tun_dev);
> > -		lsm_pr("blob(xattr) count %d\n", blob_sizes.lbs_xattr_count);
> > -		lsm_pr("blob(bdev) size %d\n", blob_sizes.lbs_bdev);
> > -		lsm_pr("blob(bpf_map) size %d\n", blob_sizes.lbs_bpf_map);
> > -		lsm_pr("blob(bpf_prog) size %d\n", blob_sizes.lbs_bpf_prog);
> > -		lsm_pr("blob(bpf_token) size %d\n", blob_sizes.lbs_bpf_token);
> > +#define PRINT_LSM_BLOB_SIZE(name) \
> > +	lsm_pr("blob(" #name ") size %d\n", blob_sizes.lbs_##name);
> > +		LSM_BLOBS_LIST(PRINT_LSM_BLOB_SIZE);
> > +#undef PRINT_LSM_BLOB_SIZE
> 
> This is another case where having the text string grep'able can be a good
> thing.
> 
> --
> paul-moore.com
