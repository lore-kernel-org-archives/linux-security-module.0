Return-Path: <SRS0=J6Hd=6T=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F91C47247
	for <linux-security-module@archiver.kernel.org>; Tue,  5 May 2020 00:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 918BF20661
	for <linux-security-module@archiver.kernel.org>; Tue,  5 May 2020 00:16:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N4s+XP8H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbgEEAQZ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 4 May 2020 20:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728374AbgEEAQZ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 4 May 2020 20:16:25 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E70C061A10
        for <linux-security-module@vger.kernel.org>; Mon,  4 May 2020 17:16:24 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id t11so11363110lfe.4
        for <linux-security-module@vger.kernel.org>; Mon, 04 May 2020 17:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QiqUUss2jL8iYfIE6Bd+6noVnRyNqoTAQ9IVKOuRQgM=;
        b=N4s+XP8Hut8idJW2OzJ7P2a4JzXglSpVAIJjOBw2Ld+5maAmt0BoeQ06cj4QDsgGDE
         6NAcJbsXytHSsE4lwzCkdHu0rpMzM+wisgaZcziE5fWQOQV64jlS0LdKr7xstsB9UVpj
         mvdwkKwFKgiksfSm/EgH/UxIAAWrqnO8bFFX0Lexs6cbcyu8KkMMItlCihp8z7iDO0ss
         aNEAOQneXGQzOZoCkFT5iHrMhaq7DQ80aKybV35v5cm2xpXcpz7v57rzUH81ux+HoSU3
         DZiwpOXUYwj1/gR1uVO5SGmB9WkBXR5UKZl8CKlSKBHoyL8UsOZlR+02AseogMgZ52Np
         grdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QiqUUss2jL8iYfIE6Bd+6noVnRyNqoTAQ9IVKOuRQgM=;
        b=pX4PI5TOPhihjtPG3HzA3DK1bRl1uN71xckQh41g8QP9ZfHRsTzRlslCypfqGhb/Rk
         RHDubhkAMtqEFov2pnPcYUB8LO4voq+Ndz5ac62JKesynxdV9B3o+MjMqVN5Ca4QOdcS
         PcfqwyIkJHlZ0GjayUHCHbHiq+oy5ZSnurd2rnG4vCPQcpfucyrFGmIpzvYz8UeRWeM0
         VFZev6xkeO+tKsH2vPMadKtEOAxuIvJtRZgnh/jpvHnYf9xpPiFleLS6LgVnia+IlVuy
         PzYTpWN3Kxxjywh3Pz6f12NnqjDyXj6QfExUbxgqDSLDUuDfFMc0Q4fNlkVPflAnHDya
         cEhA==
X-Gm-Message-State: AGi0PuZSPBYznKtvxXIqu5EoU2wedRwILTytewb84hn1Rxrx0QP7mO/f
        f9knJeQMlshv/kWR3wzhxW0AcmW8xzNkJa02vS2Y0w==
X-Google-Smtp-Source: APiQypJGv5tcseONQbK5x2mnROWwvW0Pn8R67E8fsfoelBLNFOf4MQLot2TT1lmzTeAvYKM70sV8eZFtKle0oWz4pT4=
X-Received: by 2002:a05:6512:104a:: with SMTP id c10mr5802lfb.184.1588637782543;
 Mon, 04 May 2020 17:16:22 -0700 (PDT)
MIME-Version: 1.0
References: <1588627060-7399-1-git-send-email-zohar@linux.ibm.com>
In-Reply-To: <1588627060-7399-1-git-send-email-zohar@linux.ibm.com>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 5 May 2020 02:15:56 +0200
Message-ID: <CAG48ez2PwqoDBx0pkZKFHvMXHNqAc8AfuTR5oPoF-obHqUo0zQ@mail.gmail.com>
Subject: Re: [RFC PATCH] ima: verify mprotect change is consistent with mmap policy
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Biggers <ebiggers@kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, May 4, 2020 at 11:18 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> Files can be mmap'ed read/write and later changed to execute to circumvent
> IMA's mmap appraise policy rules.  Due to locking issues (mmap semaphore
> would be taken prior to i_mutex), files can not be measured or appraised at
> this point.  Eliminate this integrity gap, by denying the mprotect
> PROT_EXECUTE change, if an mmap appraise policy rule exists.

Just keep in mind that there are other ways to create executable
mappings containing controlled code; e.g. PROT_EXEC with
MAP_ANONYMOUS, or writing to /proc/self/mem (which is a debugging API
that works entirely without ever making the VMA writable - I had an
old series to provide LSM hooks for that stuff at
<https://lore.kernel.org/lkml/1478142286-18427-3-git-send-email-jann@thejh.net/>,
but I guess I must have forgotten about it or something...).
