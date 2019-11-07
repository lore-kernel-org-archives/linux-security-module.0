Return-Path: <SRS0=96uJ=Y7=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB0A0C43331
	for <linux-security-module@archiver.kernel.org>; Thu,  7 Nov 2019 16:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D2202077C
	for <linux-security-module@archiver.kernel.org>; Thu,  7 Nov 2019 16:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573145847;
	bh=Z1dqk+RRh5Tw9vIdgN632bDR4HOjWiROuyE5KZkrIOc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=mK3X5U0R7rIO04g82JfGvvAUmuxgfXkv/TYpIZDkV555yuSI9XtmOQCM2wuu15ogv
	 Ngxg9Laj2fpRX+h8IoI1dEEc9xWPC+8SMh46pEtIebrLnV5SPQzlBn+5y+itFSu8w7
	 AkRImiswV2oq4JyY64ZfL8xTdGb6a/ZHJDqjZLYU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729451AbfKGQ51 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 7 Nov 2019 11:57:27 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40628 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbfKGQ50 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 7 Nov 2019 11:57:26 -0500
Received: by mail-lj1-f194.google.com with SMTP id q2so3071780ljg.7
        for <linux-security-module@vger.kernel.org>; Thu, 07 Nov 2019 08:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QmbLva0bcejWfZ5vroXCCCNjtDh9+KzeuzRfAkUcNVw=;
        b=RC+2jxnet1c9HEhXNBxtTTpEfLinckdbFJn5Bmrik3m/W7Num2OjpLxTQS23AoRNRr
         Aj4dYDnclnksK9me7oG5iyDsfchGPA4TwVOyMbOGN2PJFpJroPg+VNW7luk63nWV0aoz
         X/nFl5ue/aQhw5K+6Ogz8TNi8yWG86H2/HKz4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QmbLva0bcejWfZ5vroXCCCNjtDh9+KzeuzRfAkUcNVw=;
        b=JoEnyccTo/UwT/B2ohS+SnctWAStxR6kCZdyDae7gJdJ394I1ZsVDYHT8c8CPheNbI
         tG7ZiaywZ3PCKTYu+Lil2SpgsFW7SQAqpw1W7wNVjHMvD3v9nfQTSw+jZjsYXX89ahBr
         ZJrSovvPmW9+szlqEm/BQVFBYWXulOZztXC2CVAZTA+51n4e/Mj51pDlR/gyOgbIkZAV
         QieUfBn5y04WjLknhdPWKxtWgzm/qsGiWeTWvkVpm4vHD7P6fWeYzRbKcb1P2rek2Z8+
         ViG5az9SSFd4xsCW666wimoux7TSL7tztkrkowBAnlTQEGY/oVA7upvWC50qKAtokAp9
         16eA==
X-Gm-Message-State: APjAAAVlWNSxI1f+4wcAOXOPaDYNnqVRDJh+Pq3Z7PN4abyhFac4zIUR
        6rQujZ4cc6mkt6Re+/qtVw6eU/10dTU=
X-Google-Smtp-Source: APXvYqxRf7A6wQjZNEGy23NxMmI8B+MF82GhrIQfWK2xZtXOMUzMvod3I1Y2RGAbByxPPIefN/te8g==
X-Received: by 2002:a2e:28a:: with SMTP id y10mr3246947lje.155.1573145844144;
        Thu, 07 Nov 2019 08:57:24 -0800 (PST)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id u14sm1169856lfk.47.2019.11.07.08.57.23
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Nov 2019 08:57:23 -0800 (PST)
Received: by mail-lf1-f53.google.com with SMTP id m6so2157400lfl.3
        for <linux-security-module@vger.kernel.org>; Thu, 07 Nov 2019 08:57:23 -0800 (PST)
X-Received: by 2002:ac2:5bca:: with SMTP id u10mr3159115lfn.134.1573145526683;
 Thu, 07 Nov 2019 08:52:06 -0800 (PST)
MIME-Version: 1.0
References: <157262967752.13142.696874122947836210.stgit@warthog.procyon.org.uk>
 <20191107090306.GV29418@shao2-debian>
In-Reply-To: <20191107090306.GV29418@shao2-debian>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 7 Nov 2019 08:51:50 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiJ+jaT5Ev-wCg7iGNNO_JFUyMDcat0KDdA2b_+n_cZCQ@mail.gmail.com>
Message-ID: <CAHk-=wiJ+jaT5Ev-wCg7iGNNO_JFUyMDcat0KDdA2b_+n_cZCQ@mail.gmail.com>
Subject: Re: [pipe] d60337eff1: phoronix-test-suite.noise-level.0.activity_level
 144.0% improvement
To:     lkp report check <rong.a.chen@intel.com>
Cc:     David Howells <dhowells@redhat.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>, raven@themaw.net,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        lkp@lists.01.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Nov 7, 2019 at 1:03 AM lkp report check <rong.a.chen@intel.com> wrote:
>
> FYI, we noticed a 144.0% improvement of phoronix-test-suite.noise-level.0.activity_level due to commit:
>
> commit: d60337eff18a3c587832ab8053a567f1da9710d2 ("[RFC PATCH 04/11] pipe: Use head and tail pointers for the ring, not cursor and length [ver #3]")

That sounds nice, but is odd. That commit really shouldn't change
anything noticeable. David, any idea?

               Linus
