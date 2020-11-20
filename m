Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88790C5519F
	for <linux-security-module@archiver.kernel.org>; Fri, 20 Nov 2020 05:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B20A2237B
	for <linux-security-module@archiver.kernel.org>; Fri, 20 Nov 2020 05:03:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725829AbgKTFDg (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 20 Nov 2020 00:03:36 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35108 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725208AbgKTFDg (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 20 Nov 2020 00:03:36 -0500
Received: by mail-qt1-f196.google.com with SMTP id t5so6345577qtp.2
        for <linux-security-module@vger.kernel.org>; Thu, 19 Nov 2020 21:03:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pi2oe6/BxPHqHcfD/n2FOnSt8intvrKAKlw7Go9DLCw=;
        b=VqnINHU00/TVZnVXz7nJ/nRFSZqFD7xAmLvHguXO/fuFgWzEBtDQRLRqLZlnp0trUP
         PMivWR2cVcxJ2R+QNcn5EgDmP4+C+DjJ2LqD6UzAyRN04LBvrGrDUOTwzeFRcVnrroNM
         XfzHKvC3TLQPbpMxEBuA3dMVHSRSfF6QB4DwxMUMeXNodWsqMiXTLxfoSWpXJu+ewUjm
         lm4sBu4MsgJIoV8HNUTPNrpnuQ1FvtLFBccDi2WIcXmEV+1q9ZxpeVWI8itMo0j7ylOL
         f32o3kBPjI236bRgIK035h+T0L6gEYWwJKrcWaBIqSWy11I+pcIE+PsZf//8JYsWviD2
         T10A==
X-Gm-Message-State: AOAM532Y7hmAVGfSR51tqzvZM/1CEcjKt/zK5IsWFjB3q2KTgluEtF4l
        UbCzyJqDEINIHN5Vmj2QZu20/N80bi2Zfu9SgX43UQ==
X-Google-Smtp-Source: ABdhPJxY1c2aMolVfvvT9PFcWZSVhQNjQXgaGtPuLoiGf0LRkSie0w3FYSvtSaquvS/ukavW5zl3nbaBcj1r8cs0dnQ=
X-Received: by 2002:ac8:1288:: with SMTP id y8mr14224869qti.177.1605848615435;
 Thu, 19 Nov 2020 21:03:35 -0800 (PST)
MIME-Version: 1.0
References: <20201117150856.GA12240@mail.hallyn.com> <CALQRfL5UzUt0YkKDAguETmdXM7qsPC9sGmsgutQ-P2cymPte-w@mail.gmail.com>
 <alpine.LRH.2.21.2011201419210.20300@namei.org>
In-Reply-To: <alpine.LRH.2.21.2011201419210.20300@namei.org>
From:   "Andrew G. Morgan" <morgan@kernel.org>
Date:   Thu, 19 Nov 2020 21:03:23 -0800
Message-ID: <CALQRfL5usVijE_HxwgiW6qKKjLsJwqzcKU_W5C13B12qC-8c+A@mail.gmail.com>
Subject: Re: [PATCH] fix namespaced fscaps when !CONFIG_SECURITY
To:     James Morris <jmorris@namei.org>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>,
        lkml <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Herv=C3=A9_Guillemet?= <herve@guillemet.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Reviewed-by: Andrew G. Morgan <morgan@kernel.org>

Works for me too.

On Thu, Nov 19, 2020 at 7:20 PM James Morris <jmorris@namei.org> wrote:
>
> On Tue, 17 Nov 2020, Andrew G. Morgan wrote:
>
> > Signed-off-by: Andrew G. Morgan <morgan@kernel.org>
>
> This should be Acked-by or Reviewed-by, unless this is your patch, or it
> came via your tree.
>
>
> --
> James Morris
> <jmorris@namei.org>
>
