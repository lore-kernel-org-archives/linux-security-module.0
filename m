Return-Path: <SRS0=gHeC=3D=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5320C33CAE
	for <linux-security-module@archiver.kernel.org>; Tue, 14 Jan 2020 02:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A65020CC7
	for <linux-security-module@archiver.kernel.org>; Tue, 14 Jan 2020 02:19:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C5RRpqXM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729211AbgANCTJ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 13 Jan 2020 21:19:09 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38737 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728931AbgANCTI (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 13 Jan 2020 21:19:08 -0500
Received: by mail-pl1-f193.google.com with SMTP id f20so4591905plj.5
        for <linux-security-module@vger.kernel.org>; Mon, 13 Jan 2020 18:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I7aN7Y1nzik1KbsNshiwY6nugyBpWzW8lv7vF97PZQM=;
        b=C5RRpqXMfZpMtG14RRkraQFn1Sb5pbDBSB3Cb3uaNQfi/0xa0jM56TSKBtGYYLNo6n
         tWVPwTFEsCdF+47l7vtn4Fr1RnA6OJhuyLBDUrjWxQQ45xqZS4KPsPekcWf7md5BWqqN
         y4mtINZx/zEAi+nLD+ji9BLOfL2uI46y8ZAOK7cfFJuLd4mjK04x4Ln4RILVBD7LUPxu
         67aj+1E82N427JNXgL467Ozglj20XYvWOSxrkp7QD/dF1/C6tlpKrtB0oay4HWoY6h1l
         6powEnAq0H5y3mvCQXt1bNGGmpkQwichArkoOF08BCpu76t8xY9MMH04iAcDzbD1ZFQ0
         +4oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I7aN7Y1nzik1KbsNshiwY6nugyBpWzW8lv7vF97PZQM=;
        b=sgNipvlmYJjECcA/dDyXEtKwEcyOuzTIWr2EUC2iulBRlWS2nHbR+IXlgjMx+hvLTM
         z2FmFdLuBz1CeUUERrQWT1Lbf25P/LMrsczBqN9EmsdHNGkeNlnqrMFCI3yaosp6LVKh
         xcEZieGAxN4fg2oSd/SF9i2t4HgnBZmOCe5BhcSkY1gkXcKz+FHDmCrmLA43bME5Xg12
         mz0h8qHy3/OyWI0a/iUZT8j0ADW4Fk1zW9kJr0PRbUp7xWUVUJJwE7nJc6KUyzALyQPJ
         cM/GklkZ9kfJn0i0VQCajN1cX4Fx74caUf4SfbE29yr6zbnutAE8MURWQ8poge7AM6uF
         7M7w==
X-Gm-Message-State: APjAAAXagpVO3Zz415GS1pFa3aAui03d7uSOu6fFJPQGLQ83imFriu66
        E+e3JGNd5V9KnvZlN2LN4fl6Ww6+rsVaM2gvmnZfxA==
X-Google-Smtp-Source: APXvYqz+9AZOJJpTU34QiSXSYDhA2HUFGP93xod3rAKylUqbvfH/Pmt8P197RInxMERv7NI/gqMqrsXBuTOaZAiTkLM=
X-Received: by 2002:a17:902:fe8d:: with SMTP id x13mr17804616plm.232.1578968347761;
 Mon, 13 Jan 2020 18:19:07 -0800 (PST)
MIME-Version: 1.0
References: <1578656965-2993-1-git-send-email-alan.maguire@oracle.com> <bb27a03b-1c3d-567b-caf3-7b0e4a039f6d@linuxfoundation.org>
In-Reply-To: <bb27a03b-1c3d-567b-caf3-7b0e4a039f6d@linuxfoundation.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 13 Jan 2020 18:18:56 -0800
Message-ID: <CAFd5g45qfWtB9yp=MZ=79hR7Z+c7r7nsfMeofxzF0WAbzkvxag@mail.gmail.com>
Subject: Re: [PATCH kunit] kunit: building kunit as a module breaks allmodconfig
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Alan Maguire <alan.maguire@oracle.com>,
        Greg KH <gregkh@linuxfoundation.org>, rafael@kernel.org,
        jmorris@namei.org, serge@hallyn.com,
        Knut Omang <knut.omang@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Jan 10, 2020 at 1:39 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> Hi Alan,
>
> On 1/10/20 4:49 AM, Alan Maguire wrote:
> > kunit tests that do not support module build should depend
> > on KUNIT=y rather than just KUNIT in Kconfig, otherwise
> > they will trigger compilation errors for "make allmodconfig"
> > builds.
> >
> > Fixes: 9fe124bf1b77 ("kunit: allow kunit to be loaded as a module")
> > Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> > Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
>
> Thanks for fixing this quickly. For future reference, Signed-off-by
> should be last. I fixed it and applied the patch.

Thanks everyone for taking care of this so quickly in my absence!

Cheers
