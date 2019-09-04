Return-Path: <SRS0=4koF=W7=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A90C3A5AA
	for <linux-security-module@archiver.kernel.org>; Wed,  4 Sep 2019 22:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8200121883
	for <linux-security-module@archiver.kernel.org>; Wed,  4 Sep 2019 22:50:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="OR3LembM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729640AbfIDWu0 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 4 Sep 2019 18:50:26 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40727 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728072AbfIDWuZ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 4 Sep 2019 18:50:25 -0400
Received: by mail-lf1-f66.google.com with SMTP id u29so318624lfk.7
        for <linux-security-module@vger.kernel.org>; Wed, 04 Sep 2019 15:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=or8i5QC8wwPyBAqXI9A1QNz+kBi9OgX+KK6APEn8gXY=;
        b=OR3LembMJZ6Jn9kbLR0j8Ywffmk47BwcKIguYKcJyRCmCPvOuiB3iJDJqUEQMaY7YS
         EtALo/WqVHLkao5rs/yNZ3lyIPbkUKV+lTzW4W6rTJseTwhnEM03PbTQPaphcMtfHJ8w
         2mTVwB3bnDZS3RhSCyGNBvah8Pl88SGAJoPWHr7b8Zc5LiSMHevNnaZf1dI0gIQHqNHh
         1vgnDWRBvYdyVbO+hkVUiaSFwH6UFppjmClpyMNs7VWIcwpNNyp3QwVr3MUnJG43ERmM
         27lQJTlUXkPvrUz/FKyR0zYqWI2cT0l5Ate6k6yK8rVvbh+TLsoGJX5r9N3lcpxci2zw
         UQsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=or8i5QC8wwPyBAqXI9A1QNz+kBi9OgX+KK6APEn8gXY=;
        b=j+Ef/N1LX4VRQtWbw7mO5+b8xZDRehhqYMdiuglcRoTj6gxJYjeptOsx9Iq18U/3zT
         1CBXIqFwRdqFG7wZpsUgFSoZdzmM0gLgvplKby+Y56eimq+ac8uKQk3rSYtcOCHfjv0x
         vXAJSzt1nc6j2CyWQPYA+mzv6EYCA/Jp9HftchwGZF21gOp39bSUcRoDE4ULlfk2q2uq
         97wSckK7WlV8oPVftyGZd8et/6hGYvsRc0kXQD49+vXJaoN8JALeoceQ+Qdiu3AybO4q
         fYK1Bic6/8CHC7PKyV2QHrNgmXnKjymQUJ5+5jBNtwJ+QEfS+7aJCbQ+PJTxJUs5KwD4
         lyTw==
X-Gm-Message-State: APjAAAW7usDFcKpJ37buKb+nvtzuKrru9c5227HMqW2xeLHlox8pafO4
        sEiQpF9M7xF22gF254fgqUBUywEjxZALnNrEp+XL
X-Google-Smtp-Source: APXvYqyNlE9P/7Tzg3qdUCKxPzbeqU5GV6xpkiVe5rNuRgiLqMr5RHF2u9+yDmgcWjNmUy55pt59697Gb3977Rqlx2s=
X-Received: by 2002:a05:6512:202:: with SMTP id a2mr267542lfo.175.1567637423535;
 Wed, 04 Sep 2019 15:50:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190904143248.7003-1-sds@tycho.nsa.gov>
In-Reply-To: <20190904143248.7003-1-sds@tycho.nsa.gov>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 4 Sep 2019 18:50:12 -0400
Message-ID: <CAHC9VhTdv2C2MbNb7p-cPAW8ZeY+tmcz1c77qXmvowSxrWbw4g@mail.gmail.com>
Subject: Re: [PATCH] selinux: fix residual uses of current_security() for the
 SELinux blob
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     keescook@chromium.org, casey@schaufler-ca.com,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>, dhowells@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Sep 4, 2019 at 10:32 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> We need to use selinux_cred() to fetch the SELinux cred blob instead
> of directly using current->security or current_security().  There
> were a couple of lingering uses of current_security() in the SELinux code
> that were apparently missed during the earlier conversions. IIUC, this
> would only manifest as a bug if multiple security modules including
> SELinux are enabled and SELinux is not first in the lsm order. After
> this change, there appear to be no other users of current_security()
> in-tree; perhaps we should remove it altogether.
>
> Fixes: bbd3662a8348 ("Infrastructure management of the cred security blob")
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
>  security/selinux/hooks.c          |  2 +-
>  security/selinux/include/objsec.h | 20 ++++++++++----------
>  2 files changed, 11 insertions(+), 11 deletions(-)

Thanks Stephen, and everyone who reviewed/commented on the patch.
This looks fine to me too, and while it is a little late, I think
there is value in getting this into the next merge window so I've gone
ahead and merged this into selinux/next.

As far as removing current_security is concerned, I also agree that
removing it is probably a good idea.  Does anyone object if I merge a
follow-up patch via the SELinux tree (patch coming shortly)?

-- 
paul moore
www.paul-moore.com
