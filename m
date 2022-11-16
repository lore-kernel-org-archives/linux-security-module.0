Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02511C433FE
	for <linux-security-module@archiver.kernel.org>; Wed, 16 Nov 2022 19:18:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233163AbiKPTSL (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 16 Nov 2022 14:18:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiKPTSL (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 16 Nov 2022 14:18:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7176153EF6
        for <linux-security-module@vger.kernel.org>; Wed, 16 Nov 2022 11:18:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0DD8D61F69
        for <linux-security-module@vger.kernel.org>; Wed, 16 Nov 2022 19:18:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E0B9C43150
        for <linux-security-module@vger.kernel.org>; Wed, 16 Nov 2022 19:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668626289;
        bh=FWxV5cOhm3yOOlmNt1Kx1v7jIiHG6J6Wyzkt+Su/K0U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XZLkMROXqq0DqoUmuUMyorNGjz09RV32m3SFoYg1FViWvtgupf36lHbLUL06Lm2Ba
         fOJxWwPBzsOPScKghVN4eXkyIUm3L5EmBY9jGZht+Fp/WL82UX8ysvdmibGPVIBNPw
         nw4V/h3mDzsChRJQA8qm3tuKeMqCEvE/Xj25rLWl1NVlZq4TaenuLgaBZJncMfe1HQ
         ZmXBT5BjtDuvJ+FR7Pp4+jt5GLuzgEtOO5KNcf7EC+eBqo9BbyJmtqE/iVRFCmnUbG
         /mchCv4a0rvtsVMk7+g3wgiwJ9HdSUQqLsuKP9KntoSKFgCr66nMErMl5xqOGFYR/5
         s0qGWPgY2cwew==
Received: by mail-lj1-f169.google.com with SMTP id k19so23119763lji.2
        for <linux-security-module@vger.kernel.org>; Wed, 16 Nov 2022 11:18:09 -0800 (PST)
X-Gm-Message-State: ANoB5pmVih6YX83Cah/5rlkhdbK/+cdDPN2Wpc9kT5AnZxtBdZQsWYzP
        KNHwDYl98n7fSADCwSUj/UXHDhQieVo4Q3nLDkGQ+A==
X-Google-Smtp-Source: AA0mqf7PG0dBZO8iorKSEIMF0hXEjFNMGwElj5QH9Zt3D/JxRv5uBgb2JAvG2OWvxypTy7vE24n3ktmivq0WZ65txLI=
X-Received: by 2002:a2e:3606:0:b0:277:b84:81b6 with SMTP id
 d6-20020a2e3606000000b002770b8481b6mr7831300lja.425.1668626287137; Wed, 16
 Nov 2022 11:18:07 -0800 (PST)
MIME-Version: 1.0
References: <20221115175652.3836811-1-roberto.sassu@huaweicloud.com>
 <20221115175652.3836811-2-roberto.sassu@huaweicloud.com> <CAHC9VhQjnwbFgAoFgTaLQP7YnNDNyP1i0i8H++HZWj930pW=-A@mail.gmail.com>
 <18e375adfe53f8ce5fb38a6a146ad06eaec71a5e.camel@huaweicloud.com>
In-Reply-To: <18e375adfe53f8ce5fb38a6a146ad06eaec71a5e.camel@huaweicloud.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Wed, 16 Nov 2022 20:17:56 +0100
X-Gmail-Original-Message-ID: <CACYkzJ43UZARCkWp6wOQuuEDpOnf33JwAJ=CeZVuW0hffQrmeQ@mail.gmail.com>
Message-ID: <CACYkzJ43UZARCkWp6wOQuuEDpOnf33JwAJ=CeZVuW0hffQrmeQ@mail.gmail.com>
Subject: Re: [RFC][PATCH 1/4] lsm: Clarify documentation of vm_enough_memory hook
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     Paul Moore <paul@paul-moore.com>, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        revest@chromium.org, jackmanb@chromium.org, jmorris@namei.org,
        serge@hallyn.com, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Nov 16, 2022 at 9:06 AM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> On Tue, 2022-11-15 at 21:11 -0500, Paul Moore wrote:
> > On Tue, Nov 15, 2022 at 12:57 PM Roberto Sassu
> > <roberto.sassu@huaweicloud.com> wrote:
> > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > >
> > > include/linux/lsm_hooks.h reports the result of the LSM infrastructure to
> > > the callers, not what LSMs should return to the LSM infrastructure.
> > >
> > > Clarify that and add that returning 1 from the LSMs means calling
> > > __vm_enough_memory() with cap_sys_admin set, 0 without.
> > >
> > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > > Reviewed-by: KP Singh <kpsingh@kernel.org>
> > > ---
> > >  include/linux/lsm_hooks.h | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> > > index 4ec80b96c22e..f40b82ca91e7 100644
> > > --- a/include/linux/lsm_hooks.h
> > > +++ b/include/linux/lsm_hooks.h
> > > @@ -1411,7 +1411,9 @@
> > >   *     Check permissions for allocating a new virtual mapping.
> > >   *     @mm contains the mm struct it is being added to.
> > >   *     @pages contains the number of pages.
> > > - *     Return 0 if permission is granted.
> > > + *     Return 0 if permission is granted by LSMs to the caller. LSMs should
> > > + *     return 1 if __vm_enough_memory() should be called with
> > > + *     cap_sys_admin set, 0 if not.
> >
> > I think this is a nice addition, but according to the code, any value
> > greater than zero will trigger the caller-should-have-CAP_SYS_ADMIN
> > behavior, not just 1.  I suggest updating the comment.
>
> Ok, yes. Thanks.

Also, this is an unrelated patch and you can probably send it
independently, especially
since the other changes will now land mostly via BPF.

>
> Roberto
>
