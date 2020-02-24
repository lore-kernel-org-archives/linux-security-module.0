Return-Path: <SRS0=CMy/=4M=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14CD3C11D2F
	for <linux-security-module@archiver.kernel.org>; Mon, 24 Feb 2020 17:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF58720732
	for <linux-security-module@archiver.kernel.org>; Mon, 24 Feb 2020 17:23:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="g+oJppTD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbgBXRXU (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 24 Feb 2020 12:23:20 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34681 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728382AbgBXRXM (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 24 Feb 2020 12:23:12 -0500
Received: by mail-wr1-f65.google.com with SMTP id z15so3013864wrl.1
        for <linux-security-module@vger.kernel.org>; Mon, 24 Feb 2020 09:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Z7r4FCCdgK//1AJV7o7c7T7DxWEhsHdVIX0fUYjE4Ts=;
        b=g+oJppTDpv5kQixddVJjhu7C9YgdQArMSg5hmvMNu3Y69lt1nSnlv6e4GUhHjgzmhc
         kpyDv0phuVbr2tlC8zCjmDiCR1McS75gOj4mhVZnXt6t/GONUhBWF2zamYaURL31rXtE
         7lQy0TnmmSKA733p9DxpdQcfGDWL0NZ7BMpRU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z7r4FCCdgK//1AJV7o7c7T7DxWEhsHdVIX0fUYjE4Ts=;
        b=Ex7lQb9KcSeGLIcGzJs/UEvgy6XWAigHXV9d7pJsVBTVVw2PU6QWt7d3zaFEUdkCzI
         WmImWkaEwGFrC7bvg5oEjgoUzUFe5p5Xo/hPPfxcONjs054fGvOCn4mtPIp0TORZCcLZ
         MxGXeg9bOedpra4BcbjHo4RDFHFiGThYjZDMY6EV6J7tCogi1GyXtQ452TvrtZ6ZyUpJ
         DllKar4DszIEGwyYEf49M2v+GYVdsLtF7uooA1BfPSiezw39MYVneguO0BZ5HhU1v37+
         q6Jxn76SBEz+1RKmEaoCQVUaLc1LqyZYv0kZl3dij6vTYhVUUj1DdGW1AzEFeeVtXHdY
         Xi0Q==
X-Gm-Message-State: APjAAAUvCgcdEto4mXuF0i8eloTgBQD7Wxq8hmc06cBMg4f67atg+KTt
        N1wRI8Z2UxMTo4RHE7SRaaXxXA==
X-Google-Smtp-Source: APXvYqw/rLv+BSiAvCyHeUmMe9yYodWuPz2r3aFrU2+asq1tfmpvCuhAPRCp6EaiEEqrhW9IeqWgdQ==
X-Received: by 2002:a5d:5706:: with SMTP id a6mr67768995wrv.108.1582564990967;
        Mon, 24 Feb 2020 09:23:10 -0800 (PST)
Received: from chromium.org ([2620:0:105f:fd00:d960:542a:a1d:648a])
        by smtp.gmail.com with ESMTPSA id j15sm20087903wrp.9.2020.02.24.09.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 09:23:10 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Mon, 24 Feb 2020 18:23:09 +0100
To:     Kees Cook <keescook@chromium.org>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        James Morris <jmorris@namei.org>
Subject: Re: [PATCH bpf-next v4 3/8] bpf: lsm: provide attachment points for
 BPF LSM programs
Message-ID: <20200224172309.GB21886@chromium.org>
References: <20200220175250.10795-1-kpsingh@chromium.org>
 <20200220175250.10795-4-kpsingh@chromium.org>
 <0ef26943-9619-3736-4452-fec536a8d169@schaufler-ca.com>
 <202002211946.A23A987@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202002211946.A23A987@keescook>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi Kees,

Thanks for the feedback!

On 21-Feb 20:22, Kees Cook wrote:
> On Thu, Feb 20, 2020 at 03:49:05PM -0800, Casey Schaufler wrote:
> > On 2/20/2020 9:52 AM, KP Singh wrote:
> > > From: KP Singh <kpsingh@google.com>
> > 
> > Sorry about the heavy list pruning - the original set
> > blows thunderbird up.
> 
> (I've added some people back; I had to dig this thread back out of lkml
> since I didn't get a direct copy...)
> 
> > > The BPF LSM programs are implemented as fexit trampolines to avoid the
> > > overhead of retpolines. These programs cannot be attached to security_*
> > > wrappers as there are quite a few security_* functions that do more than
> > > just calling the LSM callbacks.
> > >
> > > This was discussed on the lists in:
> > >
> > >   https://lore.kernel.org/bpf/20200123152440.28956-1-kpsingh@chromium.org/T/#m068becce588a0cdf01913f368a97aea4c62d8266
> > >
> > > Adding a NOP callback after all the static LSM callbacks are called has
> > > the following benefits:
> > >
> > > - The BPF programs run at the right stage of the security_* wrappers.
> > > - They run after all the static LSM hooks allowed the operation,
> > >   therefore cannot allow an action that was already denied.
> > 
> > I still say that the special call-out to BPF is unnecessary.
> > I remain unconvinced by the arguments. You aren't doing anything
> > so special that the general mechanism won't work.
> 
> If I'm understanding this correctly, there are two issues:
> 
> 1- BPF needs to be run last due to fexit trampolines (?)
> 
> 2- BPF hooks don't know what may be attached at any given time, so
>    ALL LSM hooks need to be universally hooked. THIS turns out to create
>    a measurable performance problem in that the cost of the indirect call
>    on the (mostly/usually) empty BPF policy is too high.
> 
> "1" can be solved a lot of ways, and doesn't seem to be a debated part
> of this series.
> 
> "2" is interesting -- it creates a performance problem for EVERYONE that
> builds in this kernel feature, regardless of them using it. Excepting
> SELinux, "traditional" LSMs tends to be relatively sparse in their hooking:
> 
> $ grep '^      struct hlist_head' include/linux/lsm_hooks.h | wc -l
> 230
> $ for i in apparmor loadpin lockdown safesetid selinux smack tomoyo yama ; \
>   do echo -n "$i " && (cd $i && git grep LSM_HOOK_INIT | wc -l) ; done
> apparmor   68
> loadpin     3
> lockdown    1
> safesetid   2
> selinux   202
> smack     108
> tomoyo     28
> yama        4
> 
> So, trying to avoid the indirect calls is, as you say, an optimization,
> but it might be a needed one due to the other limitations.
> 
> To me, some questions present themselves:
> 
> a) What, exactly, are the performance characteristics of:
> 	"before"
> 	"with indirect calls"
> 	"with static keys optimization"

Good suggestion!

I will do some analysis and come back with the numbers.

> 
> b) Would there actually be a global benefit to using the static keys
>    optimization for other LSMs? (Especially given that they're already
>    sparsely populated and policy likely determines utility -- all the
>    LSMs would just turn ON all their static keys or turn off ALL their
>    static keys depending on having policy loaded.)

As Alexei mentioned, we can use the patches for static calls after
they are merged:

https://lore.kernel.org/lkml/8bc857824f82462a296a8a3c4913a11a7f801e74.1547073843.git.jpoimboe@redhat.com/

to make the framework better (as a separate series) especially given
that we are unsure how they work with BPF.

- KP

> 
> If static keys are justified for KRSI (by "a") then it seems the approach
> here should stand. If "b" is also true, then we need an additional
> series to apply this optimization for the other LSMs (but that seems
> distinctly separate from THIS series).
> 
> -- 
> Kees Cook
