Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BD3FC432BE
	for <linux-security-module@archiver.kernel.org>; Tue, 31 Aug 2021 13:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2E4C61027
	for <linux-security-module@archiver.kernel.org>; Tue, 31 Aug 2021 13:48:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239908AbhHaNt3 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 31 Aug 2021 09:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237678AbhHaNtI (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 31 Aug 2021 09:49:08 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB8CDC061575
        for <linux-security-module@vger.kernel.org>; Tue, 31 Aug 2021 06:48:12 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id u19so10234991edb.3
        for <linux-security-module@vger.kernel.org>; Tue, 31 Aug 2021 06:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mmFZqBTqVe/Ey7uTSUFYWtRV0draZMGsqhEcHMQAYl4=;
        b=DdIdN2gVK1lhYyHe9hvYZT5TMv5NHj5+ItxjlgKrSVaAXZCjU6xPVeogpX7UJLGATp
         kQeKhPtI+bgTwQCPI9q/kyMQyOx0IukRHNuooqwbZLjkQy6D3+nMkFhixYNO9fI2BxaE
         Rx7O4fISi1KVsLfY5D4AMv1K4+UUTw4SXKLG+Nh1lClmozc4n8m5wSr3rbVfQdONdj14
         YikvRa/VwJ3rfZU0Ke3sjg+NKsEPurQuGLFa5qzhYihC9Zx8jNICDOizu1lCoa7KlWK9
         +uU72zv9FEQzhavJmCNm1O92El/fdUer2w0BFoQ6DaxSnq3i/I6e8qkzMW0K/aKAM15U
         P5fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mmFZqBTqVe/Ey7uTSUFYWtRV0draZMGsqhEcHMQAYl4=;
        b=FSVF0kk+LATYvFnKNwmjhtXd2gzmS6h9m7lq7u0ZSmODtOlhNwYRbEqTkeT8oGeVto
         ifYTkPPCdHBAm1DfLsXmh6rdahgusndAYstMijF1a0v6yZOFkRhzdSXHDs23V1khgL0l
         24X1l4dogCKykin9UxRrDYXlUbbMjszPDUbMYxuP/LfSSnM1i5VePBGjADSCIkhkeMqA
         JeuNuphPkGGNhXS7G2HCY0U1G3EUrCOG0swuYdLJMWazoiCf5OtIsqHPcEF0sX7CDqYC
         lVyKXGZP3WTLtTcH2TFqLEh+1VBV7WdRKgS8hDTi9BLCqRrK0SoChv/Z/7lnzs6s0k7Z
         ownQ==
X-Gm-Message-State: AOAM5300oaoCOid19B8cWznA4v4notRHKRRrbSFd/1yN9OfWUNJBA7vu
        sQh5GsB+QLMfQMoPfuGAkP8NUCMy8xqQFuldef0W
X-Google-Smtp-Source: ABdhPJyBmci35BWRh85c9NvhHKnkLvl+JlF07VCIPxOUECowRZwFI8fl3IYxjDZDqSUZJuzv+0oCDWdGUH3TKpXgEnU=
X-Received: by 2002:aa7:d04a:: with SMTP id n10mr27898033edo.12.1630417691192;
 Tue, 31 Aug 2021 06:48:11 -0700 (PDT)
MIME-Version: 1.0
References: <c6864908-d093-1705-76ce-94d6af85e092@linux.alibaba.com>
 <18f0171e-0cc8-6ae6-d04a-a69a2a3c1a39@linux.alibaba.com> <CAHC9VhTEs9E+ZeGGp96NnOhmr-6MZLXf6ckHeG8w5jh3AfgKiQ@mail.gmail.com>
 <20210830094525.3c97e460@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <CAHC9VhRHx=+Fek7W4oyZWVBUENQ8VnD+mWXUytKPKg+9p-J4LQ@mail.gmail.com> <84262e7b-fda6-9d7d-b0bd-1bb0e945e6f9@linux.alibaba.com>
In-Reply-To: <84262e7b-fda6-9d7d-b0bd-1bb0e945e6f9@linux.alibaba.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 31 Aug 2021 09:48:00 -0400
Message-ID: <CAHC9VhRPUa-oD_85j6RcAVvp7sLZQEAGGapYYP1fEt7Ax5LMfA@mail.gmail.com>
Subject: Re: [PATCH v2] net: fix NULL pointer reference in cipso_v4_doi_free
To:     =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Aug 30, 2021 at 10:42 PM =E7=8E=8B=E8=B4=87 <yun.wang@linux.alibaba=
.com> wrote:
> On 2021/8/31 =E4=B8=8A=E5=8D=8812:50, Paul Moore wrote:
> [SNIP]
> >>>> Reported-by: Abaci <abaci@linux.alibaba.com>
> >>>> Signed-off-by: Michael Wang <yun.wang@linux.alibaba.com>
> >>>> ---
> >>>>  net/netlabel/netlabel_cipso_v4.c | 4 ++--
> >>>>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>>
> >>> I see this was already merged, but it looks good to me, thanks for
> >>> making those changes.
> >>
> >> FWIW it looks like v1 was also merged:
> >>
> >> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/=
?id=3D733c99ee8b
> >
> > Yeah, that is unfortunate, there was a brief discussion about that
> > over on one of the -stable patches for the v1 patch (odd that I never
> > saw a patchbot post for the v1 patch?).  Having both merged should be
> > harmless, but we want to revert the v1 patch as soon as we can.
> > Michael, can you take care of this?
>
> As v1 already merged, may be we could just goon with it?
>
> Actually both working to fix the problem, v1 will cover all the
> cases, v2 take care one case since that's currently the only one,
> but maybe there will be more in future.

No.  Please revert v1 and stick with the v2 patch.  The v1 patch is in
my opinion a rather ugly hack that addresses the symptom of the
problem and not the root cause.

It isn't your fault that both v1 and v2 were merged, but I'm asking
you to help cleanup the mess.  If you aren't able to do that please
let us know so that others can fix this properly.

--=20
paul moore
www.paul-moore.com
