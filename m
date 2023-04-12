Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E308BC77B6F
	for <linux-security-module@archiver.kernel.org>; Wed, 12 Apr 2023 18:06:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjDLSGj (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 12 Apr 2023 14:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjDLSGg (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 12 Apr 2023 14:06:36 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED6A4170F
        for <linux-security-module@vger.kernel.org>; Wed, 12 Apr 2023 11:06:34 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-54f6a796bd0so119627097b3.12
        for <linux-security-module@vger.kernel.org>; Wed, 12 Apr 2023 11:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1681322794; x=1683914794;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zOpur0z+ZUUUDWNeIp4MQxAonJUSL+1bv5gFocfKWCI=;
        b=PxWnHbD6Ws3W1Gz8QcTv7ijtBMErQWuPurVBvwdlR5YTLZt4Dto7gJJxu/QUEnKriw
         1EnSZWBdOpDL84FhNN0xUmkqwZ2dFJ+qj3Vn5Eo4BZKHkBowACbYxK2pUBjc485b3hrw
         7YC/CDhINtaaFrGNNh9Xrer/a/55WhJyhbv0OrB7DbF310MO6Hgf6oVycO1gAWptPJ+E
         UZijXb7vV/SsFY5bzTRiaag2TmqrhaujlGAC22kaCcDvOZe2kp/FABUVcXxDarh9CFCw
         Ci8l//6nR9RCYDbcubv9Xjh7dQw0M/Scz95Yf24mOIflPBZq4OKDFcUnWCZKy9+hckKY
         KX9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681322794; x=1683914794;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zOpur0z+ZUUUDWNeIp4MQxAonJUSL+1bv5gFocfKWCI=;
        b=Y6sbjxastpd0sY71o2Iu+Hl5yVz2RCk+OyNKQ0yxrWN+6qDMLMxAoc7jpYPTMWHRWQ
         QY4gogN7wWkhRsVrtrZdCYsLgLF+GKAxCgK4uwUS6r8mpBlmrtn819rQZyevA96Ufp0L
         C+sfU9mr8gp78uVne12gHpEUOJ1qtRYwyXH4TRjF1TcYAd0hyC0afqAfhDg5Uknvdby8
         O72ywpbk/tp4jjQeJUow40CzAV7rj7M9ue8YZ1lndiceF+d2Zv5u2KW/xBCUM4Wbe1pi
         gQ52VahDJ69IdKa7X8FA/19O8YYfh47HMORDPViWJpEECEgXiW2+how0xVmWbOSBfI/Y
         nxkA==
X-Gm-Message-State: AAQBX9ft6a17ff5hwLOTyUQhM8f9cej29kYhrJ58xxTTWy/P0+VGZ/cU
        y0C39Np3/+OIECehgRVsMBva6rqb1gdC8WenVWz74giGXe1zC4K6wQ==
X-Google-Smtp-Source: AKy350Ybwq+KRN5bFKlKsx/pmdDpoZPyi/qw9onZN+iQFEKvChuLI1f8Exzmju5lj8P+PDvCDwvwr+EWf6eCQju/dJU=
X-Received: by 2002:a81:a789:0:b0:54f:aa4b:100c with SMTP id
 e131-20020a81a789000000b0054faa4b100cmr1178701ywh.8.1681322794078; Wed, 12
 Apr 2023 11:06:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230412043300.360803-1-andrii@kernel.org> <CAHC9VhQHmdZYnR=+rX-3FcRh127mhJt=jAnototfTiuSoOTptg@mail.gmail.com>
 <6436eea2.170a0220.97ead.52a8@mx.google.com>
In-Reply-To: <6436eea2.170a0220.97ead.52a8@mx.google.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 12 Apr 2023 14:06:23 -0400
Message-ID: <CAHC9VhR6ebsxtjSG8-fm7e=HU+srmziVuO6MU+pMpeSBv4vN+A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/8] New BPF map and BTF security LSM hooks
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kpsingh@kernel.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Apr 12, 2023 at 1:47=E2=80=AFPM Kees Cook <keescook@chromium.org> w=
rote:
> On Wed, Apr 12, 2023 at 12:49:06PM -0400, Paul Moore wrote:
> > On Wed, Apr 12, 2023 at 12:33=E2=80=AFAM Andrii Nakryiko <andrii@kernel=
.org> wrote:
> > >
> > > Add new LSM hooks, bpf_map_create_security and bpf_btf_load_security,=
 which
> > > are meant to allow highly-granular LSM-based control over the usage o=
f BPF
> > > subsytem. Specifically, to control the creation of BPF maps and BTF d=
ata
> > > objects, which are fundamental building blocks of any modern BPF appl=
ication.
> > >
> > > These new hooks are able to override default kernel-side CAP_BPF-base=
d (and
> > > sometimes CAP_NET_ADMIN-based) permission checks. It is now possible =
to
> > > implement LSM policies that could granularly enforce more restriction=
s on
> > > a per-BPF map basis (beyond checking coarse CAP_BPF/CAP_NET_ADMIN
> > > capabilities), but also, importantly, allow to *bypass kernel-side
> > > enforcement* of CAP_BPF/CAP_NET_ADMIN checks for trusted applications=
 and use
> > > cases.
> >
> > One of the hallmarks of the LSM has always been that it is
> > non-authoritative: it cannot unilaterally grant access, it can only
> > restrict what would have been otherwise permitted on a traditional
> > Linux system.  Put another way, a LSM should not undermine the Linux
> > discretionary access controls, e.g. capabilities.
> >
> > If there is a problem with the eBPF capability-based access controls,
> > that problem needs to be addressed in how the core eBPF code
> > implements its capability checks, not by modifying the LSM mechanism
> > to bypass these checks.
>
> I think semantics matter here. I wouldn't view this as _bypassing_
> capability enforcement: it's just more fine-grained access control.
>
> For example, in many places we have things like:
>
>         if (!some_check(...) && !capable(...))
>                 return -EPERM;
>
> I would expect this is a similar logic. An operation can succeed if the
> access control requirement is met. The mismatch we have through-out the
> kernel is that capability checks aren't strictly done by LSM hooks. And
> this series conceptually, I think, doesn't violate that -- it's changing
> the logic of the capability checks, not the LSM (i.e. there no LSM hooks
> yet here).

Patch 04/08 creates a new LSM hook, security_bpf_map_create(), which
when it returns a positive value "bypasses kernel checks".  The patch
isn't based on either Linus' tree or the LSM tree, I'm guessing it is
based on a eBPF tree, so I can't say with 100% certainty that it is
bypassing a capability check, but the description claims that to be
the case.

Regardless of how you want to spin this, I'm not supportive of a LSM
hook which allows a LSM to bypass a capability check.  A LSM hook can
be used to provide additional access control restrictions beyond a
capability check, but a LSM hook should never be allowed to overrule
an access denial due to a capability check.

> The reason CAP_BPF was created was because there was nothing else that
> would be fine-grained enough at the time.

The LSM layer predates CAP_BPF, and one could make a very solid
argument that one of the reasons LSMs exist is to provide
supplementary controls due to capability-based access controls being a
poor fit for many modern use cases.

--
paul-moore.com
