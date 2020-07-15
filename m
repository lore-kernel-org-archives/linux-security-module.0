Return-Path: <SRS0=JoCX=A2=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2088FC433E1
	for <linux-security-module@archiver.kernel.org>; Wed, 15 Jul 2020 22:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDA4E20656
	for <linux-security-module@archiver.kernel.org>; Wed, 15 Jul 2020 22:59:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UyVYVGZ3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbgGOW7P (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 15 Jul 2020 18:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726776AbgGOW7P (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 15 Jul 2020 18:59:15 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC6CBC08C5CE
        for <linux-security-module@vger.kernel.org>; Wed, 15 Jul 2020 15:59:14 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id p20so4126477ejd.13
        for <linux-security-module@vger.kernel.org>; Wed, 15 Jul 2020 15:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fZ1rBakSReO9Dn+EzmBi7QlVUTw5S5sAIhY6NkDcqpg=;
        b=UyVYVGZ3tCLbe+5CH0LQ890sq2xoQmOnnE5A7hlJaGCoxZtFB624re+THIl7BI+lvO
         eyyMilV41zbb2R7HS+QQp0qUghMOIUFFpGhvCz6uhonYxEZ2Lupsz+v2JGuO2SUposUC
         wjZ0s+y5RtIISKMhBqUi/DW+mBLIJ4qpPEQ28=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fZ1rBakSReO9Dn+EzmBi7QlVUTw5S5sAIhY6NkDcqpg=;
        b=ROXfN+RIlW11ykI4NhSZzNfZfEjqnEryg9/GDc5gKvnukMXzyIq/B1l1w8mE4gdI0b
         ZsD1sH8uHAa9OWxRnrg6LGx1iSyaz0egfZD6fHr4VILDemB3UicRyQlHQuT4miWKuCje
         xUIk2adRzaN0LMSMvhSl85WMM5O56O5GJo4u485u7+2EOXdKKxikqYOWPuivETe1LdPN
         86KxWyR7+zf+9oQCyekfqNM8XD6kcIlzk8zlkFZyW/0rCpmYzvacIA34tRgPVThEni2f
         mrz8vWLw8me6iA/YocNgDik+7+H7topjaLsiYV5luvcq9LSLbnUaaCYog58ZR/chc210
         MQDA==
X-Gm-Message-State: AOAM532iVfmDRw4G9kGLhIcj46L/xKVPKN38QvCiOY7IQrQSN2yEvr1E
        gR11tejo/mrTDl/kfaVK7DUOvg==
X-Google-Smtp-Source: ABdhPJwtiT8rbD9B7KAQceCDxM9R1q9fPYU/TGYjl/rb8FPg4sH1QIcjoK1TO2tKm/WTJsefqNGf6A==
X-Received: by 2002:a17:907:2149:: with SMTP id rk9mr1079014ejb.553.1594853953417;
        Wed, 15 Jul 2020 15:59:13 -0700 (PDT)
Received: from google.com ([81.6.44.51])
        by smtp.gmail.com with ESMTPSA id hb8sm3307531ejb.8.2020.07.15.15.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 15:59:12 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Thu, 16 Jul 2020 00:59:11 +0200
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     KP Singh <kpsingh@chromium.org>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>
Subject: Re: [PATCH bpf-next v4 2/4] bpf: Implement bpf_local_storage for
 inodes
Message-ID: <20200715225911.GA1194150@google.com>
References: <20200709101239.3829793-1-kpsingh@chromium.org>
 <20200709101239.3829793-3-kpsingh@chromium.org>
 <20200715215751.6llgungzff66iwxh@kafai-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200715215751.6llgungzff66iwxh@kafai-mbp>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 15-Jul 14:57, Martin KaFai Lau wrote:
> On Thu, Jul 09, 2020 at 12:12:37PM +0200, KP Singh wrote:
> > From: KP Singh <kpsingh@google.com>
> > 
> > Similar to bpf_local_storage for sockets, add local storage for inodes.
> > The life-cycle of storage is managed with the life-cycle of the inode.
> > i.e. the storage is destroyed along with the owning inode.
> > 
> > The BPF LSM allocates an __rcu pointer to the bpf_local_storage in the
> > security blob which are now stackable and can co-exist with other LSMs.
> > 
> > Signed-off-by: KP Singh <kpsingh@google.com>
> 
> [ ... ]
> 
> 
> > +static void *bpf_inode_storage_lookup_elem(struct bpf_map *map, void *key)
> > +{
> > +	struct bpf_local_storage_data *sdata;
> > +	struct inode *inode;
> > +	int err = -EINVAL;
> > +
> > +	if (key) {
> > +		inode = *(struct inode **)(key);
> The bpf_inode_storage_lookup_elem() here and the (update|delete)_elem() below
> are called from the userspace syscall.  How the userspace may provide this key?

I realized this when I replied about the _fd_ name in the sk helpers.
I am going to mark them as unsupported for now for inodes.

We could, probably and separately, use a combination of the device
and inode number as a key from userspace.

- KP

> 
> > +		sdata = inode_storage_lookup(inode, map, true);
> > +		return sdata ? sdata->data : NULL;
> > +	}
> > +
> > +	return ERR_PTR(err);
> > +}
> > +
> > +static int bpf_inode_storage_update_elem(struct bpf_map *map, void *key,
> > +					 void *value, u64 map_flags)
> > +{
> > +	struct bpf_local_storage_data *sdata;
> > +	struct inode *inode;
> > +	int err = -EINVAL;
> > +
> > +	if (key) {
> > +		inode = *(struct inode **)(key);
> > +		sdata = map->ops->map_local_storage_update(inode, map, value,
> > +							   map_flags);
> > +		return PTR_ERR_OR_ZERO(sdata);
> > +	}
> > +	return err;
> > +}
> > +
> > +static int inode_storage_delete(struct inode *inode, struct bpf_map *map)
> > +{
> > +	struct bpf_local_storage_data *sdata;
> > +
> > +	sdata = inode_storage_lookup(inode, map, false);
> > +	if (!sdata)
> > +		return -ENOENT;
> > +
> > +	bpf_selem_unlink_map_elem(SELEM(sdata));
> > +
> > +	return 0;
> > +}
> > +
> > +static int bpf_inode_storage_delete_elem(struct bpf_map *map, void *key)
> > +{
> > +	struct inode *inode;
> > +	int err = -EINVAL;
> > +
> > +	if (key) {
> > +		inode = *(struct inode **)(key);
> > +		err = inode_storage_delete(inode, map);
> > +	}
> > +
> > +	return err;
> > +}
> > +
> 
> [ ... ]
> 
> > +static int inode_storage_map_btf_id;
> > +const struct bpf_map_ops inode_storage_map_ops = {
> > +	.map_alloc_check = bpf_local_storage_map_alloc_check,
> > +	.map_alloc = inode_storage_map_alloc,
> > +	.map_free = inode_storage_map_free,
> > +	.map_get_next_key = notsupp_get_next_key,
> > +	.map_lookup_elem = bpf_inode_storage_lookup_elem,
> > +	.map_update_elem = bpf_inode_storage_update_elem,
> > +	.map_delete_elem = bpf_inode_storage_delete_elem,
> > +	.map_check_btf = bpf_local_storage_map_check_btf,
> > +	.map_btf_name = "bpf_local_storage_map",
> > +	.map_btf_id = &inode_storage_map_btf_id,
> > +	.map_local_storage_alloc = inode_storage_alloc,
> > +	.map_selem_alloc = inode_selem_alloc,
> > +	.map_local_storage_update = inode_storage_update,
> > +	.map_local_storage_unlink = unlink_inode_storage,
> > +};
> > +
