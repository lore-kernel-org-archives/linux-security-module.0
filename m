Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B975EB64D7
	for <linux-security-module@archiver.kernel.org>; Tue, 13 Jun 2023 21:43:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232063AbjFMVna (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 13 Jun 2023 17:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjFMVn2 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 13 Jun 2023 17:43:28 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFCA7DE
        for <linux-security-module@vger.kernel.org>; Tue, 13 Jun 2023 14:43:26 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-56d1cb6a607so377597b3.2
        for <linux-security-module@vger.kernel.org>; Tue, 13 Jun 2023 14:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1686692606; x=1689284606;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HIVGrn2UG3gN2eNILh7fTseSDqg8knsp5sSLFqLEHtc=;
        b=K82SWrC47y9svWfAJiRRS8RkXj5CtpYx2+cpvsF8vlQJOJBv9VTnZ/ZF406SGPZ/cQ
         PuKnDklPjxR7CmsSTOtn3AHyoXAGnmO/yy0LFY35Wb/B3eU/8Qys5akTlIzlzgwWVy7f
         LQ065Qd5k7eJtxGashEd4kJePL0vdixSMONX+InuGwDAe+n8dheiF7DLw+Nj9ydyMTrw
         3hjMGnZr4qSfAoCERrgD36BGE654El3yt5+Md/NncaJLvnpXvcoWAxZ3pC7HjnPP43ta
         043I7yLomJuEy6DomEryzFx3yuLAH4Wop1Gi3yGa4187w96gbNywecR8xGewSdy6Bi3S
         +y8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686692606; x=1689284606;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HIVGrn2UG3gN2eNILh7fTseSDqg8knsp5sSLFqLEHtc=;
        b=QFJhiDYS9AX2ScAbCJa7XfUek9wBUhSs8qQIo5DWSwqdllM1aikFmnylPdUw3cY66T
         Cjpu8JYkOIxkJtTH2r7HfVuV+7XqHWOcq0whctZx+yOzptoGdp1SuGh8kAAJ2/6Ohdaw
         ReHo+Cdy7b3QFXzgRTsgykg47XW+UCUAJZLtOGuZcSm5D73fkdFl3GkhELffU0Zkin/R
         NjS1Bo3LjOxDm/qXGFERSZcEnFJwZa3FnkZ3XA/0EvsMiDtEx+UHv4wX34OwqvKY7QXG
         j2rpGXgRj6b2x2mrRmJb+ENN3QEQ3aX0CyE6f5VkRah3Rycmdiridqmly6eKUCHKFUju
         U8YA==
X-Gm-Message-State: AC+VfDxxnp59sOA/e8Ntu55uFs3/DJIKuooqGuaEMV/u66ZqXBxc71cP
        pmIYotzeMjg3nfgOmV7ZMSSbLUw7OQH9+5s6Xz4s
X-Google-Smtp-Source: ACHHUZ48EzshYzKiXjopsdVfpagGQ7YaGMsS2CpO7ZtH3eZvHC8m7Pi+Jaw59xQX7oHZqQPBowjQ8wJAabBg1EOOml0=
X-Received: by 2002:a25:add3:0:b0:ba5:ee5a:f41c with SMTP id
 d19-20020a25add3000000b00ba5ee5af41cmr380926ybe.1.1686692605945; Tue, 13 Jun
 2023 14:43:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230120000818.1324170-1-kpsingh@kernel.org> <20230120000818.1324170-4-kpsingh@kernel.org>
 <202301192004.777AEFFE@keescook> <CACYkzJ75nYnunhcAaE-20p9YHLzVynUEAA+uK1tmGeOWA83MjA@mail.gmail.com>
 <db1fed31-0283-5401-cf55-d18a98ca33ae@schaufler-ca.com> <CAPhsuW4C8NU15mjetX8Ucp3R66xEgOGS6udiaauUtPg06Si93Q@mail.gmail.com>
 <8b5f62f3-a2c4-9ba3-d1e4-af557047f44b@schaufler-ca.com> <CACYkzJ7=xPB-mzAq-GBszm2Q3NapVNbcrqBdSS0FZsTeTbL9QA@mail.gmail.com>
 <63e14c10.170a0220.beb2a.bc4c@mx.google.com> <CACYkzJ4LX6Acxs0s-d2+hC0Zfx2CTL7_JpeWD9pGz4b9_0J29g@mail.gmail.com>
In-Reply-To: <CACYkzJ4LX6Acxs0s-d2+hC0Zfx2CTL7_JpeWD9pGz4b9_0J29g@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 13 Jun 2023 17:43:15 -0400
Message-ID: <CAHC9VhTQ_x=MccVU9gtndy3tW-SOdXpQoOa1RTd0jr4_iO1xZQ@mail.gmail.com>
Subject: Re: [PATCH RESEND bpf-next 3/4] security: Replace indirect LSM hook
 calls with static calls
To:     KP Singh <kpsingh@kernel.org>
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

On Wed, Jun 7, 2023 at 10:48=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrote=
:
> On Mon, Feb 6, 2023 at 7:51=E2=80=AFPM Kees Cook <keescook@chromium.org> =
wrote:
> > On Mon, Feb 06, 2023 at 07:41:04PM +0100, KP Singh wrote:
> > > On Mon, Feb 6, 2023 at 7:29 PM Casey Schaufler <casey@schaufler-ca.co=
m> wrote:
> > > >
> > > > On 2/6/2023 9:48 AM, Song Liu wrote:
> > > > > On Mon, Feb 6, 2023 at 8:29 AM Casey Schaufler <casey@schaufler-c=
a.com> wrote:
> > > > >> On 2/6/2023 5:04 AM, KP Singh wrote:
> > > > >>> On Fri, Jan 20, 2023 at 5:36 AM Kees Cook <keescook@chromium.or=
g> wrote:
> > > > >>>> On Fri, Jan 20, 2023 at 01:08:17AM +0100, KP Singh wrote:
> > > > >>>>> The indirect calls are not really needed as one knows the add=
resses of
> > > > >>> [...]
> > > > >>>
> > > > >>>>> +/*
> > > > >>>>> + * Define static calls and static keys for each LSM hook.
> > > > >>>>> + */
> > > > >>>>> +
> > > > >>>>> +#define DEFINE_LSM_STATIC_CALL(NUM, NAME, RET, ...)         =
         \
> > > > >>>>> +     DEFINE_STATIC_CALL_NULL(LSM_STATIC_CALL(NAME, NUM),    =
         \
> > > > >>>>> +                             *((RET(*)(__VA_ARGS__))NULL)); =
         \
> > > > >>>>> +     DEFINE_STATIC_KEY_FALSE(SECURITY_HOOK_ENABLED_KEY(NAME,=
 NUM));
> > > > >>>> Hm, another place where we would benefit from having separated=
 logic for
> > > > >>>> "is it built?" and "is it enabled by default?" and we could us=
e
> > > > >>>> DEFINE_STATIC_KEY_MAYBE(). But, since we don't, I think we nee=
d to use
> > > > >>>> DEFINE_STATIC_KEY_TRUE() here or else won't all the calls be
> > > > >>>> out-of-line? (i.e. the default compiled state will be NOPs?) I=
f we're
> > > > >>>> trying to optimize for having LSMs, I think we should default =
to inline
> > > > >>>> calls. (The machine code in the commit log seems to indicate t=
hat they
> > > > >>>> are out of line -- it uses jumps.)
> > > > >>>>
> > > > >>> I should have added it in the commit description, actually we a=
re
> > > > >>> optimizing for "hot paths are less likely to have LSM hooks ena=
bled"
> > > > >>> (eg. socket_sendmsg).
> > > > >> How did you come to that conclusion? Where is there a correlatio=
n between
> > > > >> "hot path" and "less likely to be enabled"?
> > > > > I could echo KP's reasoning here. AFAICT, the correlation is that=
 LSMs on
> > > > > hot path will give more performance overhead. In our use cases (M=
eta),
> > > > > we are very careful with "small" performance hits. 0.25% is signi=
ficant
> > > > > overhead; 1% overhead will not fly without very good reasons (Do =
we
> > > > > have to do this? Are there any other alternatives?). If it is pos=
sible to
> > > > > achieve similar security on a different hook, we will not enable =
the hook on
> > > > > the hot path. For example, we may not enable socket_sendmsg, but =
try
> > > > > to disallow opening such sockets instead.
> > > >
> > > > I'm not asking about BPF. I'm asking about the impact on other LSMs=
.
> > > > If you're talking strictly about BPF you need to say that. I'm all =
for
> > > > performance improvement. But as I've said before, it should be for =
all
> > > > the security modules, not just BPF.
> > >
> > > It's a trade off that will work differently for different LSMs and
> > > distros (based on the LSM they chose) and this the config option. I
> > > even suggested this be behind CONFIG_EXPERT (which is basically says
> > > this:
> > >
> > >  "This option allows certain base kernel options and settings
> > >  to be disabled or tweaked. This is for specialized
> > >  environments which can tolerate a "non-standard" kernel.
> > >  Only use this if you really know what you are doing."
> >
> > Using the DEFINE_STATIC_KEY_MAYBE() and static_branch_maybe() macros
> > tied to a new CONFIG seems like it can give us a reasonable knob for
> > in-line vs out-of-line calls.
>
> Coming back to this after a while as I finally got time to work on
> this. (work/personal downtime).
>
> I am changing it to DEFINE_STATIC_KEY_TRUE in this patch and
> DEFINE_STATIC_KEY_MAYBE in a subsequent one and guarded by a config
> called CONFIG_SECURITY_HOOK_LIKELY. I am letting it default to yes,
> but distros can change it depending on their choice of LSM and
> performance characteristics.

I'm still more curious about the correctness/isolation aspect that I
mused about back in Jan/Feb on your original posting.

--=20
paul-moore.com
