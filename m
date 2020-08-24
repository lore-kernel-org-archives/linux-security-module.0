Return-Path: <SRS0=szIC=CC=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71CC5C433DF
	for <linux-security-module@archiver.kernel.org>; Mon, 24 Aug 2020 15:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 417B22078D
	for <linux-security-module@archiver.kernel.org>; Mon, 24 Aug 2020 15:21:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N4ZRpOGM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgHXPVK (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 24 Aug 2020 11:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727930AbgHXPUk (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 24 Aug 2020 11:20:40 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 036CEC061574
        for <linux-security-module@vger.kernel.org>; Mon, 24 Aug 2020 08:20:35 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id s1so9024089iot.10
        for <linux-security-module@vger.kernel.org>; Mon, 24 Aug 2020 08:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zeC/aDefrZoTzvg9rlHaO0UB/IBG2UmhhL24I87SS1Q=;
        b=N4ZRpOGMnhvYWQQG+jl12Q/BjcjWCSKU+SK+vib9BkSRL3Ye0gtU0sNoUGF3h+Ofkk
         IBZQNkAkRvBj1MscZZFa117en/0+akhCSFECnMnHhx2t+yEr7Sefx0lfNOkbFzCTUkK4
         d++7WouZ1kiRD89Z0wLpzixt1bOxGd0zJ+f9lbWG15GIkAca9hNKH84lhf4d4NcOeoYs
         nyDa8Y9SdfxWnCiy9uUQc5+E8bCB+QbbWoAwW4WNsy+T/1iCpQBp561iU7goNJgJVfSu
         O+NfZQxM7JBCsO/DSisTTsqz/eRudBzJRwnY2VO2FR3SUPk3/hljVhEqXMxXRxkEk7ag
         FDlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zeC/aDefrZoTzvg9rlHaO0UB/IBG2UmhhL24I87SS1Q=;
        b=GsKutfIPlLdWxIQO+eqwVP1Zp9UHtb4DuHI+FRUhdTbbtZ+bB3H9XORstdOR5vlahb
         N02vtSBxeiJNPHI7g07oL8/xfknScxgkJUhe14ethhxJ4wpvPyfb6A1eUFrygPay4lSA
         afjE2ddCdVruMZlXX1CFPkg8wHuPBUb7cDG2HLxZUsGHzm/6ai2szAbNlCr3aNfDy8dV
         81i6Hx8xmQvmf1QyQ7mNkgTgjVK9/ZB2gpnxY7FqtEtXlT7a+iOkyzgMnTx/fX/zvaqg
         QrK2HavUtWTY5pzG6z2WbMfovm73ZdChtxROI3kjAh4NILN8JN38VAxchuKhTLurg/cS
         DH2Q==
X-Gm-Message-State: AOAM533d9/AJ3S4JwiOpBJ574GE/pckGrqF3LmGPyDUoxQbZ0w/H9rp8
        ekUMEA7MJaalR65oD6PhGkdQs6GL6ecVRLn+Gappqw==
X-Google-Smtp-Source: ABdhPJy278YluTofu0sFJZY5pDSWm9saNVVAkhdL8U6wgVtI+kCshwIZnENHnc8l0A9enr9br7vWZBlVC3FTR30WgL4=
X-Received: by 2002:a6b:9256:: with SMTP id u83mr5366174iod.194.1598282432748;
 Mon, 24 Aug 2020 08:20:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200820164753.3256899-1-jackmanb@chromium.org> <42fb4180-772c-5579-ef3e-b4003e2b784b@schaufler-ca.com>
In-Reply-To: <42fb4180-772c-5579-ef3e-b4003e2b784b@schaufler-ca.com>
From:   Brendan Jackman <jackmanb@google.com>
Date:   Mon, 24 Aug 2020 17:20:21 +0200
Message-ID: <CA+i-1C09YZ8aCr6p5NOA2e3Ji5TKwdET=qAy=M328NK--L=0RA@mail.gmail.com>
Subject: Re: [RFC] security: replace indirect calls with static calls
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Brendan Jackman <jackmanb@chromium.org>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Paul Renauld <renauld@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>, Paul Turner <pjt@google.com>,
        Jann Horn <jannh@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        rafael.j.wysocki@intel.com, Kees Cook <keescook@chromium.org>,
        thgarnie@chromium.org, KP Singh <kpsingh@google.com>,
        paul.renauld.epfl@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, 21 Aug 2020 at 00:46, Casey Schaufler <casey@schaufler-ca.com> wrot=
e:
>
> On 8/20/2020 9:47 AM, Brendan Jackman wrote:
[...]
> What does NOP really look like?

The NOP is the same as a regular function call but the CALL
instruction is replaced with a NOP instruction. The code that sets up
the call parameters is unchanged, and so is the code that expects to
get the return value in eax or whatever. That means we cannot actually
call the static_calls for NULL slots, we'd get undefined behaviour
(except for void hooks) - this is what Peter is talking about in the
sibling thread.

For this reason, there are _no gaps_ in the callback table. For a
given LSM hook, all the slots after base_slot_idx are filled, and all
before are empty, so jumping to base_slot_idx ensures that we don't
reach an empty slot. That's what the switch trick is all about.

>
> >                         if ret !=3D 0:
>
> I assume you'd want "ret !=3D DEFAULT_RET" instead of "ret !=3D 0".

Yeah that's a good question - but the existing behaviour is to always
check against 0 (DEFAULT_RET is called IRC in the real code),
which does seem strange.

> So what goes in for empty slots? What about gaps in the table?

It's a NOP, but we never execute it (explained above). There are no gaps.

>> +#define __UNROLL_MACRO_LOOP_20(MACRO, ...) \
>> + __UNROLL_MACRO_LOOP_19(MACRO, __VA_ARGS__) \
>> + MACRO(19, __VA_ARGS__)
>> +
> Where does "20" come from? Why are you unrolling beyond 11?

It's just an arbitrary limit on the unrolling macro implementation, we
aren't actually unrolling beyond 11 where the macro is used (N is set
to 11).

>
> >   With this use of the table and the
> > switch, it is possible to jump directly to the first used slot and exec=
ute
> > all of the slots after. This essentially makes the entry point of the t=
able
> > dynamic. Instead, it would also be possible to start from 0 and break a=
fter
> > the final populated slot, but that would require an additional conditio=
nal
> > after each slot.
> >
> > This macro is used to generate the code for each static slot, (e.g. eac=
h
> > case statement in the previous example). This will expand into a call t=
o
> > MACRO for each static slot defined. For example, if with again 5 slots:
> >
> > SECURITY_FOREACH_STATIC_SLOT(MACRO, x, y) ->
> >
> >       MACRO(0, x, y)
> >       MACRO(1, x, y)
> >       MACRO(2, x, y)
> >       MACRO(3, x, y)
> >       MACRO(4, x, y)
> >
> > This is used in conjunction with LSM_HOOK definitions in
> > linux/lsm_hook_defs.h to execute a macro for each static slot of each L=
SM
> > hook.
> >
> > The patches for static calls [6] are not upstreamed yet.
> >
> > The number of available slots for each LSM hook is currently fixed at
> > 11 (the number of LSMs in the kernel). Ideally, it should automatically
> > adapt to the number of LSMs compiled into the kernel.
>
> #define SECURITY_STATIC_SLOT_COUNT ( \
>         1 + /* Capability module is always there */ \
>         (IS_ENABLED(CONFIG_SECURITY_SELINUX) ? 1 : 0) + \
>         (IS_ENABLED(CONFIG_SECURITY_SMACK) ? 1 : 0) + \
>         ... \
>         (IS_ENABLED(CONFIG_BPF_LSM) ? 1 : 0))
>

