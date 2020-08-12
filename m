Return-Path: <SRS0=RtEY=BW=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30135C433DF
	for <linux-security-module@archiver.kernel.org>; Wed, 12 Aug 2020 02:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05151206DA
	for <linux-security-module@archiver.kernel.org>; Wed, 12 Aug 2020 02:11:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="VeOPEJnK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbgHLCLB (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 11 Aug 2020 22:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726355AbgHLCLB (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 11 Aug 2020 22:11:01 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8AA0C06174A
        for <linux-security-module@vger.kernel.org>; Tue, 11 Aug 2020 19:11:00 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id c16so511744ejx.12
        for <linux-security-module@vger.kernel.org>; Tue, 11 Aug 2020 19:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZxKVvYU8oJvuGMKFb+gkPZUt5/Nd4hHk74vOhULNnxQ=;
        b=VeOPEJnK8z1LXt6c1mfkr605C86+SD3itLl9dfyht1RCNzhDDGuqwLBvWE0TMXTKXX
         saM1x9OuDdayNLdXSVQ0OmXDC8/0hrNCuZpRNfWP+tMJz/Jib64KmwethcTYo79qofNf
         yI8hlY/8Zm9lYR4Ge5r6AqYo3Pt0tE1I+4lkEzwAnaPf/o8t5gKnbX/kDo96K9WddPvq
         x6TpLeWVyBkvM5XnDDvShqPppj1Kpq1+GxDcyU+cR7uE7HqBgFmuLTLp0KmKJMBbNSrR
         AyNVcfuGJv6TxJgPTmUfEFcm2/AzaGU7KRY1I9DI6TfpnXigguoU9LKvh4GxAGFdzEyf
         ZWcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZxKVvYU8oJvuGMKFb+gkPZUt5/Nd4hHk74vOhULNnxQ=;
        b=F6VtVQJ1Dk6zpvUhoL06SszCp7Wm2xMrLyoLSlkzeKf0XHQIntcy0rcJAv9gZqnA6n
         K+lmxSusMcafD7+ll3qgOwgK4oTpzE+N2OYULcdZ5fEUjx5HRp+oaqGevs6jQxoEUB5/
         ReWPIeTDW7R4V/VAtWsWXWUA6LXtFBTj3E/TEFeYAN7oIJPhaPNUTO0a77G1izosXFMU
         HJs5yqfg4PKeokLCqAbOreQJ0+qPcWdRyCswtZ5uaUQWlN2e3sVzraXKKM/EPJkCd8RL
         l/YCeBxndJenRzZgReVw9xfBfujtow3XcrZ1FfJF1EiJ/0WnZAs+SyXbT1OUchn5eAv+
         4Vhg==
X-Gm-Message-State: AOAM532NUCOTmkiSb6jd/CXfFWCt54S6T+40S7nWZBe39RKphfuCfSuH
        DssF5K9Rl8PoSf2txkIeZH4dFAxpwAlKORcWgDiR
X-Google-Smtp-Source: ABdhPJxZouSrkE7i+bzPsxps6Qp3XV/apv2D0WYE/69wpOcCf23/KCf9g8PlMmYt4rzIg9NnPwcu5DgS+LZoB4hBBpc=
X-Received: by 2002:a17:907:20e1:: with SMTP id rh1mr10671435ejb.106.1597198259432;
 Tue, 11 Aug 2020 19:10:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200812003943.3036-1-casey.ref@schaufler-ca.com> <20200812003943.3036-1-casey@schaufler-ca.com>
In-Reply-To: <20200812003943.3036-1-casey@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 11 Aug 2020 22:10:48 -0400
Message-ID: <CAHC9VhTq66h1LsNBuhXG6WFiKn7hCBApciG6sVawW=jDwqDDWg@mail.gmail.com>
Subject: Re: [PATCH 0/3] Smack: Use the netlbl incoming cache
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     SMACK-discuss@lists.01.org, casey.schaufler@intel.com,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Aug 11, 2020 at 8:39 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> Update the Smack security module to use the Netlabel cache
> mechanism to speed the processing of incoming labeled packets.
> There is some refactoring of the existing code that makes it
> simpler, and reduces duplication. The outbound packet labeling
> is also optimized to track the labeling state of the socket.
> Prior to this the socket label was redundantly set on each
> packet send.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  security/smack/smack.h        |  19 ++--
>  security/smack/smack_access.c |  55 ++++++----
>  security/smack/smack_lsm.c    | 245 ++++++++++++++++++++++++------------------
>  security/smack/smackfs.c      |  23 ++--
>  4 files changed, 193 insertions(+), 149 deletions(-)

FWIW, I gave this a cursory look just now and the NetLabel usage
seemed reasonable.  Out of curiosity, have you done any before/after
performance tests?  It was quite significant when we adopted it in
SELinux, but that was some time ago, it would be nice to know that it
is still working well and hasn't been invalidated by some other,
unrelated change.

-- 
paul moore
www.paul-moore.com
