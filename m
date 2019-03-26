Return-Path: <SRS0=+HMg=R5=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F975C43381
	for <linux-security-module@archiver.kernel.org>; Tue, 26 Mar 2019 19:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B4AF2075C
	for <linux-security-module@archiver.kernel.org>; Tue, 26 Mar 2019 19:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553628151;
	bh=TEBNw7TiawxkZvyrCzIPpSy5Hct8IdJe9+97XBQEcjI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Og41iR+LzKYPSS58vSu1Ptx5mFBj8VTiiGY3mh0EYbVjlQ43cIM2j4nmkpVcGuubH
	 96hiD5eDxWvl/VZ2X/v2WG6b9wpcuDXsJx6Czi3r9XIMoXxbbVtZy1AVnIcUeVUISD
	 RO5uFzJUwqxCczNHRYOhxcQAhKVadyrG4rmGsV3c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732141AbfCZTWa (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 26 Mar 2019 15:22:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:49362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732504AbfCZTWa (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 26 Mar 2019 15:22:30 -0400
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24987213A2
        for <linux-security-module@vger.kernel.org>; Tue, 26 Mar 2019 19:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553628149;
        bh=TEBNw7TiawxkZvyrCzIPpSy5Hct8IdJe9+97XBQEcjI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=yXSujwgKXCG0x9NxMCv9CanO+xoDJpZVWENNAQOFqFaKCuUfQr7O4+YEWqVr0PVuK
         sWab4rtOMLRjAi+eRgF3zIDgzvfmTchgorJLOZjxaagrAgnWbs4IfDdL3HVwJKhOtW
         cZ3/6bqNYgsR5Dt4UQUbtTk6QjRRRFXBw8E7Wrjo=
Received: by mail-wr1-f54.google.com with SMTP id o1so15716631wrs.13
        for <linux-security-module@vger.kernel.org>; Tue, 26 Mar 2019 12:22:29 -0700 (PDT)
X-Gm-Message-State: APjAAAV95DhMwuSqvtP9ItU3Iws2sRoCkrucZrUrziDfZ4iVK3P+P9DQ
        xX2uggjwCp2D9gnADCGt6qognF/5LklcZRB3rqR67Q==
X-Google-Smtp-Source: APXvYqz6qQn4tdlnd+9IIQn4uhajoJQO7lunAFxi8D0JlRkCJGpkajiezU/sOokacme974yx0V5OpqpctbUi7Mn4Fa4=
X-Received: by 2002:adf:f011:: with SMTP id j17mr18511809wro.330.1553628147761;
 Tue, 26 Mar 2019 12:22:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190325220954.29054-1-matthewgarrett@google.com>
 <20190325220954.29054-24-matthewgarrett@google.com> <20190325164221.5d8687bd@shemminger-XPS-13-9360>
 <CALCETrU=EqqRwyQGBT0=_N9-E_pBM53=z+WJrd9OzV7g6xJa0A@mail.gmail.com> <alpine.LRH.2.21.1903270523240.5235@namei.org>
In-Reply-To: <alpine.LRH.2.21.1903270523240.5235@namei.org>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 26 Mar 2019 12:22:17 -0700
X-Gmail-Original-Message-ID: <CALCETrUZ+oP0xxNt4mwN=AZA+zvkkfPZiAsFmAuqUD48pOHbBg@mail.gmail.com>
Message-ID: <CALCETrUZ+oP0xxNt4mwN=AZA+zvkkfPZiAsFmAuqUD48pOHbBg@mail.gmail.com>
Subject: Re: [PATCH 23/27] bpf: Restrict kernel image access functions when
 the kernel is locked down
To:     James Morris <jmorris@namei.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Linux API <linux-api@vger.kernel.org>,
        Matthew Garrett <matthewgarrett@google.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Network Development <netdev@vger.kernel.org>,
        Chun-Yi Lee <jlee@suse.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kees Cook <keescook@chromium.org>,
        Will Drewry <wad@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Mar 26, 2019 at 11:57 AM James Morris <jmorris@namei.org> wrote:
>
> On Mon, 25 Mar 2019, Andy Lutomirski wrote:
>
> > A while back, I suggested an approach to actually make this stuff
> > mergeable: submit a patch series that adds lockdown mode, enables it
> > by command line option (and maybe sysctl) *only* and has either no
> > effect or only a token effect.  Then we can add actual features to
> > lockdown mode one at a time and review them separately.
>
> This makes sense to me.
>
> >
> > And I'm going to complain loudly unless two things change about this
> > whole thing:
> >
> > 1. Lockdown mode becomes three states, not a boolean.  The states are:
> > no lockdown, best-effort-to-protect-kernel-integrity, and
> > best-effort-to-protect-kernel-secrecy-and-integrity.  And this BPF
> > mess illustrates why: most users will really strongly object to
> > turning off BPF when they actually just want to protect kernel
> > integrity.  And as far as I know, things like Secure Boot policy will
> > mostly care about integrity, not secrecy, and tracing and such should
> > work on a normal locked-down kernel.  So I think we need this knob.
>
> Another approach would be to make this entirely policy based:
>
> - Assign an ID to each lockdown point
> - Implement a policy mechanism where each ID is mapped to 0 or 1
> - Allow this policy to be specified statically or dynamically
>
> So,
>
>         kernel_is_locked_down("ioperm")
>
> becomes
>
>         kernel_is_locked_down(LOCKDOWN_IOPERM)
>
> and this function checks e.g.
>
>         if (lockdown_polcy[id]) {
>                 fail or warn;
>         }
>
> Thoughts?

I'm concerned that this gives too much useless flexibility to
administrators and user code in general.  If you can break kernel
integrity, you can break kernel integrity -- it shouldn't really
matter *how* you break it.

--Andy
