Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6416C61DA4
	for <linux-security-module@archiver.kernel.org>; Thu,  9 Feb 2023 22:46:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbjBIWqr (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 9 Feb 2023 17:46:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbjBIWqp (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 9 Feb 2023 17:46:45 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D77E118B
        for <linux-security-module@vger.kernel.org>; Thu,  9 Feb 2023 14:46:43 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id r8so4622541pls.2
        for <linux-security-module@vger.kernel.org>; Thu, 09 Feb 2023 14:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9g2yQtWzAVH6ZOpDsD/Sskemui/XDqoYgj9fWj/hkxU=;
        b=Fcjg1IeCP5a42XMH+PhI6FfYg/ZEC4FgpEwO2V6GvMNyMrvAcl9kKvcS01KBHSx82+
         OZZKtrI7t5/KX66FOK/1hHFW0nVKD4IBJf/vEIg9028FjBGjeq+MxlG8wtJRbGXCe8Zv
         ssz7dnJgd1z50RC8sOXXUWNvCagc3zNzWh7y6NFro6FvBBXOx3hjqr8K9oWb616ub3vD
         nXXLKpIF4/k+oT2CQZYhei6jOVDegdDoUAyaqgD8+2AB3UMhfTdFu+tjTrdWCiYHd/UC
         /CDS2BY/9+s5PZrlNrGdQPNrWzw61I1u1EAxVPSdCY2ZXwyX7YgR1ABL5UcgKsWMwx8r
         KwzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9g2yQtWzAVH6ZOpDsD/Sskemui/XDqoYgj9fWj/hkxU=;
        b=rP0v7sSeu1QXINWpQfeHuTLAAkY85P7OZF/A3WcC481zzzwpveX+rj5PQEHz1/CBmq
         j8JkV4RFjms147Gka0xGOnLQoyekGNoRUv7OxQnbpxqrPafjtHG7ip6YxZ7fGMd1txDj
         s97z49CFORUZ2qTzthPlodjpn8/gqH9EyIbsk9fp6KAz9cK5Suv27Qtz6efRr3i62bzl
         dxY4N66Zh7Bv1tL4zintKw3oAkFQsivbksPPirgMHKlq9ulsNmBxHGgfefl0z6xVZcyC
         TYAlsAiyg5YUE7Q26qv6i5T2u40KJ4GwSHEYJAe+8YPmWB2G67UMR5ImKo+xE1OGUOEX
         O4aw==
X-Gm-Message-State: AO0yUKULPtQJjpO8mFFFCiQ0/3Vd6fTx7WN310ODf5qWF2ck6ProeXku
        DMed0ByJJ6IxckBG0AUeLj1BaBR1dlwKjtAXcQ8U
X-Google-Smtp-Source: AK7set+5+CGbyUdx+XEn7CyiOAlZsrmdC59etIZEgrVyrqoicPNTGQjjG1Gn3JnsMH+LPETc4+h+vPAftTT77wQ7BnQ=
X-Received: by 2002:a17:902:70c4:b0:198:ff55:2ef3 with SMTP id
 l4-20020a17090270c400b00198ff552ef3mr3307989plt.27.1675982803339; Thu, 09 Feb
 2023 14:46:43 -0800 (PST)
MIME-Version: 1.0
References: <20221227142740.2807136-1-roberto.sassu@huaweicloud.com>
 <20221227142740.2807136-3-roberto.sassu@huaweicloud.com> <Y64XB0yi24yjeBDw@sol.localdomain>
 <d2a54ddec403cad12c003132542070bf781d5e26.camel@huaweicloud.com>
 <857eedc5ad18eddae7686dca63cf8c613a051be4.camel@huaweicloud.com> <Y+VBMQEwPTPGBIpP@gmail.com>
In-Reply-To: <Y+VBMQEwPTPGBIpP@gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 9 Feb 2023 17:46:32 -0500
Message-ID: <CAHC9VhTYeqCB8roaNvWUYJeKPwT35ixJ8MMXBe0v0+a9o8CXWw@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] KEYS: asymmetric: Copy sig and digest in public_key_verify_signature()
To:     David Howells <dhowells@redhat.com>
Cc:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net,
        zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, jmorris@namei.org,
        serge@hallyn.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>,
        Eric Biggers <ebiggers@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Feb 9, 2023 at 1:53 PM Eric Biggers <ebiggers@kernel.org> wrote:
> On Thu, Feb 09, 2023 at 11:49:19AM +0100, Roberto Sassu wrote:
> > On Fri, 2023-01-27 at 09:27 +0100, Roberto Sassu wrote:
> > > On Thu, 2022-12-29 at 14:39 -0800, Eric Biggers wrote:
> > > > On Tue, Dec 27, 2022 at 03:27:40PM +0100, Roberto Sassu wrote:
> > > > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > > > >
> > > > > Commit ac4e97abce9b8 ("scatterlist: sg_set_buf() argument must be in linear
> > > > > mapping") checks that both the signature and the digest reside in the
> > > > > linear mapping area.
> > > > >
> > > > > However, more recently commit ba14a194a434c ("fork: Add generic vmalloced
> > > > > stack support") made it possible to move the stack in the vmalloc area,
> > > > > which is not contiguous, and thus not suitable for sg_set_buf() which needs
> > > > > adjacent pages.
> > > > >
> > > > > Always make a copy of the signature and digest in the same buffer used to
> > > > > store the key and its parameters, and pass them to sg_init_one(). Prefer it
> > > > > to conditionally doing the copy if necessary, to keep the code simple. The
> > > > > buffer allocated with kmalloc() is in the linear mapping area.
> > > > >
> > > > > Cc: stable@vger.kernel.org # 4.9.x
> > > > > Fixes: ba14a194a434 ("fork: Add generic vmalloced stack support")
> > > > > Link: https://lore.kernel.org/linux-integrity/Y4pIpxbjBdajymBJ@sol.localdomain/
> > > > > Suggested-by: Eric Biggers <ebiggers@kernel.org>
> > > > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > > > > ---
> > > > >  crypto/asymmetric_keys/public_key.c | 38 ++++++++++++++++-------------
> > > > >  1 file changed, 21 insertions(+), 17 deletions(-)
> > > >
> > > > Reviewed-by: Eric Biggers <ebiggers@google.com>
> > >
> > > Hi David
> > >
> > > could you please take this patch in your repo, if it is ok?
> >
> > Kindly ask your support here. Has this patch been queued somewhere?
> > Wasn't able to find it, also it is not in linux-next.
> >
>
> The maintainer of asymmetric_keys (David Howells) is ignoring this patch, so
> you'll need to find someone else to apply it.  Herbert Xu, the maintainer of the
> crypto subsystem, might be willing to apply it.  Or maybe Jarkko Sakkinen, who
> is a co-maintainer of the keyrings subsystem (but not asymmetric_keys, for some
> reason; should that change?).

It is problematic that David isn't replying to this.  I have no idea
if it will work, but I just reached out to him to see if I can draw
his attention back to this ...

--
paul-moore.com
