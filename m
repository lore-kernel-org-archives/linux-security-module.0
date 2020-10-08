Return-Path: <SRS0=sAtF=DP=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D84C433DF
	for <linux-security-module@archiver.kernel.org>; Thu,  8 Oct 2020 17:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5AF422200
	for <linux-security-module@archiver.kernel.org>; Thu,  8 Oct 2020 17:40:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="Zml7I0nQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728732AbgJHRku (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 8 Oct 2020 13:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728623AbgJHRku (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 8 Oct 2020 13:40:50 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B64C061755
        for <linux-security-module@vger.kernel.org>; Thu,  8 Oct 2020 10:40:49 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id p15so9305461ejm.7
        for <linux-security-module@vger.kernel.org>; Thu, 08 Oct 2020 10:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GlLrCya3hinlqd2K69TvcEsfyyjSSv7M0qdXIwR4Cwo=;
        b=Zml7I0nQqJWjXcxahE64jsHz3Lqk4635aswtfWqOc2dWODrxNAbbXP7eJJ1Bcf3S3/
         t3/BMa6WYQDZB7HyzGnFieRSoai9z+9Pvn711scy84At/qVkDi7/vEPHB/2i8jQ9XCqO
         lzJ2y9WUF181jHQs3c/+JAk98qsE/OsqepYCs/9X2e+KYa13LVeCBlFPo31/tW7Q+WpL
         5qghNH6GOT9U+peFLsiLpEFaK9FlzIw5KvgX64EWMo98Y2zyM861/HDfAeLqzOsSwAOD
         Z+EsdK6PTVf36sigyYnf34OKxRKyzyNtWJ/zh3ARxma/sgr40Tl3zFlQK3H6nVqNM8mX
         vQ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GlLrCya3hinlqd2K69TvcEsfyyjSSv7M0qdXIwR4Cwo=;
        b=FkUi8+ncDrxnxeKJkuHrX08WH/s72JJoCFZ24Mo93fjsDEvxN6wN6+s9NZEh64Rwvk
         h+TZci1FDFGX3YqWNc5XXml6JGeeFwZfKcNdMi9CMUKmrOGakBckSZx4jpBxgTl4yxZS
         jQSepQGJNewESbPFzNtHIVv8neWhTwu/SzXN3OttBPMOu6qn6JIU903WfHviHc62Ao3E
         8ZDDBAGENaO4AEOLvnzEdy6yDdT0JG92E8o2wM3XXk56cCOunGIDc8BfLSTbFQP83YpE
         pqhm+JnnY/kYGqKRpnjfwhBWRONGkRzrqtLZ264AWG5aill4oAVliN3oQnFGnBE/2SbB
         OERw==
X-Gm-Message-State: AOAM531Wa/dajI71E6LB91KrNSQ+ZI9vE+P964Bj3b09Xuxdsi/i9IWF
        9qW5QhJ2g5DdliE42FT0Q/QrNe3ch/+RruU3n0CRxy6WqEs=
X-Google-Smtp-Source: ABdhPJxFqm+Wk8YKTHLRI/NQ+bPASK9f30sB4UzO/mLSlP2IjgkVStY+zIoruEuByrLPKWpwxb6GQ4bBmuQq8RI0nrc=
X-Received: by 2002:a17:906:cca9:: with SMTP id or9mr9585252ejb.451.1602178848162;
 Thu, 08 Oct 2020 10:40:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAN-5tyETQWVphrgqWjcPrtTzHHyz5DGrRz741yPYRS9Byyd=3Q@mail.gmail.com>
 <18b81f83-5fa2-12d1-1f0f-7933d2ecc6c4@schaufler-ca.com>
In-Reply-To: <18b81f83-5fa2-12d1-1f0f-7933d2ecc6c4@schaufler-ca.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Thu, 8 Oct 2020 13:40:36 -0400
Message-ID: <CAN-5tyEUUpLv5nzpfOZ-h-afsCTg8QLxpgnFqWhU0JsC5ZEFkw@mail.gmail.com>
Subject: Re: selinux: how to query if selinux is enabled
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Oct 8, 2020 at 1:06 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> On 10/7/2020 5:40 PM, Olga Kornievskaia wrote:
> > Hi folks,
> >
> > >From some linux kernel module, is it possible to query and find out
> > whether or not selinux is currently enabled or not?
>
> % cat /sys/kernel/security/lsm
> capability,yamma,selinux

Thank you Casey, but it's frowned upon to read files from within a
kernel. I'm looking for a kernel api to use.

>
> >
> > Thank you.
