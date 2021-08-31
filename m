Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF90C432BE
	for <linux-security-module@archiver.kernel.org>; Tue, 31 Aug 2021 19:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11F7E61074
	for <linux-security-module@archiver.kernel.org>; Tue, 31 Aug 2021 19:15:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240378AbhHaTQu (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 31 Aug 2021 15:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239694AbhHaTQq (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 31 Aug 2021 15:16:46 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2491BC061575
        for <linux-security-module@vger.kernel.org>; Tue, 31 Aug 2021 12:15:50 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id n27so1116112eja.5
        for <linux-security-module@vger.kernel.org>; Tue, 31 Aug 2021 12:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LRu3w/aDjbu6nLXcWdhVb0x5w4DgW1rHwaWns4vHGkU=;
        b=GrVqDCWJ47WFtA6A/pcjE82vFKjlsZc9KXICG7aYWtOShZDbJ0baMSf/Dlzk/7vlSI
         0XBAix2NF04DaYHYtpYbMeILbThYSlInegJ90RrRM4zDkW/tTN+FPIF9W/l5y+xT1ew3
         UhGcbua7lKtiqp73fOVxDaKyLsxBXleFr0wDw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LRu3w/aDjbu6nLXcWdhVb0x5w4DgW1rHwaWns4vHGkU=;
        b=Y4SjhZ8XG+fZm6FKb9YPj1E70gFXVa+BnUCwaflBJiomMMIZJRxHaVBXkMNauhgTuj
         lQpKeXp54wdJpaKuy/V1buWtTpWVgaUB113RVIKDLgQnoTIvmiJ2SlX+s9Fj0n6DW464
         gkpDUT4lPfKUN34qTn6p/EQTMvOkPlx89UAhI5/WTFnmqicBwGzbVHRVvjqUxDBw/5fH
         p4rqTpqLBFLs2E+dZ2taph0cberVbOkMYmXPF/7gAMGt+87A253YtmjnkPvJmni4DdtJ
         6Nsp0B9qagcmAeXNYRhxFsT11L6dLcIGLWPOkGvzCsx92LCn14aT7qTHhH//XUmYgpG3
         oQzQ==
X-Gm-Message-State: AOAM53252mE6NtiF7lAVyoMrBjX0tYlu8ozR8x7d3LO0HzOnfLhltZxP
        dilA8GTD0Zx9wagEntNGlqKgCgh8EASqmT7htTVc3JGsvwpldnKV
X-Google-Smtp-Source: ABdhPJwDXEk0fhlWloCFjxuKx6dWx6wpwmrkENdBVL0IulLdcZuW7RYsFEQG72VCjSxfpqJiUVnqdLeDbkbx/CG//+Q=
X-Received: by 2002:a17:906:5855:: with SMTP id h21mr31467671ejs.230.1630437348629;
 Tue, 31 Aug 2021 12:15:48 -0700 (PDT)
MIME-Version: 1.0
References: <ff60d9aa-28b9-9c6d-f318-94dd51a95abd.ref@schaufler-ca.com> <ff60d9aa-28b9-9c6d-f318-94dd51a95abd@schaufler-ca.com>
In-Reply-To: <ff60d9aa-28b9-9c6d-f318-94dd51a95abd@schaufler-ca.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 31 Aug 2021 12:15:37 -0700
Message-ID: <CAADWXX9A-6R13VAekvzvWYGcy990nLxcyz1BiZyeBpKHivtCqg@mail.gmail.com>
Subject: Re: [GIT PULL] Smack patches for v5.15
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Austin Kim <austindh.kim@gmail.com>,
        Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Aug 31, 2021 at 11:53 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> Here is the Smack pull request for v5.15.

Hmm. This went into my spambox.

I have no idea why. Everything looks ok as far as I can tell, although
having a SPF record for the originating host might have helped.

It also doesn't look like you are doing anything new wrt your email
setup, even if that yahoo web mail thing might be a bit unusual.

It *might* help to use "git://" instead of "https://" in case some
spam logic thinks web links might be more suspicious, but who knows..

Anyway, I've caught it and marked it not spam, but this is a note to
let you know that something on the internet hates you and your emails.

              Linus
