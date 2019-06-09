Return-Path: <SRS0=UuNM=UI=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE8CC468BE
	for <linux-security-module@archiver.kernel.org>; Sun,  9 Jun 2019 17:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9DC3206C3
	for <linux-security-module@archiver.kernel.org>; Sun,  9 Jun 2019 17:07:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LzAAe+Tk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389084AbfFIRGv (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 9 Jun 2019 13:06:51 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42125 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388593AbfFIRGu (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 9 Jun 2019 13:06:50 -0400
Received: by mail-lj1-f195.google.com with SMTP id t28so5790523lje.9;
        Sun, 09 Jun 2019 10:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gGV10idHgx5OoEyeZ70v3PUsySFkt989S84U24GlNss=;
        b=LzAAe+TkzJPbUtppaHPrh0qxTyQUI3cNCyMFguy/crPom1tlzYEVhEsITRGvJYeBpu
         iDaxT3B35QLLIHAiayaCkd5OGqrhnjkw2TcQAJwhZggcQnClLYSAdnN2T3WBNA74HitS
         MGmwsj6Vfh/x7XkOZCaUF6qa1PqabDeiyXqF0nVbKhblgq/pMa9eMEOVizjLF3ZR4LTP
         YeFLgUaSVeJ0SyVjhUauyM1eLMkK+VS/jjjsAWqLctBzIMsy8bS3Yaft7+WVKIWQwhdA
         syCFRsEXKxDzecAe15RLwdbhuUc5Ujk+SbC34Ccl3z97YfkL7R6Gr7XCffSDQdrZSqtO
         RLpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gGV10idHgx5OoEyeZ70v3PUsySFkt989S84U24GlNss=;
        b=NBYOyrMGm4lCuymCRC3UGSlVJZzkYZeB2YV0doDJegg3xiUqhcBgzNyDr/GP7N13ix
         SbfSknZap3r7WUYQ7bfovuiegIfeliwlYUbPYURay6ayVdIQ0GVcvAYFhlM53wb2+Zfh
         OIc1KtfbP50lkCU4YwUVTajqEqZCnBSfwDBBsCA9fwQBehJmW7IIhU8IaqB4Y/BXm0/W
         YHQ3BlJefly6V/mUln2/HFtYd83dMbLbmCX7f2Yv6iTdHnpHoiVN+R8XEFgGmSrqmF5G
         TOXJuU7R7+Pv8/oyTV7dGU7ahF7xm8MweJ8SVuujnu+EBB7J3aS0Ci2HQXvnZls68ioA
         sHMg==
X-Gm-Message-State: APjAAAX8bjmTB86K8MkVvHI0ItMVahwtBR5oLQRhB5YIp0uAfrIsfXRz
        HdNol5T6twOjxXk2KKikRjFKn728Ow4UV6oW5k8=
X-Google-Smtp-Source: APXvYqwmYT6l3NGefpOw6K8jgYeDCFp0F9kke0M/LXAw5jD/n5BHG/ZJ6OJ9zMeOZML9jwSEoR1Bm+fE68AsfHTc3Ls=
X-Received: by 2002:a2e:3a05:: with SMTP id h5mr23150927lja.114.1560100008157;
 Sun, 09 Jun 2019 10:06:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190605083606.4209-1-janne.karhunen@gmail.com>
 <9121835b-d6ac-c9d5-349a-1ef7024c6192@schaufler-ca.com> <CAE=NcrahPmzmB-xJwxzXqaPGtJY+ijbxV4wXz7K=y-ocw4Cmwg@mail.gmail.com>
 <1edfbd72-f492-db17-8717-a8cfe30d9654@schaufler-ca.com> <CAHC9VhTzwPoxYPxYWn15ZQQwM6Q3wGJSRybb-zu_ZDA1xU6ziQ@mail.gmail.com>
 <alpine.LRH.2.21.1906071043160.21512@namei.org> <CAHC9VhSrjVmnsAuXDmHVmsyDaEF10nsvdxq7VsfCsh=NfaOMQg@mail.gmail.com>
 <alpine.LRH.2.21.1906080748010.24873@namei.org>
In-Reply-To: <alpine.LRH.2.21.1906080748010.24873@namei.org>
From:   Janne Karhunen <janne.karhunen@gmail.com>
Date:   Sun, 9 Jun 2019 20:06:37 +0300
Message-ID: <CAE=NcrYrBPZEkB==+n_PB539kwL7awRVuohWUpfTKCXAgKK0kA@mail.gmail.com>
Subject: Re: [PATCH 1/2] LSM: switch to blocking policy update notifiers
To:     James Morris <jmorris@namei.org>
Cc:     Paul Moore <paul@paul-moore.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sat, Jun 8, 2019 at 12:48 AM James Morris <jmorris@namei.org> wrote:

> > simple fact that we started with one type of notifier for the LSM, and
> > we are now switching to the other (and getting lucky that it is safe
> > to do so for the existing callers) seems to lend some weight to the
> > argument we may need both and adding "block"/"blocking"/etc. to the
> > name has value.
>
> Fair enough.

Ok, I take this to mean we have an agreement to go with this variant.
I will post the fixes to the Mimi's findings on top of this one
tomorrow.


--
Janne
