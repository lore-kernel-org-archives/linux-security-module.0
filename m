Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D61C43334
	for <linux-security-module@archiver.kernel.org>; Sun, 10 Jul 2022 14:07:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbiGJOHL (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 10 Jul 2022 10:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGJOHK (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 10 Jul 2022 10:07:10 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A81BF4A
        for <linux-security-module@vger.kernel.org>; Sun, 10 Jul 2022 07:07:09 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id d13-20020a05600c34cd00b003a2dc1cf0b4so1671465wmq.4
        for <linux-security-module@vger.kernel.org>; Sun, 10 Jul 2022 07:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+Kz8nRCFUne/Ayme9USyvJHMtzkXtw/liE+I0kdzCAQ=;
        b=OAh8jrFeAVNUvqcMF/44zwipUxUoOwMKA02uG2J7CWXP0X6jfBm6iHDuoDnFGhx3xF
         dB1Srh1CIVse8+XiIFxzXRbcpK3EKKQPCzWi8KD0pxr+R0Qg+YcCrrfypK5pEBUC2abM
         Xyppv08mRP2/HgpUVwtsv2+o3iuNRMZj99jeE9/13l05Lrrofh06kiu18mbuRAstcPSV
         uyQjcpDHpeWUROX0kTZRzaXf1DkVuP1Z9ZVvhyk3hpLKbe0NfmiYvSdMfw1t/LtS05wz
         jL6+91zPp6P5uIg9n6yt2tDF+GNJrLOCl79MAOQ8gP4vkLsKh++K0fn+qLbcAAEBw/pv
         FeJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+Kz8nRCFUne/Ayme9USyvJHMtzkXtw/liE+I0kdzCAQ=;
        b=PIJU04AjD+duIKOBKXSJZ0HlVKIBWcm+z82p5wRCDUUkvOXM/29I2SagTeXzTqV9yF
         pPHV+q8aiRUKPA651pEKoYCj8jGvxL60RpG1aKIxBd56SqLr/k7YuHjCq9rG3M4voLre
         Uxfwq8qPjwvOV9tkP7GCk6jkRvYiSooatvOw6lHxpVZ7NeEjOr4B/Cc7iSV8Q/vLr6O7
         GZtuGZQRVs5SyKNeuS0IPC6QP2tWl43dSd+o1aAIwMBdt2VxVOOEZYaQ8wWjRSleKk5I
         KzfozZzHqKP8CUIzHdO470VpSgkSUS8jQxEWnXkaQWuR3iClj2Yun9kyPQfB7KCJ35ri
         Truw==
X-Gm-Message-State: AJIora95iLEgbC4aZ4waTyVOPJDpIWGC7KQRMTvEwsnIGgw+2JDxzBDo
        J2AAisn9T48c6H4d0nZmYlVgFxI+x3cUaQ63+dNe
X-Google-Smtp-Source: AGRyM1vk1v28We6QeGJ22gblHF1ObtlVMRmckfY1rLhyq1jXklIFXsZNKyo816TkaOWhzvu26JHyPx3i/XiN8dH+/bY=
X-Received: by 2002:a05:600c:22c9:b0:3a2:d069:a046 with SMTP id
 9-20020a05600c22c900b003a2d069a046mr11036828wmg.29.1657462027911; Sun, 10 Jul
 2022 07:07:07 -0700 (PDT)
MIME-Version: 1.0
References: <165731248606.335227.15503387932450699761.stgit@olly> <4c33604f-25ee-c1e7-4a4c-afe95b3dba15@namei.org>
In-Reply-To: <4c33604f-25ee-c1e7-4a4c-afe95b3dba15@namei.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sun, 10 Jul 2022 10:06:56 -0400
Message-ID: <CAHC9VhSowtGrY=Crgk85Yf6G+o-4SsWgDMJc_T_Jpw7yPx8zkg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: update the LSM maintainer info
To:     James Morris <jmorris@namei.org>
Cc:     linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Jul 8, 2022 at 5:19 PM James Morris <jmorris@namei.org> wrote:
> On Fri, 8 Jul 2022, Paul Moore wrote:
> > After many years of shepherding the LSM layer, and Linux kernel
> > access control in general, James has decided to take a small step
> > away from his technical role and has asked me to assume the
> > day-to-day maintenance tasks for the LSM.  This patch makes the
> > necessary updates to the MAINTAINERS file.
> >
> > Thanks for all you patience and stewardship over the years James,
> > I promise to do my best not to screw it all up :)
> >
> > Cc: linux-security-module@vger.kernel.org
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
>
> Acked-by: James Morris <jamorris@linux.microsoft.com>

James, are you planning to send this up to Linus during the next merge
window or should I?

-- 
paul-moore.com
