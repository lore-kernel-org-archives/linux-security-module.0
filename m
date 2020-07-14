Return-Path: <SRS0=s2H2=AZ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8141BC433E2
	for <linux-security-module@archiver.kernel.org>; Tue, 14 Jul 2020 15:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A97B2064C
	for <linux-security-module@archiver.kernel.org>; Tue, 14 Jul 2020 15:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594741225;
	bh=UOvSlkuV54U/TaZY2uVsKcWzuCnJdNP9zODYoQcqtj0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=2j+rQtWB76+uP+X/owl5ETdNLKJBwDX1kzhgbaGdqr7Qr/Vujocu7E5ck7krRuDAQ
	 NVGK7tz1gILI2UzZf5jWF4ybfIkqJ49/Zv8aSYmPr3eU2m8F2PWu8QBrvBVpyTm5Cn
	 iqMxE2AOH0FokHNhVfgyx/QlP9BR30rVl64C11zM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgGNPkY (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 14 Jul 2020 11:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbgGNPkY (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 14 Jul 2020 11:40:24 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1BD6C061755
        for <linux-security-module@vger.kernel.org>; Tue, 14 Jul 2020 08:40:23 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id r19so23325842ljn.12
        for <linux-security-module@vger.kernel.org>; Tue, 14 Jul 2020 08:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5jTmpU8Dkl5pvNFGB2BTMvHLzNVV8sfUdRQkwZjkOYc=;
        b=MNp9lKJj7EBD880it9siqaztgSYUNv2sy/wFhoNDgIzZpKe4AYAUKzWcV09V4oisxf
         HKIulcI2QBS2tkfjO7CEQSO1KsnTIWqin3TEpMbWO2sBDpv2rqyjvt2Bxz98B6d8XsYs
         XUidiZRkBG5l0bWJsyuW3RbjP6Km9DdHXUKo0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5jTmpU8Dkl5pvNFGB2BTMvHLzNVV8sfUdRQkwZjkOYc=;
        b=ZvgklYX9jNS8rkBv9u6U/4EHI85lJZjZApCgx3ffJXOeOSRat9OV/hbwjpXWK5P4uY
         VAPuF0RaHoeu1SqpyA6oMhi7bAxv5K8Hi6G/NTAqWCPqRAiYsyr991ZO/N+ppE2cB0D2
         iBUeDqPzR1t1JeSh/wcKDyTMrGxIlfyXC/2MEzzUfXwczA+xivnn56mhGBZv0r7zcZ3x
         Gh66K4U+IGhI6bjol/74Iny/QZb+9a13SyfaE2+UxdSz8ryeYzBkkwqyWM+YIf8vGCrD
         RlLXo4YYTrep8hyMLQnSBK4iBD1UVS6W293T34Y/R1GWOEgjwQ77mSVQtXsFcbH9FoXm
         Y+aw==
X-Gm-Message-State: AOAM530xIvsY2X6h+bfLOcBLvexKdXUgd48XKNEuaiYWOEsVbklZMatl
        UjXYB2FaNQXW5jOcIwQfQysZr1zQwC4=
X-Google-Smtp-Source: ABdhPJyPOiXalEWGkD28z85TP3SYbDsqqfjTy81aLTBlYxatewfLbMsetaWnRkJttFL3+wwIiXpikQ==
X-Received: by 2002:a05:651c:1186:: with SMTP id w6mr2489330ljo.123.1594741221937;
        Tue, 14 Jul 2020 08:40:21 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id d18sm5331336lfb.26.2020.07.14.08.40.21
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2020 08:40:21 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id x9so13362996ljc.5
        for <linux-security-module@vger.kernel.org>; Tue, 14 Jul 2020 08:40:21 -0700 (PDT)
X-Received: by 2002:ac2:5093:: with SMTP id f19mr2517777lfm.10.1594740757966;
 Tue, 14 Jul 2020 08:32:37 -0700 (PDT)
MIME-Version: 1.0
References: <871rle8bw2.fsf@x220.int.ebiederm.org>
In-Reply-To: <871rle8bw2.fsf@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 14 Jul 2020 08:32:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjgPUov18XLYgak3zEju7pGR-XkXWi442Nq0paA5pokuQ@mail.gmail.com>
Message-ID: <CAHk-=wjgPUov18XLYgak3zEju7pGR-XkXWi442Nq0paA5pokuQ@mail.gmail.com>
Subject: Re: [PATCH 0/7] Implementing kernel_execve
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        LSM List <linux-security-module@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        James Morris <jmorris@namei.org>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Jul 14, 2020 at 6:30 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Please let me know if you see something wrong.

Ack, looks good to me.

                 Linus
