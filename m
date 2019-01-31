Return-Path: <SRS0=hRTQ=QH=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A141C169C4
	for <linux-security-module@archiver.kernel.org>; Thu, 31 Jan 2019 17:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0115620B1F
	for <linux-security-module@archiver.kernel.org>; Thu, 31 Jan 2019 17:44:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Lbm7Ajk5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbfAaRoD (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 31 Jan 2019 12:44:03 -0500
Received: from mail-lf1-f41.google.com ([209.85.167.41]:36816 "EHLO
        mail-lf1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbfAaRoD (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 31 Jan 2019 12:44:03 -0500
Received: by mail-lf1-f41.google.com with SMTP id a16so3009708lfg.3
        for <linux-security-module@vger.kernel.org>; Thu, 31 Jan 2019 09:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z/qGLqs3Y9QIb+ifodOXo9LL2UnAj6Xio+3e9N5Habg=;
        b=Lbm7Ajk5iswWNdIclqld/UBPsufNmlCro+hy7ZQbWDUIqLPA0o711Y6gfzbXGbszXC
         PXZbOtPAEOU/tl4dy5u/0qBtpfp9a3FEpl5AMSimiNHB7ynmwTty6OaQrExYhDTmVvqz
         NL628HoGZ1uRIY/4Rq28xM4l2ykzlkE2eUkIo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z/qGLqs3Y9QIb+ifodOXo9LL2UnAj6Xio+3e9N5Habg=;
        b=Njw04sg2WZ/msUZqk46x7V8U6WVdHYGrt2SDQ1VqP1Rxg4yA2HwJwW+FtWFz9ooTsb
         hc0L86idErj1ACKqmnR80awq9VcZY1hKTjYEQWmOQA/7Ep/VH9HNHLFReRvKZlGiKCX3
         RbegkDuDxdxd4Yyo36RlMjmGsEndv2xRbVghJ+jY+KXZMk2Atui08AC7t4EzLyQzYX+h
         f6Kp2HfH2tTTCCYjiYDF5hf5oZjH8x3zg1m+L7OOZn5PRAQXsx5Xy4K3ZbtU0LLk+sd5
         ilGQLYd5aOWHAgPGTmeJYnYVvpRCFjbk1ue959U455EKublGyVz0++v6zdZaDosieZKw
         rxWQ==
X-Gm-Message-State: AJcUukfTdDVdLTUA0FwvH+uZPAoub04RFjKHdJdyj/CWrCezr5XXmWL8
        6M5go7+iTarZJ8PJYqN6efKv5SBvM/0=
X-Google-Smtp-Source: ALg8bN5eMMubvzRJQIO4SlBGSUZx10WCo9cju0qjZaPWm+LF9flhnoaoNOsHvcKOWrjSajPF0WGlUg==
X-Received: by 2002:a19:c7c2:: with SMTP id x185mr30193513lff.123.1548956640806;
        Thu, 31 Jan 2019 09:44:00 -0800 (PST)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id l21-v6sm876582lji.6.2019.01.31.09.43.59
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 09:44:00 -0800 (PST)
Received: by mail-lf1-f42.google.com with SMTP id a8so2991637lfk.5
        for <linux-security-module@vger.kernel.org>; Thu, 31 Jan 2019 09:43:59 -0800 (PST)
X-Received: by 2002:a19:ef15:: with SMTP id n21mr28198593lfh.21.1548956638976;
 Thu, 31 Jan 2019 09:43:58 -0800 (PST)
MIME-Version: 1.0
References: <20190120160413.GB30478@linux.intel.com> <20190122010218.GA26713@linux.intel.com>
 <20190122025836.GH25163@ziepe.ca> <20190122132910.GA2720@linux.intel.com>
 <CAHk-=wgdOfi+zVVfKDDqJMs2Y7Lq0uufmP8Hx8JzQFA9UzNrBw@mail.gmail.com>
 <20190123153638.GA8727@linux.intel.com> <CAHk-=whgoJ8aAYH37hnyFjZ8jbYyswyf9wZZ82tTFL5f2he+6g@mail.gmail.com>
 <20190129132016.GA1602@linux.intel.com> <20190131122606.GA12470@linux.intel.com>
 <20190131160437.GA5629@linux.intel.com> <20190131170603.GA18349@linux.intel.com>
In-Reply-To: <20190131170603.GA18349@linux.intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 31 Jan 2019 09:43:42 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh+TBaphuAbHyNMdGYz=JM6tcuAfAsF_Kgthdev7oj2uA@mail.gmail.com>
Message-ID: <CAHk-=wh+TBaphuAbHyNMdGYz=JM6tcuAfAsF_Kgthdev7oj2uA@mail.gmail.com>
Subject: Re: Getting weird TPM error after rebasing my tree to security/next-general
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        tomas.winkler@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Jan 31, 2019 at 9:06 AM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> Found something that *does* fix the issue. If I replace memcpy_*io()
> calls with regular memcpy(), the driver works and all my tests pass.

That's not surprising, since that's what we used to do. And it's
horribly wrong because "memcpy()" can do things that are horribly
wrong on IO accesses. Like doing them twice, but alternatively also
"copy one byte at a time" which generally works, but is horrendously
slow for IO.

Can you check *which* memcpy_*io() triggers the issue? Maybe by
"bisecting" them (first perhaps on a file-by-file basis, and then
within a file).

                 Linus
