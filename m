Return-Path: <SRS0=h0Om=WS=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC854C3A5A1
	for <linux-security-module@archiver.kernel.org>; Thu, 22 Aug 2019 03:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B15F122DD3
	for <linux-security-module@archiver.kernel.org>; Thu, 22 Aug 2019 03:27:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="WKBuPdzo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730856AbfHVD1R (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 21 Aug 2019 23:27:17 -0400
Received: from mail-lj1-f179.google.com ([209.85.208.179]:35613 "EHLO
        mail-lj1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727553AbfHVD1Q (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 21 Aug 2019 23:27:16 -0400
Received: by mail-lj1-f179.google.com with SMTP id l14so4136054lje.2
        for <linux-security-module@vger.kernel.org>; Wed, 21 Aug 2019 20:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UMqmrmnztIq3oZoIN5y14urbqTA1VRquGQl2PhYtfoQ=;
        b=WKBuPdzoUeXIVBh4ocFTP/MUOGYNg3+UiNDxqBA2VqC+niiAbTWDx4V+qeGDzgoPN1
         Ey8lKM7nZk4fErjSWJPEyDBBCjIzVJBVH5XEuWSe9SXcryBFlob6efZ1xhGBC1cyM680
         tES8oSmipuig7WOaEnWSff0NjtLM/AC+JCozi3NPzku5VsCoEzhqTuQNohZ6Ltkr9WUt
         npMCT1wgp+0e1KzmWLP/dP+E5puq7+NM72/mMK6g0C5WeYjuPdTVGpPVCw0FGgP4NpZo
         FG3gJGy9AjHBAMSPpZe3X060YTb9KqMlf59c7GEVzsljA/H+dmcmoIjP4KbcqOewNkZc
         cggw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UMqmrmnztIq3oZoIN5y14urbqTA1VRquGQl2PhYtfoQ=;
        b=tX/6r9gZX7qeIwLx02m4DWOLVLHjDduz4+aFRzSzCECfs/Okjg8LbG0hkp4ZhKyrOt
         SUXwM/rKzJEaHVqQ8XMVfbK+JduXfNSr4944Qx7X8Hzn0ippZ/MXkBozJzCvgklM0psR
         1BMOInLF6uK93r65udbpr5mO77IWzyIbFEup4nioTT7VyRYR5lpUIZo97NVhgwxvCqHa
         l1yt4p4/H5rhgg1PA8cV64kw/Ai3g//CMub2VmIR5uGDWRfY/L5BE+BjX8ylObQJJoxc
         9J2ffuwac/d9tYiJC5wqgm8riBImFIgsUyVPzjjBL7r7HRdcL+fePqkrDekK8G1TgtQX
         dcMw==
X-Gm-Message-State: APjAAAUEeSIPHEMeSsIh2NtFTLd8Y7AqFguYmnOGt1RxAcZifKOm0ZvN
        9d2eEVt4NfsoSoNrTlf0wgiln063y4oxarapz+5B
X-Google-Smtp-Source: APXvYqwWFWOa6QvtUlEtF+xhxZuNZ5uq8pXqPg6Ebrqx66NtE1JLbAxeegRNzwAcatyikvEUkXHd9m5wv7hMvL/aR9I=
X-Received: by 2002:a2e:6393:: with SMTP id s19mr19726675lje.46.1566444434368;
 Wed, 21 Aug 2019 20:27:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhSz1_KA1tCJtNjwK26BOkGhKGbPT7v1O82mWPduvWwd4A@mail.gmail.com>
 <20190821.155013.1723892743521935274.davem@davemloft.net>
In-Reply-To: <20190821.155013.1723892743521935274.davem@davemloft.net>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 21 Aug 2019 23:27:03 -0400
Message-ID: <CAHC9VhRLexftb5mK8_izVQkv9w46m=aPukws2d2m+yrMvHUF_g@mail.gmail.com>
Subject: Re: New skb extension for use by LSMs (skb "security blob")?
To:     David Miller <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Aug 21, 2019 at 6:50 PM David Miller <davem@davemloft.net> wrote:
> From: Paul Moore <paul@paul-moore.com>
> Date: Wed, 21 Aug 2019 18:00:09 -0400
>
> > I was just made aware of the skb extension work, and it looks very
> > appealing from a LSM perspective.  As some of you probably remember,
> > we (the LSM folks) have wanted a proper security blob in the skb for
> > quite some time, but netdev has been resistant to this idea thus far.
> >
> > If I were to propose a patchset to add a SKB_EXT_SECURITY skb
> > extension (a single extension ID to be shared among the different
> > LSMs), would that be something that netdev would consider merging, or
> > is there still a philosophical objection to things like this?
>
> Unlike it's main intended user (MPTCP), it sounds like LSM's would use
> this in a way such that it would be enabled on most systems all the
> time.
>
> That really defeats the whole purpose of making it dynamic. :-/

I would be okay with only adding a skb extension when we needed it,
which I'm currently thinking would only be when we had labeled
networking actually configured at runtime and not just built into the
kernel.  In SELinux we do something similar today when it comes to our
per-packet access controls; if labeled networking is not configured we
bail out of the LSM hooks early to improve performance (we would just
be comparing unlabeled_t to unlabeled_t anyway).  I think the other
LSMs would be okay with this usage as well.

While a number of distros due enable some form of LSM and the labeled
networking bits at build time, vary few (if any?) provide a default
configuration so I would expect no additional overhead in the common
case.

Would that be acceptable?

-- 
paul moore
www.paul-moore.com
