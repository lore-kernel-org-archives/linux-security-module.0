Return-Path: <SRS0=Tg6P=VI=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8158FC74A41
	for <linux-security-module@archiver.kernel.org>; Thu, 11 Jul 2019 01:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B7AA20844
	for <linux-security-module@archiver.kernel.org>; Thu, 11 Jul 2019 01:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562810374;
	bh=yctOEGr15lqaEv9xSMz2miuVt2G/lSyyty867n1nn/w=;
	h=References:In-Reply-To:From:Date:Subject:To:List-ID:From;
	b=wBdbd4TjkN+PWR3VTQxPAjNssD0mRjFqIpqKS+xD9RNgEX6cPcsuVPp6C2Ch6EQtx
	 NNkfbSm0pJS6hPNEjRNelfLCMcS+qILogmPQ0kUrwfwCuzZ+eHGE74ZhYJj5S7tuOk
	 vvXR+9CJYC2LfDrXt2f0p+v4PexVsgcmlS6K4W8M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbfGKB7d (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 10 Jul 2019 21:59:33 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39134 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727937AbfGKB72 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 10 Jul 2019 21:59:28 -0400
Received: by mail-lj1-f196.google.com with SMTP id v18so4050272ljh.6
        for <linux-security-module@vger.kernel.org>; Wed, 10 Jul 2019 18:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=NiaFfYJ216nYjgBrBY5JKQAHNiRjdATog8sl2JxZW+g=;
        b=MQOzZI79mvoiVs1sgBWHfqE+YJM9b7M05jQpHMpAAyRFe0Cs7GZ1SKjYmbrPj6ztHM
         B7Jmo2E1tOKxmtYLHAeJfiv0Yw5iWNpJ6su3Aywbxq++FWe46hRTt1FaTYFdrs51gDai
         Fc+1NUhQh/izklmNT0WE5mkHqoWlVg+hybjs0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=NiaFfYJ216nYjgBrBY5JKQAHNiRjdATog8sl2JxZW+g=;
        b=pvt1W2lad7EQ/gGD/3azKYioweTnVciEPFVBOJriYOrmDY9kDTnmEZs7MyJLLRAfL2
         7hgd/ev+Uma5xN6lvReVvYVEVeFcj+U0iMC1CQfCIqmiIfc6ywKTiCBArdAraeiUGu3J
         ovAN2ZSnBtoX7p/UnIHGUmx71Y8XEcIBzGmeaSfPdUYEQxqXVwE0pN0ZiZxjM1wJnGni
         OqoTqOl5OCwSqnPaO1oScKxnWcYIj0EpjJgsK5uGzfgfjdFTMOCrmkJQG8xIIi1vOv8m
         KtLWn/p6FlCKqw6svK0+W3HUqmhQvkECRTBFzqlBeUcnFPsoGqd+nqNxe7adKo2VDJUk
         +NVg==
X-Gm-Message-State: APjAAAUVCyNPFiy3jxcBrJcm3ExXTXd4PNhj+oiIJjfLWE7shdYFBKst
        y2JuywfVsrlk4ShsIXNFRGHf3fZQMas=
X-Google-Smtp-Source: APXvYqyR0qrITGRwGExxFJ2D84ewamniecFVcx9lJKfZNzALDWJ0DHkZeTTxHZwqQpFLBNPGri8vDQ==
X-Received: by 2002:a2e:8082:: with SMTP id i2mr726503ljg.121.1562810365407;
        Wed, 10 Jul 2019 18:59:25 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id z30sm610419lfj.63.2019.07.10.18.59.21
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jul 2019 18:59:23 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id z15so2888336lfh.13
        for <linux-security-module@vger.kernel.org>; Wed, 10 Jul 2019 18:59:21 -0700 (PDT)
X-Received: by 2002:ac2:4839:: with SMTP id 25mr355474lft.79.1562810361547;
 Wed, 10 Jul 2019 18:59:21 -0700 (PDT)
MIME-Version: 1.0
References: <28477.1562362239@warthog.procyon.org.uk> <CAHk-=wjxoeMJfeBahnWH=9zShKp2bsVy527vo3_y8HfOdhwAAw@mail.gmail.com>
 <20190710194620.GA83443@gmail.com> <20190710201552.GB83443@gmail.com>
In-Reply-To: <20190710201552.GB83443@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 10 Jul 2019 18:59:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiFti6=K2fyAYhx-PSX9ovQPJUNp0FMdV0pDaO_pSx9MQ@mail.gmail.com>
Message-ID: <CAHk-=wiFti6=K2fyAYhx-PSX9ovQPJUNp0FMdV0pDaO_pSx9MQ@mail.gmail.com>
Subject: Re: [GIT PULL] Keys: Set 4 - Key ACLs for 5.3
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>, keyrings@vger.kernel.org,
        Netdev <netdev@vger.kernel.org>, linux-nfs@vger.kernel.org,
        CIFS <linux-cifs@vger.kernel.org>, linux-afs@lists.infradead.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-integrity@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Jul 10, 2019 at 1:15 PM Eric Biggers <ebiggers@kernel.org> wrote:
>
> Also worth noting that the key ACL patches were only in linux-next for 9 days
> before the pull request was sent.

Yes. I was not entirely happy with the whole key subsystem situation.
See my concerns in

  https://lore.kernel.org/lkml/CAHk-=wjEowdfG7v_4ttu3xhf9gqopj1+q1nGG86+mGfGDTEBBg@mail.gmail.com/

for more. That was before I realized it was buggy.

So it really would be good to have more people involved, and more
structure to the keys development (and, I suspect, much else under
security/)

Anyway, since it does seem like David is offline, I've just reverted
this from my tree, and will be continuing my normal merge window pull
requests (the other issues I have seen have fixes in their respective
trees).

                 Linus
