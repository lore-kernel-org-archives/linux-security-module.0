Return-Path: <SRS0=rS9t=XV=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 287CAC4360C
	for <linux-security-module@archiver.kernel.org>; Thu, 26 Sep 2019 18:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0235A222BF
	for <linux-security-module@archiver.kernel.org>; Thu, 26 Sep 2019 18:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569522115;
	bh=AXXrhWbwsofC1rmf8TbGYx+/8aqKnOhwDk1OD2n0Btc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=emDbe3ZjrAb2GTrw+sJItLk+hxEGJ1X2kILi760cd+ve5T3+VNYrOZxTzXBn1TJKD
	 Xm7PqJzulFIte32JK8qXjVOXJbTH23jgjAGfa63qGR97pYq1hr6UGcVmsUn1ybrxIr
	 HcQLo7D+0aOhsAC7tQORgHsEl/kmSv7Dp4B3LCs0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbfIZSVy (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 26 Sep 2019 14:21:54 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34187 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727796AbfIZSVy (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 26 Sep 2019 14:21:54 -0400
Received: by mail-lj1-f193.google.com with SMTP id j19so3210132lja.1
        for <linux-security-module@vger.kernel.org>; Thu, 26 Sep 2019 11:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rrcu3G8Duy/FeUjbYtKJnhs5/UkfjjDxGs8XQQZjFoU=;
        b=gzGIbnTBRa0MWz7TFhp8ocJz4Lh2yp/shAcSeubrA6fuXKkzxeQIMSMNUPYdBFXJYn
         /j0pV7SWgvNqO2g+oiezYX4Vi4visN26kdNsSZ+7eBfZXMOInvLGEWdmfAdWBQVuPnk5
         706kND9Z6EULVBwuXFq61uGYcokd+0OZjjggU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rrcu3G8Duy/FeUjbYtKJnhs5/UkfjjDxGs8XQQZjFoU=;
        b=nBk3Y3QArJ1A6UelwBBB8tgC/WiM202+deYR6mbohmI0usI060w0M+HS4MI6x09HqR
         46n8F+/3YLcjcLO8yrLxeHoQvE+Z1Bfqt6iIgcueGmCGXg3MXN+r761XanLUA3XxfKrU
         NwcxGhmsxBT9AwFwc8Ul71nhsDlNdphha5kGVUBORBQ1ckHNDKaVB4D/Roy88ngXrNPa
         7dq9/L9XSksHmhR8dbMXws5Gz949ZPWrA73m8qvtrD22TnV0xrr5J0BeeyzqeCmky6t4
         kIaDtisxmUmOcqgmJqhWWRA8YP/UItBDsKPwpGkr3L9IV6/F3RCYEgpZ4pLdX1TnmQ+/
         XpGg==
X-Gm-Message-State: APjAAAUSoNCXlmG1nWXXVS25w7A7cRy4ckXEmfU9JrneJRfhfGAalAZt
        JKDMnZko2wM53xyApje4Pq1cuiMc8Us=
X-Google-Smtp-Source: APXvYqzHpTOfFzOyY4ew7ufN/WOSuXhmc51OHDraVILw0k+6ju9iNGZlgx30dmaH/8OHj6FP//EvVg==
X-Received: by 2002:a2e:9059:: with SMTP id n25mr26841ljg.134.1569522111431;
        Thu, 26 Sep 2019 11:21:51 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id q11sm659266lje.52.2019.09.26.11.21.49
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Sep 2019 11:21:50 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id y127so2452940lfc.0
        for <linux-security-module@vger.kernel.org>; Thu, 26 Sep 2019 11:21:49 -0700 (PDT)
X-Received: by 2002:a19:2489:: with SMTP id k131mr3025988lfk.52.1569522109593;
 Thu, 26 Sep 2019 11:21:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ-EccM49yBA+xgkR+3m5pEAJqmH_+FxfuAjijrQxaxxMUAt3Q@mail.gmail.com>
 <CAHk-=wiAsJLw1egFEE=Z7-GGtM6wcvtyytXZA1+BHqta4gg6Hw@mail.gmail.com>
 <CAHk-=wh_CHD9fQOyF6D2q3hVdAhFOmR8vNzcq5ZPcxKW3Nc+2Q@mail.gmail.com>
 <alpine.LRH.2.21.1909231633400.54130@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.inter>
 <CAHk-=wh4cuHsE8jFHO7XVatdXa=M2f4RHL3VwnSkAf5UNHUJ-Q@mail.gmail.com> <CAJ-EccMy=tNPp3=PQZxLT7eovojoAdpfQmqhAyv7XO3GwPQBMg@mail.gmail.com>
In-Reply-To: <CAJ-EccMy=tNPp3=PQZxLT7eovojoAdpfQmqhAyv7XO3GwPQBMg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 26 Sep 2019 11:21:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjH25fp_9oMMi+1GxUR1h+WyXQRvW+GuNVq7vC9Kaad2g@mail.gmail.com>
Message-ID: <CAHk-=wjH25fp_9oMMi+1GxUR1h+WyXQRvW+GuNVq7vC9Kaad2g@mail.gmail.com>
Subject: Re: [GIT PULL] SafeSetID LSM changes for 5.4
To:     Micah Morton <mortonm@chromium.org>
Cc:     James Morris <jamorris@linuxonhyperv.com>,
        Jann Horn <jannh@google.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Sep 23, 2019 at 8:31 PM Micah Morton <mortonm@chromium.org> wrote:
>
>                The best way I know of ensuring this is
> for me to personally run the SafeSetID selftest (in
> tools/testing/selftests/safesetid/) every release, regardless of
> whether we make any changes to SafeSetID itself. Does this sound
> sufficient or are there more formal guidelines/processes here that I'm
> not aware of?

I think that would help, but I wopuld also hope that somebody actually
runs Chromium / Chrome OS with a modern kernel.

Even if *standard* device installs don't end up having recent kernels,
I would assume there are people who are testing development setups?

              Linus
