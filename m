Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F0F7EB64D8
	for <linux-security-module@archiver.kernel.org>; Tue, 13 Jun 2023 22:03:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbjFMWDt (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 13 Jun 2023 18:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjFMWDs (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 13 Jun 2023 18:03:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36643186
        for <linux-security-module@vger.kernel.org>; Tue, 13 Jun 2023 15:03:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF16763B65
        for <linux-security-module@vger.kernel.org>; Tue, 13 Jun 2023 22:03:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DDB0C433C0
        for <linux-security-module@vger.kernel.org>; Tue, 13 Jun 2023 22:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686693826;
        bh=QhWHe6RjDHIXgDuuEnw6oOyTQ7y16ZcGlZ/AzW5jN4Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=H7OEDjwsZ6m1p7O9TC8B1bETumJfQOZ4UIh9H/NHmNp1rNK++CxZGpqjFiM5MPgU1
         Tx0nEM7d2yv5ZcoJafeEGaLIS4NmB2vHvK4va5PG4iBVmOWlLk4SZJyB4iOdwlOG+Z
         SiQybZbAxE+ugGbs9V25mCU3B8tK3v5xQj3/w5AZkYYO6LhbrBxlOUfs+9KpqABqJR
         gFvvlycM5xA2DKnd0lrWULby84bfLIs16uX49dy9M2Dgqacf0bO+t8w8UJ+RyfMiHO
         O1PFAKx3e4XCW76OuAI6zS35KwHl6rWPnOKGAxanQQ5xw04qxxym/00pJgmZXM1Qg9
         dBCW40ef8CJvg==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2b1bb2fc9c6so299561fa.0
        for <linux-security-module@vger.kernel.org>; Tue, 13 Jun 2023 15:03:46 -0700 (PDT)
X-Gm-Message-State: AC+VfDzuPk/Ku0srOojrOJ16YWnk3jiTCY7hXS7h5Yzg3phGSftQgOhE
        yBS4H8tX5YWbXU75pZt8Bw/iaMsUXeU9kx/NUs6hOA==
X-Google-Smtp-Source: ACHHUZ512dqndaesD9Kur4QSc/scUm++8YR40xO8nAG3BnKAFDwIlvd0TCyOpPdDAaa+suZfFzMoI0teWg507xRKues=
X-Received: by 2002:a2e:b0fc:0:b0:2ac:78d5:fd60 with SMTP id
 h28-20020a2eb0fc000000b002ac78d5fd60mr5934064ljl.9.1686693824200; Tue, 13 Jun
 2023 15:03:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230120000818.1324170-1-kpsingh@kernel.org> <20230120000818.1324170-4-kpsingh@kernel.org>
 <202301192004.777AEFFE@keescook> <CACYkzJ75nYnunhcAaE-20p9YHLzVynUEAA+uK1tmGeOWA83MjA@mail.gmail.com>
 <db1fed31-0283-5401-cf55-d18a98ca33ae@schaufler-ca.com> <CAPhsuW4C8NU15mjetX8Ucp3R66xEgOGS6udiaauUtPg06Si93Q@mail.gmail.com>
 <8b5f62f3-a2c4-9ba3-d1e4-af557047f44b@schaufler-ca.com> <CACYkzJ7=xPB-mzAq-GBszm2Q3NapVNbcrqBdSS0FZsTeTbL9QA@mail.gmail.com>
 <63e14c10.170a0220.beb2a.bc4c@mx.google.com> <CACYkzJ4LX6Acxs0s-d2+hC0Zfx2CTL7_JpeWD9pGz4b9_0J29g@mail.gmail.com>
 <CAHC9VhTQ_x=MccVU9gtndy3tW-SOdXpQoOa1RTd0jr4_iO1xZQ@mail.gmail.com>
In-Reply-To: <CAHC9VhTQ_x=MccVU9gtndy3tW-SOdXpQoOa1RTd0jr4_iO1xZQ@mail.gmail.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Wed, 14 Jun 2023 00:03:33 +0200
X-Gmail-Original-Message-ID: <CACYkzJ7JhP1=nEqufCj=-VmC-ZMnAtSU9n+0Dm+2BLX1u0JFQQ@mail.gmail.com>
Message-ID: <CACYkzJ7JhP1=nEqufCj=-VmC-ZMnAtSU9n+0Dm+2BLX1u0JFQQ@mail.gmail.com>
Subject: Re: [PATCH RESEND bpf-next 3/4] security: Replace indirect LSM hook
 calls with static calls
To:     Paul Moore <paul@paul-moore.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Song Liu <song@kernel.org>,
        linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, jackmanb@google.com,
        renauld@google.com, revest@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Jun 13, 2023 at 11:43=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
>
> On Wed, Jun 7, 2023 at 10:48=E2=80=AFPM KP Singh <kpsingh@kernel.org> wro=
te:
> > On Mon, Feb 6, 2023 at 7:51=E2=80=AFPM Kees Cook <keescook@chromium.org=
> wrote:
> > > On Mon, Feb 06, 2023 at 07:41:04PM +0100, KP Singh wrote:
> > > > On Mon, Feb 6, 2023 at 7:29 PM Casey Schaufler <casey@schaufler-ca.=
com> wrote:
> > > > >
> > > > > On 2/6/2023 9:48 AM, Song Liu wrote:
> > > > > > On Mon, Feb 6, 2023 at 8:29 AM Casey Schaufler <casey@schaufler=
-ca.com> wrote:
> > > > > >> On 2/6/2023 5:04 AM, KP Singh wrote:
> > > > > >>> On Fri, Jan 20, 2023 at 5:36 AM Kees Cook <keescook@chromium.=
org> wrote:
> > > > > >>>> On Fri, Jan 20, 2023 at 01:08:17AM +0100, KP Singh wrote:
> > > > > >>>>> The indirect calls are not really needed as one knows the a=
ddresses of
> > > > > >>> [...]
> > > > > >>>
> > > > > >>>>> +/*
> > > > > >>>>> + * Define static calls and static keys for each LSM hook.
> > > > > >>>>> + */
> > > > > >>>>> +
> > > > > >>>>> +#define DEFINE_LSM_STATIC_CALL(NUM, NAME, RET, ...)       =
           \
> > > > > >>>>> +     DEFINE_STATIC_CALL_NULL(LSM_STATIC_CALL(NAME, NUM),  =
           \
> > > > > >>>>> +                             *((RET(*)(__VA_ARGS__))NULL))=
;          \
> > > > > >>>>> +     DEFINE_STATIC_KEY_FALSE(SECURITY_HOOK_ENABLED_KEY(NAM=
E, NUM));
> > > > > >>>> Hm, another place where we would benefit from having separat=
ed logic for
> > > > > >>>> "is it built?" and "is it enabled by default?" and we could =
use
> > > > > >>>> DEFINE_STATIC_KEY_MAYBE(). But, since we don't, I think we n=
eed to use
> > > > > >>>> DEFINE_STATIC_KEY_TRUE() here or else won't all the calls be
> > > > > >>>> out-of-line? (i.e. the default compiled state will be NOPs?)=
 If we're
> > > > > >>>> trying to optimize for having LSMs, I think we should defaul=
t to inline
> > > > > >>>> calls. (The machine code in the commit log seems to indicate=
 that they
> > > > > >>>> are out of line -- it uses jumps.)
> > > > > >>>>
> > > > > >>> I should have added it in the commit description, actually we=
 are
> > > > > >>> optimizing for "hot paths are less likely to have LSM hooks e=
nabled"
> > > > > >>> (eg. socket_sendmsg).
> > > > > >> How did you come to that conclusion? Where is there a correlat=
ion between
> > > > > >> "hot path" and "less likely to be enabled"?
> > > > > > I could echo KP's reasoning here. AFAICT, the correlation is th=
at LSMs on
> > > > > > hot path will give more performance overhead. In our use cases =
(Meta),
> > > > > > we are very careful with "small" performance hits. 0.25% is sig=
nificant
> > > > > > overhead; 1% overhead will not fly without very good reasons (D=
o we
> > > > > > have to do this? Are there any other alternatives?). If it is p=
ossible to
> > > > > > achieve similar security on a different hook, we will not enabl=
e the hook on
> > > > > > the hot path. For example, we may not enable socket_sendmsg, bu=
t try
> > > > > > to disallow opening such sockets instead.
> > > > >
> > > > > I'm not asking about BPF. I'm asking about the impact on other LS=
Ms.
> > > > > If you're talking strictly about BPF you need to say that. I'm al=
l for
> > > > > performance improvement. But as I've said before, it should be fo=
r all
> > > > > the security modules, not just BPF.
> > > >
> > > > It's a trade off that will work differently for different LSMs and
> > > > distros (based on the LSM they chose) and this the config option. I
> > > > even suggested this be behind CONFIG_EXPERT (which is basically say=
s
> > > > this:
> > > >
> > > >  "This option allows certain base kernel options and settings
> > > >  to be disabled or tweaked. This is for specialized
> > > >  environments which can tolerate a "non-standard" kernel.
> > > >  Only use this if you really know what you are doing."
> > >
> > > Using the DEFINE_STATIC_KEY_MAYBE() and static_branch_maybe() macros
> > > tied to a new CONFIG seems like it can give us a reasonable knob for
> > > in-line vs out-of-line calls.
> >
> > Coming back to this after a while as I finally got time to work on
> > this. (work/personal downtime).
> >
> > I am changing it to DEFINE_STATIC_KEY_TRUE in this patch and
> > DEFINE_STATIC_KEY_MAYBE in a subsequent one and guarded by a config
> > called CONFIG_SECURITY_HOOK_LIKELY. I am letting it default to yes,
> > but distros can change it depending on their choice of LSM and
> > performance characteristics.
>
> I'm still more curious about the correctness/isolation aspect that I
> mused about back in Jan/Feb on your original posting.

Thanks, I put some clarifications there. I will post a v2 soon (TM).
Although beware I have upcoming downtime due to a surgery next week.

>
> --
> paul-moore.com
