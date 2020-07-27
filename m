Return-Path: <SRS0=m40R=BG=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B08C433E1
	for <linux-security-module@archiver.kernel.org>; Mon, 27 Jul 2020 20:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17AA920809
	for <linux-security-module@archiver.kernel.org>; Mon, 27 Jul 2020 20:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595883479;
	bh=AMSN2ecQFesrryvC8lvOnbL7UBWDRobz8cXhfmoQXb4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=o/G8djtnLTNdmF+BwYIjHPasu1KItarBdyqKBQInf1nn9i4RzpI7W2IbN5YJRw2tZ
	 2BaPDPFAW86fFQduCT2WwyTXZFKxLOvjNgodVMscpOEsCZ74OHRSdHhF3fnrCvtb0A
	 vaZ9xmhNbtjV0NDO5ib2tqpt/WcaavF39EkSYHAM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbgG0U56 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 27 Jul 2020 16:57:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:37432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726171AbgG0U56 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 27 Jul 2020 16:57:58 -0400
Received: from localhost.localdomain (pool-96-246-152-186.nycmny.fios.verizon.net [96.246.152.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C0CB20838;
        Mon, 27 Jul 2020 20:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595883478;
        bh=AMSN2ecQFesrryvC8lvOnbL7UBWDRobz8cXhfmoQXb4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=RujnX9ZJola97Aga2AvExn0NHQBjg3drtWr/XHQ6jZ4Bc0og1CnxHQfuWQNuS6ZaG
         JykataoGGPIl4l3hzdUZ/nqn255YvbgpeBbATvi+1N37QOjEb2XDMSURl2RnFLNU4j
         eK98wqwZzlZwjr+FlyqNL7dT0Ix0TCYJ6eeykoZ0=
Message-ID: <1595883476.4841.167.camel@kernel.org>
Subject: Re: [PATCH] integrity: remove redundant initialization of variable
 ret
From:   Mimi Zohar <zohar@kernel.org>
To:     James Morris <jmorris@namei.org>,
        Colin King <colin.king@canonical.com>,
        Mimi Zohar <zohar@linux.ibm.com>
Cc:     "Serge E . Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 27 Jul 2020 16:57:56 -0400
In-Reply-To: <alpine.LRH.2.21.2007280405340.18670@namei.org>
References: <20200701134634.549399-1-colin.king@canonical.com>
         <alpine.LRH.2.21.2007280405340.18670@namei.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, 2020-07-28 at 04:05 +1000, James Morris wrote:
> On Wed, 1 Jul 2020, Colin King wrote:
> 
> > From: Colin Ian King <colin.king@canonical.com>
> > 
> > The variable ret is being initialized with a value that is never read
> > and it is being updated later with a new value.  The initialization is
> > redundant and can be removed.
> > 
> > Addresses-Coverity: ("Unused value")
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > ---
> >  security/integrity/digsig_asymmetric.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/security/integrity/digsig_asymmetric.c b/security/integrity/digsig_asymmetric.c
> > index 4e0d6778277e..cfa4127d0518 100644
> > --- a/security/integrity/digsig_asymmetric.c
> > +++ b/security/integrity/digsig_asymmetric.c
> > @@ -79,7 +79,7 @@ int asymmetric_verify(struct key *keyring, const char *sig,
> >  	struct public_key_signature pks;
> >  	struct signature_v2_hdr *hdr = (struct signature_v2_hdr *)sig;
> >  	struct key *key;
> > -	int ret = -ENOMEM;
> > +	int ret;
> 
> Assuming Mimi will grab this.
> 
> 
> Acked-by: James Morris <jamorris@linux.microsoft.com>

Yes, thank you for the reminder.

Mimi
