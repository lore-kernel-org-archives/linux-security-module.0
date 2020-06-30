Return-Path: <SRS0=UBGi=AL=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1282CC433E1
	for <linux-security-module@archiver.kernel.org>; Tue, 30 Jun 2020 11:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E671F20702
	for <linux-security-module@archiver.kernel.org>; Tue, 30 Jun 2020 11:50:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="c/i+r8l1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733134AbgF3LuB (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 30 Jun 2020 07:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728419AbgF3LuA (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 30 Jun 2020 07:50:00 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F37DC061755
        for <linux-security-module@vger.kernel.org>; Tue, 30 Jun 2020 04:50:00 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id z15so8536897wrl.8
        for <linux-security-module@vger.kernel.org>; Tue, 30 Jun 2020 04:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Hm99DwMfRW6Yrn3tUagzkyRAZ9V3WiaXuRVl4bieKDk=;
        b=c/i+r8l16IvmJHjNCI6NSEnbnhhTryuHilmSuq9nRPKgVxnTS2uVAk6mFFhrjesy/N
         cD3AeBuT0MGPVc1Z4atrCHi4kpXXFvvY6taRE2W244YMvI5fxjwNF2u2+Ue4P6qNoNzX
         VQ9gDQ8v65t9lJ6EcyaufWQIC5CyMz3j0Mme0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Hm99DwMfRW6Yrn3tUagzkyRAZ9V3WiaXuRVl4bieKDk=;
        b=mNCQBUQufkMHK1duZqo6Gd1mEnAPPy6HHLXFMsvnaV2weAgWOiS9WJqCyzEnkRwt3I
         jyeK//uy02QuKDGyOIeqaKWOfWywI8UMReb35iC8Ze82sdR2p6PHj3pTL+lWV3hfVl+f
         tTOPh87qQfPvMsLS9b9ZRncLTGxAyLnyY3GvLyTc7t87RrsvZapca53xBUfLgVAGE+d4
         CgGlyCv0rhse24DIFqEjnXvGtKzdeuzVHklOXBBSSiB6fCCovIBiBJ+LfPjeFz3rv5vQ
         h0Wl2daep30F0q3cyM+Zp3IQfRuK5pf5k3sAxoVry9frjVKP3OHpdgUK1Pmz8FyspAje
         CUUw==
X-Gm-Message-State: AOAM532TOu77c8CXfyCFsx5hKIACRsyM2Sj0tCe3BpuZFREuelLTC5Wd
        xjg8M4Zrj5hVBO4joi1P66mvkw==
X-Google-Smtp-Source: ABdhPJzHOV39ukk2h81FYtYP2PJLbg+uZqHvfmTlT2Zf2OBkJDS4/55jtC5jQc2CYfF2o8W/1Gc1kQ==
X-Received: by 2002:adf:f9c8:: with SMTP id w8mr21133678wrr.354.1593517799060;
        Tue, 30 Jun 2020 04:49:59 -0700 (PDT)
Received: from google.com ([81.6.44.51])
        by smtp.gmail.com with ESMTPSA id c5sm3248089wmb.24.2020.06.30.04.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 04:49:58 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Tue, 30 Jun 2020 13:49:56 +0200
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     KP Singh <kpsingh@chromium.org>, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>
Subject: Re: [PATCH bpf-next v2 2/4] bpf: Implement bpf_local_storage for
 inodes
Message-ID: <20200630114956.GA421824@google.com>
References: <20200617202941.3034-1-kpsingh@chromium.org>
 <20200617202941.3034-3-kpsingh@chromium.org>
 <20200619065245.t755bkffk6zleoi2@kafai-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200619065245.t755bkffk6zleoi2@kafai-mbp.dhcp.thefacebook.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 18-Jun 23:52, Martin KaFai Lau wrote:
> On Wed, Jun 17, 2020 at 10:29:39PM +0200, KP Singh wrote:
> [ ... ]
> 
> > diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
> > index af74712af585..8efd7562e3de 100644
> > --- a/include/linux/bpf_lsm.h
> > +++ b/include/linux/bpf_lsm.h
> > @@ -17,9 +17,24 @@
> >  #include <linux/lsm_hook_defs.h>
> >  #undef LSM_HOOK
> >  
> > +struct bpf_storage_blob {
> > +	struct bpf_local_storage __rcu *storage;
> > +};
> > +
> > +extern struct lsm_blob_sizes bpf_lsm_blob_sizes;
> > +
> >  int bpf_lsm_verify_prog(struct bpf_verifier_log *vlog,
> >  			const struct bpf_prog *prog);
> >  
> > +static inline struct bpf_storage_blob *bpf_inode(
> > +	const struct inode *inode)
> > +{
> > +	if (unlikely(!inode->i_security))
> > +		return NULL;
> > +
> > +	return inode->i_security + bpf_lsm_blob_sizes.lbs_inode;
> > +}
> > +
> >  #else /* !CONFIG_BPF_LSM */
> >  
> >  static inline int bpf_lsm_verify_prog(struct bpf_verifier_log *vlog,
> > @@ -28,6 +43,12 @@ static inline int bpf_lsm_verify_prog(struct bpf_verifier_log *vlog,
> >  	return -EOPNOTSUPP;
> >  }
> >  
> > +static inline struct bpf_storage_blob *bpf_inode_storage(
> This does not seem to match the newly added "bpf_inode()"
> above for the "CONFIG_BPF_LSM" case.
> 
> A typo?  May be a good idea to test compiling with !CONFIG_BPF_LSM.

Sorry about that, yeah it was a last minute lazy rename. Will
compile test the series with !CONFIG_BPF_LSM and !CONFIG_NET. Thanks.

> 
> > +	const struct inode *inode)
> > +{
> > +	return NULL;
> > +}
> > +
> >  #endif /* CONFIG_BPF_LSM */
> >  
> >  #endif /* _LINUX_BPF_LSM_H */
> > diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
> > index a18ae82a298a..881e7954c956 100644
> > --- a/include/linux/bpf_types.h
> > +++ b/include/linux/bpf_types.h
> > @@ -101,6 +101,7 @@ BPF_MAP_TYPE(BPF_MAP_TYPE_HASH_OF_MAPS, htab_of_maps_map_ops)
> >  BPF_MAP_TYPE(BPF_MAP_TYPE_DEVMAP, dev_map_ops)
> >  BPF_MAP_TYPE(BPF_MAP_TYPE_DEVMAP_HASH, dev_map_hash_ops)
> >  BPF_MAP_TYPE(BPF_MAP_TYPE_SK_STORAGE, sk_storage_map_ops)
> > +BPF_MAP_TYPE(BPF_MAP_TYPE_INODE_STORAGE, inode_storage_map_ops)
> sk_storage is under CONFIG_NET.
> 
> inode_storage should be CONFIG_BPF_LSM?

Thanks, updated.

- KP

> 
> >  #if defined(CONFIG_BPF_STREAM_PARSER)
> >  BPF_MAP_TYPE(BPF_MAP_TYPE_SOCKMAP, sock_map_ops)
> >  BPF_MAP_TYPE(BPF_MAP_TYPE_SOCKHASH, sock_hash_ops)
