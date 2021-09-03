Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0EB8C433EF
	for <linux-security-module@archiver.kernel.org>; Fri,  3 Sep 2021 02:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0698610D2
	for <linux-security-module@archiver.kernel.org>; Fri,  3 Sep 2021 02:15:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344100AbhICCQy (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 2 Sep 2021 22:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242941AbhICCQy (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 2 Sep 2021 22:16:54 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41305C061760
        for <linux-security-module@vger.kernel.org>; Thu,  2 Sep 2021 19:15:55 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id me10so8827407ejb.11
        for <linux-security-module@vger.kernel.org>; Thu, 02 Sep 2021 19:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vCsIXCUIo4U27jwNkmfQGyMnD+0UtUag5leEX/B23VA=;
        b=OLXieu5C23HCHIbHJf1QpZ3ZG/21Taw2slo9p/SDfDopoMUkMpIEgtSmoERZMlTDrQ
         AJSoEEkeaugPhwmSep0anOXjYX9IJ8yU/5uGEGcpDyowFc3ehGP9/11Qy3CmkYhY9wUT
         J+odcO8XgsGtANzabgpfCRE1aNf7E40XViFvmgNp2CcAT8cYJ7p6SFUXKYHTiWRxI0XW
         B6kV4Go0k8zcRT1rsB/1KvPtejBXUtg+EhQT3MzawGCjmWR8R9JAMSzn23v2/6rbVqxo
         bQ3tmDnQR69fEr9NvXWXmXdiplN3VJ+f8hQLYmzwePKBvDbxH0Yg05mTliMz6y8r/fnW
         8+Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vCsIXCUIo4U27jwNkmfQGyMnD+0UtUag5leEX/B23VA=;
        b=pgLQ09k3AUYyliHi3lhR2vlMpZC4jTtwlyeIsYbClTy4fzdgJMp5iXkkamzVnUj+Bb
         vWLy2agCXXpw2+Vdl2ogfDaruBYXpQRgnkEbZ+g2MB4NKA30XU1CALo9Zq2X/bIYP9PD
         5Ay8FUKYOixjT8hA0/04qUjWGXmnh08EoBagrHFIjSk7UGkbyRwNVU7c2f7yUAKAgYaW
         6mY2u6QinDwUzF4tadctnHoOk3HRsG/lHgfoC2hjZC12SahSfww/Fo1lWmv6dIJlhyTv
         JKQVq3TAnavwmHGgpFoM+G3bftlP9nzIZ6V1GWjg1QreQQ3aH3J7bwb1Wji8l0AFQZsL
         pGRg==
X-Gm-Message-State: AOAM532C0UPGJr6/Yeq3w4Y/fvU967p5sPVsGchKeMA2dC7DZEtEyPX9
        mXQBjHzlVhkJoUcXeXVdRJTKvpMo18V0PjFUlDRP
X-Google-Smtp-Source: ABdhPJxLHl9QJMJkgu7S/Ue7YgcYfSOOQu/XXCxhMSL5ntLnZM0AYuTtv9TMheuYa9JTM7y2uZ0mFG3AiDUsgG70txY=
X-Received: by 2002:a17:906:abd7:: with SMTP id kq23mr1430286ejb.542.1630635353644;
 Thu, 02 Sep 2021 19:15:53 -0700 (PDT)
MIME-Version: 1.0
References: <c6864908-d093-1705-76ce-94d6af85e092@linux.alibaba.com>
 <18f0171e-0cc8-6ae6-d04a-a69a2a3c1a39@linux.alibaba.com> <7f239a0e-7a09-3dc0-43ce-27c19c7a309d@linux.alibaba.com>
 <4c000115-4069-5277-ce82-946f2fdb790a@linux.alibaba.com> <CAHC9VhRBhCfX45V701rbGsvmOPQ4Nyp7dX2GA6NL8FxnA9akXg@mail.gmail.com>
 <a53753dc-0cce-4f9a-cb97-fc790d30a234@linux.alibaba.com>
In-Reply-To: <a53753dc-0cce-4f9a-cb97-fc790d30a234@linux.alibaba.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 2 Sep 2021 22:15:42 -0400
Message-ID: <CAHC9VhR2c=HYdWmz-At0+7RexUBjQHktv3ypHmFU2jD5gDc2Cw@mail.gmail.com>
Subject: Re: [PATCH] Revert "net: fix NULL pointer reference in cipso_v4_doi_free"
To:     =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Sep 1, 2021 at 10:37 PM =E7=8E=8B=E8=B4=87 <yun.wang@linux.alibaba.=
com> wrote:
> On 2021/9/2 =E4=B8=8A=E5=8D=885:05, Paul Moore wrote:
> > On Tue, Aug 31, 2021 at 10:21 PM =E7=8E=8B=E8=B4=87 <yun.wang@linux.ali=
baba.com> wrote:
> >>
> >> Hi Paul, it confused me since it's the first time I face
> >> such situation, but I just realized what you're asking is
> >> actually this revert, correct?
> >
> > I believe DaveM already answered your question in the other thread,
> > but if you are still unsure about the patch let me know.
>
> I do failed to get the point :-(
>
> As I checked the:
>   https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
>
> both v1 and v2 are there with the same description and both code modifica=
tion
> are applied.
>
> We want revert v1 but not in a revert patch style, then do you suggest
> send a normal patch to do the code revert?

It sounds like DaveM wants you to create a normal (not a revert) patch
that removes the v1 changes while leaving the v2 changes intact.  In
the patch description you can mention that v1 was merged as a mistake
and that v2 is the correct fix (provide commit IDs for each in your
commit description using the usual 12-char hash snippet followed by
the subject in parens-and-quotes).

--=20
paul moore
www.paul-moore.com
