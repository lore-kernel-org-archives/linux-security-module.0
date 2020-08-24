Return-Path: <SRS0=szIC=CC=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 773F7C433E1
	for <linux-security-module@archiver.kernel.org>; Mon, 24 Aug 2020 17:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D06420866
	for <linux-security-module@archiver.kernel.org>; Mon, 24 Aug 2020 17:05:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aRAELLIL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbgHXRFe (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 24 Aug 2020 13:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbgHXREz (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 24 Aug 2020 13:04:55 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396ECC061573
        for <linux-security-module@vger.kernel.org>; Mon, 24 Aug 2020 10:04:55 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id s2so9456329ioo.2
        for <linux-security-module@vger.kernel.org>; Mon, 24 Aug 2020 10:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fgZwZCIujuxzzLKMoK4XwDwGpdA2x4tRAfT7RbGfEyE=;
        b=aRAELLILR7Gs8V4eWNB5DkiYJqrocT3AqS8Ka1bV4Lunz/lpBe3Q/4QBC2lSVFQoOF
         5gT0i3tjDPI/8YDJDT1Tnd/Jqq3UuVfHh7a0GpqfoATt3p6OKIzOb68H9KfZ3dSBcWLj
         YL17yEVwNe2Ewm76W1ny8icHTAXNFuYgOHh1LMrlKaF767Xpxro52LA+Ag2/fSL/fkI3
         JBKkduITmseGjItU/x66Re4EF06ascn5lIVigOIH5ftzgNKeRmWO/2UnVVY3nTQ9ZQoZ
         aGh5T093QSyYTiTVk+xC7rWQ54FtV3MZo1Gw173JUG8s34BT3HMgAeCkirvYvnMme0VX
         JWlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fgZwZCIujuxzzLKMoK4XwDwGpdA2x4tRAfT7RbGfEyE=;
        b=QZr4bpCeFKrJnScHLq7EoqBDWJQw/qDNP57nDJmz1UGg1nqwh9XY2lBaCSLG2pFH07
         P03auLmhORUJg43+3Rgwmo2Ui5RSZkoSc1nexMqTLaI8ETv+NHiXDWL/k1RhKd+fK9SC
         VIVG3X+xK/E3ygcAfnbrGpCPNhNLCFhyNDxqo9QC4gX07Zvd0AcT49IztuaGaU64tNaE
         VUSUp7DkcBE7CEk9rh25SzaVGn4iqgpPUj8uI2pCMVMbPh++tB4WfNvLrs+gFuS/Hnlp
         PlS5FNQVBYhttW+Cc/VFi0wk11X/1x2AxEtBlmB/DUrDtStFb6wAz1wcSdCoJq6NFcbv
         5rJw==
X-Gm-Message-State: AOAM5302BySeZ55NL/ZNvMDo8Agafg81t4RVtCAKr1mQugE5O7onRaXY
        vJ5o/mT5Jnf/Axrv28qOgIygq/jbU6X3QgomhQEStQ==
X-Google-Smtp-Source: ABdhPJzyv5i/pTPasEP6mPwaAemka1mfGrbTgakxsiJNgGVH64HPjPguQKB4K7RAeE/vYSrfjmU1nVmoS7ByFsfu7+M=
X-Received: by 2002:a6b:9256:: with SMTP id u83mr5748173iod.194.1598288694363;
 Mon, 24 Aug 2020 10:04:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200820164753.3256899-1-jackmanb@chromium.org>
 <42fb4180-772c-5579-ef3e-b4003e2b784b@schaufler-ca.com> <CA+i-1C09YZ8aCr6p5NOA2e3Ji5TKwdET=qAy=M328NK--L=0RA@mail.gmail.com>
 <66a35f25-53be-17c3-8ab3-7cb32b0bc77a@schaufler-ca.com>
In-Reply-To: <66a35f25-53be-17c3-8ab3-7cb32b0bc77a@schaufler-ca.com>
From:   Brendan Jackman <jackmanb@google.com>
Date:   Mon, 24 Aug 2020 19:04:43 +0200
Message-ID: <CA+i-1C1GwgYJAfaUofzv47nyryQ15znE6OLWhAN-gsscm6mMoA@mail.gmail.com>
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
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, 24 Aug 2020 at 18:43, Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> On 8/24/2020 8:20 AM, Brendan Jackman wrote:
> > On Fri, 21 Aug 2020 at 00:46, Casey Schaufler <casey@schaufler-ca.com> wrote:
> >> On 8/20/2020 9:47 AM, Brendan Jackman wrote:
> > [...]
> >> What does NOP really look like?
> > The NOP is the same as a regular function call but the CALL
> > instruction is replaced with a NOP instruction. The code that sets up
> > the call parameters is unchanged, and so is the code that expects to
> > get the return value in eax or whatever.
>
> Right. Are you saying that NOP is in-line assembler in your switch?

That's right - although it's behind the static_call API that the patch
depends on ([5] in the original mail).

> > That means we cannot actually
> > call the static_calls for NULL slots, we'd get undefined behaviour
> > (except for void hooks) - this is what Peter is talking about in the
> > sibling thread.
>
> Referring to the "sibling thread" is kinda confusing, and
> assumes everyone is one all the right mailing lists, and knows
> which other thread you're talking about.

Sure, sorry - here's the Lore link for future reference:

https://lore.kernel.org/lkml/20200820164753.3256899-1-jackmanb@chromium.org/T/#m5a6fb3f10141049ce43e18a41f154796090ae1d5

> >
> > For this reason, there are _no gaps_ in the callback table. For a
> > given LSM hook, all the slots after base_slot_idx are filled,
>
> Why go to all the trouble of maintaining the base_slot_idx
> if NOP is so cheap? Why not fill all unused slots with NOP?
> Worst case would be a hook with no users, in which case you
> have 11 NOPS in the void hook case and 11 "if (ret != DEFAULT_RET)"
> and 11 NOPS in the int case. No switch magic required. Even
> better, in the int case you have two calls/slot, the first is the
> module supplied function (or NOP) and the second is
>         int isit(int ret) { return (ret != DEFAULT_RET) ? ret : 0; }
> (or NOP).
>
> The no security module case degenerates to 22 NOP instructions
> and no if checks of any sort. I'm not the performance guy, but
> that seems better than maintaining and checking base_slot_idx
> to me.

The switch trick is not really motivated by performance.

I think all the focus on the NOPs themselves is a bit misleading here
- we _can't_ execute the NOPs for the int hooks, because there are
instructions after them that expect a function to have just returned a
value, which NOP doesn't do. When there is a NOP in the slot instead
of a CALL, it would appear to "return" whatever value is leftover in
the return register. At the C level, this is why the static_call API
doesn't allow static_call_cond to return a value (which is what PeterZ
is referring to in the thread I linked above).

So, we could drop the switch trick for void hooks and just use
static_call_cond, but this doesn't work for int hooks. IMO that
variation between the two hook types would just add confusion.

> >>> +#define __UNROLL_MACRO_LOOP_20(MACRO, ...) \
> >>> + __UNROLL_MACRO_LOOP_19(MACRO, __VA_ARGS__) \
> >>> + MACRO(19, __VA_ARGS__)
> >>> +
> >> Where does "20" come from? Why are you unrolling beyond 11?
> > It's just an arbitrary limit on the unrolling macro implementation, we
> > aren't actually unrolling beyond 11 where the macro is used (N is set
> > to 11).
>
> I'm not a fan of including macros you can't use, especially
> when they're just obvious variants of other macros.

Not sure what you mean here - is there already a macro that does what
UNROLL_MACRO_LOOP does?
