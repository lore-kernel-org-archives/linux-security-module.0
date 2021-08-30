Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 952B8C432BE
	for <linux-security-module@archiver.kernel.org>; Mon, 30 Aug 2021 16:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D7C960F5E
	for <linux-security-module@archiver.kernel.org>; Mon, 30 Aug 2021 16:50:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237835AbhH3Qvi (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 30 Aug 2021 12:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231234AbhH3Qvh (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 30 Aug 2021 12:51:37 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87CD9C061575
        for <linux-security-module@vger.kernel.org>; Mon, 30 Aug 2021 09:50:43 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id ia27so32526515ejc.10
        for <linux-security-module@vger.kernel.org>; Mon, 30 Aug 2021 09:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bQVMvYcjCnMFgvYOVDQREa1BXf8UCBlf+lOOy+41N5U=;
        b=obzbb1pzaE1LR8FOGj+GTvRiG8gJkpP+lR1f98oUFk0zlgW9DVHYeNoJPhjBDHIW98
         47IEBb+gsKPIwsCtga4z5CpSMw1iboO+i7+MDAU1P7/JWMEe8kvW6FrNxT8NCgFlCGSD
         ePfyC2Npipk2h3J/gWBvCDfA7vUpiwI54PTOm+w26AFvwnpmeamGky/4GnYqw7r8vedF
         F2d3w3EA9YMq2G9pTFz+NTUjARmEt0VQVCdEy0ub7t6eNo+giW4piBQgkFReTSdxUecm
         Jj64UtjFvvfxkJc3lv28hZqhJe1PF7GpNxLYtJeGk2UXlBUt1aZJXa/4LeFOuWmcFX3x
         v80A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bQVMvYcjCnMFgvYOVDQREa1BXf8UCBlf+lOOy+41N5U=;
        b=pap3ESxhHPScK3g95mKGZflNNsYWmTRdH+oMMQjDhjRDleLmpmLCvOeDiiDlF2U6rs
         q15XPSCSHM/iRA5wq9k3GnSsK8y/P+ZpQMwZi616aBxxhGku/kMpX0hLrXC/7L3d9ZhO
         UE76SBmHNOBGr8qgBEQkWX/fxZk/llMWcKELuyTbVJoZfLly06jhQt7xe9T+adqeZqrA
         PUacx0lqnwSnx9Lj3xi3y83Fn6RYALlhsoBOPZqj9W/3qbH/dYDy0qIY1tiqCmtDTtcg
         DbmPo8YYEowjM4uQfnP3CqcAFyqDXkGFa39483Y0cNloekIBC9pXtkseJJ7IVL+G2PwB
         upbA==
X-Gm-Message-State: AOAM5322Pu4FPga3gC6w69f3zb9VTjdi4rcseSztnzWiKjXKuJB0SDJB
        Pf4d5BNCi5uAnrtdricSHXH7Kc5dpOb3ohGMlWRV
X-Google-Smtp-Source: ABdhPJx52e04Hss4PIUoU//zykOp13TlB+DzQ6HwhK6DcPWsOi04aRDu8IY7lDXCZ7khHk0VuPR7KlNpbq+lxTgZvYk=
X-Received: by 2002:a17:906:b845:: with SMTP id ga5mr26745803ejb.106.1630342242114;
 Mon, 30 Aug 2021 09:50:42 -0700 (PDT)
MIME-Version: 1.0
References: <c6864908-d093-1705-76ce-94d6af85e092@linux.alibaba.com>
 <18f0171e-0cc8-6ae6-d04a-a69a2a3c1a39@linux.alibaba.com> <CAHC9VhTEs9E+ZeGGp96NnOhmr-6MZLXf6ckHeG8w5jh3AfgKiQ@mail.gmail.com>
 <20210830094525.3c97e460@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20210830094525.3c97e460@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 30 Aug 2021 12:50:31 -0400
Message-ID: <CAHC9VhRHx=+Fek7W4oyZWVBUENQ8VnD+mWXUytKPKg+9p-J4LQ@mail.gmail.com>
Subject: Re: [PATCH v2] net: fix NULL pointer reference in cipso_v4_doi_free
To:     Jakub Kicinski <kuba@kernel.org>,
        =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Aug 30, 2021 at 12:45 PM Jakub Kicinski <kuba@kernel.org> wrote:
> On Mon, 30 Aug 2021 10:17:05 -0400 Paul Moore wrote:
> > On Mon, Aug 30, 2021 at 6:28 AM =E7=8E=8B=E8=B4=87 <yun.wang@linux.alib=
aba.com> wrote:
> > >
> > > In netlbl_cipsov4_add_std() when 'doi_def->map.std' alloc
> > > failed, we sometime observe panic:
> > >
> > >   BUG: kernel NULL pointer dereference, address:
> > >   ...
> > >   RIP: 0010:cipso_v4_doi_free+0x3a/0x80
> > >   ...
> > >   Call Trace:
> > >    netlbl_cipsov4_add_std+0xf4/0x8c0
> > >    netlbl_cipsov4_add+0x13f/0x1b0
> > >    genl_family_rcv_msg_doit.isra.15+0x132/0x170
> > >    genl_rcv_msg+0x125/0x240
> > >
> > > This is because in cipso_v4_doi_free() there is no check
> > > on 'doi_def->map.std' when doi_def->type got value 1, which
> > > is possibe, since netlbl_cipsov4_add_std() haven't initialize
> > > it before alloc 'doi_def->map.std'.
> > >
> > > This patch just add the check to prevent panic happen in similar
> > > cases.
> > >
> > > Reported-by: Abaci <abaci@linux.alibaba.com>
> > > Signed-off-by: Michael Wang <yun.wang@linux.alibaba.com>
> > > ---
> > >  net/netlabel/netlabel_cipso_v4.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > I see this was already merged, but it looks good to me, thanks for
> > making those changes.
>
> FWIW it looks like v1 was also merged:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=
=3D733c99ee8b

Yeah, that is unfortunate, there was a brief discussion about that
over on one of the -stable patches for the v1 patch (odd that I never
saw a patchbot post for the v1 patch?).  Having both merged should be
harmless, but we want to revert the v1 patch as soon as we can.
Michael, can you take care of this?

--=20
paul moore
www.paul-moore.com
