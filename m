Return-Path: <SRS0=8dNN=VN=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40DE6C7618F
	for <linux-security-module@archiver.kernel.org>; Tue, 16 Jul 2019 23:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14225217F4
	for <linux-security-module@archiver.kernel.org>; Tue, 16 Jul 2019 23:14:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="OZv744op"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728699AbfGPXOI (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 16 Jul 2019 19:14:08 -0400
Received: from mail-lj1-f174.google.com ([209.85.208.174]:44024 "EHLO
        mail-lj1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728601AbfGPXOI (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 16 Jul 2019 19:14:08 -0400
Received: by mail-lj1-f174.google.com with SMTP id 16so21638643ljv.10
        for <linux-security-module@vger.kernel.org>; Tue, 16 Jul 2019 16:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0Bd5Qq9nLF54vSE2ZtollGcnD2iIGwl8u2ADzpQ1DYA=;
        b=OZv744opL0MsApSsRmeJVqQX8BYqeu8jV35rFM/9rEg7s3qoSdTWxjCi5xMSjhdPH8
         UcE3Op4Sc+eo+6C6fb+c8PCwhZC1n5lXvyx//PRZrGZuBfzu6h/5BfDbgO5Rj4LvXPHR
         KtLKG7ChddVPv1QkD44NYQOvMKScwn0INthD1dxcS6LoK6N4UvUhRZVjntLBKeQ6fMEp
         /XP2VAkVaKY8NUZ9gX2EDJbbapmWpv1/bzfaEpr0a5tdXmP3QX2heRgklGRfVgblKfda
         GRezAUbFTStuGKYGdxEbC/KS5m4vEQU7PfiBaZEO09qNS5m5oJuYlOi9h2HH54E+sNrQ
         Ooog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0Bd5Qq9nLF54vSE2ZtollGcnD2iIGwl8u2ADzpQ1DYA=;
        b=ODfTb51kHzgKO/2tAGtk2aL5HwFRosZ43828p32tydg64QFpT7PIXPnnlAaFbcIPXf
         TvpWvg1vwQdPN0L1Tw150X0Os2cVI4Q+AlK5p7FoN1eX3afk8nW4+6KFRpMRE0yBHTzu
         iBxV2+w+/mSJo6KnP0aePjPy1JpIlXThiism6PLgPhTHlTW5OHe+KXMWkkQccnxwO8Ds
         +MEm/9qHZo6H0i14DMYW4vckR1eabrkBYYdPV8nbC0NLw/hEX0ovDy/OVxhrmRn0uc7f
         JJZdSvtqt2OcYu9B8qR93EfBhflFEO/VnToQO8D3UKwpf9vkESmXc7XZ/rBxdp4opHyH
         ng3Q==
X-Gm-Message-State: APjAAAXPRFXiF/H+qfBeAxoDLLxlu7kT4VZG4wyoJde94ie9p7+U8n30
        AlYzUyqW+VXJxdGp8qG3JPT7rZCbY6pFssUcOQ==
X-Google-Smtp-Source: APXvYqyuzAElHMYoAnpdQpmhpzt+MZGUlfyqihr2+6WE/dmLzZgr+rjj+LTkcGwMs9DGUI6WPn/xR0cd0E4G9bn882g=
X-Received: by 2002:a2e:9dc1:: with SMTP id x1mr19147241ljj.0.1563318845975;
 Tue, 16 Jul 2019 16:14:05 -0700 (PDT)
MIME-Version: 1.0
References: <f824828c-5c9d-b91e-5cec-70ee7a45e760@schaufler-ca.com>
 <d1a237d3-4b72-48b0-27d6-fb168354ad31@schaufler-ca.com> <CAHC9VhTQLihNQ1iGjJB=LAn=C6BQokFsjsRcj8O_O9AjqQ7HBg@mail.gmail.com>
 <2517266.eHZzEmjMsX@x2> <27e2c710-efe6-d9cd-d4f9-bc217df5ede3@schaufler-ca.com>
In-Reply-To: <27e2c710-efe6-d9cd-d4f9-bc217df5ede3@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 16 Jul 2019 19:13:54 -0400
Message-ID: <CAHC9VhTpcnyGg5j3b6Z7Yi0Ob01JETRiBmz1AuLqPWqP9tEAnA@mail.gmail.com>
Subject: Re: Preferred subj= with multiple LSMs
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Steve Grubb <sgrubb@redhat.com>,
        Richard Guy Briggs <rgb@redhat.com>,
        "linux-audit@redhat.com" <linux-audit@redhat.com>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Jul 16, 2019 at 6:18 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> It sounds as if some variant of the Hideous format:
>
>         subj=selinux='a:b:c:d',apparmor='z'
>         subj=selinux/a:b:c:d/apparmor/z
>         subj=(selinux)a:b:c:d/(apparmor)z
>
> would meet Steve's searchability requirements, but with significant
> parsing performance penalties.

I think "hideous format" sums it up nicely.  Whatever we choose here
we are likely going to be stuck with for some time and I'm near to
100% that multiplexing the labels onto a single field is going to be a
disaster.

-- 
paul moore
www.paul-moore.com
