Return-Path: <SRS0=IE2G=4V=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A690FC3F2CE
	for <linux-security-module@archiver.kernel.org>; Wed,  4 Mar 2020 19:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EE7E2146E
	for <linux-security-module@archiver.kernel.org>; Wed,  4 Mar 2020 19:09:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="g1F21Jna"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgCDTJB (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 4 Mar 2020 14:09:01 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40757 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728278AbgCDTJA (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 4 Mar 2020 14:09:00 -0500
Received: by mail-wr1-f67.google.com with SMTP id r17so3837751wrj.7
        for <linux-security-module@vger.kernel.org>; Wed, 04 Mar 2020 11:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=3SS4fekyQGzGk+bEcZn0ToSHy9OyXafStxdmWHS/l5c=;
        b=g1F21JnaXgZ/b+fqRbHrmibZXuy6uq7quiVcj8o9bY3mtdTjKW3DwnytkGBBhsYcBz
         uurPUDZheKBecYlKZ3hwqF8Cb18i0zHW+C8J92SS+gHJqjOdtmI/z5qi78VIzgn5ovdf
         OctW/J68R2IVHrpLo6q3sEsBevRAWmSywJ3Vw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=3SS4fekyQGzGk+bEcZn0ToSHy9OyXafStxdmWHS/l5c=;
        b=E7vtgieGOz+JRvR29tm+zZJsjX+37QBZm2r1b0OssiMyMNiPTD2acPO9DYYpqLUy75
         Re1Y6MAxms4eVVRfJHwD5UnmdKsV1EC1mxgHOl9T5mKiOv2ws6G+8aCzYlFUoboH400L
         cvx+UO3ELt5bkoTJWJ3+M5A//nhayJbaLkYImdEW5u8OU0lpRl3ql6pkxljuQ20OTxaQ
         5XPpNVWpIdAo+SDDY7qBwJ89SE21MerbpfPCgE38qP+K4EnPnzaV2AFNfkg4Qp6R9wmU
         Mi0taNyII8imfbKh0r68LAvPIYKBevH6WSfICel1D2vDRExXovret/CWHiCsoPvFxb80
         Epwg==
X-Gm-Message-State: ANhLgQ3j6MlMDj6HsUOx9azmKySA1TaD9/Ct01byu/iB9xgDsnz8UfCH
        reObkwc8sE/XTKVqmeBXc3CZag==
X-Google-Smtp-Source: ADFU+vvQX/rymjiQTTfmrRp8pXMzu+YTmiwg5naE9OKjaOSx1gH5F4Y92Cp+WVSUK0MJ9+BB0OphxQ==
X-Received: by 2002:adf:b189:: with SMTP id q9mr4679569wra.169.1583348937825;
        Wed, 04 Mar 2020 11:08:57 -0800 (PST)
Received: from chromium.org (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id j14sm41257638wrn.32.2020.03.04.11.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 11:08:57 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Wed, 4 Mar 2020 20:08:55 +0100
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        linux-security-module@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Subject: Re: [PATCH bpf-next v3 1/7] bpf: Refactor trampoline update code
Message-ID: <20200304190855.GA31073@chromium.org>
References: <20200304154747.23506-1-kpsingh@chromium.org>
 <20200304154747.23506-2-kpsingh@chromium.org>
 <cb54c137-6d8e-b4e5-bd17-e0a05368c3eb@iogearbox.net>
 <20200304184441.GA25392@chromium.org>
 <CAEf4Bza4y_H+Avry=OdQ=j6Ey-niTYLafKUwicVeutmQ3X5g=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4Bza4y_H+Avry=OdQ=j6Ey-niTYLafKUwicVeutmQ3X5g=g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 04-Mär 10:47, Andrii Nakryiko wrote:
> On Wed, Mar 4, 2020 at 10:44 AM KP Singh <kpsingh@chromium.org> wrote:
> >
> > On 04-Mär 19:37, Daniel Borkmann wrote:
> > > On 3/4/20 4:47 PM, KP Singh wrote:
> > > > From: KP Singh <kpsingh@google.com>
> > > >
> > > > As we need to introduce a third type of attachment for trampolines, the
> > > > flattened signature of arch_prepare_bpf_trampoline gets even more
> > > > complicated.
> > > >
> > > > Refactor the prog and count argument to arch_prepare_bpf_trampoline to
> > > > use bpf_tramp_progs to simplify the addition and accounting for new
> > > > attachment types.
> > > >
> > > > Signed-off-by: KP Singh <kpsingh@google.com>
> > > > Acked-by: Andrii Nakryiko <andriin@fb.com>
> > >
> > > [...]
> > > > diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
> > > > index c498f0fffb40..9f7e0328a644 100644
> > > > --- a/kernel/bpf/bpf_struct_ops.c
> > > > +++ b/kernel/bpf/bpf_struct_ops.c
> > > > @@ -320,6 +320,7 @@ static int bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
> > > >     struct bpf_struct_ops_value *uvalue, *kvalue;
> > > >     const struct btf_member *member;
> > > >     const struct btf_type *t = st_ops->type;
> > > > +   struct bpf_tramp_progs *tprogs = NULL;
> > > >     void *udata, *kdata;
> > > >     int prog_fd, err = 0;
> > > >     void *image;
> > > > @@ -425,10 +426,18 @@ static int bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
> > > >                     goto reset_unlock;
> > > >             }
> > > > +           tprogs = kcalloc(BPF_TRAMP_MAX, sizeof(*tprogs), GFP_KERNEL);
> > > > +           if (!tprogs) {
> > > > +                   err = -ENOMEM;
> > > > +                   goto reset_unlock;
> > > > +           }
> > > > +
> > >
> > > Looking over the code again, I'm quite certain that here's a memleak
> > > since the kcalloc() is done in the for_each_member() loop in the ops
> > > update but then going out of scope and in the exit path we only kfree
> > > the last tprogs.
> >
> > You're right, nice catch. Fixing it.
> 
> There is probably no need to do many allocations as well, just one
> outside of the loop and reuse?

Yeah moved it out of the loop and before we grab the mutex, returning
an -ENOMEM directly.

Thanks for noticing this. Sending v4 now.

- KP

> 
> >
> > - KP
> >
> > >
> > > > +           tprogs[BPF_TRAMP_FENTRY].progs[0] = prog;
> > > > +           tprogs[BPF_TRAMP_FENTRY].nr_progs = 1;
> > > >             err = arch_prepare_bpf_trampoline(image,
> > > >                                               st_map->image + PAGE_SIZE,
> > > >                                               &st_ops->func_models[i], 0,
> > > > -                                             &prog, 1, NULL, 0, NULL);
> > > > +                                             tprogs, NULL);
> > > >             if (err < 0)
> > > >                     goto reset_unlock;
> > > > @@ -469,6 +478,7 @@ static int bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
> > > >     memset(uvalue, 0, map->value_size);
> > > >     memset(kvalue, 0, map->value_size);
> > > >   unlock:
> > > > +   kfree(tprogs);
> > > >     mutex_unlock(&st_map->lock);
> > > >     return err;
> > > >   }
