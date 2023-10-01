Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A37A0E748ED
	for <linux-security-module@archiver.kernel.org>; Sun,  1 Oct 2023 14:26:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235005AbjJAO0V (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 1 Oct 2023 10:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233590AbjJAO0U (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 1 Oct 2023 10:26:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE7EAB
        for <linux-security-module@vger.kernel.org>; Sun,  1 Oct 2023 07:26:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B68B6C433CB
        for <linux-security-module@vger.kernel.org>; Sun,  1 Oct 2023 14:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696170376;
        bh=4PCgQ6n3OWAggDFGP5fJ11V+Hd6aNBbabWmB4liLuJY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DkrBtIjTBLk1KZZHshUVg4hxGseJez4aSI/vrYq4mOJmtpFDuCpfw64uXb8im7EEo
         y40WGkEevTgrdKyc4SpVDcJ0DfgYrAq01XGtHyVYeASaIl0d1ve9Pc0K53Nf9LGY6t
         k+R3GdMzo9TXCx060Y0We9URNWQPqIeOOwyQ4LMLd9wkEko8a5F7VQ3Yix6Y6w9L3i
         SIW317VGkcMI63V7F2gTO0xT5cW1gBhEx4CS0tnXqa6VxXjabwEwLK1Xgsv77H4U/7
         Lb/VSuIB3fYSQgNbCHH+rVOAypwQNpnV0PwAJ9AtuEXdinsMyKq3HTradjj0T+jdx9
         HsztzKVEVN1IQ==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5362bcc7026so5947276a12.1
        for <linux-security-module@vger.kernel.org>; Sun, 01 Oct 2023 07:26:16 -0700 (PDT)
X-Gm-Message-State: AOJu0YwSGBdoRIqYF310iQ8JZz9J47Qrisw1krf8DG3PC2qnd5dmST7Q
        XVXPMiJiBrZuQrWoQCuGlTzLY+UeTtvZcp+MmZvPOw==
X-Google-Smtp-Source: AGHT+IGfWEn9cKGXm8yfkaoBd5C90LjZNxSm8Ua8OhdToxN8IgqT44UN6FqWeKogo2WhZ+xSy/lcJ4EAaRIKXCwBw3w=
X-Received: by 2002:a05:6402:400d:b0:538:8d4:2077 with SMTP id
 d13-20020a056402400d00b0053808d42077mr3837502eda.13.1696170375101; Sun, 01
 Oct 2023 07:26:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230918212459.1937798-1-kpsingh@kernel.org> <20230918212459.1937798-3-kpsingh@kernel.org>
 <cb67f607-3a9d-34d2-0877-a3ff957da79e@I-love.SAKURA.ne.jp>
 <CACYkzJ5GFsgc3vzJXH34hgoTc+CEf+7rcktj0QGeQ5e8LobRcw@mail.gmail.com>
 <dde20522-af01-c198-5872-b19ef378f286@I-love.SAKURA.ne.jp>
 <CACYkzJ5M0Bw9S_mkFkjR_-bRsKryXh2LKiurjMX9WW-d0Mr6bg@mail.gmail.com>
 <ed785c86-a1d8-caff-c629-f8a50549e05b@I-love.SAKURA.ne.jp>
 <CACYkzJ4TLCMFEa5h-iEVC-58cakjduw44c-ct64SgBe0_jFKuQ@mail.gmail.com>
 <6a80711e-edc4-9fab-6749-f1efa9e4231e@I-love.SAKURA.ne.jp>
 <CACYkzJ4AGRcqLPqWY65OC778EPaUwTBpyOMfiVBXa4EmnHTXGQ@mail.gmail.com> <c1683052-aa5a-e0d5-25ae-40316273ed1b@I-love.SAKURA.ne.jp>
In-Reply-To: <c1683052-aa5a-e0d5-25ae-40316273ed1b@I-love.SAKURA.ne.jp>
From:   KP Singh <kpsingh@kernel.org>
Date:   Sun, 1 Oct 2023 16:26:04 +0200
X-Gmail-Original-Message-ID: <CACYkzJ7_42dhynhmuCBF6z0hyMkYL_FxLR9rM1beCwJVkEv9gQ@mail.gmail.com>
Message-ID: <CACYkzJ7_42dhynhmuCBF6z0hyMkYL_FxLR9rM1beCwJVkEv9gQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] security: Count the LSMs enabled at compile time
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        paul@paul-moore.com, keescook@chromium.org, casey@schaufler-ca.com,
        song@kernel.org, daniel@iogearbox.net, ast@kernel.org,
        Kui-Feng Lee <sinquersw@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sun, Oct 1, 2023 at 12:51=E2=80=AFPM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2023/09/25 20:22, KP Singh wrote:
> >> It is Casey's commitment that the LSM infrastructure will not forbid L=
KM-based LSMs.
> >> We will start allowing LKM-based LSMs. But it is not clear how we can =
make it possible to
> >> allow LKM-based LSMs.
> >
> > I think this needs to be discussed if and when we allow LKM based LSMs.
>
> It is *now* (i.e. before your proposal is accepted) that we need to discu=
ss.
>
> > One needs to know MAX_LSM_COUNT at compile time (not via kernel
> > command line), I really suggest you try out your suggestions before
> > posting them. I had explained this to you earlier, you still chose to
> > ignore and keep suggesting stuff that does not work.
>
> Your proposal needs to know MAX_LSM_COUNT at compile time, that's why
> we need to discuss now.

People already mention that you seem to deliberately ignore advice
given to you and continue with your own narrative. Here's my last
attempt to explain things to you:

You are conflating two use cases, built-in out-of-tree LSMS and
modular LSMs. However, the proposed changes block neither of the use
cases.

* For modules that are out-of-tree but compiled into the kernel, they
can just modify the MAX_LSM_COUNT
* For dynamically loadable LSMs, you anyways want a separate
security_hook_heads. The __ro_after_init should not be relaxed on the
existing security_hook_heads to prevent any memory corruption from
overriding LSM callbacks, this lowers the existing security posture.
And then, in the call_int_hook and security_for_each_hook you can
iterate over both the static call slots.

^^ I said the above multiple times but you ignored all of it!

- KP

>
> > We will see when this happens. I don't think it's a difficult problem
> > and there are many ways to implement this:
> >
> > * Add a new slot(s) for modular LSMs (One can add up to N fast modular =
LSMs)
> > * Fallback to a linked list for modular LSMs, that's not a complexity.
> > There are serious performance gains and I think it's a fair trade-off.
> > This isn't even complex.
>
> That won't help at all. You became so blind because what you want to use =
(i.e.
> SELinux and BPF) are already supported by Linux distributors. The reason =
I'm
> insisting on supporting LKM-based LSMs is that Linux distributors cannot =
afford
> supporting minor LSMs.
>
> Dave Chinner said
>
>   Downstream distros support all sorts of out of tree filesystems loaded
>   via kernel modules
>
> at https://lkml.kernel.org/r/ZQo94mCzV7hOrVkh@dread.disaster.area , and e=
.g.
> antivirus software vendors use out of tree filesystems loaded via kernel
> modules (because neither the upstream kernel community nor the Linux dist=
ributors
> can afford supporting out of tree filesystems used by antivirus software =
vendors).
>
> If Linux distributors decide "we don't allow loading out of tree filesyst=
ems
> via kernel modules because we can't support", that's the end of the world=
 for
> such filesystems.
>
> What I'm saying is nothing but s/filesystem/LSM/g .
> If Linux distributors decide "we don't allow loading out of tree LSMs
> via kernel modules because we can't support", that's the end of the world=
 for
> LKM-based LSMs.
>
> The mechanism which makes LKM-based LSMs possible must not be disabled by
> the person/organization who builds the vmlinux.
>
> You might still say that "You can build your vmlinux and distribute it", =
but
> that is also impossible in practice. Some device drivers are meant to be =
loaded
> for Linux distribution's prebuilt kernels. Also, debuginfo package is nee=
ded for
> analyzing vmcore. Building vmlinux and distributing it is not practical w=
ithout
> becoming a well-known Linux distributors enough to get out-of-tree device=
 drivers
> being prebuilt (such as Red Hat).
>
> Again, you are so blind.
>
> > Now, this patch and the patch that makes security_hook_heads
> > __ro_after_init by removing CONFIG_SECURITY_HOOKS_WRITABLE breaks your
> > hack.
>
> Like I demonstrated at https://lkml.kernel.org/r/cc8e16bb-5083-01da-4a77-=
d251a76dc8ff@I-love.SAKURA.ne.jp ,
> removing CONFIG_SECURITY_HOOKS_WRITABLE does not break my hack.
>
