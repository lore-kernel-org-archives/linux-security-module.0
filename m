Return-Path: <SRS0=Z1sm=7J=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43941C433E0
	for <linux-security-module@archiver.kernel.org>; Wed, 27 May 2020 17:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D8F720873
	for <linux-security-module@archiver.kernel.org>; Wed, 27 May 2020 17:09:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Qtq4RcWn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731170AbgE0RJS (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 27 May 2020 13:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731130AbgE0RJR (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 27 May 2020 13:09:17 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93DEFC03E97D
        for <linux-security-module@vger.kernel.org>; Wed, 27 May 2020 10:09:17 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id l10so2042878wrr.10
        for <linux-security-module@vger.kernel.org>; Wed, 27 May 2020 10:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N7BcF2YbmFlnYsgsgnhG+rP4MiM9BYbCfVaOcHA0CmE=;
        b=Qtq4RcWnFirDNuZdCyVBt5tPFqmhvzYSUFkVjQjHkQBc6IkA+WeniGp5LmnT8OVVfB
         UE9q1ImGpjLTJce6qJy6hzRVPiHuV5AmS4EJxRkfHzrKJ9QHTdXlw8wjGUt2+zXOLkZn
         Se1DyUC2fMvdHcPa6G5vi/3874MVikhkzprOA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N7BcF2YbmFlnYsgsgnhG+rP4MiM9BYbCfVaOcHA0CmE=;
        b=bQOhs06OyBBY5jLJAHGRGxz3u9PcrxBsq9VjnG2wtQ0iCIId89EIZnDrxhaL5FZfnX
         bngnWIn1dA1L/KlwFBeYBwfAHjvVEpncquwSGoNI92C7lxI78HPZUQgb+CGu/lxwOZ3S
         teQUkvjDJ0GbgW9cO7YsGmaCWkad/LUhc9jhJ4CSmf5Tf2ikYV2Zl5z8dk8EiJ+jtKiw
         AKOKTguRRi3QM8eA6y0bLHkap3v4EEz7UqgHC/6mBRhPzO4gFgGAgkbh1YxYgz0Msfl/
         yvgz6D8WQHPlKQwS+EXLQ2A9CqY6X1BPsyMtcPqrJURSgf2NT4PKbVLo8fPtiEYME4jz
         slKQ==
X-Gm-Message-State: AOAM532V+YW7uh1iDq6OQNJ0bapMSFZZn+j4etZCTZPUJvb+R/NTg1iu
        acCCRF1IZNXiCvnshns6bcgib7tU40xtVDaGHJuT2j+G
X-Google-Smtp-Source: ABdhPJzb9gs//rirYU8Ktj397bVqkAAUoWJzxzq0eYzi6ZVCA4steGmUtKbIrEXVz5r+7fo8CuNrI6m8cpFs8ONaSh0=
X-Received: by 2002:a5d:4e88:: with SMTP id e8mr14770779wru.188.1590599356306;
 Wed, 27 May 2020 10:09:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200526163336.63653-1-kpsingh@chromium.org> <20200526163336.63653-3-kpsingh@chromium.org>
 <20200527050823.GA31860@infradead.org> <20200527123840.GA12958@google.com> <f933521f-6370-c9ba-d662-703c1ebc7c03@schaufler-ca.com>
In-Reply-To: <f933521f-6370-c9ba-d662-703c1ebc7c03@schaufler-ca.com>
From:   KP Singh <kpsingh@chromium.org>
Date:   Wed, 27 May 2020 19:09:05 +0200
Message-ID: <CACYkzJ6f0=r4h9sNqnXp_uBnHu=b6oGQFFGOv7H65UMOjtNKaw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/4] bpf: Implement bpf_local_storage for inodes
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Martin KaFai Lau <kafai@fb.com>,
        Florent Revest <revest@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, May 27, 2020 at 6:41 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> On 5/27/2020 5:38 AM, KP Singh wrote:
> > On 26-May 22:08, Christoph Hellwig wrote:
> >> On Tue, May 26, 2020 at 06:33:34PM +0200, KP Singh wrote:
> >>> From: KP Singh <kpsingh@google.com>
> >>>
> >>> Similar to bpf_local_storage for sockets, add local storage for inodes.
> >>> The life-cycle of storage is managed with the life-cycle of the inode.
> >>> i.e. the storage is destroyed along with the owning inode.
> >>>
> >>> Since, the intention is to use this in LSM programs, the destruction is
> >>> done after security_inode_free in __destroy_inode.
> >> NAK onbloating the inode structure.  Please find an out of line way
> >> to store your information.
> > The other alternative is to use lbs_inode (security blobs) and we can
> > do this without adding fields to struct inode.
>
> This is the correct approach, and always has been. This isn't the
> first ( or second :( ) case where the correct behavior for an LSM
> has been pretty darn obvious, but you've taken a different approach
> for no apparent reason.
>
> > Here is a rough diff (only illustrative, won't apply cleanly) of the
> > changes needed to this patch:
> >
> >  https://gist.github.com/sinkap/1d213d17fb82a5e8ffdc3f320ec37d79
>
> To do just a little nit-picking, please use bpf_inode() instead of
> bpf_inode_storage(). This is in keeping with the convention used by
> the other security modules. Sticking with the existing convention
> makes it easier for people (and tools) that work with multiple
> security modules.
>
> > Once tracing has gets a whitelist based access to inode storage, I
> > guess it, too, can use bpf_local_storage for inodes
>
> Only within the BPF module. Your sentence above is slightly garbled,
> so I'm not really sure what you're saying, but if you're suggesting
> that tracing code outside of the BPF security module can use the
> BPF inode data, the answer is a resounding "no".

This is why I wanted to add a separate pointer in struct inode so that
we could share the implementation with tracing. bpf_local_storage
is managed (per-program+per-type of storage) with separate BPF maps.
So, it can be easily shared between two programs (and
program types) without them clobbering over each other.

I guess we can have separate pointers for tracing,
use the pointer in the security blob for the LSM and discuss this separately
if and when we use this for tracing and keep this series patches scoped to
BPF_PROG_TYPE_LSM.

- KP

>
> >  if CONFIG_BPF_LSM
> > is enabled. Does this sound reasonable to the BPF folks?
> >
> > - KP
> >
> >
>
