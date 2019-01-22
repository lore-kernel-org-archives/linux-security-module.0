Return-Path: <SRS0=9r3I=P6=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C98FC282C5
	for <linux-security-module@archiver.kernel.org>; Tue, 22 Jan 2019 17:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50A4B217F5
	for <linux-security-module@archiver.kernel.org>; Tue, 22 Jan 2019 17:48:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="iIt5NhBO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbfAVRsR (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 22 Jan 2019 12:48:17 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42942 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbfAVRsR (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 22 Jan 2019 12:48:17 -0500
Received: by mail-lj1-f195.google.com with SMTP id l15-v6so21400002lja.9
        for <linux-security-module@vger.kernel.org>; Tue, 22 Jan 2019 09:48:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Om+BcGGu6G0+DC4UgEJBrr4yO4tKSm87s11wNparSPw=;
        b=iIt5NhBOZA7jcYRX7ScJ9kYXUpH7qePUQ340fDriJS6dPo6ja1H6EdidggTjQP8bY8
         lfQ5M6gLqYE0wy4hjYWUq/sgfLTAnX9yha+sSDvVQdBIQlAmsvdaPnEIt0Snadz7pOIs
         5eCVGpF+6QvfWNDHK32vHK1c01aewJvFSbmmoFsCKh2t3mJooHeT3mXZ9rGqxFJH9XL7
         uEnrTzEZ+8aUPx5S+38zjoOr04uISMW7d/25N7SfWnAqz3S0VXsSMvQUD2kbMpB+CtZe
         eqp3pT9ruNk7tn7+nJdd7eMXvcyQuruItl/MD7PdUCleumso/Ru1T2l0ekavgvPkBb/b
         8GWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Om+BcGGu6G0+DC4UgEJBrr4yO4tKSm87s11wNparSPw=;
        b=FivIphUNO0gfpppkmQH2YrxzaTLZYIjJq/JD3BKePUP0WtAF4EcMDbuRlOsPDoFU3N
         zxLSixGmA5EPvuQqW5SvmnA1tOiM763mh9WSEBIv/LDmt0R7f7vsqvLWLF4te7FQxA8K
         2X3pszWxLEqjLdWfiYLatENU+6V6BbHhBTOU6/kgUTwtwAaZ2crtXVuXXGyKl4UmdlJ0
         FyjwMpusiimpoocPsTX87IzhedQeMFRy5wQEg06OROp8GkqDOEQ+RSiHMZ3G96O5lbKt
         9fjvQlIbNWzFkP0H1AScXiqV7vAYhk6gWxn/qOCCzuNzJptJju6jL/YZUMB3d2CEbD9G
         6l6w==
X-Gm-Message-State: AJcUukfOE3nDpHiOqoUNKsamUzYayn59TuHG7mrY0+9vnHScVxP4F5ak
        lnK3d5BhfnyzlNpCMDNvOkWhQxSvoxBLPmHLfsQU
X-Google-Smtp-Source: ALg8bN5Xrz/h54QKR62wZVgIV9+SHcp5N74SsEoWM9SiRJFfJQKXta5FlovAIKcIdkjlmBrXXPBCFuBYc6ws6AurnCU=
X-Received: by 2002:a2e:9d17:: with SMTP id t23-v6mr20827284lji.57.1548179295275;
 Tue, 22 Jan 2019 09:48:15 -0800 (PST)
MIME-Version: 1.0
References: <16659801547571984@sas1-890ba5c2334a.qloud-c.yandex.net>
 <1378e106-1826-2ab4-a3b1-88b57cee8497@schaufler-ca.com> <CAHC9VhTNnEpOito2b6ARFseCXcSw+kSE0erKhikd6FfwwBYppA@mail.gmail.com>
 <CAHC9VhTEUzjd=Wk1y0Jjq8y0-xUf-8nVY727KRBD3z6APuQKfw@mail.gmail.com>
 <10416711547829281@sas1-fed4e4c8a570.qloud-c.yandex.net> <CAHC9VhS-veQHhyhVBv0kRr0MZc6ZSh9WWO-9K2tOyQxFba43eA@mail.gmail.com>
 <42957681548090694@sas1-adb97d30497b.qloud-c.yandex.net> <CAHC9VhT58UT4oN9uXq3eew-OeZi_Yos+s4b21XCoSB3CTMeZNg@mail.gmail.com>
 <4824091548178512@sas1-ea1d14049a51.qloud-c.yandex.net>
In-Reply-To: <4824091548178512@sas1-ea1d14049a51.qloud-c.yandex.net>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 22 Jan 2019 12:48:04 -0500
Message-ID: <CAHC9VhRhEvcU804qMfZik7qwohuCDfcbvJMHRT+DxMPvvMDEGQ@mail.gmail.com>
Subject: Re: Kernel memory corruption in CIPSO labeled TCP packets processing.
To:     Nazarov Sergey <s-nazarov@yandex.ru>
Cc:     "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Jan 22, 2019 at 12:35 PM Nazarov Sergey <s-nazarov@yandex.ru> wrote:
> 22.01.2019, 19:49, "Paul Moore" <paul@paul-moore.com>:
> >
> > Granted I'm looking at this rather quickly, so I may be missing
> > something, but why the changes to ip_options_compile()? Couldn't you
> > simply set opt->data manually (set the ptr) in cipso_v4_error() before
> > calling ip_options_compile() and arrive at the same result without
> > having to modify ip_options_compile()? I suppose there is the rtable
> > value to worry about, but ip_options_echo() should take care of that,
> > yes? No?
>
> ip_options_compile calls icmp_send, if someting wrong. So, we'll go back
> to trying to fix. ip_options_compile changes needed to avoid this.

Yes, exactly.  If you don't pass the skb it shouldn't attempt to call
icmp_send() in case of error.

-- 
paul moore
www.paul-moore.com
