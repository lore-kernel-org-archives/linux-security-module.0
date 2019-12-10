Return-Path: <SRS0=PCLm=2A=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 701A0C00454
	for <linux-security-module@archiver.kernel.org>; Tue, 10 Dec 2019 16:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 465AE2073D
	for <linux-security-module@archiver.kernel.org>; Tue, 10 Dec 2019 16:50:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="zrIO+Yz9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbfLJQuT (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 10 Dec 2019 11:50:19 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35621 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727542AbfLJQuT (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 10 Dec 2019 11:50:19 -0500
Received: by mail-lj1-f196.google.com with SMTP id j6so20727986lja.2
        for <linux-security-module@vger.kernel.org>; Tue, 10 Dec 2019 08:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uJBPNo5Ifpm4b2jx5CbDzjmnEU5Idos92xl1yp2IpZ4=;
        b=zrIO+Yz9oIcKVXb/1H+NHkasIJPZbw58jnP73LEmVuKzEev5Rs62uerQouXhG641Iy
         7jmQysaPyNd8eTPv5t4jeSK7EN/d5svDFhDlUgBkmGAne8IF62Nxd1ba+FwaZHN6RT/i
         T1ZDciEFuNEmWyjOXamrhUmgy+zuG+BglFSSFy4tfJSlRpKCBAvusSU+IDSeRGGT5RD+
         fLXwAjTy/cnQsYn1+yD1ywTYRlDZsVIEZyfgoOL6Oa9cRC3Cqq7zJAxyvV/VJtE+AybG
         a/IJ/9mjCwg1CyZXF5DleAL8nOOipz/egrsXRrXEwbyToS/RchsEKHVGHpazr/lOCrb0
         Tvww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uJBPNo5Ifpm4b2jx5CbDzjmnEU5Idos92xl1yp2IpZ4=;
        b=q0ETP5IFTWfbYPNAgpR4HT+m+f9+85REIWxUn6gsFMFRNsvQN0WxT5YisFoMr1+oqj
         1sKsWBfUGLpUI7a7/weDY0C8/1aaLFb35H2sQtgn4cPdYItHd5uuqr00uzsjp5cmbIQ+
         LdnsmaMU78YdTGTWyHgigpKC/zC9hTfYo8DVZtXJvZ+B+Mx3DPjb9+LPPjQH/9rehCZS
         hNOJBWaVwxH0e/ql1/ycUs7pn3h086iomxwQZ99IVpMZ65MQI88Upc3IDTQLX8kcF/5a
         zaDfjrwKIkmBYVXbFirrcwKzjcqMYOSsgdM2RZmNRtwFNVGEFc5s+XAvqQcAns5dT3EG
         q5OQ==
X-Gm-Message-State: APjAAAWS+U2aJUr8O0IaOFwE19lWHyPS+6yxHQswFhp+Egtg42JzANnO
        ice//kfwcHXZ5/iRDLxSkS0JMRh1SWCbfRISAbq/pgUKdw==
X-Google-Smtp-Source: APXvYqyWdr9mcOoFo4b/o0BKQ+PHnICc0npi2+looo9Uq+PMFdu0R+Bw+EYmYoD3Yg3gAF7xvxq7gCpJhmMbYwdMk4w=
X-Received: by 2002:a2e:4704:: with SMTP id u4mr21464693lja.117.1575996617044;
 Tue, 10 Dec 2019 08:50:17 -0800 (PST)
MIME-Version: 1.0
References: <157594493094.748324.9234611948545428995.stgit@chester>
 <285edbb5-b08e-5bdc-f951-841fe1d77521@tycho.nsa.gov> <CAHC9VhS4ksmcqBMzwQDArgd9xn_cJ+nyEBrHJcYjoiMaFzCq-Q@mail.gmail.com>
 <a11bfefc-c010-36ca-2303-35dcd4e9aa41@tycho.nsa.gov> <CAHC9VhRjs-pMWD-2ZTcF42eR3ugW7Bn7uYhmp4cQFneOtcqUkg@mail.gmail.com>
 <85a3c4ce-0636-30e7-21bf-dfcd4be5cd9c@tycho.nsa.gov>
In-Reply-To: <85a3c4ce-0636-30e7-21bf-dfcd4be5cd9c@tycho.nsa.gov>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 10 Dec 2019 11:50:06 -0500
Message-ID: <CAHC9VhSNO+e5Db2yY9roQNirAPy9B+BQ6q_x1oB6PbvOcK5TZQ@mail.gmail.com>
Subject: Re: [RFC PATCH] security: add an interface to lookup the lockdown reason
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-next@vger.kernel.org, jamorris@linux.microsoft.com
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Dec 10, 2019 at 11:20 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 12/10/19 10:58 AM, Paul Moore wrote:
> > On Tue, Dec 10, 2019 at 10:45 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> >> On 12/10/19 10:04 AM, Paul Moore wrote:
> >>> On Tue, Dec 10, 2019 at 9:59 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> >>>> On 12/9/19 9:28 PM, Paul Moore wrote:
> >>>>> With CONFIG_AUDIT enabled but CONFIG_SECURITY disabled we run into
> >>>>> a problem where the lockdown reason table is missing.  This patch
> >>>>> attempts to fix this by hiding the table behind a lookup function.
> >>>>
> >>>> Shouldn't lsm_audit.c be conditional on both CONFIG_AUDIT and
> >>>> CONFIG_SECURITY?  When/why would we want it built without
> >>>> CONFIG_SECURITY enabled?
> >>>
> >>> My first thought of a fix was just that, but I remembered that the
> >>> capabilities code is built regardless of the CONFIG_SECURITY setting
> >>> and I thought there might be some value in allowing for lsm_audit to
> >>> be used in commoncap (although in full disclosure commoncap doesn't
> >>> currently make use of lsm_audit).
> >>
> >> Seems contrary to normal practice, i.e. if/when commoncap grows a
> >> dependency, it can be changed then.
> >
> > Okay, want to submit a tested patch?  I really would like to get this
> > fixed before today's linux-next run.
>
> In looking at it, I'm wondering if we could just change the Makefile to
> use obj-$(CONFIG_SECURITY) instead of obj-$(CONFIG_AUDIT) for
> lsm_audit.c.  I think it might build just fine without CONFIG_AUDIT
> since audit.h provides static inlines that boil away to nothing for
> audit_log*() in that case. Offhand I don't see any support/examples of
> specifying two different config options for an obj list in a Makefile.

That should work too I think.

> The other option would be to introduce its own CONFIG_LSM_AUDIT option
> and select that option automatically for the modules that use it, which
> would currently be selinux, apparmor, and smack.  Then if you aren't
> using any of those modules you can omit it from your kernel.

This seems to be both the right thing to do, as well as overly complicated :)

I'm not sure I have a strong preference at this point, other than
getting it fixed.

-- 
paul moore
www.paul-moore.com
