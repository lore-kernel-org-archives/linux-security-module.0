Return-Path: <SRS0=CjC+=7Z=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC95C433DF
	for <linux-security-module@archiver.kernel.org>; Fri, 12 Jun 2020 21:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21938207F7
	for <linux-security-module@archiver.kernel.org>; Fri, 12 Jun 2020 21:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591997006;
	bh=GWbucJlHAKAuWyG/jAfjMXZVJTNUvUMWRMBjIDkwRHc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=NoiB/CEyo9n3jInCB8wjcyvMZeCsK9vF+2zP7oymZBWdee/vMvyUbV0+yBAmdPBbu
	 Qs4K8CA+eK8xnE/+7ycQULx+pPSyyBgAbRBKtkqKo/5kkKS/aDtSQqyU0Hv9XU9X05
	 hF2ilRoqEFFQ/lbycCTViijK9nyf7gudaugab8q0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbgFLVXZ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 12 Jun 2020 17:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgFLVXZ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 12 Jun 2020 17:23:25 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B9DC03E96F
        for <linux-security-module@vger.kernel.org>; Fri, 12 Jun 2020 14:23:24 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id z206so6256087lfc.6
        for <linux-security-module@vger.kernel.org>; Fri, 12 Jun 2020 14:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DneVe3TvWGEFvY6ffxpfkbEvILOh996RTrpL4zTe4ME=;
        b=CpTHsPKeHgGX6LiwbKToRuV9OL2n9dMtvwuGysyrQpMMf72lp5zL0WSu9rHSerWf2N
         zG9LyevjHKt99IxDAnQTFaj//Gu06xM++Y4DnEEjALpphE1egQt/xUuLx69pcxqlqjGM
         Ba0+PsCCetnKw1M1i5D11aI6ya1VSI3UeGMu0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DneVe3TvWGEFvY6ffxpfkbEvILOh996RTrpL4zTe4ME=;
        b=SyM16/Uet6VgOsSRo8qezYGOBjCELjCv6aNVDoDLhmrnsRES26F3J89lWz+Rw2nv9X
         nmFIUmWJFcuO+GnBUl1TZXlXg+obIOKYybX3fZCIJ13i/DtClrN5ijKzvPgo/E/fh0lZ
         AT5tULZdQGSkCrHmyj25BsdT4Aq7nc930q+564y5PDlP1PdB8m+Hd2GQ1xHkvhpS2kqa
         apik3rtMIuggqNvVYGhe7uwVha8kqpN4B0eiIC2e3ECeD+YtbZZBWLKg3NZNnUE7nvL9
         M3fZR5vB4N/uT/cu1x6K+/Ytx/9j7i5av1e1Bo3iGYsxCNDJnbeK0p4Tk+wgI/rfdKFO
         amXw==
X-Gm-Message-State: AOAM530Ac2CugDj5W8SqtP/fl/yuesG0R5PHk/HRKY98UlzmKyoCcoeB
        fXDm8HUyjknCS9IyozGaINZ//IVCysE=
X-Google-Smtp-Source: ABdhPJzBRQf6/kroJ/q/ESmjIwReysCBFxIOt9IAcU8HdK4vmPRk/5Yz6xKF+BkNDhWB5BQSTioc9g==
X-Received: by 2002:a19:4ac5:: with SMTP id x188mr7812443lfa.180.1591997002665;
        Fri, 12 Jun 2020 14:23:22 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id c5sm2026107ljj.37.2020.06.12.14.23.21
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2020 14:23:21 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id s1so12697842ljo.0
        for <linux-security-module@vger.kernel.org>; Fri, 12 Jun 2020 14:23:21 -0700 (PDT)
X-Received: by 2002:a2e:b5d7:: with SMTP id g23mr7212084ljn.70.1591997000694;
 Fri, 12 Jun 2020 14:23:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ-EccOy4qDpbfrP5=KH40LSOx1F4-ciY2=hFv_c+goUHLJ6PQ@mail.gmail.com>
In-Reply-To: <CAJ-EccOy4qDpbfrP5=KH40LSOx1F4-ciY2=hFv_c+goUHLJ6PQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 12 Jun 2020 14:23:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiLXXR1+o4VAuw5MM3V1D8h6C6te3y8VMvW8iAJw6noJg@mail.gmail.com>
Message-ID: <CAHk-=wiLXXR1+o4VAuw5MM3V1D8h6C6te3y8VMvW8iAJw6noJg@mail.gmail.com>
Subject: Re: [GIT PULL] SafeSetID LSM changes for v5.8
To:     Micah Morton <mortonm@chromium.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Finally emptied my normal pull request queue and starting to look at
things I wanted to look at more closely..

On Tue, Jun 9, 2020 at 11:26 AM Micah Morton <mortonm@chromium.org> wrote:
>
> This patch was sent to the security mailing list and there were no objections.

That patch as committed has both the wrong authorship, and the wrong
sign-off chain.

Not pulling.

                 Linus
