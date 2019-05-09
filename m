Return-Path: <SRS0=3Nce=TJ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F859C04AB1
	for <linux-security-module@archiver.kernel.org>; Thu,  9 May 2019 19:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CECDA2173B
	for <linux-security-module@archiver.kernel.org>; Thu,  9 May 2019 19:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557431652;
	bh=gMSZvH2jlV+E3jQtFqiDNxyLY2LVd3yMAAHRjgUI8bI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=oPuFS69ZWAmGf+qDjlfhj4Fgo9dr//a9dzQV0As4JToETVnx5jM3MdIysanKD1AMg
	 VBwActJFcxxsZZlrSr3oJkN1IdsOxc+dT5XsENNkbncstKNnPMckJoQCu6IvM3z8OY
	 5JraEo91ia6rPrvi1wlCnVhKe7vg88op3gSoXqiA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbfEITyM (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 9 May 2019 15:54:12 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45313 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbfEITyM (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 9 May 2019 15:54:12 -0400
Received: by mail-lf1-f68.google.com with SMTP id n22so2423407lfe.12
        for <linux-security-module@vger.kernel.org>; Thu, 09 May 2019 12:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oGG06UbFIpIka8kH8mF+DXo9oIX85rLGrtvTzTqeUYQ=;
        b=Bhff/nyavJfT40PuALUNmV3NXjnHsrbN+pAjB4c+7XVvzcKW/ubj0wSd2FNv9dp01I
         PEmNRE69Gq1/nhGrWzYnZGlXBoDh5fsc7w049UJnCsXJIwhkrczb6bJT2fpYeG8x9oPA
         +f0BOPIBNwyU7J3ce6H2g/VMV1QRPpnEEQ8wU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oGG06UbFIpIka8kH8mF+DXo9oIX85rLGrtvTzTqeUYQ=;
        b=k9SYUko3YNgZ/gE7j13BtB8ZpAGYGBYuDXTo6pA3D+B/93hTI1dhXoxHKKR5EeKNzR
         uL4lHemb+FpJoAl0/5eyXkjhoXPuIZ0cSdHS1I/hvS0zgNsO0lCL424Q0GqweCwjMvAz
         vwQTms6km6uHb7bFxwI5sL7VQO4PTIXMdh/QvhwF7jSm+Ug1c1oPtaM58Mv3WbeZWrO/
         ZykwFCUa1ta8riRqLQm0/vZ3p8AAKJ/YNW14kN3zWaf3f6t1mGd7jTzU6DCDt/L4ZMaP
         qoheVK+sGDUq06DRcDTIZKLftTgkeK7tNDH6qrs3qWwDipWKOdmpS8CibVqYjOnSlbOd
         Jp+A==
X-Gm-Message-State: APjAAAUZZHyvik6P/UTT3ZlQQ8xYvHpRZ4TJU7WXgprUF/EgPnWsyOdy
        2atGs7gEdyV4wtBoKqeG+e02aDocqW4=
X-Google-Smtp-Source: APXvYqz1W9qhomyQZoMue/TlZYdXEpQcJn6UgZmtFKWr+18NsuFt6T9PEFaFhtOks1A5qVMmg+CmVg==
X-Received: by 2002:a19:196:: with SMTP id 144mr3764108lfb.35.1557431649597;
        Thu, 09 May 2019 12:54:09 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id s16sm549016lji.61.2019.05.09.12.54.08
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 12:54:09 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id 14so3091323ljj.5
        for <linux-security-module@vger.kernel.org>; Thu, 09 May 2019 12:54:08 -0700 (PDT)
X-Received: by 2002:a2e:9ac8:: with SMTP id p8mr3140904ljj.79.1557431648546;
 Thu, 09 May 2019 12:54:08 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.21.1905100320110.25349@namei.org>
In-Reply-To: <alpine.LRH.2.21.1905100320110.25349@namei.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 9 May 2019 12:53:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=whqzNFfeNOouBjH2GKMVgMi22fsNOaCgbUOnCPmKmEXeQ@mail.gmail.com>
Message-ID: <CAHk-=whqzNFfeNOouBjH2GKMVgMi22fsNOaCgbUOnCPmKmEXeQ@mail.gmail.com>
Subject: Re: [GIT PULL] security subsytem: TPM changes for v5.2
To:     James Morris <jmorris@namei.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, May 9, 2019 at 10:23 AM James Morris <jmorris@namei.org> wrote:
>
> Bugfixes and new selftests for v5.1 features (partial reads in /dev/tpm0).

What the heck is going on?

I got all of these long ago in the "TPM fixes" branch for 5.1. One
month ago, merge commit a556810d8e06.

These are just rebased (!) copies of stuff I already have, and they should

 (a) never have been rebased in the first place

 (b) certainly not be re-sent to me as a new branch

Please throw this branch away and make sure it really is dead and
buried and never shows up again.

And take a moment to look at what happened and why this broken branch
was duplicated and sent twice!

              Linus
