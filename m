Return-Path: <SRS0=wJOd=3N=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40DBDC35242
	for <linux-security-module@archiver.kernel.org>; Fri, 24 Jan 2020 14:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 117E520838
	for <linux-security-module@archiver.kernel.org>; Fri, 24 Jan 2020 14:12:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iJ2fU2hU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389118AbgAXOML (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 24 Jan 2020 09:12:11 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40837 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387414AbgAXOML (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 24 Jan 2020 09:12:11 -0500
Received: by mail-pf1-f195.google.com with SMTP id q8so1164704pfh.7
        for <linux-security-module@vger.kernel.org>; Fri, 24 Jan 2020 06:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Iz5cHqMUZemh4vAyieC4PCm90mjuvS7GOLpZDZYwVvE=;
        b=iJ2fU2hUfwnRDmxd/eXMmRa2aMXc0i2MJXp7+HH9Tf0DRiVk3U9TSlE4p6wTcXeGQv
         50oTElkkEj0ajwNnarMd9pDPixfviwyCRyGnKD0QN/RriohADXzI+qbpNolRcH/dRy8y
         MlxvbyHbViJJeVlVsAJt7in3W1+a52g6VGY3Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Iz5cHqMUZemh4vAyieC4PCm90mjuvS7GOLpZDZYwVvE=;
        b=JjFeidNfWXeJ56iAk+Lu79wuxMndjzvzPgztXdoT074vzMEuHnSI1nUCKEk3QFJ+qG
         cf6c+ImpfY6zV8ct4dVkRMISUiBsi06ATUD1ltw0CaCALOvtq4z6XFqK8IKgNIyLyQDj
         GihK0zE8AzDZhxNkZaRI2WsdVbgd/RTBZVKWYBEG1LmUu/tQBILKtZre5hGKAKxmwQ1a
         4/kSmptiCAWtZgENT+Q3Rt9vWOtqyBUBEVTiOt4J8TeMu/8gnfaAxxDQi84nsjq/1HRq
         oUMaB8AG10G87IPvPt8nxSBUC7edCeTBzgMGyT09YVevcCGZJpb6/ZPa4E+mtkOqjnoD
         R8CA==
X-Gm-Message-State: APjAAAUUpQHLC8zpe9RoUicdPSm/vJJo73Vqx0VVaJF3fl12f3uZFdiA
        eGfel3OCbaQ9hmUPehil9WZdrQ==
X-Google-Smtp-Source: APXvYqyEY68xNjBYfjXdbh+1/z6XOSVIUgDGnsumwmzifqvXVisLTjDtm3Q6i/HD+sE7qbfNuJmhVg==
X-Received: by 2002:a63:cb06:: with SMTP id p6mr4355321pgg.236.1579875130290;
        Fri, 24 Jan 2020 06:12:10 -0800 (PST)
Received: from chromium.org ([2601:647:4903:8020:88e3:d812:557:e2e5])
        by smtp.gmail.com with ESMTPSA id u20sm6599646pgf.29.2020.01.24.06.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 06:12:09 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Fri, 24 Jan 2020 06:12:03 -0800
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, linux-security-module@vger.kernel.org,
        Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Thomas Garnier <thgarnie@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Garnier <thgarnie@chromium.org>,
        Michael Halcrow <mhalcrow@google.com>,
        Paul Turner <pjt@google.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Jann Horn <jannh@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Christian Brauner <christian@brauner.io>,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Stanislav Fomichev <sdf@google.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Andrey Ignatov <rdna@fb.com>, Joe Stringer <joe@wand.net.nz>
Subject: Re: [PATCH bpf-next v3 01/10] bpf: btf: Add btf_type_by_name_kind
Message-ID: <20200124141203.GA21334@chromium.org>
References: <20200123152440.28956-1-kpsingh@chromium.org>
 <20200123152440.28956-2-kpsingh@chromium.org>
 <CAEf4BzbBAM1+E3j6pBaLjBwnvOVKV=oWrnANONEm8SCoGj=ZbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzbBAM1+E3j6pBaLjBwnvOVKV=oWrnANONEm8SCoGj=ZbQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 23-Jan 12:06, Andrii Nakryiko wrote:
> On Thu, Jan 23, 2020 at 7:25 AM KP Singh <kpsingh@chromium.org> wrote:
> >
> > From: KP Singh <kpsingh@google.com>
> >
> > - The LSM code does the combination of btf_find_by_name_kind and
> >   btf_type_by_id a couple of times to figure out the BTF type for
> >   security_hook_heads and security_list_options.
> > - Add an extern for btf_vmlinux in btf.h
> >
> > Signed-off-by: KP Singh <kpsingh@google.com>
> > Reviewed-by: Brendan Jackman <jackmanb@google.com>
> > Reviewed-by: Florent Revest <revest@google.com>
> > Reviewed-by: Thomas Garnier <thgarnie@google.com>
> > ---
> >  include/linux/btf.h |  3 +++
> >  kernel/bpf/btf.c    | 12 ++++++++++++
> >  2 files changed, 15 insertions(+)
> >
> > diff --git a/include/linux/btf.h b/include/linux/btf.h
> > index 5c1ea99b480f..d4e859f90a39 100644
> > --- a/include/linux/btf.h
> > +++ b/include/linux/btf.h
> > @@ -15,6 +15,7 @@ struct btf_type;
> >  union bpf_attr;
> >
> >  extern const struct file_operations btf_fops;
> > +extern struct btf *btf_vmlinux;
> >
> >  void btf_put(struct btf *btf);
> >  int btf_new_fd(const union bpf_attr *attr);
> > @@ -66,6 +67,8 @@ const struct btf_type *
> >  btf_resolve_size(const struct btf *btf, const struct btf_type *type,
> >                  u32 *type_size, const struct btf_type **elem_type,
> >                  u32 *total_nelems);
> > +const struct btf_type *btf_type_by_name_kind(
> > +       struct btf *btf, const char *name, u8 kind);
> >
> >  #define for_each_member(i, struct_type, member)                        \
> >         for (i = 0, member = btf_type_member(struct_type);      \
> > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > index 32963b6d5a9c..ea53c16802cb 100644
> > --- a/kernel/bpf/btf.c
> > +++ b/kernel/bpf/btf.c
> > @@ -441,6 +441,18 @@ const struct btf_type *btf_type_resolve_func_ptr(const struct btf *btf,
> >         return NULL;
> >  }
> >
> > +const struct btf_type *btf_type_by_name_kind(
> > +       struct btf *btf, const char *name, u8 kind)
> > +{
> > +       s32 type_id;
> > +
> > +       type_id = btf_find_by_name_kind(btf, name, kind);
> > +       if (type_id < 0)
> > +               return ERR_PTR(type_id);
> > +
> > +       return btf_type_by_id(btf, type_id);
> > +}
> > +
> 
> is it worth having this as a separate global function? If
> btf_find_by_name_kind returns valid ID, then you don't really need to
> check btf_type_by_id result, it is always going to be valid. So the
> pattern becomes:

Yeah you're right. We went from using this a few times in separate
functions to 2 times in the same function (based on the changes in
v2 -> v3)

I will drop this from the next revision.

 
> type_id = btf_find_by_name_kind(btf, name, kind);
> if (type_id < 0)
>   goto handle_error;
> t = btf_type_by_id(btf, type_id);
> /* now just use t */
> 
> which is not much more verbose than:
> 
> t = btf_type_by_name_kind(btf, name, kind);
> if (IS_ERR(t))
>   goto handle_error
> /* now use t */
> 

Agreed.

- KP

> 
> >  /* Types that act only as a source, not sink or intermediate
> >   * type when resolving.
> >   */
> > --
> > 2.20.1
> >
