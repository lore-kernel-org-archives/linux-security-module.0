Return-Path: <SRS0=kszx=R7=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E9AC43381
	for <linux-security-module@archiver.kernel.org>; Thu, 28 Mar 2019 20:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37A0020685
	for <linux-security-module@archiver.kernel.org>; Thu, 28 Mar 2019 20:08:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F8htFQGL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbfC1UIw (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 28 Mar 2019 16:08:52 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:55873 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbfC1UIw (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 28 Mar 2019 16:08:52 -0400
Received: by mail-it1-f195.google.com with SMTP id z126so226125itd.5
        for <linux-security-module@vger.kernel.org>; Thu, 28 Mar 2019 13:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KXa4aw3Kp05X/TfkEO7Kz/YGOX0pHLxbS3qn41bra2I=;
        b=F8htFQGLOx8rOJ/PUrM899ncSK9ex/eqiOBDGKlu12kUTENuN9iQZ92nBpzaNk2zFp
         1RwoZGwVTs/DZuulS/L3/VaU/w3OMD4XYEsM0UqT7O2LC57mfI/WwHkV/WjVJTEKtSd3
         JGwmDreClRvFPz2t6deVlyPEnxBKwTgpEpQFgvacdJ1aeUvcgPPpLPb6iRmwPe3rA9Zg
         9qC+Q+a5s/OBcmk7RuFoanA+5YuXH3eev8evCg4fRar8g2dJ82u3Hupb5Txyqhoeq8i0
         FD3LoAQdNrwZJ61h0cQapbPCTB49qqtLi8ecc8qx72ySVzBiG3IqoHXopXAKCpL8K/XF
         QRDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KXa4aw3Kp05X/TfkEO7Kz/YGOX0pHLxbS3qn41bra2I=;
        b=qEJAVNhzBfwhfz7l5cvjt4murl9BYIHRL/rxCng64iO6lzDBWhUmBcMYPzrJE6IM/a
         Q2gYwHHtS1BZXP0tfVav11JJ0SHkzhplXN4NNSRX7ZuSUUFpeEY985PtL7dS6s0aLXQY
         rukQTypl4Xtlzp5CTaP2IqZGIQdmngVjs7pNie+1SvGHTtmeT9koX8Piw/vyc8hHVNId
         UMH5rhx+RhACSsdx7QDCyIkKkM5WORIXsjmyw8oD9BQGQ9R8jKZmtpOlpZHNjX54z5hZ
         zdC3h4cVv4o9RJIvSiKoSCSq7dGXUbVJ0qvGfZ3mteg0iW554/pqhoAl63+Jhx7luLhq
         Pc2A==
X-Gm-Message-State: APjAAAXfmXqHYw6RtfNP9QE94UqZxWxIFM8Qy3MXznWdVgvvJ1ebDwq+
        h9GnTmKV2GJKNkJKK+e6XJXDOTWZrc+UMKXmizqqIw==
X-Google-Smtp-Source: APXvYqyWywh2R8MMEKwy93JCRcDsRn2zKXc1oTE06EvJgHduUfwzKZnct0bX7he26MrdcD1D0gDrDBw9QuQOmc01mJ0=
X-Received: by 2002:a24:4e91:: with SMTP id r139mr1578477ita.118.1553803731483;
 Thu, 28 Mar 2019 13:08:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190325220954.29054-1-matthewgarrett@google.com>
 <20190325220954.29054-24-matthewgarrett@google.com> <20190325164221.5d8687bd@shemminger-XPS-13-9360>
 <CALCETrU=EqqRwyQGBT0=_N9-E_pBM53=z+WJrd9OzV7g6xJa0A@mail.gmail.com>
 <alpine.LRH.2.21.1903270523240.5235@namei.org> <CALCETrUZ+oP0xxNt4mwN=AZA+zvkkfPZiAsFmAuqUD48pOHbBg@mail.gmail.com>
 <alpine.LRH.2.21.1903281403540.27561@namei.org> <CACdnJusbi1jB+G0wMcj43wNik9Fiv3QCc8v30ztrFWg5-P-0iQ@mail.gmail.com>
 <alpine.LRH.2.21.1903290621350.1769@namei.org>
In-Reply-To: <alpine.LRH.2.21.1903290621350.1769@namei.org>
From:   Matthew Garrett <mjg59@google.com>
Date:   Thu, 28 Mar 2019 13:08:39 -0700
Message-ID: <CACdnJusN0XwKAFhCk-z2+u8Wn1OOzbSqQYYACFikcAtFqOA+WA@mail.gmail.com>
Subject: Re: [PATCH 23/27] bpf: Restrict kernel image access functions when
 the kernel is locked down
To:     James Morris <jmorris@namei.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Linux API <linux-api@vger.kernel.org>,
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

On Thu, Mar 28, 2019 at 12:23 PM James Morris <jmorris@namei.org> wrote:
>
> On Thu, 28 Mar 2019, Matthew Garrett wrote:
>
> > On Wed, Mar 27, 2019 at 8:15 PM James Morris <jmorris@namei.org> wrote:
> > > OTOH, this seems like a combination of mechanism and policy. The 3 modes
> > > are a help here, but I wonder if they may be too coarse grained still,
> > > e.g. if someone wants to allow a specific mechanism according to their own
> > > threat model and mitigations.
> >
> > In general the interfaces blocked by these patches could also be
> > blocked with an LSM, and I'd guess that people with more fine-grained
> > requirements would probably take that approach.
>
> So... I have to ask, why not use LSM for this in the first place?
>
> Either with an existing module or perhaps a lockdown LSM?

Some of it isn't really achievable that way - for instance, enforcing
module or kexec signatures. We have other mechanisms that can be used
to enable that which could be done at the more fine-grained level, but
a design goal was to make it possible to automatically enable a full
set of integrity protections under specified circumstances.
