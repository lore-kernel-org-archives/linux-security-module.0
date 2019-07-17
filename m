Return-Path: <SRS0=Vtm6=VO=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78449C76186
	for <linux-security-module@archiver.kernel.org>; Wed, 17 Jul 2019 12:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FCD020880
	for <linux-security-module@archiver.kernel.org>; Wed, 17 Jul 2019 12:24:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="AuJH/e1L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbfGQMYL (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 17 Jul 2019 08:24:11 -0400
Received: from mail-lj1-f179.google.com ([209.85.208.179]:45679 "EHLO
        mail-lj1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbfGQMYL (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 17 Jul 2019 08:24:11 -0400
Received: by mail-lj1-f179.google.com with SMTP id m23so23377400lje.12
        for <linux-security-module@vger.kernel.org>; Wed, 17 Jul 2019 05:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6fjmRWh4VVEeFFvGgt+lgp6jp51UPEMlzWuwbTO9L4k=;
        b=AuJH/e1LFAc1bhlTsCyC5vYc/VAs1BB76cesc7PDTepSuPXorBnlxTjEUA92NDBC+t
         Fj898AMwRlAEq/q5cAVczqgqCdJClWEteoSRDttCZJlt3DYFwtlwiyVT8qZ64qfKtff0
         bhBE9gNjqgX+dv5vJ/IdUFihc5FAcOqXWNxzUdp4SDNukxySNWzFoEJtsCLBQJar4Dlb
         vSbMReVbphpmAKR3vejVVHdLjpaAs28phWM3V2iMLt/f9p9+TpK/DBEA0nk7fbhOHa26
         11ructPEEN1B8N1K4g/NpZQDXQOoGPkoSD3Inu6z3rAkQpIqk/z3uBUuzRodMFHWq9xU
         CPeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6fjmRWh4VVEeFFvGgt+lgp6jp51UPEMlzWuwbTO9L4k=;
        b=e6LCuL6oBvpjMqMhKaT0dMiw15H7OoL+gspSI2lI8giugoutyR5DxM/3LtnMgaBWTk
         kzB50JUmD0P0lFU4WRxGehoGL31zsS+TtdTXjh5ednNLJqpOYs94I3Euy+Wv/LS50mg+
         Tslg18EXUrCE4Jf/G7RcLsup6JvP1PfrHX5+IhZP/JUjfxpX3iEbTbXJHvnFpGBRs2KO
         SdFc5GqUOQsqKmtF5CBej5kRPJRSTSQ5dA1tkrAZ8Jw8qwcv4KRN/Tq1GmuXLegCeEir
         pXOA7CtJa8TBzdtfihDCWlC53nGMvLVSO4Ey0skFAkjytO4Kw6xPIGXYAQQvoXRYePs7
         dvMQ==
X-Gm-Message-State: APjAAAUWEAmdV735I8Nj96HCAwcpoe4Jc8C9RGAZmg6orzyHP8R2eRGW
        eRCj9IY9A+LyIXQAmcKTPMHz5RC60RbfkoQPKA==
X-Google-Smtp-Source: APXvYqz+uZDCqnc/wZtJVW6dbWEGdaaWNRkbT/+omtUxB5Tj1/fPQfWmrZtkcbzIrsgyqLq4GzdlH97S4aocUKJUANc=
X-Received: by 2002:a2e:3807:: with SMTP id f7mr7467552lja.87.1563366249173;
 Wed, 17 Jul 2019 05:24:09 -0700 (PDT)
MIME-Version: 1.0
References: <f824828c-5c9d-b91e-5cec-70ee7a45e760@schaufler-ca.com>
 <d1a237d3-4b72-48b0-27d6-fb168354ad31@schaufler-ca.com> <CAHC9VhTQLihNQ1iGjJB=LAn=C6BQokFsjsRcj8O_O9AjqQ7HBg@mail.gmail.com>
 <2517266.eHZzEmjMsX@x2> <CAHC9VhS-WGuKYzG5AU01BN8tk8nzp+7qxk7Sz-hbHQGL+UXOfg@mail.gmail.com>
 <alpine.LRH.2.21.1907171435200.2314@namei.org>
In-Reply-To: <alpine.LRH.2.21.1907171435200.2314@namei.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 17 Jul 2019 08:23:57 -0400
Message-ID: <CAHC9VhQA9iCbk2F35i9qjP5G8SP_jzMzduwxJcj4wH7fbR1kDw@mail.gmail.com>
Subject: Re: Preferred subj= with multiple LSMs
To:     James Morris <jmorris@namei.org>
Cc:     Steve Grubb <sgrubb@redhat.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Richard Guy Briggs <rgb@redhat.com>,
        "linux-audit@redhat.com" <linux-audit@redhat.com>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Jul 17, 2019 at 12:36 AM James Morris <jmorris@namei.org> wrote:
> On Tue, 16 Jul 2019, Paul Moore wrote:
>
> > The subj_X approach is still backwards compatible, the difference is
> > that old versions of the tools get a "?" for the LSM creds which is a
> > rather sane way of indicating something is different.
>
> This will still break existing userspace, right?  We can't do that.

Trust me, I don't want to break userspace, I wouldn't be suggesting that.

The subj_X approach would cause userspace to see a "?" for the LSM
creds when looking at logs from a stacked-LSM system.  I would argue
this is actually safer than the multiplexed approach as "?" is a safe
sentinel used by the audit subsystem when the value can't be
determined; the multiplexed label in the hands of legacy userspace
tools would be confusing at best, and misleading at worst.

> > Once again, I believe that the subj_X approach is going to be faster
> > than safely parsing the multiplexed format.
>
> What about emitting one audit record for each LSM?

In many of the LSM generated audit events that is what would happen,
and should just work.  What we've been discussing in all the cases
where the audit event is generated outside the context of the LSM but
the LSM credentials are still desirable bits of information.  While we
are definitely going in the direction of making multiple record events
more common, duplicating the same record, with only changes to the LSM
creds, may end up confusing Steve's tools.  It would also end up
bloating the audit log, which I know is something everyone wants to
avoid.

-- 
paul moore
www.paul-moore.com
