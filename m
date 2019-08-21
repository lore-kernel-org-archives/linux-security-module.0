Return-Path: <SRS0=EETi=WR=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 015E1C3A5A1
	for <linux-security-module@archiver.kernel.org>; Wed, 21 Aug 2019 22:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C146A206DD
	for <linux-security-module@archiver.kernel.org>; Wed, 21 Aug 2019 22:00:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="Wv33EjD8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbfHUWAX (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 21 Aug 2019 18:00:23 -0400
Received: from mail-lj1-f169.google.com ([209.85.208.169]:40072 "EHLO
        mail-lj1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727923AbfHUWAW (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 21 Aug 2019 18:00:22 -0400
Received: by mail-lj1-f169.google.com with SMTP id e27so3594245ljb.7
        for <linux-security-module@vger.kernel.org>; Wed, 21 Aug 2019 15:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=UtLPTpmziN33YG4O4Q+fjJadZXwsjUnQKgfuJCB6e30=;
        b=Wv33EjD8K7IOFULJM+TWEQSabao5/oqiMjnkyfl+6HMstEOSL21yE53KCLaJPidc0q
         9qQfmolCwTV5Ek7i6WXu9us2CqOrFlqzfDi6IbIeX5BjL9wLsQzc8V1hBpm3xAARaQf+
         Oga/EyMhUtNF36RfXc/LeFK2p99pwVJ4Le5o3nDYYFhbiY2AjRaNZBXXGQjOAszNS5oK
         x5kqhOXZTj3hO9PsmEr0X8PmJhX7gtV4ye515mRAs+e0iC0iWEn9/nGXCvOoV2j/dlPU
         fC5cVbqPsWu16g8XTObBhnsp0ywWzJ2r/i6l7YtdXrK8fZoGJiWCgNeQgFNgLX0lPPv7
         ASwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=UtLPTpmziN33YG4O4Q+fjJadZXwsjUnQKgfuJCB6e30=;
        b=BoJau8BV49xK+0PVgG0cgEJjCCdQvwcdrgc12Gp778zWG571cF3lIM2j1v3td2WVVb
         hljMKed+gEyjyi4V2xWY5dz9B34hQGk3dYEIcdjlWaIu03n8w3j+gu0o30OWLOtOvjCb
         TPf1lVvW/MsAWZoWg/N+pNd6FqG90oNBBH+PQgpw8OpW6/Bubb4iGdi4OyeDx00Zzoxv
         1CLipETA717nrMPNqvBzmtQ1ficPc8SlwC9lBdryHfJnrvcxsjCh9GjZ+SpO9pQd0PYg
         Kc4Aq6b0msyowZZuxr1oLCntnIxUKZHWqApUW2efp31EO8mUoWuOaXcLwoVDr9gkp8xx
         1z8Q==
X-Gm-Message-State: APjAAAWFy+ThZe8TYhvS0e+CcFooCPwrUNjRzw35HRQAPTc6+aTho+ce
        bsvBYZG4TB+QuoHgDlXiUPDAHUhnrKfdh5MYgw9J6GtkqPzz
X-Google-Smtp-Source: APXvYqzkHSMhD3XMQ8GKHBBdvLF/0nj7DXZcIfPjPF24ezy7vpBJXXOuH0d3+RQVZvlHi4Wx+J41C7uj7eWbUoJtCuA=
X-Received: by 2002:a05:651c:1111:: with SMTP id d17mr12865350ljo.87.1566424820383;
 Wed, 21 Aug 2019 15:00:20 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 21 Aug 2019 18:00:09 -0400
Message-ID: <CAHC9VhSz1_KA1tCJtNjwK26BOkGhKGbPT7v1O82mWPduvWwd4A@mail.gmail.com>
Subject: New skb extension for use by LSMs (skb "security blob")?
To:     netdev@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hello netdev,

I was just made aware of the skb extension work, and it looks very
appealing from a LSM perspective.  As some of you probably remember,
we (the LSM folks) have wanted a proper security blob in the skb for
quite some time, but netdev has been resistant to this idea thus far.

If I were to propose a patchset to add a SKB_EXT_SECURITY skb
extension (a single extension ID to be shared among the different
LSMs), would that be something that netdev would consider merging, or
is there still a philosophical objection to things like this?

-- 
paul moore
www.paul-moore.com
