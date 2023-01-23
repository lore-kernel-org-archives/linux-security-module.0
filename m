Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6B2FC38142
	for <linux-security-module@archiver.kernel.org>; Mon, 23 Jan 2023 21:04:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232813AbjAWVEA (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 23 Jan 2023 16:04:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232543AbjAWVD7 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 23 Jan 2023 16:03:59 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F8636093
        for <linux-security-module@vger.kernel.org>; Mon, 23 Jan 2023 13:03:57 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id dw9so12845110pjb.5
        for <linux-security-module@vger.kernel.org>; Mon, 23 Jan 2023 13:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QYRKS6tK0AlWUYVU3JpIqYKEaEflzI/5b9bQPlwSQRk=;
        b=RQJpS5bvHF4bxpPevxaJjNW3kpOhnZzXPQGREFopGamxR7V572BdQUe4yPrg8PUVsd
         zFzcPI2g0DbV0kWC1xfx50eoLy2Nn/YHpllWhCHCA1NPVYz7oJnQrktxBVsJe6T1e+V8
         p1c+ycDNxaZnW0SDTwbjdRWLossVWgxd5bLaU4Qq2ezwha56am0ywXzm0rgui6vsXkc9
         5wW6a/smQp3381B4MXFvGbvAoVO8ekkw8orzE8EDSsTJUknsKutErStCvDlkj54w76BB
         YRBtgncznYske9y2p7AEf6SzbFhv4RiC/GmH4ActQD0mCR3x0zhNg5jVmQP2R5I3APFP
         6rUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QYRKS6tK0AlWUYVU3JpIqYKEaEflzI/5b9bQPlwSQRk=;
        b=MMbfUp0Bo6JRo4JEyksOpfCps0H5O3xqpBSquGozRrpL4Pk/kDT2P1NWaZIL2XKo46
         96RdxHEvFHvgaFh+7lvVmRiBn7cG0fbYBKGjuWPdN+owS5nfFMPY0lBybE9oodntjAQU
         8lRoFxUpSqwE3IcLaB3XZr6E5XLtXu2rFhsz+dBLOZf40siLzUE30cUPl9t9OV/QEH1A
         4cZzQ57tMz7YMBxyEYBCzBjOd+sChHVjj8zlTw6PHgB1FI6tHXaGmO2MRiIk6hp6SwMA
         xDmFOn51lN7WBZ/odFgdDRgbMD8smMy0IDLbQIEELvPRUkPTKg4b7dNRV9x5QephPyJm
         yTyA==
X-Gm-Message-State: AFqh2kqbfpnibmJnwKZX2zLlk7T7xAnKU3GlDZJbGd1HSsGzBwu32CLp
        rSoxIh+F18w5KqH3GVa4F2aO0Qv3zM40RTZRw3pM
X-Google-Smtp-Source: AMrXdXux2G/SuTCc/RUxY/DLSxHTuuQuPv2N05DFnASMKwMSo03QpwuFQI1Y9345VD/C3jEW3vlPiDkvTVqmGTEGkio=
X-Received: by 2002:a17:90a:17a1:b0:229:9ffe:135b with SMTP id
 q30-20020a17090a17a100b002299ffe135bmr2899277pja.72.1674507837468; Mon, 23
 Jan 2023 13:03:57 -0800 (PST)
MIME-Version: 1.0
References: <20221221141007.2579770-1-roberto.sassu@huaweicloud.com>
 <CAHC9VhQUAuF-Fan72j7BOqOdLE=B=mJpJ_GpR5p5cUmXruYT=Q@mail.gmail.com>
 <4b8688ee3d533d989196004d5f9f2c7eb4093f8b.camel@huaweicloud.com>
 <CAHC9VhSamRVpgrDrSuc2dsbbw3-pvjDi9BsFWoWssHkAD2W5vA@mail.gmail.com>
 <a764acb285d0616c8608eaab8671ceb9c22cb390.camel@huaweicloud.com>
 <058f1bdf4ba75c3a00918cefbf1be32477b51639.camel@linux.ibm.com>
 <e1a1fe029aea21ba533cb6196e64f29c7b052c57.camel@huaweicloud.com>
 <CAHC9VhT--Q8QkFmKTpD3zjryDL19V9myfr3PuzSRo_bDzDRyqQ@mail.gmail.com> <dfb387003ee50db5fe0d71bc825cc39df47f74ed.camel@huaweicloud.com>
In-Reply-To: <dfb387003ee50db5fe0d71bc825cc39df47f74ed.camel@huaweicloud.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 23 Jan 2023 16:03:46 -0500
Message-ID: <CAHC9VhSkx58Q=U8GfyCSn5MvRv95myOwu9yweoYsG82a7K3oCQ@mail.gmail.com>
Subject: Re: [PATCH v2] security: Restore passing final prot to ima_file_mmap()
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, jmorris@namei.org,
        serge@hallyn.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        Roberto Sassu <roberto.sassu@huawei.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Jan 23, 2023 at 3:30 AM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
> On Fri, 2023-01-20 at 16:04 -0500, Paul Moore wrote:
> > On Fri, Jan 13, 2023 at 5:53 AM Roberto Sassu
> > <roberto.sassu@huaweicloud.com> wrote:
> > > On Thu, 2023-01-12 at 12:45 -0500, Mimi Zohar wrote:
> > > > On Thu, 2023-01-12 at 13:36 +0100, Roberto Sassu wrote:
> > > > > On Wed, 2023-01-11 at 09:25 -0500, Paul Moore wrote:
> > > > > > On Wed, Jan 11, 2023 at 4:31 AM Roberto Sassu
> > > > > > <roberto.sassu@huaweicloud.com> wrote:
> > > > > > > On Fri, 2023-01-06 at 16:14 -0500, Paul Moore wrote:
> > > > > > > > On Wed, Dec 21, 2022 at 9:10 AM Roberto Sassu
> > > > > > > > <roberto.sassu@huaweicloud.com> wrote:
> > > > > > > > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > > > > > > > >
> > > > > > > > > Commit 98de59bfe4b2f ("take calculation of final prot in
> > > > > > > > > security_mmap_file() into a helper") moved the code to update prot with the
> > > > > > > > > actual protection flags to be granted to the requestor by the kernel to a
> > > > > > > > > helper called mmap_prot(). However, the patch didn't update the argument
> > > > > > > > > passed to ima_file_mmap(), making it receive the requested prot instead of
> > > > > > > > > the final computed prot.
> > > > > > > > >
> > > > > > > > > A possible consequence is that files mmapped as executable might not be
> > > > > > > > > measured/appraised if PROT_EXEC is not requested but subsequently added in
> > > > > > > > > the final prot.
> > > > > > > > >
> > > > > > > > > Replace prot with mmap_prot(file, prot) as the second argument of
> > > > > > > > > ima_file_mmap() to restore the original behavior.
> > > > > > > > >
> > > > > > > > > Cc: stable@vger.kernel.org
> > > > > > > > > Fixes: 98de59bfe4b2 ("take calculation of final prot in security_mmap_file() into a helper")
> > > > > > > > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > > > > > > > > ---
> > > > > > > > >  security/security.c | 2 +-
> > > > > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > > > > >
> > > > > > > > > diff --git a/security/security.c b/security/security.c
> > > > > > > > > index d1571900a8c7..0d2359d588a1 100644
> > > > > > > > > --- a/security/security.c
> > > > > > > > > +++ b/security/security.c
> > > > > > > > > @@ -1666,7 +1666,7 @@ int security_mmap_file(struct file *file, unsigned long prot,
> > > > > > > > >                                         mmap_prot(file, prot), flags);
> > > > > > > > >         if (ret)
> > > > > > > > >                 return ret;
> > > > > > > > > -       return ima_file_mmap(file, prot);
> > > > > > > > > +       return ima_file_mmap(file, mmap_prot(file, prot));
> > > > > > > > >  }
> > > > > > > >
> > > > > > > > This seems like a reasonable fix, although as the original commit is
> > > > > > > > ~10 years old at this point I am a little concerned about the impact
> > > > > > > > this might have on IMA.  Mimi, what do you think?
> >
> > So ... where do we stand on this patch, Mimi, Roberto?  I stand by my
> > original comment, but I would want to see an ACK from Mimi at the very
> > least before merging this upstream.  If this isn't ACK-able, do we
> > have a plan to resolve this soon?
>
> Sorry, I had business trips last week. Will send the patches this week.

No worries, I just wasn't sure of the status and wanted to check in on this.

-- 
paul-moore.com
