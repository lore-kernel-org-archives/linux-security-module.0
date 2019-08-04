Return-Path: <SRS0=dEQQ=WA=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D53E8C19759
	for <linux-security-module@archiver.kernel.org>; Sun,  4 Aug 2019 17:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BE922070D
	for <linux-security-module@archiver.kernel.org>; Sun,  4 Aug 2019 17:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564940895;
	bh=ggEn9CNkrRVbsmb8JS/qtor2ggCZ+icfElBh7ri1eOY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=NutNY7ODTRxpC9D08e8UoJyUhlx4pBgLx0rCLJ9oq6eP5dat7HpiuudNSk4puqJ7I
	 pYlHcel96vXgZ6adCqtmECXcOgCMAdNiG2UiwtftZ+h40lF+E5onUpacHfqS+DFGnZ
	 siZvPJFAqnkie6gMEHruEt66/HygFlD7Su9MMffg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbfHDRsO (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 4 Aug 2019 13:48:14 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40078 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726474AbfHDRsO (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 4 Aug 2019 13:48:14 -0400
Received: by mail-lj1-f194.google.com with SMTP id m8so43665827lji.7
        for <linux-security-module@vger.kernel.org>; Sun, 04 Aug 2019 10:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rtj7voNPnR4Wiu+uq0F+P27/AFOcsLAfhzZSJLzdH5E=;
        b=P5aqPh8FSawTh+Z9CFacvErR5U0UMmC5gluSOokj58/8tSepT3b34XLtcSJjUbH2MD
         R+MU0q9eLGwQVSdSKAV5UNOuUphnRuigcmlh+bWcingqC+Bj2OZIJlQzb5ZlGnp1StlF
         I8U4Sw7iu0sB6HCq7WRgxi4Ip649XLmLNAFKM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rtj7voNPnR4Wiu+uq0F+P27/AFOcsLAfhzZSJLzdH5E=;
        b=jg7kt2hpJix52hrM25ET5yUKEtFHTGhmFImXysL3h+uhLu5JZa62NxznFInv/DFgSx
         KdnOTF0O2vTzYHOHk8su8sKg9C8F6v7jG7aj53QddsoEnAGlnZYe3S/5Xccipp0bFsH0
         0KJoBW4BlP4kT1ly++jR2OFnlH+uWJGb9IteWuxA4oEhcggTJ/IEucUMD/h5QlPbyLfc
         1/vWh+ow+lPcyjWeB7Asp6zrsGGUiUFJfkTZGkSY8lPt4uYSYaugx8Khx9pFybrCwaZB
         vZ/P7QTZhPpJ2EDVStJU7OMn/KPs2zfwItxncbdXZiJl5L/WW67IUBdSr3CcVS3R1vWx
         Z/JQ==
X-Gm-Message-State: APjAAAUVSWi0iSHYxymtrIViim1wvvqlvApWbNEkc69ZPN32OiGy9yPU
        9GvYCeByz4eYtNfGj/+WqPy/nUj3lxw=
X-Google-Smtp-Source: APXvYqy4WySberZToyMZJKDHkijEvBheId7TL2QV72CTLtht+tslx+CH/ad2Vo8H8Z+VoIkzc/p3Hg==
X-Received: by 2002:a2e:8849:: with SMTP id z9mr36891205ljj.203.1564940892362;
        Sun, 04 Aug 2019 10:48:12 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id q22sm16781544lje.75.2019.08.04.10.48.11
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Aug 2019 10:48:11 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id k18so77234568ljc.11
        for <linux-security-module@vger.kernel.org>; Sun, 04 Aug 2019 10:48:11 -0700 (PDT)
X-Received: by 2002:a2e:9ec9:: with SMTP id h9mr72983638ljk.90.1564940890784;
 Sun, 04 Aug 2019 10:48:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ-EccMXEVktpuPS5BwkGqTo++dGcpHAuSUZo7WgJhAzFByz0g@mail.gmail.com>
 <CAHk-=whZzJ8WxAeHcirUghcbeOYxmpCr+XxeS9ngH3df3+=p2Q@mail.gmail.com> <CAJ-EccOqmmrf2KPb7Z7NU6bF_4W1XUawLLy=pLekCyFKqusjKQ@mail.gmail.com>
In-Reply-To: <CAJ-EccOqmmrf2KPb7Z7NU6bF_4W1XUawLLy=pLekCyFKqusjKQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 4 Aug 2019 10:47:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgT7Z3kCbKS9Q1rdA=OVxPL32CdBovX=eHvD2PppWCHpQ@mail.gmail.com>
Message-ID: <CAHk-=wgT7Z3kCbKS9Q1rdA=OVxPL32CdBovX=eHvD2PppWCHpQ@mail.gmail.com>
Subject: Re: [GIT PULL] SafeSetID MAINTAINERS file update for v5.3
To:     Micah Morton <mortonm@chromium.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     linux-security-module <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Aug 1, 2019 at 11:11 AM Micah Morton <mortonm@chromium.org> wrote:
>
> The following changes since commit 609488bc979f99f805f34e9a32c1e3b71179d10b:
>
>   Linux 5.3-rc2 (2019-07-28 12:47:02 -0700)
>
> are available in the Git repository at:
>
>   https://github.com/micah-morton/linux.git
>   tags/safesetid-maintainers-correction-5.3-rc2

Hmm.

This pull request was apparently not caught by pr-tracker-bot for some
reason, so it didn't get the automated "this has been pulled" message.

I'm not entirely sure why - it was cc'd to lkml, and I see it on lore as

   https://lore.kernel.org/lkml/CAJ-EccOqmmrf2KPb7Z7NU6bF_4W1XUawLLy=pLekCyFKqusjKQ@mail.gmail.com/

so the email itself made it through the system. And it has "GIT PULL"
in the subject line, so the pr-tracker-bot should have looked at it.

I see a couple of _potential_ reasons why it might have been overlooked:

 - maybe the "--" marker after your explanation made pr-tracker-bot go
"oh, the rest is just a signature"

 - the fact that the git link looks more like a regular web thing, and
the branch name is on another line. Does pr-tracker-bot only trigger
on kernel.org things?

 - maybe pr-tracker-bot ignores follow-up emails with "Re:" in the subject?

but it could be something else too.

Adding Konstantin to the participants, since he knows the magic.

This is not a big deal, and I have probably missed a lot of other
cases where the pr-tracker-bot doesn't react to pull requests, but I
really like how it gives a heads-up to people about their pulls
without me having to do anything extra, so I generally try to look for
failures when I can.

Konstantin?

                  Linus
