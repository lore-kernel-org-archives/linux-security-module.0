Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45635C433E0
	for <linux-security-module@archiver.kernel.org>; Sun, 21 Feb 2021 22:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15EA66146D
	for <linux-security-module@archiver.kernel.org>; Sun, 21 Feb 2021 22:13:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbhBUWNV (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 21 Feb 2021 17:13:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231597AbhBUWNO (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 21 Feb 2021 17:13:14 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBDC1C061786
        for <linux-security-module@vger.kernel.org>; Sun, 21 Feb 2021 14:12:32 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id d8so26180608ejc.4
        for <linux-security-module@vger.kernel.org>; Sun, 21 Feb 2021 14:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JHLbwT/ysBdqWf/COmA52ux7qzFg6vWUUO9UK965XT8=;
        b=lTnwExIFwzArZnyv4fZz7IOs+S/6QFZAMNLV4esTGEPpr7fcftiAU59BJnKr0rHEgQ
         SOcXURchNRRSD1iifWyn46RzKL/UlQ3y/2n/rxyV/ch/LROQ6gCTtD0UZiEJzuhx5mNf
         9ygT3IVEqOPLLsalhZioCreIGHjXj3Bl2NRCA72KX2+BV/1vpnJlpoZY1JQ7xgsw9ZME
         CycQn18LBv1Rs1eTaYJZFyCOOXElo88WxWIKgTiI4E+l/4fXIHs5YHyPLh6IkyoV7nZ9
         0oBzouA1rzIJXrimtZ5xw5Pi39+0I8J9rwTNlZj7uFAg14bkOVEDG0qc7nZMoQ+T5C/e
         Mt0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JHLbwT/ysBdqWf/COmA52ux7qzFg6vWUUO9UK965XT8=;
        b=WtEefeq4zvvIcrIgc426OTOJiDuwE2YccsTL+F5BPdQKSgr0Rj5zxw+hHThD9mrF+C
         kockIs1Jcx2Dl5vfAKC+MMtuADtdQ0axft+tpyjGlSFaIvcV2Go4JSKAvupqh5RS3V4b
         lo0JnauR0CzP4ZJPuyJyGUsa+2uuX3pApyKW3d6t4Hsws/XzVdq2l1j83GNjx2APkzQR
         FxEqQltPzW7CuuLuKSDL4ubQ0Do8ktSyGf1XriC5LqAHzi4GkCnGkJRn0iFP9qxWItdu
         5ZhzII1p7mRUPY3BfFudAhAoFVbktMsmwNFOoesoY2YL0DLbUzmYTQtKP6BQIa5hy5XR
         Czvg==
X-Gm-Message-State: AOAM533zU2RFjuMoQwlTaXaXCGuyyD9mXk/57t5USxhC6kkG1cdakr5o
        S2nvpwguvkXqiCdZ6YJUJ0gvs0Ui38/YPOAczzmx
X-Google-Smtp-Source: ABdhPJzC8AgWl6lkNnXnwDrKhO1kGPO9s6ErhPfRwnjbiInC6c1hcYVpWVaXQNi3+Iu7IaJg76JIBWJv0tqMaclUMiE=
X-Received: by 2002:a17:906:8394:: with SMTP id p20mr18467935ejx.178.1613945551482;
 Sun, 21 Feb 2021 14:12:31 -0800 (PST)
MIME-Version: 1.0
References: <161377712068.87807.12246856567527156637.stgit@sifl>
 <161377736385.87807.7033400948278183233.stgit@sifl> <28174118-93d2-e7a5-50fb-004185354625@canonical.com>
In-Reply-To: <28174118-93d2-e7a5-50fb-004185354625@canonical.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sun, 21 Feb 2021 17:12:19 -0500
Message-ID: <CAHC9VhS+K2tD_8UYcgO5Lzkh3r4TWBEyzJArekagoykwj+fekw@mail.gmail.com>
Subject: Re: [RFC PATCH 4/4] apparmor: differentiate between subjective and
 objective task credentials
To:     John Johansen <john.johansen@canonical.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sun, Feb 21, 2021 at 7:57 AM John Johansen
<john.johansen@canonical.com> wrote:
> On 2/19/21 3:29 PM, Paul Moore wrote:
> > With the split of the security_task_getsecid() into subjective and
> > objective variants it's time to update AppArmor to ensure it is
> > using the correct task creds.
> >
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
>
> This has a couple problems, that I will work on addressing

Yes, I figured that might be the case; I don't have enough
understanding of the AppArmor internals to do anything more than a ham
fisted approach - my apologies on that.  Let me know if there is
anything I can do to help.

-- 
paul moore
www.paul-moore.com