Yeah, that's exactly what we need but it needs to be expanded to an
integer literal at preprocessor time, those +s won't work :(

> > If there=E2=80=99s no practical way to implement such automatic adaptat=
ion, an
> > option instead would be to remove the panic call by falling-back to the=
 old
> > linked-list mechanism, which is still present anyway (see below).
> >
> > A few special cases of LSM don't use the macro call_[int/void]_hook but
> > have their own calling logic. The linked-lists are kept as a possible s=
low
> > path fallback for them.
>
> Unfortunately, the stacking effort is increasing the number of hooks
> that will require special handling. security_secid_to_secctx() is one
> example.
>
> >
> > Before:
> >
> > https://gist.githubusercontent.com/PaulRenauld/fe3ee7b51121556e03c18143=
2c8b3dd5/raw/62437b1416829ca0e8a0ed9101530bc90fd42d69/lsm-performance.png
> >
> > After:
> >
> > https://gist.githubusercontent.com/PaulRenauld/fe3ee7b51121556e03c18143=
2c8b3dd5/raw/00e414b73e0c38c2eae8f05d5363a745179ba285/faster-lsm-results.pn=
g
> >
> > With this implementation, any overhead of the indirect call in the LSM
> > framework is completely mitigated (performance results: [7]). This
> > facilitates the adoption of "bpf" LSM on production machines and also
> > benefits all other LSMs.
>
> Your numbers for a system with BPF are encouraging. What do the numbers
> look like for a system with SELinux, Smack or AppArmor?

Yeah that's a good question. As I said in the sibling thread the
motivating example is very lightweight LSM callbacks in very hot
codepaths, but I'll get some broader data too and report back.
