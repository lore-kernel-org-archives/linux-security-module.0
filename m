Return-Path: <SRS0=H0F3=27=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C1D7C3F68F
	for <linux-security-module@archiver.kernel.org>; Fri, 10 Jan 2020 20:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42CE420838
	for <linux-security-module@archiver.kernel.org>; Fri, 10 Jan 2020 20:21:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="c38SvAdv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbgAJUVs (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 10 Jan 2020 15:21:48 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38880 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgAJUVs (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 10 Jan 2020 15:21:48 -0500
Received: by mail-lj1-f195.google.com with SMTP id w1so3420090ljh.5
        for <linux-security-module@vger.kernel.org>; Fri, 10 Jan 2020 12:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7yLQzw93HlFRviBArrYyOpwzYNVdXPIbSagU7ITmK9s=;
        b=c38SvAdvl5MAfXJDwFU2V+RiTubIzBd2TjNeAJqMhTvspaEe7WGd55Y3cOMbOU+h4H
         Db+eLJDBIqHJtMEB2fF0knHiqr5KcUU5wCVCZ0LJjqGMufJ5FGF+/eT4TWaEs/C9W3Cs
         ZmDd8VbrdkBHPOm7AqXSzr/7CHyViM47H4cXTR+cNagHUkeNL1R+3F5ZYwOvHlhAd4KM
         XV0UqrUHF5pDgEAfsVOZdZuGA8988z4IppY3sVlrTJgt1eH3ZBlokZ78NHfasfplUb9A
         ccKOW4rmVXsKKHtaQXFU1SAgmpAu+Xj3n6720CJ348XhpS1RqYKd8m7M3wUZ/2CS47m2
         DHvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7yLQzw93HlFRviBArrYyOpwzYNVdXPIbSagU7ITmK9s=;
        b=EXbRuTAsCgRpfaCPVCQ12URIb2aWO6pawuJkHOItAg4De2C+3gpdAHAW2LoxyqksFR
         IvwIjoS89yzg1QyBK97CdJpD8MOY0yMiexBR8Rr/jKO53dfyAEjM58rFlh8Af80oAcsE
         bfwavCN6poUJqFQ3E0AOdtTs7bDA0qmNafMEa2dAeCy70CbfCKs/ZEzUO3t7G4U7VDnu
         4h0J2YR3G0PZAPCg/ustk5VcdR2cCPy0+srQKRC6JIQ2qmj1L3WAAkW+r3KfbyrCudeR
         2JppQtUe4BOhFJIJ0RoDxNwMLH22GTBh7y3U/pJxwDmvLhjFOzeGajBy+dGC6+zcPCI4
         2dRg==
X-Gm-Message-State: APjAAAXfoFWaP781dEzDgeJ+7QwXZvgeoormIQ5jhDL5bCOAVO2RX2O+
        OheDjpIsgUHvRN43VEFb+bRyCUemGBIi/hakurM/
X-Google-Smtp-Source: APXvYqzdxdZN/CE1UMUF3qE36RvSxD+f6Rn1i6mtmQ4ixgyTfIlH7BQru54RYoZTyn6ZQmfrlFWJlcqeo37GqR747pU=
X-Received: by 2002:a2e:9f52:: with SMTP id v18mr3547382ljk.30.1578687706327;
 Fri, 10 Jan 2020 12:21:46 -0800 (PST)
MIME-Version: 1.0
References: <20200107133154.588958-1-omosnace@redhat.com> <20200107133154.588958-2-omosnace@redhat.com>
In-Reply-To: <20200107133154.588958-2-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 10 Jan 2020 15:21:35 -0500
Message-ID: <CAHC9VhSu3Nt8JEQW-WOVwGnzsKy1o4uj=FkoVXaa-qQaRoJ85w@mail.gmail.com>
Subject: Re: [PATCH 1/2] selinux: treat atomic flags more carefully
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        selinux@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Micah Morton <mortonm@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Jan 7, 2020 at 8:32 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> The disabled/enforcing/initialized flags are all accessed concurrently
> by threads so use the appropriate accessors that ensure atomicity and
> document that it is expected.
>
> Use smp_load/acquire...() helpers (with memory barriers) for the
> initialized flag, since it gates access to the rest of the state
> structures.
>
> Note that the disabled flag is currently not used for anything other
> than avoiding double disable, but it will be used for bailing out of
> hooks once security_delete_hooks() is removed.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  security/selinux/hooks.c            | 21 ++++++++--------
>  security/selinux/include/security.h | 33 +++++++++++++++++++++++--
>  security/selinux/ss/services.c      | 38 ++++++++++++++---------------
>  3 files changed, 61 insertions(+), 31 deletions(-)

Merged into selinux/next, thanks Ondrej!

-- 
paul moore
www.paul-moore.com
