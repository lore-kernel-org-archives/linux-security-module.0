Return-Path: <SRS0=PCLm=2A=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB4AC00454
	for <linux-security-module@archiver.kernel.org>; Tue, 10 Dec 2019 15:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4E7F207FF
	for <linux-security-module@archiver.kernel.org>; Tue, 10 Dec 2019 15:58:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="OcdWiwF2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbfLJP6W (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 10 Dec 2019 10:58:22 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39881 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727407AbfLJP6V (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 10 Dec 2019 10:58:21 -0500
Received: by mail-lj1-f195.google.com with SMTP id e10so20485050ljj.6
        for <linux-security-module@vger.kernel.org>; Tue, 10 Dec 2019 07:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LEzPIee6pNHus2hM7ukA0TFs/leUR3YoNGkCo+m7X+8=;
        b=OcdWiwF2IPFEXVinDWDs9r34D/0XBAsh1i51ZzLjkBEMZ6IU+w5A5OvzU3FUT5AP6y
         EHZo0EfxBSMMisP/aeUu2gXQR9N0Mk1hrRvRsb6zio84jSEB6R87QhfAS03FOvF8jIl3
         /eJr4w4Kap6iPb2CCQqLpVd7yvu02IbbOKYnW0gAWNHYccRIDuAVZwE+/KrzYRXCm+xq
         7nVNsW5de7Z42ryhoPPRnlkedRZCGy5JMz/NMFg5ISc9+jItwy0S38S1ZoR25tmzdOnK
         m32BXquYyjkah3nQ9+xInHLP3l7ouPs+4AtSOZnIq0FS4p6X+FlhhdFxq3IQrYhOn1dS
         RvHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LEzPIee6pNHus2hM7ukA0TFs/leUR3YoNGkCo+m7X+8=;
        b=iROas3eXqFCMuBGheUDQGIP6Ek/sqrOjRVyk0BEK/perY2i+7g0Lx9KlLU9VUyl0B6
         nHF+G7Pev9rkB2SZNr7NYa666OODCF53C/ZMXcWxkJrSLIrYWTPDJ2FAXOIlamIf05Gr
         26sHQTomSo+RejXKnwpRKx6v8fS5n8kucNanaryoBM6wMYMyQgU2mEVlDcnRcrR3sqs7
         4kCzDEmUc624z3k/mNrzPKFMJ02EwzfN0KuGfN/ACBRyMK6DI3idmoWAO1govGfwO4/j
         mmFYvuwXyb1K87XRV6cbr54zBjYXLyG2zIHqaln6iWSqC2L1uRqL1tlQ6xdxJ6pPTYlg
         VoaQ==
X-Gm-Message-State: APjAAAUy8qUxTa/0XFbHSqTpYBBmx6+rly3pMEcVWlVl+K6rq3AlqGeA
        lYVwFOylK9bhIZctTG3K8kSbwltsUEH5908Skz1f
X-Google-Smtp-Source: APXvYqxXbSn/v5tMZSkgXLe21RUKVQldm8wnVs/okHayFlloRlBWnIs3FHi60D2H2iBj03JLYgmeGDbuiwUAo1b2Rc8=
X-Received: by 2002:a2e:99cd:: with SMTP id l13mr6865932ljj.243.1575993499711;
 Tue, 10 Dec 2019 07:58:19 -0800 (PST)
MIME-Version: 1.0
References: <157594493094.748324.9234611948545428995.stgit@chester>
 <285edbb5-b08e-5bdc-f951-841fe1d77521@tycho.nsa.gov> <CAHC9VhS4ksmcqBMzwQDArgd9xn_cJ+nyEBrHJcYjoiMaFzCq-Q@mail.gmail.com>
 <a11bfefc-c010-36ca-2303-35dcd4e9aa41@tycho.nsa.gov>
In-Reply-To: <a11bfefc-c010-36ca-2303-35dcd4e9aa41@tycho.nsa.gov>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 10 Dec 2019 10:58:08 -0500
Message-ID: <CAHC9VhRjs-pMWD-2ZTcF42eR3ugW7Bn7uYhmp4cQFneOtcqUkg@mail.gmail.com>
Subject: Re: [RFC PATCH] security: add an interface to lookup the lockdown reason
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-next@vger.kernel.org, jamorris@linux.microsoft.com
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Dec 10, 2019 at 10:45 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 12/10/19 10:04 AM, Paul Moore wrote:
> > On Tue, Dec 10, 2019 at 9:59 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> >> On 12/9/19 9:28 PM, Paul Moore wrote:
> >>> With CONFIG_AUDIT enabled but CONFIG_SECURITY disabled we run into
> >>> a problem where the lockdown reason table is missing.  This patch
> >>> attempts to fix this by hiding the table behind a lookup function.
> >>
> >> Shouldn't lsm_audit.c be conditional on both CONFIG_AUDIT and
> >> CONFIG_SECURITY?  When/why would we want it built without
> >> CONFIG_SECURITY enabled?
> >
> > My first thought of a fix was just that, but I remembered that the
> > capabilities code is built regardless of the CONFIG_SECURITY setting
> > and I thought there might be some value in allowing for lsm_audit to
> > be used in commoncap (although in full disclosure commoncap doesn't
> > currently make use of lsm_audit).
>
> Seems contrary to normal practice, i.e. if/when commoncap grows a
> dependency, it can be changed then.

Okay, want to submit a tested patch?  I really would like to get this
fixed before today's linux-next run.

-- 
paul moore
www.paul-moore.com
