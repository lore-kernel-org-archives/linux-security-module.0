Return-Path: <SRS0=h0Om=WS=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 474DBC3A5A3
	for <linux-security-module@archiver.kernel.org>; Thu, 22 Aug 2019 16:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E21223401
	for <linux-security-module@archiver.kernel.org>; Thu, 22 Aug 2019 16:32:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="pi6XK9pe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388168AbfHVQcc (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 22 Aug 2019 12:32:32 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41669 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733098AbfHVQcc (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 22 Aug 2019 12:32:32 -0400
Received: by mail-lf1-f67.google.com with SMTP id 62so4969968lfa.8
        for <linux-security-module@vger.kernel.org>; Thu, 22 Aug 2019 09:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ujwYz/NxPt4KuZjfQpu/cnFqN0PKCiE0M+fWaEKXyzU=;
        b=pi6XK9pe93bWuyf6pKryFGG43zRe1ZCwwDleYSgufZv9Ci87EtNumSlh81D/RMBUB1
         SkpQVhfDqHWd+OvxONVKRfKsmHySwguPchGfTt+wRko0hWR9DVzcoHkWnhqNRVJLc463
         PiOXVl+YsmkFkn5w2u+TMtRHc6qyawh1xi+nxO6St0bc+jI1FT3TA/9k/+Vm2YIdcgGp
         EBYt5j1wQaaqWleGeWnb3Mw9+6lZSjsrpJAvvXLPTJFHmVqklBrovOL1hU02MgFGeiqX
         PC7aIX8nX/8P96zUM4rYaQG02bsss1BLzMdmXQ2sZU/WQaDv1/5fphkKSKBF1bFyqIJi
         4FmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ujwYz/NxPt4KuZjfQpu/cnFqN0PKCiE0M+fWaEKXyzU=;
        b=uEsHczy5IyNnQgI9bHAmwuJf9JE+b3ZFWZOQzR5BDtthY1DxSP1xucwcnnM22CgDhR
         DZJyVh7bxIHipGUxu0DZBvgKJESiDTjPRQ/IXusUSxglbW7AzPc+s6Wklbcaco+gAMSR
         /J0tJ6lKT1VaMr5Vw70+KUaTDROZaxIYRJzVeIMDpSdbrwFbVCjIy+HnQqPJy2fS0URc
         6BJlNTllaJzx3lvWqeXEfCjK7YqglPdPvFLrc+39CuPNFzuIwKIT6wuV2JSA5Ah7dnHQ
         cdLp0Vy4/OxiVLHshsKJrwGBNVuQjqwXmGEU6nJDN0Qtga6jdf1lmdAINR5qt+wzrlEK
         6dHg==
X-Gm-Message-State: APjAAAULK5oqZ9q7vT5S2Urs46AVVL4RtrR+QwzpzuPEJURKPRVYQGIa
        egWKAme3CdoB1/nZy8uGGdTx5I8PPk+G8Y2exXr3
X-Google-Smtp-Source: APXvYqzz2n4ssNU9eUBLNHNiiN1igpCWk1mywwCx6WmTr0Wqj7FtpXsRl6ByHayPfeQfIrJhDa2FjRZ8pjDimCZFisc=
X-Received: by 2002:a19:4349:: with SMTP id m9mr35378lfj.64.1566491549775;
 Thu, 22 Aug 2019 09:32:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhSz1_KA1tCJtNjwK26BOkGhKGbPT7v1O82mWPduvWwd4A@mail.gmail.com>
 <20190822070358.GE20113@breakpoint.cc>
In-Reply-To: <20190822070358.GE20113@breakpoint.cc>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 22 Aug 2019 12:32:18 -0400
Message-ID: <CAHC9VhQ_+3ywPu0QRzP3cSgPH2i9Br994wJttp-yXy2GA4FrNg@mail.gmail.com>
Subject: Re: New skb extension for use by LSMs (skb "security blob")?
To:     Florian Westphal <fw@strlen.de>
Cc:     netdev@vger.kernel.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Aug 22, 2019 at 3:03 AM Florian Westphal <fw@strlen.de> wrote:
> Paul Moore <paul@paul-moore.com> wrote:
> > Hello netdev,
> >
> > I was just made aware of the skb extension work, and it looks very
> > appealing from a LSM perspective.  As some of you probably remember,
> > we (the LSM folks) have wanted a proper security blob in the skb for
> > quite some time, but netdev has been resistant to this idea thus far.
>
> Is that "blob" in addition to skb->secmark, or a replacement?

That's a good question.  While I thought about that, I wasn't sure if
that was worth bringing up as previous attempts to trade the secmark
field for a void pointer met with failure.  Last time I played with it
I was able to take the additional 32-bits from holes in the skb, and
possibly even improve some of the cacheline groupings (but that is
always going to be a dependent on use case I think), but that wasn't
enough.

I think we could consider freeing up the secmark in the main skb, and
move it to a skb extension, but this would potentially increase the
chances that we would need to add an extension to a skb.  I don't have
any hard numbers, but based on discussions and questions I suspect
Secmark is more widely used than NetLabel and/or labeled IPsec;
although I'm confident it is still a minor percentage of the overall
Linux installed base.

For me the big question is what would it take for us to get a security
blob associated with the skb?  Would moving the secmark into the skb
extension be enough?  Something else?  Or is this simply never going
to happen?  I want to remain optimistic, but I've been trying for this
off-and-on for over a decade and keep running into a brick wall ;)

-- 
paul moore
www.paul-moore.com
