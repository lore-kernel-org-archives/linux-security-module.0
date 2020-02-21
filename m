Return-Path: <SRS0=8B0L=4J=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A5E9C35647
	for <linux-security-module@archiver.kernel.org>; Fri, 21 Feb 2020 12:02:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ECBA222C4
	for <linux-security-module@archiver.kernel.org>; Fri, 21 Feb 2020 12:02:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UKFOzCl6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbgBUMCy (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 21 Feb 2020 07:02:54 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46817 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726976AbgBUMCy (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 21 Feb 2020 07:02:54 -0500
Received: by mail-wr1-f65.google.com with SMTP id z7so1718786wrl.13
        for <linux-security-module@vger.kernel.org>; Fri, 21 Feb 2020 04:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XEMXcf1Qym5KZXe7M87kC8LbHamJQ0UMLSMngcLuhOU=;
        b=UKFOzCl6q4/cR/NsAjylHV5Gebfb6qxNZdL5rw1XT2ToRS3Q+BmEAaQt3KQowks3FV
         O2f4DMGkYVUc9KYLH3UeegG+7DhMaBXhBb8dvjuLIFosDhSaBHSmk3y0GcXVyKS00HDn
         CB3v4G6PN2dB9kj8W5qmjzuUQudPYm7QpNcUs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XEMXcf1Qym5KZXe7M87kC8LbHamJQ0UMLSMngcLuhOU=;
        b=aWAquhZMZ0NxC06sWD0QQ6Ogu3FGOztqTw2jtFRLbW8qBDIIIU8E8x3QvHDGPdcqAn
         o8jzJg/S8euxqNwHKruJHCIkAqdlEJtSaQOaivHNbNN374VNbnVMHMdjPEEDD02hv2yv
         yI/FQ48oTlzG2rQv3zN68jyvhTFlqsZJrN7QRIY9n6QPzP1vdmvvjicywu+LH81Zm/i7
         0NUcEhRag6OTRrOFNkkDEBuo3J4FkaAIwY2K4BCOyvT6ZNr7B3rbbU/n1U5cDCE8KcMP
         wT1kOg/9Qo8zp1GVYd+f5lBH4p7c3iCfHvK1UxJxWCvshyAKWLsGvtYqjoz9PMoAXwSj
         b7nw==
X-Gm-Message-State: APjAAAVuuajfVqjoNK4fROVnRFg6tYgIxIvIas4V38Jv2rVD73iOjMg5
        976NjEFlm7pv6RHWA1JDsemikQ==
X-Google-Smtp-Source: APXvYqzsuM0rMnESdMtK5OBkUXp1jDKWa+okCPaVGYbgB20R7139xAB9Mq1tDbbjbEUGQCmxgxSxBQ==
X-Received: by 2002:a5d:61cb:: with SMTP id q11mr50890228wrv.71.1582286562277;
        Fri, 21 Feb 2020 04:02:42 -0800 (PST)
Received: from google.com ([2a00:79e0:42:204:8a21:ba0c:bb42:75ec])
        by smtp.gmail.com with ESMTPSA id x21sm3322107wmi.30.2020.02.21.04.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 04:02:41 -0800 (PST)
Date:   Fri, 21 Feb 2020 13:02:40 +0100
From:   KP Singh <kpsingh@chromium.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     KP Singh <kpsingh@chromium.org>,
        open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH bpf-next v4 5/8] bpf: lsm: Implement attach, detach and
 execution
Message-ID: <CACYkzJ6E7FDE0xnnZPCmxgC+vEw1o4qcu9szV1DMeDeukbnFxQ@mail.gmail.com>
References: <20200220175250.10795-1-kpsingh@chromium.org>
 <20200220175250.10795-6-kpsingh@chromium.org>
 <20200221021755.3z7ifyyeh6seo3zs@ast-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221021755.3z7ifyyeh6seo3zs@ast-mbp>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 20-Feb 18:17, Alexei Starovoitov wrote:
> On Thu, Feb 20, 2020 at 06:52:47PM +0100, KP Singh wrote:
> > +
> > +   /* This is the first program to be attached to the LSM hook, the hook
> > +    * needs to be enabled.
> > +    */
> > +   if (prog->type == BPF_PROG_TYPE_LSM && tr->progs_cnt[kind] == 1)
> > +           err = bpf_lsm_set_enabled(prog->aux->attach_func_name, true);
> >  out:
> >     mutex_unlock(&tr->mutex);
> >     return err;
> > @@ -336,7 +348,11 @@ int bpf_trampoline_unlink_prog(struct bpf_prog *prog)
> >     }
> >     hlist_del(&prog->aux->tramp_hlist);
> >     tr->progs_cnt[kind]--;
> > -   err = bpf_trampoline_update(prog->aux->trampoline);
> > +   err = bpf_trampoline_update(prog);
> > +
> > +   /* There are no more LSM programs, the hook should be disabled */
> > +   if (prog->type == BPF_PROG_TYPE_LSM && tr->progs_cnt[kind] == 0)
> > +           err = bpf_lsm_set_enabled(prog->aux->attach_func_name, false);
>
> Overall looks good, but I don't think above logic works.
> Consider lsm being attached, then fexit, then lsm detached, then fexit detached.
> Both are kind==fexit and static_key stays enabled.

You're right. I was weary of introducing a new kind (something like
BPF_TRAMP_LSM) since they are just fexit trampolines. For now, I
added nr_lsm_progs as a member in struct bpf_trampoline and refactored
the increment and decrement logic into inline helper functions e.g.

static inline void bpf_trampoline_dec_progs(struct bpf_prog *prog,
                                            enum bpf_tramp_prog_type kind)
{
        struct bpf_trampoline *tr = prog->aux->trampoline;

        if (prog->type == BPF_PROG_TYPE_LSM)
                tr->nr_lsm_progs--;

        tr->progs_cnt[kind]--;
}

and doing the check as:

  if (prog->type == BPF_PROG_TYPE_LSM && tr->nr_lsm_progs == 0)
        err = bpf_lsm_set_enabled(prog->aux->attach_func_name, false);

This should work, If you're okay with it, I will update it in the next
revision of the patch-set.

- KP
