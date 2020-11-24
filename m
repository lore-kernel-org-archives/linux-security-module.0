Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6298C56201
	for <linux-security-module@archiver.kernel.org>; Tue, 24 Nov 2020 11:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EE232073C
	for <linux-security-module@archiver.kernel.org>; Tue, 24 Nov 2020 11:05:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="J7Yh5Gl8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732365AbgKXLFK (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 24 Nov 2020 06:05:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732330AbgKXLFJ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 24 Nov 2020 06:05:09 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70379C0617A6
        for <linux-security-module@vger.kernel.org>; Tue, 24 Nov 2020 03:05:09 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id u18so28255165lfd.9
        for <linux-security-module@vger.kernel.org>; Tue, 24 Nov 2020 03:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5TaUVzQhpURqvZLgSdjgXP5Y5E8KytlSxVtILGHQLAo=;
        b=J7Yh5Gl8VJbnnkSr3W+xvsWVk19oFqjxfIfH9nCy15iVRvUOsv8pmwTZxeCo10ESh4
         evtmHyd962VrS41Pb/McGhWkE+6TvXxQ9kW3hR0ik54yj+kGqNvycMHxRkSOPaFHL7Mm
         MuNVaNl3nuBxFF854StZ/6unFn+/EIefpvvDo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5TaUVzQhpURqvZLgSdjgXP5Y5E8KytlSxVtILGHQLAo=;
        b=OuZFLDotq0c1AbWd5gXbaUd1GCUs+FCTfihXmDW5jznHeaY4b1fkkOEne8GluhU90Z
         wWcHHe6dWYx8Ts4QjKdRyDZywKmSNxBLf+U7o2I4gTX5+7a1KAci4dZJIDFurQdeOLLI
         D/HNn7Z8xbVG5/3zDmvB+3jYjwqrX0Dzg3R9WsyKJgpV7+oJzB0XJ9Vf/vDV8xe5w3BL
         Sy/9RWzkLN7zcqOlBlfvZAXnPQo6COeuGZpa0/WybcCevRZhB0Vuk360TIL7FhnigUgr
         N9Z1SM+bGVtQnXwS4J/OQLDAhAYg1Mq9oRpCtgl/B79G7fruK+lA7oOWHFquEAjy9nsV
         PYeA==
X-Gm-Message-State: AOAM533Fp4Z4EItzwiPxirt6uUO6+lPX7EzzgBTCjTZr3/Q5qBvT4qkd
        oYAiGQ0E0Cdz3L6UwQ5QDAaticsdkuTq4/ClMACldg==
X-Google-Smtp-Source: ABdhPJwePVkBoLYvzdYmFFTTJ40fLmwarojjzR4z5mPSX5vuZd8vf2N8lchfHei1yAx1hdjsDBwh6ZyKreUqquutcwA=
X-Received: by 2002:ac2:5475:: with SMTP id e21mr1431414lfn.153.1606215907809;
 Tue, 24 Nov 2020 03:05:07 -0800 (PST)
MIME-Version: 1.0
References: <20201120131708.3237864-1-kpsingh@chromium.org>
 <20201120131708.3237864-2-kpsingh@chromium.org> <20201124040220.oyajc7wqn7gqgyib@ast-mbp>
In-Reply-To: <20201124040220.oyajc7wqn7gqgyib@ast-mbp>
From:   KP Singh <kpsingh@chromium.org>
Date:   Tue, 24 Nov 2020 12:04:57 +0100
Message-ID: <CACYkzJ4i9qCgBRm3_pt19Tty4eR0RTMOg66f-_Rb7N3mBvgU8w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/3] bpf: Add a BPF helper for getting the IMA
 hash of an inode
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     James Morris <jmorris@namei.org>,
        open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Mimi Zohar <zohar@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Nov 24, 2020 at 5:02 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Nov 20, 2020 at 01:17:07PM +0000, KP Singh wrote:
> > +
> > +static bool bpf_ima_inode_hash_allowed(const struct bpf_prog *prog)
> > +{
> > +     return bpf_lsm_is_sleepable_hook(prog->aux->attach_btf_id);
> > +}
> > +
> > +BTF_ID_LIST_SINGLE(bpf_ima_inode_hash_btf_ids, struct, inode)
> > +
> > +const static struct bpf_func_proto bpf_ima_inode_hash_proto = {
> > +     .func           = bpf_ima_inode_hash,
> > +     .gpl_only       = false,
> > +     .ret_type       = RET_INTEGER,
> > +     .arg1_type      = ARG_PTR_TO_BTF_ID,
> > +     .arg1_btf_id    = &bpf_ima_inode_hash_btf_ids[0],
> > +     .arg2_type      = ARG_PTR_TO_UNINIT_MEM,
> > +     .arg3_type      = ARG_CONST_SIZE_OR_ZERO,
> > +     .allowed        = bpf_ima_inode_hash_allowed,
> > +};
> > +
> >  static const struct bpf_func_proto *
> >  bpf_lsm_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
> >  {
> > @@ -97,6 +121,8 @@ bpf_lsm_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
> >               return &bpf_task_storage_delete_proto;
> >       case BPF_FUNC_bprm_opts_set:
> >               return &bpf_bprm_opts_set_proto;
> > +     case BPF_FUNC_ima_inode_hash:
> > +             return &bpf_ima_inode_hash_proto;
>
> That's not enough for correctness.
> Not only hook has to sleepable, but the program has to be sleepable too.
> The patch 3 should be causing all sort of kernel warnings
> for calling mutex from preempt disabled.
> There it calls bpf_ima_inode_hash() from SEC("lsm/file_mprotect") program.

I did actually mean to use SEC("lsm.s/bprm_committed_creds"), my bad.

> "lsm/" is non-sleepable. "lsm.s/" is.
> please enable CONFIG_DEBUG_ATOMIC_SLEEP=y in your config.

Oops, yes I did notice that during recent work on the test cases.

Since we need a stronger check than just warnings, I am doing
something similar to
what we do for bpf_copy_from_user i.e.

     return prog->aux->sleepable ? &bpf_ima_inode_hash_proto : NULL;
