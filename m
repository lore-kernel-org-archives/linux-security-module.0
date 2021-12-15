Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED54C433F5
	for <linux-security-module@archiver.kernel.org>; Wed, 15 Dec 2021 13:17:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242792AbhLONRy (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 15 Dec 2021 08:17:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237406AbhLONRx (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 15 Dec 2021 08:17:53 -0500
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE3BC06173E
        for <linux-security-module@vger.kernel.org>; Wed, 15 Dec 2021 05:17:53 -0800 (PST)
Received: by mail-oo1-xc33.google.com with SMTP id t9-20020a4a8589000000b002c5c4d19723so5884191ooh.11
        for <linux-security-module@vger.kernel.org>; Wed, 15 Dec 2021 05:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Au62n4m8uRCaSs4+vVgR5PSbqPQx8MPEQSlKHv3tUvo=;
        b=aj3Sj5liapebe6SJRITNXLiI4KThaaqInZzt1i7hIMcEYfQBChC3pmnPuyo/QhSqGd
         w+qBZtYaSwZXwS3iv2DNaZBZXcu/KXH2LkO1SDZs3EPHQpQuyaDT7dMkqVp/ZSGBugLU
         hQLFsviUCObiQTbgbt00h0krz180Dl/L0DDUQkJz975590I9K3aYpjCnFaCuKB1VD4yP
         fv+5FM6+bpIo1c+c0X9F7i0ttHfPQCnE5Nsm/oLT37XcCBOVqpfPGg6TtaNe6ugIGVWa
         XeqpPhcMqc+W76crBy6NMiel0a2RDjhiHty4L8YVDo+/gbcwBfUjrm9iSuNDYHRaMJFm
         p6oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Au62n4m8uRCaSs4+vVgR5PSbqPQx8MPEQSlKHv3tUvo=;
        b=QQJ4tccd11ChnzxKfs7gC4PdYPCqWH/ejjBgU2YuF9h+GxzJJlqw3VhEDYenzqKPwb
         Ih9/cd4uG7acgixuf5qQG5rIK6mKwaF4aKYN1x6owveIyZHjH49vmw/cR0GyqJ9vdjPR
         5u3NdgM2o7O5qe1Z0yTfFK+xskl65BUCzzqliLg722RLG+sy3kWFVCclx1yX7yWpBRJF
         XMgSj4yoYjIZwDCWF3p4ccRi5GbPFGWlFcIbXnGWfbY9u/25/AD0Y5IDcW/jC4/xhTud
         9BcT29TdFJNtuOSB3xmAo3zY5CvS+PXeJE8lmBLQQvrix/RqHYc/95Tc2gde7K2KmtkV
         HZwg==
X-Gm-Message-State: AOAM530ynhAFkzkJlJl4YhpzI1MQ83vcZbJimFhJ73NQpSyFiX8yNcXD
        VOouj9CNlNIzCtvkXoIQ6kOR5sgpeqjl6GFIrWNcmg+WEBI=
X-Google-Smtp-Source: ABdhPJyKiNrM46sQnQOVNCpuufZLZX8vH6amPXzMUo6ihOAnqKOaK6XOQiIg+OSbQaN3W3LYcklzBmCcOWCR2/ChcDg=
X-Received: by 2002:a4a:96f1:: with SMTP id t46mr7147958ooi.53.1639574272532;
 Wed, 15 Dec 2021 05:17:52 -0800 (PST)
MIME-Version: 1.0
References: <20211214094526.2442154-1-dvyukov@google.com> <4ad30f21-9955-a72c-d7f0-912de6c205be@i-love.sakura.ne.jp>
 <CACT4Y+Z63jk9cFgkcKeU0HN6ES_CBhrotY0Zabae17R-gqG6SA@mail.gmail.com> <8da31317-9306-70d0-2bf7-382ed157bc5c@i-love.sakura.ne.jp>
In-Reply-To: <8da31317-9306-70d0-2bf7-382ed157bc5c@i-love.sakura.ne.jp>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 15 Dec 2021 14:17:41 +0100
Message-ID: <CACT4Y+ZyXhm39R-HBgcsLawQCtDsE5YRppxADjBG7NwkEwgn4A@mail.gmail.com>
Subject: Re: [PATCH] tomoyo: Check exceeded quota early in tomoyo_domain_quota_is_ok().
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     takedakn@nttdata.co.jp, jmorris@namei.org, serge@hallyn.com,
        nogikh@google.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, 15 Dec 2021 at 12:46, Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2021/12/14 20:42, Dmitry Vyukov wrote:
> >> Therefore, asking administrator to also clear domain->flags[TOMOYO_DIF_QUOTA_WARNED] after
> >> increasing pref[TOMOYO_PREF_MAX_LEARNING_ENTRY] value (or changing domain->profile) would be
> >> tolerable...
> >
> > Should we reset flags[TOMOYO_DIF_QUOTA_WARNED] on any writes that
> > change TOMOYO_PREF_MAX_LEARNING_ENTRY?
> >
> > If I am increasing TOMOYO_PREF_MAX_LEARNING_ENTRY because I observed
> > the warning, it's useful for me to receive the warning again.
>
> I decided not to reset flags[TOMOYO_DIF_QUOTA_WARNED] automatically, and
> applied your proposal as-is. Thank you.
>
> https://osdn.net/projects/tomoyo/scm/git/tomoyo-test1/commits/04e57a2d952bbd34bc45744e72be3eecdc344294

Thanks!

It will appear in v5.17, right?
