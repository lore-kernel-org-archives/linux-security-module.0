Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E3CE7849A
	for <linux-security-module@archiver.kernel.org>; Mon,  2 Oct 2023 13:04:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237278AbjJBNEg (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 2 Oct 2023 09:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237299AbjJBNEf (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 2 Oct 2023 09:04:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D6DC4
        for <linux-security-module@vger.kernel.org>; Mon,  2 Oct 2023 06:04:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15793C433CD
        for <linux-security-module@vger.kernel.org>; Mon,  2 Oct 2023 13:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696251871;
        bh=Vz3e6eEiCyGz/ikqYCMHq6SV5GHNB4SWJy4xxDlYtRk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=N1TziSHPAfqBE8tFB6xCylqlrBzBWmMsT2G36oP/zU8BH93OjpkhR+Yfx8be0jzsW
         U1GqtNx5ufTfj91HjIqxBg+5emLFXb29i5gWxMNx+zKTqB6Yx5J4Qcx/C0OBVvh5+l
         WGxHx/Rw87mqSiW6xnBWzbblo8FwRN+F7fGlkJ4jwsu5EBzUJ5diGlFWYdZtX/icFW
         XzJrSssjPTd6UEBjY1+1YBvuEOZzV7o0uVnYzOQK1ngcG6ZBBVU4EMKe9hxgbDE5wM
         toPM5ZjfLXO7O5gVsdWqFNXMGXRB/gVYSd8asMzI9BINzV4t8p88ZJJKGlovzsSMTT
         j5IxQOJrrwpCA==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-533f193fc8dso17710269a12.2
        for <linux-security-module@vger.kernel.org>; Mon, 02 Oct 2023 06:04:31 -0700 (PDT)
X-Gm-Message-State: AOJu0YywpM7fxoQC6Zf9Y6KFhoyLFZpj9j0u0Wuz4srSKw8r18J3ISdM
        pKVIpEtfnJUCyOOQq1pZRmB4zaFDdJXfLpU6l/1EEQ==
X-Google-Smtp-Source: AGHT+IG8aYEK25QOtGLaAoK++vf698qT8Dys8K47xhN1xcTDLrJjmJgbYNnv1lDJQFBWCjLF3zYBDeFFIvk4c69srA4=
X-Received: by 2002:aa7:d451:0:b0:530:bd6b:7a94 with SMTP id
 q17-20020aa7d451000000b00530bd6b7a94mr11309178edr.24.1696251869341; Mon, 02
 Oct 2023 06:04:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230918212459.1937798-1-kpsingh@kernel.org> <20230918212459.1937798-3-kpsingh@kernel.org>
 <cb67f607-3a9d-34d2-0877-a3ff957da79e@I-love.SAKURA.ne.jp>
 <CACYkzJ5GFsgc3vzJXH34hgoTc+CEf+7rcktj0QGeQ5e8LobRcw@mail.gmail.com>
 <dde20522-af01-c198-5872-b19ef378f286@I-love.SAKURA.ne.jp>
 <CACYkzJ5M0Bw9S_mkFkjR_-bRsKryXh2LKiurjMX9WW-d0Mr6bg@mail.gmail.com>
 <ed785c86-a1d8-caff-c629-f8a50549e05b@I-love.SAKURA.ne.jp>
 <CACYkzJ4TLCMFEa5h-iEVC-58cakjduw44c-ct64SgBe0_jFKuQ@mail.gmail.com>
 <6a80711e-edc4-9fab-6749-f1efa9e4231e@I-love.SAKURA.ne.jp>
 <CACYkzJ4AGRcqLPqWY65OC778EPaUwTBpyOMfiVBXa4EmnHTXGQ@mail.gmail.com>
 <c1683052-aa5a-e0d5-25ae-40316273ed1b@I-love.SAKURA.ne.jp>
 <d9765991-45bb-ba9a-18d4-d29eab3e29b9@schaufler-ca.com> <f739db5c-7d76-7a86-c4b5-794eeffd6a2d@I-love.SAKURA.ne.jp>
In-Reply-To: <f739db5c-7d76-7a86-c4b5-794eeffd6a2d@I-love.SAKURA.ne.jp>
From:   KP Singh <kpsingh@kernel.org>
Date:   Mon, 2 Oct 2023 15:04:18 +0200
X-Gmail-Original-Message-ID: <CACYkzJ6UgBaTH+3WW+2LXHrp2JMpuH6WUbM22qPCoSRio9WQRQ@mail.gmail.com>
Message-ID: <CACYkzJ6UgBaTH+3WW+2LXHrp2JMpuH6WUbM22qPCoSRio9WQRQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] security: Count the LSMs enabled at compile time
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        paul@paul-moore.com, keescook@chromium.org, song@kernel.org,
        daniel@iogearbox.net, ast@kernel.org,
        Kui-Feng Lee <sinquersw@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Oct 2, 2023 at 12:56=E2=80=AFPM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2023/10/02 0:00, Casey Schaufler wrote:
> > On 10/1/2023 3:51 AM, Tetsuo Handa wrote:
> >> On 2023/09/25 20:22, KP Singh wrote:
> >>>> It is Casey's commitment that the LSM infrastructure will not forbid=
 LKM-based LSMs.
> >>>> We will start allowing LKM-based LSMs. But it is not clear how we ca=
n make it possible to
> >>>> allow LKM-based LSMs.
> >>> I think this needs to be discussed if and when we allow LKM based LSM=
s.
> >> It is *now* (i.e. before your proposal is accepted) that we need to di=
scuss.
> >>
> >>> One needs to know MAX_LSM_COUNT at compile time (not via kernel
> >>> command line), I really suggest you try out your suggestions before
> >>> posting them. I had explained this to you earlier, you still chose to
> >>> ignore and keep suggesting stuff that does not work.
> >> Your proposal needs to know MAX_LSM_COUNT at compile time, that's why
> >> we need to discuss now.
> >>
> >>> We will see when this happens. I don't think it's a difficult problem
> >>> and there are many ways to implement this:
> >>>
> >>> * Add a new slot(s) for modular LSMs (One can add up to N fast modula=
r LSMs)
> >>> * Fallback to a linked list for modular LSMs, that's not a complexity=
.
> >>> There are serious performance gains and I think it's a fair trade-off=
.
> >>> This isn't even complex.
> >> That won't help at all.
> >
> > This is exactly the solution I have been contemplating since this
> > discussion began. It will address the bulk of the issue. I'm almost
> > mad/crazy enough to produce the patch to demonstrate it. Almost.
>
> Yes, please show us one. I'm fine if the mechanism which allows LKM-based=
 LSMs
> cannot be disabled via the kernel configuration options.
>
> I really want a commitment that none of the LSM community objects revival=
 of
> LKM-based LSMs. I'm worrying that some of the LSM community objects reviv=
al of
> LKM-based LSMs because adding extra slots and/or linked list is e.g. an o=
verhead,
> increases attack surface etc.
>
> Let's consider the Microsoft Windows operating system. Many security vend=
ors are
> offering security software which can run without recompiling the Windows =
OS.
>
> But what about Linux? Security vendors cannot trivially add a security me=
chanism
> because LKM-based LSMs are not supported since 2.6.24. As a result, some =
chose
> hijacking LSM hooks, and others chose overwriting system call tables.
>
> The Linux kernel is there for providing what the user needs. What about t=
he LSM
> infrastructure? The LSM infrastructure is too much evolving towards in-tr=
ee and
> built-in security mechanisms.
>
> The consequence of such evolving will be "Limited Security Modes" where u=
sers cannot
> use what they need. New ideas cannot be easily tried if rebuild of vmlinu=
x is
> inevitable, which will also prevent a breath of fresh ideas from reaching=
 the LSM
> community.
>
> Never "discussed *if* we allow LKM based LSMs", for the LSM community can=
not
> afford accepting whatever LSMs and the Linux distributors cannot afford e=
nabling
> whatever LSMs.
>
> I'm not speaking for the security vendors. I'm speaking from the point of=
 view of
> minority/out-of-tree users.
>
> > There are still a bunch of details (e.g. shared blobs) that it doesn't
> > address. On the other hand, your memory management magic doesn't
> > address those issues either.
>
> Security is always trial-and-error. Just give all Linux users chances to =
continue
> trial-and-error. You don't need to forbid LKM-based LSMs just because blo=
b management
> is not addressed. Please open the LSM infrastructure to anyone.

It already is, the community is already using BPF LSM.

e.g. https://github.com/linux-lock/bpflock

>
