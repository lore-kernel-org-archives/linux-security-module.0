Return-Path: <SRS0=sk88=TY=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4743CC072B5
	for <linux-security-module@archiver.kernel.org>; Fri, 24 May 2019 19:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 184F2217D7
	for <linux-security-module@archiver.kernel.org>; Fri, 24 May 2019 19:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="NRudu2UY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391775AbfEXTzO (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 24 May 2019 15:55:14 -0400
Received: from sonic302-9.consmr.mail.bf2.yahoo.com ([74.6.135.48]:37830 "EHLO
        sonic302-9.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391698AbfEXTzO (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 24 May 2019 15:55:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1558727713; bh=+1Q6okH5AkguZZR+uu3LalnJySLPgfErpNKw1+UHrjs=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=NRudu2UYhW9KlknNAQuavfN3n1reRFShVw8m6t0XbvblTla7QEqTC9NM9MI5SUkigC698fADLZKpHydMKn9HGUgNjGWMQV+lA4X5/Ge77PpuAlwR727d4p1w8t1FTr5Vw99gkKYBN+QtNAGf1RCYfreX3oIsTiSkaR2O4i6pbgi4y74UA08sbxz5TLN4oXG715SBZ1nuiOq+33qaKAWHanKUJovTby/Mkw7yNQQU2jMtN45c48c7S+Rg1rpULC2fMOh0rkLoceuLxQ6/kzKg1ZuIRa/L81C2pgyibFFJS0KTCo9UmzhHFSi2dmtn0v0xbcQTmXny52F9R6eKDxlrrQ==
X-YMail-OSG: L35lCVYVM1nJ0MNo4aXj2MHMlkQZcxTI8pRMYlGnsSMYveFs2zKoHD9cBJFoag7
 BI2hucjpJ1ZEthTORsr1fDD45DAXAiFpWKrn5NCpp4pnZEj9ry.rcR1tCaTvLWHa2nFaLjmYRT9S
 LJSOxhyqoHixQDoZJPRalXtsdlXe3ZFqsI_bxihpQhJ61OcdRFQn29w9n7D.C8ty6yVxMY3ggLlY
 5gF0ifoYIxuETOznkyGqxgJdDhTWGtDluEaDWaYdf1R0TF09LaZvg4.jQTasHpes9MWdiWuRJKez
 NM.nTkpjmORBat1LBQ16Z8x1aMytH_boHBWjXDp8lwUzN.YpxL1jbEhAdO_XH3n0p_IIA4n2y9Th
 jihiEbmxaJ2gjjUnG9jwLU5TIBAJ3UqvUqDAzy_9k9Hmi2JnzCWThIFbpoYmhHNnNyMz7w.Wacxi
 85qBFyLaJgYJw_xjIR.BKTWEw6NDXABsWe5U7MRZzx5NrSb8s9AVEiNHYd7lnMrb_B8T7b20OwMe
 bqr4h99ImQwQbqnLaeQtOqcelrQdZbyAqnoDX2AXYxy_lEd8HMezSQNzLJ4Br6E7d2wnQCdzoINe
 vIUbViIDux9VK_BLtH.nS.4phAjJvwEHJgT1_1BVB7kocZp634sHDjiswRUL43k9ShsgzgGB8d65
 fyxax1jJTxbW0zFO.uFLj6xILckG9I2bV9xK7lFpNjcAxNLNsaPapsfx5XajRsQBB.PMSdkH8lVe
 AqlL7hTkDEBRbDw5HDODtQFEDHxj4tEydNWGh90RkaMwWuPk3CyjH3ypSGu_JGqM4.YKVnZKJvMT
 t54hrHbkvxlEtwUr4ZgCSajoUwjlaRxJ3w_X_G16dE7tIEm1SIw4X9MyUxCpFTDpWezr9ZF.kj67
 mP12vR8OUz9OoaxqNZP_2ixYfGJSVg8pYgXQ6gMIEKGoNfiE5O.LZNDNBFxvwqlIRraKou.l8VDy
 pSM8j_83Q_827h77bPztbGhIGZu2rp6kbY.QBQJiOmVLWWsM_36zjjbbMnlnEkBRD8F8tH3qWPL.
 n2YBm9plP1d93RcHlOb1FsQM7q8HdBQsrJpDW97vAO83Vi60De7NZEaQusYEOZNHKUL8Vp4khVnZ
 VzuNBMh6UmMY0OgMUp2du43LqyjoFQAemR2knOPf7LracNXB34mxZJ3q4GCUoSqugDkjPQhVErir
 WVrnVXLgvVPwx7urIBjBxFiq2jOc4bj135wufVPCU_oNe_hUIfMIIB_hUHX4EUHMFneLlSzuhguR
 MoWNvt0TpdCbfdARGv.acUZ..BqbGYGRF
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.bf2.yahoo.com with HTTP; Fri, 24 May 2019 19:55:13 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([73.223.4.185])
          by smtp407.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 19a73f1c81bea859654f103f6e3fd974;
          Fri, 24 May 2019 19:55:11 +0000 (UTC)
Subject: Re: Stacking patches for 5.3
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        James Morris <jmorris@namei.org>,
        John Johansen <john.johansen@canonical.com>
References: <1106985e-1620-75b2-d6bf-c2c95d9a0fbb@schaufler-ca.com>
 <CAHC9VhRY8UOS9G_CgBPe=tVYgLmL7KHC_=RRtHyemHrx0_RqjA@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Message-ID: <e42136b0-d656-1aa9-c848-d6a8aaa48c92@schaufler-ca.com>
Date:   Fri, 24 May 2019 12:55:11 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAHC9VhRY8UOS9G_CgBPe=tVYgLmL7KHC_=RRtHyemHrx0_RqjA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 5/24/2019 12:37 PM, Paul Moore wrote:
> On Fri, May 24, 2019 at 3:26 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> I have a set of 59 patches for the nest round of LSM stacking.
>> They are all really small. Kees has expressed a preference for
>> small patches. I think that the collapsed set of about 10 would
>> make more sense. Which would the community as a whole prefer?
>> The patches are not much different from what has been presented
>> already.
> Is there an option for "not posted on the Friday before a holiday weekend"? ;)

I'm waiting for James' next-general to base it on, so you needn't worry.

> I honestly don't care too much about patch size, regardless of how it
> is packaged it's a lot of pretty critical stuff to review.

Consensus looks like small patches are the way to go. So be it.

