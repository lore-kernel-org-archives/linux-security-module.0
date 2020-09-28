Return-Path: <SRS0=XUbZ=DF=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA2A4C4346E
	for <linux-security-module@archiver.kernel.org>; Mon, 28 Sep 2020 02:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C219208D5
	for <linux-security-module@archiver.kernel.org>; Mon, 28 Sep 2020 02:22:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="qWrMSVm6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbgI1CWC (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 27 Sep 2020 22:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbgI1CWC (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 27 Sep 2020 22:22:02 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5CDC0613CE
        for <linux-security-module@vger.kernel.org>; Sun, 27 Sep 2020 19:22:02 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id b12so8379939edz.11
        for <linux-security-module@vger.kernel.org>; Sun, 27 Sep 2020 19:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vOX5Sd+xpTPA9/G3a3HyLwKA39unA0IaH2aJ/ahSQ48=;
        b=qWrMSVm6zYmVaFJcTErsVXateVeWWiDTida+WlvUE+uTdTpqtnEDoAS5/Fab3urTai
         zVC/L+EmWCWMmZZLXmcfTTewmXUlNJHZKMHMlOXI21wFMAIiCPKQBsVcXWBOuIWdkSJw
         wRjVb0qNA/Wr0py5s32t6cT2qH4mMisal2HMbwAzd587SjYazqjs730xTKftVO/LuVh8
         z5SqJGPe6Z6FkYdOzbDRlTuU8q6aT+KfFqcKMNC6Uq0DHawFoME2NoXJCWrpEwOSakwj
         aqz4/eyirVDPTcjNHeg2KSOdgmBn2yafu/pWbZ8fXwYjpOa4lrAz9lroe+Wfwt0jlbYj
         xUug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vOX5Sd+xpTPA9/G3a3HyLwKA39unA0IaH2aJ/ahSQ48=;
        b=FCi3j7YHz2VLnx7zbOx/Pm+x/Z3Tn9O4ySmgWLl5HKRCjpSoG83wajXkYgooEsn2ob
         JejfJLwDvZ8ik1W3lHMzNYG6oOw8N7vYXHVyoZNupBJpBMay90eqlXFfwGeGB02zZJKz
         ddBnXCaMUUQE57tGK5rr6saAMdkBySVwv3T9v78sVrwRXM7Tg0dc3SLoo7dzJHizZWEE
         AckKozBhf4ucgkxe1TgzU7OTekgoTul1zPZEvKcv1QiwjBoth+AR/Y2acsNUDSb2zDrV
         I5lo2rh4AyXcrjLtyojjpyOoV/B+tqLABq1KTrfWA0pQUCAoN0HEBeZfI7uuZLgZKXUf
         rqKw==
X-Gm-Message-State: AOAM532CeZg85RzJoj0h8Zyj4zowL9OPS62zkqxM9fVmy1cKUwvXiKtj
        BJbfN6GPVhpP4srtGLjNFQHICIa+/QEsRzdD6GrF
X-Google-Smtp-Source: ABdhPJzsqAtfa9f1NG8hfvEATJbi9eEwRIg9uIFPEmWBfP9DD88yDxmZdKhWH6XK21EL7PJHsV83fl/LkgW6hEmDjDQ=
X-Received: by 2002:a05:6402:1805:: with SMTP id g5mr13063002edy.135.1601259720569;
 Sun, 27 Sep 2020 19:22:00 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000009fc91605afd40d89@google.com> <20200925030759.GA17939@gondor.apana.org.au>
In-Reply-To: <20200925030759.GA17939@gondor.apana.org.au>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sun, 27 Sep 2020 22:21:48 -0400
Message-ID: <CAHC9VhQjfqAaPnsT20T8zsT1kGHk3LRU1fqL8kNxiKsQ_E6TWQ@mail.gmail.com>
Subject: Re: KASAN: stack-out-of-bounds Read in xfrm_selector_match (2)
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     syzbot <syzbot+577fbac3145a6eb2e7a5@syzkaller.appspotmail.com>,
        davem@davemloft.net, kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, steffen.klassert@secunet.com,
        syzkaller-bugs@googlegroups.com, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Sep 24, 2020 at 11:08 PM Herbert Xu <herbert@gondor.apana.org.au> wrote:
> On Mon, Sep 21, 2020 at 07:56:20AM -0700, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    eb5f95f1 Merge tag 's390-5.9-6' of git://git.kernel.org/pu..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=13996ad5900000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=ffe85b197a57c180
> > dashboard link: https://syzkaller.appspot.com/bug?extid=577fbac3145a6eb2e7a5
> > compiler:       gcc (GCC) 10.1.0-syz 20200507
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+577fbac3145a6eb2e7a5@syzkaller.appspotmail.com
> >
> > ==================================================================
> > BUG: KASAN: stack-out-of-bounds in xfrm_flowi_dport include/net/xfrm.h:877 [inline]
> > BUG: KASAN: stack-out-of-bounds in __xfrm6_selector_match net/xfrm/xfrm_policy.c:216 [inline]
> > BUG: KASAN: stack-out-of-bounds in xfrm_selector_match+0xf36/0xf60 net/xfrm/xfrm_policy.c:229
> > Read of size 2 at addr ffffc9001914f55c by task syz-executor.4/15633
> >
> > CPU: 0 PID: 15633 Comm: syz-executor.4 Not tainted 5.9.0-rc5-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > Call Trace:
> >  __dump_stack lib/dump_stack.c:77 [inline]
> >  dump_stack+0x198/0x1fd lib/dump_stack.c:118
> >  print_address_description.constprop.0.cold+0x5/0x497 mm/kasan/report.c:383
> >  __kasan_report mm/kasan/report.c:513 [inline]
> >  kasan_report.cold+0x1f/0x37 mm/kasan/report.c:530
> >  xfrm_flowi_dport include/net/xfrm.h:877 [inline]
>
> This one goes back more than ten years.  This patch should fix
> it.
>
> ---8<---
> The struct flowi must never be interpreted by itself as its size
> depends on the address family.  Therefore it must always be grouped
> with its original family value.
>
> In this particular instance, the original family value is lost in
> the function xfrm_state_find.  Therefore we get a bogus read when
> it's coupled with the wrong family which would occur with inter-
> family xfrm states.
>
> This patch fixes it by keeping the original family value.
>
> Note that the same bug could potentially occur in LSM through
> the xfrm_state_pol_flow_match hook.  I checked the current code
> there and it seems to be safe for now as only secid is used which
> is part of struct flowi_common.  But that API should be changed
> so that so that we don't get new bugs in the future.  We could
> do that by replacing fl with just secid or adding a family field.

I'm thinking it might be better to pass the family along with the flow
instead of passing just the secid (less worry of passing an incorrect
secid that way).  Let me see if I can cobble together a quick patch
for testing before bed ...

-- 
paul moore
www.paul-moore.com
