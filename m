Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2C2BC433FE
	for <linux-security-module@archiver.kernel.org>; Fri,  4 Nov 2022 17:01:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbiKDRBz (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 4 Nov 2022 13:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbiKDRBy (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 4 Nov 2022 13:01:54 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB2131FA6
        for <linux-security-module@vger.kernel.org>; Fri,  4 Nov 2022 10:01:52 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id kt23so14859898ejc.7
        for <linux-security-module@vger.kernel.org>; Fri, 04 Nov 2022 10:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jP21lA7uvLWkZHFB3PweSqfiiaYfO5NlBJzGo3ediA8=;
        b=ZcKFG8Hx10GyDnDFUkeABz5vuhbbvikcM5KH3sEr1pJ8IRPNYQmEVj1MVJoMZWO3+i
         7kCfbkkDJyVhOvmLvsmrhIs85U8y1LGr4SEwZOa8E1SnZcUip+09MSOyE++AwGXS/5L3
         s1cII+lSNzsrptz4GtHGcHWpX5uXd9FmwqFQelK4LOjUvT/bYlxKYSUYEqjdE2eH30lu
         OhjOigh3kwdxvli4KrIkGS1SYAGBOBYRVAr2157gKbdYkAyYxiC8txAjW/3533H0eT3C
         JDFdDAgJkQZ8YVzJcyfhySeGxITmKZObygBmYN7+B+UYU4B97Mv2kfjGLi57P1wE9lCX
         Z+0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jP21lA7uvLWkZHFB3PweSqfiiaYfO5NlBJzGo3ediA8=;
        b=jgmig0oJMfliGNb7ajqCz1UPr9xVxsMcTy1YvNDHHvaz7Gh2ijhNxZkFPZRvdrfRPZ
         +i1CURQEU7UaSLxRCFreIsTHVYhaYNhOXqk0MHZdX5jZG2T7jSdLH87XRP94qgFaNtam
         lAX6EdLtxX4amuN5GwXzI8PtAtb/M0Jne3+5ct/xEUE+R3pjYDaC8rUGG1pMT7FghXta
         JxQ1BEAIEtFmUSEK+O5hA3AnAtR9aAl7CTBtOmQVFHF1igG/Dc3hD4WeSmpnnOc77+Yc
         2OGeyTX0OPQcagdBcmir0ljxiS+UptxN3zdKd9QapfCIcDvB3DTADS6YUUzk7ZgK3Zcy
         w7wQ==
X-Gm-Message-State: ACrzQf2zgzOVblR7zMhboQT3uDcvRa5ZHbngGQNhLmUUOZtHigWw4zEx
        wzdT69yYTBoTsGEhpUUNFB2lGBVG9oQ=
X-Google-Smtp-Source: AMsMyM5xdwjXf6h/fDjvPtmrHnF67uL77pZzEb777c3XJ+fLTyK6AVbmGleuhJuFdM+36EsENFGI6g==
X-Received: by 2002:a17:906:195b:b0:7ae:108:9729 with SMTP id b27-20020a170906195b00b007ae01089729mr15100662eje.604.1667581311224;
        Fri, 04 Nov 2022 10:01:51 -0700 (PDT)
Received: from nuc ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id sd15-20020a1709076e0f00b0073d7ab84375sm2099431ejc.92.2022.11.04.10.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 10:01:50 -0700 (PDT)
Date:   Fri, 4 Nov 2022 18:01:49 +0100
From:   =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     linux-security-module@vger.kernel.org
Subject: Re: [PATCH] samples/landlock: Document best-effort approach for
 LANDLOCK_ACCESS_FS_REFER
Message-ID: <Y2VFfdAdTY7b47D7@nuc>
References: <20221030061107.2351-1-gnoack3000@gmail.com>
 <cbe72a75-b077-e5d2-52a8-db20432e15bc@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cbe72a75-b077-e5d2-52a8-db20432e15bc@digikod.net>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Nov 03, 2022 at 03:21:32PM +0100, Mickaël Salaün wrote:
> On 30/10/2022 07:11, Günther Noack wrote:
> > Add a comment to clarify how to handle best-effort backwards
> > compatibility for LANDLOCK_ACCESS_FS_REFER.
> > 
> > The "refer" access is special because these operations are always
> > forbidden in ABI 1, unlike most other operations, which are permitted
> > when using Landlock ABI levels where they are not supported yet.
> > 
> > Signed-off-by: Günther Noack <gnoack3000@gmail.com>
> > ---
> >   samples/landlock/sandboxer.c | 16 +++++++++++++++-
> >   1 file changed, 15 insertions(+), 1 deletion(-)
> > 
> > diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
> > index fd4237c64fb2..901acb383124 100644
> > --- a/samples/landlock/sandboxer.c
> > +++ b/samples/landlock/sandboxer.c
> > @@ -234,7 +234,21 @@ int main(const int argc, char *const argv[], char *const *const envp)
> > +		 * If only ABI 1 is available, the sample tool knowingly forbids
> 
> s/the sample tool/this sandboxer/
> 
> > +		 * refer operations.
> > +		 *
> > +		 * If a program *needs* to do refer operations after enabling
> > +		 * Landlock, it can not use Landlock at ABI level 1.  To be
> > +		 * compatible across different kernels, such programs should
> > +		 * fall back to not using Landlock instead.
> 
> To be compatible with different kernel versions, such programs should then
> fall back to not restrict themselves at all if the running kernel only
> supports ABI 1.

Thanks for the review, Mickaël! Both suggestions applied, and sent V2.

—Günther

-- 
