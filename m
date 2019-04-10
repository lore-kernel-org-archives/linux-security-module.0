Return-Path: <SRS0=my8L=SM=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5569C10F11
	for <linux-security-module@archiver.kernel.org>; Wed, 10 Apr 2019 15:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FA1920820
	for <linux-security-module@archiver.kernel.org>; Wed, 10 Apr 2019 15:14:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="k1LiPUOF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733054AbfDJPOs (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 10 Apr 2019 11:14:48 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:35934 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733018AbfDJPOr (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 10 Apr 2019 11:14:47 -0400
Received: by mail-yb1-f196.google.com with SMTP id e76so956894ybc.3
        for <linux-security-module@vger.kernel.org>; Wed, 10 Apr 2019 08:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=avO+my9IB6BS9iLwAEEiQ0/aTUwapxeB45iwAI6OqY4=;
        b=k1LiPUOF1zfGEYOuXUzcVqOISgqeoGX8yJ1mRhb1D6jhM+v7RKAEgsW/Qk3kTGf0Ns
         UoF33BGcH/SemPjoEKIz8V2FKcc/j0KQ94O+F33WbXmFZLh25P1y+qSCMqNlBbFUrSt4
         vXRYUAP23zEw/JxZbHtTctihmL8cy0VsvloOY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=avO+my9IB6BS9iLwAEEiQ0/aTUwapxeB45iwAI6OqY4=;
        b=P2A+7SotGjF/KD91t91Jujl8BW+Tlh7scvht+nQYIINYKqjwHQcz6EOtIxPDBdeuDH
         d6xinJvX1XGIFmMb3gtZj6Da4mnhVO8krdoY+iEtlFSwvmT7uTjmDvVTEhs0WT/XQdGW
         W1odbIvoRZr6OvnCPu7hSbSkSIq2SHoQXv1ZcgnhY/O6hhhskhEZk2bWdKnKdYLvI0B1
         l/KG0jOC9dXlSjY4yyPb0q+JG5RdR0wEsk5abkyQiKFzEEecH2bUdw27ioJx7dROP8gN
         8J/r/7GOSxsGFhi+6D0PpPwFmZKuh6LF0G8T1nQxmVaLrwLXIz+ni14N0QFUydWnoMvs
         edCQ==
X-Gm-Message-State: APjAAAXBSnCoouPsV8G49nwFNYbMCiZlQKw7Ji7amio4YLTu1+Uw1Wxh
        6F0NlNYrNjYoI8Vh3uDfA1OrJkX0pasqbyGCGCibhw==
X-Google-Smtp-Source: APXvYqy7qtoyYCGvqjVefBrjhdNFrWB7KYPcuJGJiu7elAeb+oEFgScZcbX4Q4ySweE72Gb/dCdruskqSje3jtx+DDo=
X-Received: by 2002:a25:5b41:: with SMTP id p62mr38260243ybb.322.1554909286413;
 Wed, 10 Apr 2019 08:14:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190305154922.61040-1-mortonm@chromium.org> <alpine.LRH.2.21.1903300505540.689@namei.org>
 <ac7638c0-911d-5c0c-014d-730e763454f3@schaufler-ca.com>
In-Reply-To: <ac7638c0-911d-5c0c-014d-730e763454f3@schaufler-ca.com>
From:   Micah Morton <mortonm@chromium.org>
Date:   Wed, 10 Apr 2019 08:14:35 -0700
Message-ID: <CAJ-EccPG2RD75CgiiXzCtLuvay=5VAsdGwqbK1_8opaUtYd2oA@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] LSM: SafeSetID: gate setgid transitions
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Lets hold off on merging this for now. We have some fixes that will be
going in for the existing LSM code and we can circle back to this once
those have been merged.

On Fri, Mar 29, 2019 at 12:44 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> On 3/29/2019 11:06 AM, James Morris wrote:
> > On Tue, 5 Mar 2019, mortonm@chromium.org wrote:
> >
> >> From: Micah Morton <mortonm@chromium.org>
> >>
> >> This patch generalizes the 'task_fix_setuid' LSM hook to enable hooking
> >> setgid transitions as well as setuid transitions. The hook is renamed to
> >> 'task_fix_setid'. The patch introduces calls to this hook from the
> >> setgid functions in kernel/sys.c. This will allow the SafeSetID LSM to
> >> govern setgid transitions in addition to setuid transitions. This patch
> >> also makes sure the setgid functions in kernel/sys.c call
> >> security_capable_setid rather than the ordinary security_capable
> >> function, so that the security_capable hook in the SafeSetID LSM knows
> >> it is being invoked from a setid function.
> >>
> >> Signed-off-by: Micah Morton <mortonm@chromium.org>
> > Wondering if there are any further comments or reviews for this before it
> > is merged?
>
> My comments have been addressed.
>
>
