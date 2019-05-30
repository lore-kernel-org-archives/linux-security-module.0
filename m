Return-Path: <SRS0=RYp/=T6=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90EFDC28CC3
	for <linux-security-module@archiver.kernel.org>; Thu, 30 May 2019 13:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A4BE2411A
	for <linux-security-module@archiver.kernel.org>; Thu, 30 May 2019 13:27:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HvzBFemu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbfE3N1e (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 30 May 2019 09:27:34 -0400
Received: from mail-lj1-f175.google.com ([209.85.208.175]:40450 "EHLO
        mail-lj1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbfE3N1d (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 30 May 2019 09:27:33 -0400
Received: by mail-lj1-f175.google.com with SMTP id q62so6045926ljq.7;
        Thu, 30 May 2019 06:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=00OM/ny1mBW9nh/FPGB9z4I/WrYY8XWyANyGDwrz1/Q=;
        b=HvzBFemuujfMVZMyx5kBndIPyVQwLa4qP8eHK8PJ7JZ2f2mtK1eHe2lU7DJW4o6jgS
         2gqj65BwUJpnsS5wpm1DO5h7IN0dZ5A9EASBSaB3Us5eieXvQY/D8nG60v8DbFcgkbJA
         AMHnMJbliN71yKg9jYCCM6lC/GFU1N1axyMc2hFuBy2ymbUetVvhpujsw6Ixw6wKCnlv
         IgJUW3LSIeoFFpfH/h+zldDSCpjF3uL4bpCJ3RZqkRPoNhiMwk7IfAFE3G5scxfN6g+Y
         zostYlPxc+uSnLKuQTv0VYQB/u1rwf+bHBUOpw0GQW6WgEtGVolWno09ClpbEBmb35Pf
         ybhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=00OM/ny1mBW9nh/FPGB9z4I/WrYY8XWyANyGDwrz1/Q=;
        b=PoghbcCE1OZ2wlFM+fRzp1iPiNjndQxYCQVhI3A4PRPIZryr7IkOKM/4kyO+viJEuc
         H2ucBFTxE6ChLE4LnGH+NYXUWScrVspqPntUvW7Phhl/dyyWDH3yI2Pe2c8y9uDpVZeD
         MGW4J+i31GCZ6knzqep4NomTo+mXCqRKQ0KguYNyQw1r9UYNzxfuaSp45yQxEYQwA2Cs
         AbkDFyZ5FtL8nE5KKXe6RrL4c+cxl6RWG3ot07GAoMDOS4HzjCLsky5ulo4XHL4aZxYD
         +gcmB3/Vp7IM7wSWw2JssTfCFcs2UUNtj1FKBPfVc693prd3yDrdMFFOKFOHzdAriCru
         TJsA==
X-Gm-Message-State: APjAAAWDlCyRV1lfgZ1H4C67UzpYEhWU7GIxo+krCgdFamHjN//lMyZH
        31iovvxLHTE1WVgBwurAxFvTbHa7ghmavK5VsqE=
X-Google-Smtp-Source: APXvYqwB8iOqXc6ut54zxPiYeKHoDkR3JBN2/9p2QqZQj3Odvh79sTYvDz1OQ5IO2LxlVAYH2ulcwvHwallRuuqFKLI=
X-Received: by 2002:a2e:9259:: with SMTP id v25mr2173067ljg.46.1559222851408;
 Thu, 30 May 2019 06:27:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAE=NcrYsfQ2ijJJMEyTFoWnFqF2qGS=B2JNsVaE8WUNcGS7D9Q@mail.gmail.com>
 <e8dcc9a2-594d-f81a-32a7-e18f591c6062@tycho.nsa.gov> <4a725f06-8244-8264-a911-df7ca1c66789@tycho.nsa.gov>
 <1558530022.4347.11.camel@linux.ibm.com> <4db98b76-8637-edf6-c7df-3e244be0f11e@tycho.nsa.gov>
 <1558533420.4347.30.camel@linux.ibm.com> <1432f617-424e-044c-4f78-47f1100262ae@tycho.nsa.gov>
 <CAE=NcranYrvV5Xnu8656kyDVUUzCs=Tdy+fkeo5jwVhtF8=81Q@mail.gmail.com> <a39cedd1-a932-3140-bf11-ef4e3a88e254@tycho.nsa.gov>
In-Reply-To: <a39cedd1-a932-3140-bf11-ef4e3a88e254@tycho.nsa.gov>
From:   Janne Karhunen <janne.karhunen@gmail.com>
Date:   Thu, 30 May 2019 16:27:19 +0300
Message-ID: <CAE=NcrYV_x6dKbVvO+EDZNKMuEqVhyMKrdEjuUJXqfcYVeiXBA@mail.gmail.com>
Subject: Re: sleep in selinux_audit_rule_init
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Paul Moore <paul@paul-moore.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Dan Jurgens <danielj@mellanox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, May 30, 2019 at 3:08 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:

> > @@ -269,11 +269,23 @@ static void ima_lsm_update_rules(void)
> >                                                             Audit_equal,
> >                                                             entry->lsm[i].args_p,
> >                                                             &entry->lsm[i].rule);
> > -                       BUG_ON(!entry->lsm[i].rule);
> > +                       if (result == -EINVAL)
> > +                               pr_warn("ima: rule for LSM \'%d\' is invalid\n",
> > +                                       entry->lsm[i].type);
>
> I could be wrong, but I think there is still a problem here in that you
> are modifying entry->lsm[i].rule in-place, but it is protected under RCU
> and therefore needs to be duplicated and then modified?  Also you are
> leaking the old rule?

Right. Bit too fast tapping the keyboard without thinking, will fix
and post in the proper form. But I guess the original point was to
verify if that 'notifier_block' is indeed the right way to get the
update notification?


>  Both of those issues also exist prior to your
> patch but you aren't fixing them here. And lastly, it looks like lsm
> notifiers are atomic notifiers (not clear to me why) so you can't block
> in the callback, thereby requiring scheduling the work as is done in
> infiniband.

Great catch, thank you. That's an easy fix if no-one objects pushing
these through the system-wq for example.


--
Janne
