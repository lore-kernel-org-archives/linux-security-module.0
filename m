Return-Path: <SRS0=OzCb=CT=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C925FC433E2
	for <linux-security-module@archiver.kernel.org>; Thu, 10 Sep 2020 21:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F26D221E5
	for <linux-security-module@archiver.kernel.org>; Thu, 10 Sep 2020 21:22:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="mj1ksRYl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgIJVWf (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 10 Sep 2020 17:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731085AbgIJOXu (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 10 Sep 2020 10:23:50 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB96DC0617A4
        for <linux-security-module@vger.kernel.org>; Thu, 10 Sep 2020 07:11:25 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id ay8so6449453edb.8
        for <linux-security-module@vger.kernel.org>; Thu, 10 Sep 2020 07:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JqER1n/S/bVapO+RyrM1xxWOQKbNzVguXbfv8iwgPWk=;
        b=mj1ksRYlYZoHO7kIpCwr5VKl8QULoy2ghTj3LYS/kfji3j2CawjoMCGn42zS79XNRh
         WnAI5fHo5s/8DNoLXqOv92dWpYX5paf1rXOWMU60tkmXsWATdO6Pw4W7TVAV2Tt6gLBw
         fMahCQYUhQ0eGLb3crDNL0DixDC2fR/N9X7QyM/1+bRWkSC1gO1vqbsQMv+cIL/bd5Zk
         UxjIAtIySJgzO8XbV+0+BGxHgqrGrETxylsz7OmcMjO7wbExWp2bcEV97VSNj80I5Vyz
         Bqdvy09ZzA21IET4hSfY4IoRwccGy8h8N4SBVhYpRHEEd0rl8X1PS/VgM+Tlx/+Uf7z+
         /PWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JqER1n/S/bVapO+RyrM1xxWOQKbNzVguXbfv8iwgPWk=;
        b=pcHTlARDltIfNjCvtFORXAdSkMia7Kmu+9MvChSmCO34utWpJBWEUB2PNdCi7KPrO1
         afI2seAdzju9IQdxhOQSflYq2Jw2iIjsXgIhQMJlxnzs5F3N745xsZZv5jxzS0Wuenj9
         zvY9XcCPs2OYyudz0vWuE7KgOdf85Sj7R9bGiTNEApRuQIB2k3vUPl2gW1e+PMMQ3Lgp
         RG+bIvbNDTDz/3obwXb2PmYNE7Ik0S7xeQjZk/0qMoRJNSGKyFToMYpLGyro6UjNSI03
         PdnN/sqjG4T3TXuXSLyalWec0a4PmCB6YJiLo0re7ipbszAeGdLllNmaAWsSD61K9BLy
         xE5A==
X-Gm-Message-State: AOAM530Mk3XHU8m0SJuL2SFon7tmb86yDYzL80IOsxmBngGfTWQlVQqP
        IHlDqLBytOw7nTGxbsCDdtNiMYO/BoSICwHy6c1m
X-Google-Smtp-Source: ABdhPJy1FTJ7DXFJo05WoW+t4O9pZDdDoW4TpXiv609ezJYlL+41ua8D4GnLvm80oWsYted6RRcGfRiYYQPB685hrWg=
X-Received: by 2002:a05:6402:1805:: with SMTP id g5mr9107156edy.135.1599747084327;
 Thu, 10 Sep 2020 07:11:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200826145247.10029-1-casey@schaufler-ca.com>
 <20200826145247.10029-6-casey@schaufler-ca.com> <CAHC9VhSh=r4w_3mZOUwmKN0UxCMxPNGKd=_vr_iGV06rvCNbSA@mail.gmail.com>
 <1eeef766-405f-3800-c0cf-3eb008f9673e@schaufler-ca.com> <CAHC9VhSf8RWUnRPYLR6LLzbn-cvNg8J0wnZGwTOAe=dOqkvd0g@mail.gmail.com>
 <ef6a049a-c6b9-370b-c521-4594aa73e403@schaufler-ca.com> <CAHC9VhSu4qqKWsutm3=GF_pihUKpwjAtc9gAhfjGsGtKfz-Azw@mail.gmail.com>
 <585600d7-70fb-0982-1e6b-ffd7b7c33e32@schaufler-ca.com> <9a58d14c-eaff-3acf-4689-925cf08ba406@canonical.com>
 <CAEjxPJ7i5Ruy=NZ+sq3qCm8ux+sZXY5+XX_zJu3+OqFq3d_SLQ@mail.gmail.com>
 <CAEjxPJ5KudgTjhmXBNdCO_ctvioy5UA5PXcoKX4zc19NYKgHZA@mail.gmail.com>
 <c5bef71e-6d78-2058-bcaa-8497c76d7375@schaufler-ca.com> <b320f0f6-02db-95a5-acc5-cadd5dbb57dc@canonical.com>
 <CAEjxPJ6wFJz935RR_1u+-EjAw3VMv4nabo-Za_OqkZGJuNS5Sg@mail.gmail.com> <b67799e2-fa22-2890-698d-f410913b0c8a@canonical.com>
In-Reply-To: <b67799e2-fa22-2890-698d-f410913b0c8a@canonical.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 10 Sep 2020 10:11:13 -0400
Message-ID: <CAHC9VhRMubBNRNRKSLWrQw9nGZFX1G96+8EZzaG69OHWvZaJoQ@mail.gmail.com>
Subject: Re: [PATCH v20 05/23] net: Prepare UDS for security module stacking
To:     John Johansen <john.johansen@canonical.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>, linux-audit@redhat.com,
        Kees Cook <keescook@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Sep 9, 2020 at 2:47 PM John Johansen
<john.johansen@canonical.com> wrote:
> ... For now Casey can drop it from this series.

As long as that whenever it reappears there is at the very least some
note of the limits in the commit description and the code (via
comments in the struct).  Of course that assumes we can't find an
alternate solution that we can all agree on which doesn't have these
stacking limits.

-- 
paul moore
www.paul-moore.com
