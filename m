Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EFF3C432BE
	for <linux-security-module@archiver.kernel.org>; Tue, 24 Aug 2021 09:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83752613A7
	for <linux-security-module@archiver.kernel.org>; Tue, 24 Aug 2021 09:25:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235702AbhHXJZq (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 24 Aug 2021 05:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235573AbhHXJZq (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 24 Aug 2021 05:25:46 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 243AEC061757;
        Tue, 24 Aug 2021 02:25:02 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id i28so44100263lfl.2;
        Tue, 24 Aug 2021 02:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=nwu918g+3reOoNHiDGpGGM+XCkkFZ7Cu/Ig0jIItvfw=;
        b=Lr57Wy2KJTgCUeRM4bHwFMu7Ke8etSHc1lk02RrvSjf2U4InVLDe1sxJq78eO6Vdtd
         ar34gui90itB4or/q84N5dcmhUfuNSw45RNOfj9LK8YnroKtieyeRYKX1N+MOx+6/PkE
         uD/r/2FYFzB+gl+zAePH6ZzYeslStzjKQgyj6DCqifnxRL3Q2MHYd5zavy9Y6BxsMocZ
         cv4B4EWw1nAnN6MLJwUP1bZ0WGUZp1ObAsSwmCkehP2dIg4Dazg6sXZMvNNcNA75/kvE
         qu88iOhxLDE0cYDQ28oDViBp/DzvXvu1Jum5HNgy4FJQMksuFDSwMGmtVW2DWPKoDkFR
         M1GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=nwu918g+3reOoNHiDGpGGM+XCkkFZ7Cu/Ig0jIItvfw=;
        b=ks3mPfqsbwrBFjDZDszvOoKNPboxHlsiTMiA2db8CVD4t51ORxbefKpt+g5fTm59Ld
         ++WietcwOad/5XJpgWCDkc8YpS6842fyrj0e4UlbtXBhRMwnanD8Xwatu+dvbVm7nrdf
         fyM7LJwfdppms3mUeK1lEdqm2vdut+5nJLjFtWbdoGqU0ZD+YZ7k504Hnq8jsBONp9xU
         RLk9rn/Ec0BPwqnECnp9mbD/x1+Gj+GhcPFD/QuYjdEgphAZlg9gMK2jsot/pLXYp5vS
         eIyhwYULRGKF+PZAoNQ7SK78Aez5CTGCghgqbIl5Qid/EbUwxVBPW8XtlMTU+kXJzRsX
         B3eQ==
X-Gm-Message-State: AOAM5305dtdoYKk+y7kQpmnROxTnL9nlBWNFC7L4+0pBGfA/B1dv2y1l
        uRC4rOjImDdm1m7XLWKq459BUglULwafcNGipAqxGJTvIeqFIQ==
X-Google-Smtp-Source: ABdhPJzzel5RtGt0KjjRIGwGCq9I37ekbVhe3jegqxiKeo/+kCjRwrES3uP7IzflYkE0SJf9fuWwpbtzTtZaGucKiP4=
X-Received: by 2002:a05:6512:1041:: with SMTP id c1mr28272075lfb.277.1629797100498;
 Tue, 24 Aug 2021 02:25:00 -0700 (PDT)
MIME-Version: 1.0
From:   Igor Zhbanov <izh1979@gmail.com>
Date:   Tue, 24 Aug 2021 12:25:00 +0300
Message-ID: <CAEUiM9O45SB1WM=L7XuMYQv0q8-Yq9hK_Sqc-4aC9TkXr6-hUw@mail.gmail.com>
Subject: Writes to /proc/self/mem and file_mprotect() LSM hook
To:     linux-security-module <linux-security-module@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hello,

There are several ways to write data to write-protected page. For example,
a process can write to /proc/self/mem to change read-only or even executable
pages: https://offlinemark.com/2021/05/12/an-obscure-quirk-of-proc/

In this case, the kernel code will map the physical page with another access
mode and change the data (FOLL_FORCE flag will ignore the access check). The
problem is that no security hooks are called in this case. For example, the
file_mprotect() LSM hook was designed to intercept process' attempts to
remap memory pages. Particularly SELinux and IMA controlling, if a process
is trying to make a code page writable. And this method allows to bypass it.

Therefore, my question is, should all page modifications that ignores the
protection mode call LSM hook prior to temporarily remapping the page?

Thanks.
