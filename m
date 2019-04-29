Return-Path: <SRS0=32Xp=S7=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70DCAC004C9
	for <linux-security-module@archiver.kernel.org>; Mon, 29 Apr 2019 18:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FC552067D
	for <linux-security-module@archiver.kernel.org>; Mon, 29 Apr 2019 18:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556563605;
	bh=5j9NYksW1sFn4p0aXlHqBk4ZUKpOJxf0zYGvnIwtNvc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=lqCTX8+vBEU9Fzu8Yvwdo+ttpMkjXENLdHGCnrW+2XRcTKItj9BydVSsiD1gZOax6
	 6INYQD55/ebEQvy2hzvGT4+FI62pWGNBIj8tFBIqx90ka48sSUFzqN8UQg0hitGjAC
	 8KPs0NlY14uv3sMdStAQnHSXx48WV0CE+8i1Qcjc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729208AbfD2Sqn (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 29 Apr 2019 14:46:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:48372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729197AbfD2Sqn (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 29 Apr 2019 14:46:43 -0400
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF45F2173E
        for <linux-security-module@vger.kernel.org>; Mon, 29 Apr 2019 18:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556563602;
        bh=5j9NYksW1sFn4p0aXlHqBk4ZUKpOJxf0zYGvnIwtNvc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qZhWW23MUGLTV1xDSbhGdYBi6Ok9eRCtMr6n1nCokzoNuWw+9JeXnf0EsGO5F7NPs
         X/PCZ9IWwRrVbLTkCL6BKXV1vMIK6WcURuaT7A0Eytq62xoVYAimqpRqwRhoVV6Fhb
         IpNjeuR9wz20QmsqdP9Eh/9sJy8bSiXE5p2BlFOU=
Received: by mail-wr1-f43.google.com with SMTP id k16so17543660wrn.5
        for <linux-security-module@vger.kernel.org>; Mon, 29 Apr 2019 11:46:41 -0700 (PDT)
X-Gm-Message-State: APjAAAXlVpR66a1HZA9uHAEy5bsFEZGC6G6SAGvoyqcEGj75qjr/P5PD
        ZhvWf7jrjZfTP4xXi+PRDpDEWOoxq/vdCBJrs0kMEQ==
X-Google-Smtp-Source: APXvYqy1oi8e+LSfXCrvP/jJQ24jpEljvz/aD49GKXWvZBgRJ5jZDTrdXFKCXTFaX+9EslcKt2nxyLv1fNBSB9apvzk=
X-Received: by 2002:a5d:424e:: with SMTP id s14mr18705438wrr.77.1556563600428;
 Mon, 29 Apr 2019 11:46:40 -0700 (PDT)
MIME-Version: 1.0
References: <1556228754-12996-1-git-send-email-rppt@linux.ibm.com>
 <1556228754-12996-3-git-send-email-rppt@linux.ibm.com> <20190426083144.GA126896@gmail.com>
 <20190426095802.GA35515@gmail.com> <CALCETrV3xZdaMn_MQ5V5nORJbcAeMmpc=gq1=M9cmC_=tKVL3A@mail.gmail.com>
 <20190427084752.GA99668@gmail.com> <20190427104615.GA55518@gmail.com>
In-Reply-To: <20190427104615.GA55518@gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 29 Apr 2019 11:46:28 -0700
X-Gmail-Original-Message-ID: <CALCETrUn_86VAd8FGacJ169xcWE6XQngAMMhvgd1Aa6ZxhGhtA@mail.gmail.com>
Message-ID: <CALCETrUn_86VAd8FGacJ169xcWE6XQngAMMhvgd1Aa6ZxhGhtA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/7] x86/sci: add core implementation for system call isolation
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Jonathan Adams <jwadams@google.com>,
        Kees Cook <keescook@chromium.org>,
        Paul Turner <pjt@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux-MM <linux-mm@kvack.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        X86 ML <x86@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sat, Apr 27, 2019 at 3:46 AM Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Ingo Molnar <mingo@kernel.org> wrote:
>
> > * Andy Lutomirski <luto@kernel.org> wrote:
> >
> > > > And no, I'm not arguing for Java or C#, but I am arguing for a sane=
r
> > > > version of C.
> > >
> > > IMO three are three credible choices:
> > >
> > > 1. C with fairly strong CFI protection. Grsecurity has this (supposed=
ly
> > > =E2=80=94 there=E2=80=99s a distinct lack of source code available), =
and clang is
> > > gradually working on it.
> > >
> > > 2. A safe language for parts of the kernel, e.g. drivers and maybe
> > > eventually filesystems.  Rust is probably the only credible candidate=
.
> > > Actually creating a decent Rust wrapper around the core kernel
> > > facilities would be quite a bit of work.  Things like sysfs would be
> > > interesting in Rust, since AFAIK few or even no drivers actually get
> > > the locking fully correct.  This means that naive users of the API
> > > cannot port directly to safe Rust, because all the races won't compil=
e
> > > :)
> > >
> > > 3. A sandbox for parts of the kernel, e.g. drivers.  The obvious
> > > candidates are eBPF and WASM.
> > >
> > > #2 will give very good performance.  #3 gives potentially stronger
> > > protection against a sandboxed component corrupting the kernel overal=
l,
> > > but it gives much weaker protection against a sandboxed component
> > > corrupting itself.
> > >
> > > In an ideal world, we could do #2 *and* #3.  Drivers could, for
> > > example, be written in a language like Rust, compiled to WASM, and ru=
n
> > > in the kernel.
> >
> > So why not go for #1, which would still outperform #2/#3, right? Do we
> > know what it would take, roughly, and how the runtime overhead looks
> > like?
>
> BTW., CFI protection is in essence a compiler (or hardware) technique to
> detect stack frame or function pointer corruption after the fact.
>
> So I'm wondering whether there's a 4th choice as well, which avoids
> control flow corruption *before* it happens:
>
>  - A C language runtime that is a subset of current C syntax and
>    semantics used in the kernel, and which doesn't allow access outside
>    of existing objects and thus creates a strictly enforced separation
>    between memory used for data, and memory used for code and control
>    flow.
>
>  - This would involve, at minimum:
>
>     - tracking every type and object and its inherent length and valid
>       access patterns, and never losing track of its type.
>
>     - being a lot more organized about initialization, i.e. no
>       uninitialized variables/fields.
>
>     - being a lot more strict about type conversions and pointers in
>       general.

You're not the only one to suggest this.  There are at least a few
things that make this extremely difficult if not impossible.  For
example, consider this code:

void maybe_buggy(void)
{
  int a, b;
  int *p =3D &a;
  int *q =3D (int *)some_function((unsigned long)p);
  *q =3D 1;
}

If some_function(&a) returns &a, then all is well.  But if
some_function(&a) returns &b or even a valid address of some unrelated
kernel object, then the code might be entirely valid and correct C,
but I don't see how the runtime checks are supposed to tell whether
the resulting address is valid or is a bug.  This type of code is, I
think, quite common in the kernel -- it happens in every data
structure where we have unions of pointers and integers or where we
steal some known-zero bits of a pointer to store something else.

--Andy
