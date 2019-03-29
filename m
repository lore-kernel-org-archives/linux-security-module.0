Return-Path: <SRS0=lFQA=SA=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4561AC10F05
	for <linux-security-module@archiver.kernel.org>; Fri, 29 Mar 2019 11:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B1832184C
	for <linux-security-module@archiver.kernel.org>; Fri, 29 Mar 2019 11:51:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.ch header.i=@protonmail.ch header.b="LwPzZMrr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729427AbfC2Lvw (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 29 Mar 2019 07:51:52 -0400
Received: from mail-40130.protonmail.ch ([185.70.40.130]:41067 "EHLO
        mail-40130.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729419AbfC2Lvw (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 29 Mar 2019 07:51:52 -0400
Date:   Fri, 29 Mar 2019 11:51:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.ch;
        s=default; t=1553860309;
        bh=4gf84StZPnKmYHqTKNEAE9Hg0XymADRTmxkhrK2R6yI=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:
         Feedback-ID:From;
        b=LwPzZMrroPQCXYF4xn8fMkPMvT9cq1U640iGgJtpQMRwpUd8yN8FDXkfvI4i5tVZs
         4/31e/ImmycdS1Ctyp/qdEamle4W3V0IpffsmS1qusP4kM2jouK93HdstiLTi/G3Y5
         6+SuhHDbIFDnooNMLTxy/NKyBG46bJcADovpLTWQ=
To:     Mimi Zohar <zohar@linux.ibm.com>
From:   Jordan Glover <Golden_Miller83@protonmail.ch>
Cc:     Igor Zhbanov <i.zhbanov@omprussia.ru>,
        Matthew Garrett <mjg59@google.com>,
        Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Paul Moore <paul@paul-moore.com>,
        John Johansen <john.johansen@canonical.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Jann Horn <jannh@google.com>,
        linux-security-module <linux-security-module@vger.kernel.org>
Reply-To: Jordan Glover <Golden_Miller83@protonmail.ch>
Subject: Re: Should mprotect(..., PROT_EXEC) be checked by IMA?
Message-ID: <qVt5eJGvmcoQ8hfVSs5S4nXQ_3dFyZne8vIO0fNgJevhW19XHIaJxnlBMlDfUOanUoTjTk5bLes-9ipnzoLSg1xciMA4zivRRFkaTHp5YWQ=@protonmail.ch>
In-Reply-To: <1553857187.9420.49.camel@linux.ibm.com>
References: <cce2c4c7-5333-41c3-aeef-34d43e63acb0@omprussia.ru>
 <CACdnJut6YfLnq-nCC1hHTrKYXabHoSEXN1wMuCyVybU+o_iwCg@mail.gmail.com>
 <1553167318.4899.382.camel@linux.ibm.com>
 <dab923ca-ef53-4af2-034a-bea4151a4e25@omprussia.ru>
 <CACdnJuvVqibDdd+MLKOHqEfdngTk=GSkfybj1jS3MpmC7rjyHg@mail.gmail.com>
 <07347317-ee71-83c1-384a-0c3439980af7@omprussia.ru>
 <1553793463.8711.26.camel@linux.ibm.com>
 <92718382-8669-748f-10d8-02fa21225210@omprussia.ru>
 <1553857187.9420.49.camel@linux.ibm.com>
Feedback-ID: QEdvdaLhFJaqnofhWA-dldGwsuoeDdDw7vz0UPs8r8sanA3bIt8zJdf4aDqYKSy4gJuZ0WvFYJtvq21y6ge_uQ==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Friday, March 29, 2019 10:59 AM, Mimi Zohar <zohar@linux.ibm.com> wrote:

> [Cc'ing the LSM mailing list and others]
>
> On Fri, 2019-03-29 at 13:00 +0300, Igor Zhbanov wrote:
>
> > Hi Mimi,On 28.03.2019 20:17, Mimi Zohar wrote:
>
> > > I just came across the grsecurity article on mprotect.[1]
> > > Has anyone looked at it? Would it make sense to make it a minor LSM?
> > > [1]https://pax.grsecurity.net/docs/mprotect.txt
> >
> > Interesting article. It is almost exactly of what I wanted to be implem=
ented.
> > If this minor LSM would be stackable to allow combining with e.g. SELin=
ux
> > then why not.
>
> Stacking shouldn't be a problem. =C2=A0Other LSMs are already on the
> mprotect hook. =C2=A0Let's hear what others think.
>
> Mimi

There is already minor LSM in progress: https://sara.smeso.it/en/latest/

Jordan
