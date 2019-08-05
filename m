Return-Path: <SRS0=x/8A=WB=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CAE6C433FF
	for <linux-security-module@archiver.kernel.org>; Mon,  5 Aug 2019 14:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6244820679
	for <linux-security-module@archiver.kernel.org>; Mon,  5 Aug 2019 14:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565015281;
	bh=EFibC8nuHz8k2yU2grpf2ggs1Z3fm4CC0QMtC9RxKSo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uDWeZiXnryD8zS6bC7zMRO9jNe3+qXrQ9+ekAgJ9lwY/inCza88+CUE/WMJ6I+0xu
	 YNpfCy30kDXXa+QICUdiMw09tqdVt39kr531B5PRIzoiIqNN06+8n5B6t2cH9Y5MTg
	 IGw5Qdjq++zDQorrBECnxtBt5tzIQHc5wiW2cPDg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbfHEO2A (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 5 Aug 2019 10:28:00 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45781 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727928AbfHEO17 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 5 Aug 2019 10:27:59 -0400
Received: by mail-qt1-f194.google.com with SMTP id x22so7702421qtp.12
        for <linux-security-module@vger.kernel.org>; Mon, 05 Aug 2019 07:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MPEMXXmCHM/Mi/52mb4NCYntDnv4EkvOmRuE01mrmhM=;
        b=LsYu/7kbcZOBmMJF2KPR0BdGTxfFG4KIPTNBXea2pkzguDONumtWEwAtUGH2h/3hHr
         AlrEx4oWTmsYDmbOCECB7IY3NUlCBLrjfKE5pSSSq5AhaeQ0Z+cTjkjdMxxFT5TxPVxM
         ICdTYMGtFfhKijP26HFPKcqWDexRxlkTDtrmQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MPEMXXmCHM/Mi/52mb4NCYntDnv4EkvOmRuE01mrmhM=;
        b=HF+QJUL8DovijGEJq8byPDer7ZI2H47eyqoacAZMxB2JR/WBm/AJpyi521AfqRY2/A
         y8D/AdK0ULIomDUqXgx4X7Ze+ZrfmSPU6/xqnamupvMZa8ZUbbRy2MgONlDt7k6NeO85
         mXwaRqhm/+e0DvohAaBD5GCjAUNXOMgRGNbdNvB4qJUfK3Vdh4G7OqqEDkngeSXngpr4
         Lt6BCuktGQSiy1IA9wb3nZZXC2YjeLSNGXq8gP25xpdNbmwRhsvI/8G68praJWF5DaI7
         R7sj2oEk95zHYVEBJToMQzBKua65OCcDe7gP7OagOVcWxkwP1gs/oPwgK5pFuz8vh7CQ
         SeMw==
X-Gm-Message-State: APjAAAWeV3IXCDbp7hENqMho4wyFAGd8zoQomJLUuRBZlaPMPogy1u/X
        hSFkAymWkrIwJWmsqLBS6+p6ag==
X-Google-Smtp-Source: APXvYqwNWHoP8flXC29xSNV4hE27uDEAsRgm6KXmlO41iOn5/WG4m1AQejfoVX6v04H7CdZ0ocxj9w==
X-Received: by 2002:ac8:2a88:: with SMTP id b8mr97552817qta.331.1565015278681;
        Mon, 05 Aug 2019 07:27:58 -0700 (PDT)
Received: from chatter.i7.local (192-0-228-88.cpe.teksavvy.com. [192.0.228.88])
        by smtp.gmail.com with ESMTPSA id j2sm38240945qtb.89.2019.08.05.07.27.57
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 05 Aug 2019 07:27:57 -0700 (PDT)
Date:   Mon, 5 Aug 2019 10:27:56 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Micah Morton <mortonm@chromium.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] SafeSetID MAINTAINERS file update for v5.3
Message-ID: <20190805142756.GA4887@chatter.i7.local>
References: <CAJ-EccMXEVktpuPS5BwkGqTo++dGcpHAuSUZo7WgJhAzFByz0g@mail.gmail.com>
 <CAHk-=whZzJ8WxAeHcirUghcbeOYxmpCr+XxeS9ngH3df3+=p2Q@mail.gmail.com>
 <CAJ-EccOqmmrf2KPb7Z7NU6bF_4W1XUawLLy=pLekCyFKqusjKQ@mail.gmail.com>
 <CAHk-=wgT7Z3kCbKS9Q1rdA=OVxPL32CdBovX=eHvD2PppWCHpQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <CAHk-=wgT7Z3kCbKS9Q1rdA=OVxPL32CdBovX=eHvD2PppWCHpQ@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sun, Aug 04, 2019 at 10:47:54AM -0700, Linus Torvalds wrote:
> - maybe pr-tracker-bot ignores follow-up emails with "Re:" in the 
> subject?

Yes, this is the culprit. Here are the matching regexes:

https://git.kernel.org/pub/scm/linux/kernel/git/mricon/korg-helpers.git/tree/pr-tracker-bot.py#n41

Normally, pull requests don't come in as replies -- this is the first 
one that got missed in months, to my knowledge.

I can change it to be more permissive -- the only concern would be that 
we would be scanning more bodies, and there *might* be a chance where we 
end up tracking the wrong message if someone uses Outlook-style replies 
(fully quoted messages without '>') and those replies arrive before the 
original message. Both of these are very unlikely to happen (in fact, I 
believe using Outlook-style replies on LKML would result in mass 
outrage).

So, just let me know if you'd like me to make this change and I'll 
modify the regex to be something like '^\S*:?\s*\[GIT' that should match 
most permutations of Re/Aw/etc.

-K
