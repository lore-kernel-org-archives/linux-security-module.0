Return-Path: <SRS0=hMH8=MO=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DFACC64EBC
	for <linux-security-module@archiver.kernel.org>; Tue,  2 Oct 2018 21:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FE0E2082A
	for <linux-security-module@archiver.kernel.org>; Tue,  2 Oct 2018 21:38:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NMiT4lOj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FE0E2082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbeJCEXd (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 3 Oct 2018 00:23:33 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:39192 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726862AbeJCEXd (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 3 Oct 2018 00:23:33 -0400
Received: by mail-yb1-f195.google.com with SMTP id c4-v6so1475514ybl.6
        for <linux-security-module@vger.kernel.org>; Tue, 02 Oct 2018 14:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9U346hGaAvFdwuDfRtVfUPZUdxyBrP9tyHzIfWdZO6U=;
        b=NMiT4lOj6R7864F2apfpBwr9YrJZaHu1v1M1lJlUKGQGxn8IVg/nvC8ctMgg6veLuF
         TfU1+CDk3xeswoLTq4PSmrhqYLUfgDrne/W3SjpfDwdx7RRopnP5AaDiMGEWdTu1gDp6
         CNVyunL879b84Grv/g2tsu+HPjc6gEQsw7FJk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9U346hGaAvFdwuDfRtVfUPZUdxyBrP9tyHzIfWdZO6U=;
        b=PGocK9gwrSpcQVtgSVk08Nw368iGyeqc7Yli0DE4SOjEY/5pnNKu3qVA3lc6hSudk3
         43l/FMVwmdQMPwkWFIrfdlsH256b1HlxN7k4CQoLgJJOblz2FA1jyNA8YmicAJC28N2w
         ukH7p09edrFwBvDMA2Q3/4vAng793gF55xlpq9NBY3vXv99klG+lTJfcAlIg7A54hV0v
         Y20MKwOKUmzdQFNcNnVkOGXT66DITMK3SzqH8v/hy+2Fcabg/3nVczrvHi7Xvwqmp3nY
         hfhgXgFQGIlK6VPk0/+3EccTC9DRmn13fMhRS+PE1Ig1Lt7YrE2Z8uWrdIbamtqrpX9e
         vJdA==
X-Gm-Message-State: ABuFfog5NlarEe3cKaoH3jjWBDO7tUdW4w4213Uss1Yt6ZbMsYa10L4E
        hBeWVZ1I0q/StNkKrkXPZAkmFQ6Nv8o=
X-Google-Smtp-Source: ACcGV63sw2fW45+XmyxqHayLgiLU6Hl+1jPmpVSD3ic1E8lxGN9q2fctiFv9USdefm2MWZzuVBMvtA==
X-Received: by 2002:a25:249:: with SMTP id 70-v6mr10072222ybc.421.1538516289190;
        Tue, 02 Oct 2018 14:38:09 -0700 (PDT)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id k2-v6sm22801754ywh.52.2018.10.02.14.38.06
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 14:38:07 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id w7-v6so1474318ybm.7
        for <linux-security-module@vger.kernel.org>; Tue, 02 Oct 2018 14:38:06 -0700 (PDT)
X-Received: by 2002:a25:2395:: with SMTP id j143-v6mr1547958ybj.137.1538516286591;
 Tue, 02 Oct 2018 14:38:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Tue, 2 Oct 2018 14:38:05 -0700 (PDT)
In-Reply-To: <alpine.LRH.2.21.1810030719040.23596@namei.org>
References: <20181002005505.6112-1-keescook@chromium.org> <20181002005505.6112-11-keescook@chromium.org>
 <alpine.LRH.2.21.1810030719040.23596@namei.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 2 Oct 2018 14:38:05 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJRFv_e7_-hAnuuEoC90JPXG2aTaHJ98_UaoS_4R1mYtg@mail.gmail.com>
Message-ID: <CAGXu5jJRFv_e7_-hAnuuEoC90JPXG2aTaHJ98_UaoS_4R1mYtg@mail.gmail.com>
Subject: Re: [PATCH security-next v4 10/32] LSM: Don't ignore initialization failures
To:     James Morris <jmorris@namei.org>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        LSM <linux-security-module@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Oct 2, 2018 at 2:20 PM, James Morris <jmorris@namei.org> wrote:
> On Mon, 1 Oct 2018, Kees Cook wrote:
>
>> LSM initialization failures have traditionally been ignored. We should
>> at least WARN when something goes wrong.
>
> I guess we could have a boot param which specifies what to do if any LSM
> fails to init, as I think some folks will want to stop execution at that
> point.
>
> Thoughts?

I'm not opposed, but I won't author it because Linus will yell at me
about introducing a "machine killing" option.

-Kees

-- 
Kees Cook
Pixel Security
