Return-Path: <SRS0=hu4j=BY=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5CC6C433DF
	for <linux-security-module@archiver.kernel.org>; Fri, 14 Aug 2020 17:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2E2F20838
	for <linux-security-module@archiver.kernel.org>; Fri, 14 Aug 2020 17:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597425177;
	bh=AfbstP+k4FgET/zQNAlAR/09TPUNHExZjGv0x7+VM0A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=OJe29GV5jGohsUxbfapP4FCNW0lTG3luT04MCfOHqiDYBQugJ61MDCGMv4Qea3F81
	 MfcG0L7sDGq2zVcCJzCzf1MtE8eJGwNPAdmJ/fkMwDG9PFLkXyAIjjblrJ1NcqoOGp
	 ZXxaQz7W7Fm0gycCokAfPm2BfG0eQmrJnlf0F8w8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbgHNRM4 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 14 Aug 2020 13:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727894AbgHNRMz (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 14 Aug 2020 13:12:55 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 087D3C061384
        for <linux-security-module@vger.kernel.org>; Fri, 14 Aug 2020 10:12:55 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id c16so10654568ejx.12
        for <linux-security-module@vger.kernel.org>; Fri, 14 Aug 2020 10:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qYuJ9NHHO+qnoSaHW0PlHI0fiXCW7zDlZFu/ah5uFho=;
        b=QZC+eNnnLcPaczh2E7Iym7nx2PQpiiDURT50bzxJZUsdtO86YlDCUBTiiWPJAXsWnA
         U49+U2ao8O1Ymle/LvRAFOmnKYrXWnRy0koTc1q4uPH3YiU1H0Bu0Wp5Fx58rMDOEorn
         lZP3mAReqkIBPzLDybNfptRtvd5sif7WdrmnA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qYuJ9NHHO+qnoSaHW0PlHI0fiXCW7zDlZFu/ah5uFho=;
        b=DC5us9Iy+ulpijuXbImoyDWBudrDu6BUwrmb+5msxAepQ7RDDDbjKABOjV8UBtUA7u
         Aq0+HCiSzpcrBY7tmVmECQOci94kuctZRjE+7dYX+gH7A6lDl6hr7ZXaPmiEm3PwGdTk
         PR8SDNCNmoNR36ecBTed2fle93ZQbqpM5fochvT3JCEARXsVrMXcCVydGp2cXXyN+M3D
         +A59O438ZQLvuW246DrDyKFzYec0D6IlgCeIFxK4OInSmMfYIp83ON4+canhzXNW0Sz0
         AvVzfY+Xt+DJAxKDEnHoDjvcwl1h6DKzNVmsxEf3jCJGiRZUcq2d5mBh9w+h5vqyTlzT
         C4Tg==
X-Gm-Message-State: AOAM532jqJZ00FXaSzrccBStt9XVcK+yNOq15S6natFfTWw0lWplWLYu
        ovM0hFKzQxLMk9KrjVEmXbbLKRhV/Nlcwg==
X-Google-Smtp-Source: ABdhPJwKVQvuJGfY+swwmK2810FNVNrO033r90cLo+SkOSRlGqMBLJIvhcvMSvJamYuMkbaZlQyY4w==
X-Received: by 2002:a17:906:36c2:: with SMTP id b2mr3258484ejc.238.1597425173470;
        Fri, 14 Aug 2020 10:12:53 -0700 (PDT)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id v20sm6941282ejr.12.2020.08.14.10.12.52
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Aug 2020 10:12:52 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id m22so10637849eje.10
        for <linux-security-module@vger.kernel.org>; Fri, 14 Aug 2020 10:12:52 -0700 (PDT)
X-Received: by 2002:a2e:9a11:: with SMTP id o17mr1629608lji.314.1597424726058;
 Fri, 14 Aug 2020 10:05:26 -0700 (PDT)
MIME-Version: 1.0
References: <1842689.1596468469@warthog.procyon.org.uk> <1845353.1596469795@warthog.procyon.org.uk>
 <CAJfpegunY3fuxh486x9ysKtXbhTE0745ZCVHcaqs9Gww9RV2CQ@mail.gmail.com>
 <ac1f5e3406abc0af4cd08d818fe920a202a67586.camel@themaw.net>
 <CAJfpegu8omNZ613tLgUY7ukLV131tt7owR+JJ346Kombt79N0A@mail.gmail.com>
 <CAJfpegtNP8rQSS4Z14Ja4x-TOnejdhDRTsmmDD-Cccy2pkfVVw@mail.gmail.com>
 <20200811135419.GA1263716@miu.piliscsaba.redhat.com> <CAHk-=wjzLmMRf=QG-n+1HnxWCx4KTQn9+OhVvUSJ=ZCQd6Y1WA@mail.gmail.com>
 <52483.1597190733@warthog.procyon.org.uk> <CAHk-=wiPx0UJ6Q1X=azwz32xrSeKnTJcH8enySwuuwnGKkHoPA@mail.gmail.com>
 <679456f1-5867-4017-b1d6-95197d2fa81b@auristor.com>
In-Reply-To: <679456f1-5867-4017-b1d6-95197d2fa81b@auristor.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 14 Aug 2020 10:05:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=whLhwum2E+qperD=TypGHXxoBtXOu-HHDd9L9_XFFyiaA@mail.gmail.com>
Message-ID: <CAHk-=whLhwum2E+qperD=TypGHXxoBtXOu-HHDd9L9_XFFyiaA@mail.gmail.com>
Subject: Re: file metadata via fs API (was: [GIT PULL] Filesystem Information)
To:     Jeffrey E Altman <jaltman@auristor.com>
Cc:     David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Karel Zak <kzak@redhat.com>,
        Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Christian Brauner <christian@brauner.io>,
        Lennart Poettering <lennart@poettering.net>,
        Linux API <linux-api@vger.kernel.org>,
        Ian Kent <raven@themaw.net>,
        LSM <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Aug 12, 2020 at 8:53 PM Jeffrey E Altman <jaltman@auristor.com> wrote:
>
> For the AFS community, fsinfo offers a method of exposing some server
> and volume properties that are obtained via "path ioctls" in OpenAFS and
> AuriStorFS.  Some example of properties that might be exposed include
> answers to questions such as:

Note that several of the questions you ask aren't necessarily
mount-related at all.

Doing it by mount ends up being completely the wrong thing.

For example, at a minimum, these guys may well be per-directory (or
even possibly per-file):

>  * where is a mounted volume hosted? which fileservers, named by uuid
>  * what is the block size? 1K, 4K, ...
>  * are directories just-send-8, case-sensitive, case-preserving, or
>    case-insensitive?
>  * if not just-send-8, what character set is used?
>  * if Unicode, what normalization rules? etc.
>  * what volume security policy (authn, integ, priv) is assigned, if any?
>  * what is the replication policy, if any?
>  * what is the volume encryption policy, if any?

and trying to solve this with some kind of "mount info" is pure garbage.

Honestly, I really think you may want an extended [f]statfs(), not
some mount tracking.

                 Linus
