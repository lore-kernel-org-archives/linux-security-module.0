Return-Path: <SRS0=+YFI=25=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAC8BC00523
	for <linux-security-module@archiver.kernel.org>; Wed,  8 Jan 2020 08:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 910A32051A
	for <linux-security-module@archiver.kernel.org>; Wed,  8 Jan 2020 08:16:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UAwm4X5R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgAHIQC (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 8 Jan 2020 03:16:02 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32102 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726290AbgAHIQC (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 8 Jan 2020 03:16:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578471360;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jF9+z/2U8knU4rgU50MXFQK1MLTixGWy9YUsL9ZLTcg=;
        b=UAwm4X5RTAWDsGFmtr9vwrpSiQ4VH6O4DOICsMtimCwYv9XoSa4e2ROOvYvC8bm69ReNQa
        uZbdFk00tQ+cqbvefDaPuf0sBUawz18HC0Y4ur3pscg1E6uSdQCWFQON3z3nT8KbKUdkn5
        3GZ/yg41T34bhg5LcLWC/BDDu3z5Q5w=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-22-gOQx4bUsO3mYNfLxYfsL6A-1; Wed, 08 Jan 2020 03:15:57 -0500
Received: by mail-oi1-f198.google.com with SMTP id n130so1288166oib.5
        for <linux-security-module@vger.kernel.org>; Wed, 08 Jan 2020 00:15:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=guT6kTsLokgbAQupkBrMXa7hfvd98YhJfrx8THelgJk=;
        b=SeDwQ/xvYvl1u9HuC7HPE72ibjWMllycPm4DDl78gwOmPivsjfim36UYBfyc21GJVJ
         nlGFFvVCGGNBDb4jvIH4+kanCvUu5cxITLT3ZCO9oUcP4YG4Jrxmmo7CfHEUoaKKpC6K
         iO3cjJcV9sqC/AeaENB0WdA4FyN6/t55t2ddsAq+lGndFfXVPnESZ2kWEcpb6dIZnlA/
         QuAueaJV8x3b6hB3o2UsN3QYrNqf1sOQEOlBcmw3O+z+J9T9A9L+6Kz/80NcqZospwwE
         1TfHZERLkyXJClwpHXV8QGRqY2OYJ/uDeYJAU5bf34W3jsXIXfbF2NPo54ASxZml42RE
         U3Rg==
X-Gm-Message-State: APjAAAWbcJ9NVEdLEujJOoj0l9MNp7hNw9MG/tURacBTUuwxV6JyGUn3
        KcoeELR1yu0kKJN3i0kxTcqSPa0ofRCvQo8QwDlJtZHrQk6seYfoOI9e9N/nMsLuiPdW/+Q/8l5
        BhG+xZeXabi+G6nzEUDr1PDTgYyRjcPQxQ/M/1RkvuU/4ZF4ePrVb
X-Received: by 2002:a9d:65da:: with SMTP id z26mr3263207oth.197.1578471356448;
        Wed, 08 Jan 2020 00:15:56 -0800 (PST)
X-Google-Smtp-Source: APXvYqx1WDTTWu8JFjHIcvLnML19PJN0hLw7rnXAyqh09eUDmnCDMK7ErIGk79rg1Nu/pOncZ8YIduADmYgLXuRvClU=
X-Received: by 2002:a9d:65da:: with SMTP id z26mr3263183oth.197.1578471356198;
 Wed, 08 Jan 2020 00:15:56 -0800 (PST)
MIME-Version: 1.0
References: <20200107133154.588958-1-omosnace@redhat.com> <20200107133154.588958-3-omosnace@redhat.com>
 <bad81aeb-c21f-c5be-12a1-61912d04573a@tycho.nsa.gov> <CAHC9VhRMLJLSUY5VfdDRv=OuyLkvzsyqfpNhf_SfC9V8OALJ4g@mail.gmail.com>
In-Reply-To: <CAHC9VhRMLJLSUY5VfdDRv=OuyLkvzsyqfpNhf_SfC9V8OALJ4g@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 8 Jan 2020 09:15:44 +0100
Message-ID: <CAFqZXNuv6OV_w_qneo-vK2Z4SBOqKRnnwNr-tgK__uSoX=76Ww@mail.gmail.com>
Subject: Re: [PATCH 2/2] security, selinux: get rid of security_delete_hooks()
To:     Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        SElinux list <selinux@vger.kernel.org>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Micah Morton <mortonm@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
X-MC-Unique: gOQx4bUsO3mYNfLxYfsL6A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Jan 8, 2020 at 6:32 AM Paul Moore <paul@paul-moore.com> wrote:
> On Tue, Jan 7, 2020 at 9:46 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > On 1/7/20 8:31 AM, Ondrej Mosnacek wrote:
> > > The only user is SELinux, which is hereby converted to check the
> > > disabled flag in each hook instead of removing the hooks from the lis=
t.
> > >
> > > The __lsm_ro_after_init macro is now removed and replaced with
> > > __ro_after_init directly.
> > >
> > > This fixes a race condition in SELinux runtime disable, which was
> > > introduced with the switch to hook lists in b1d9e6b0646d ("LSM: Switc=
h
> > > to lists of hooks").
> >
> > Not opposed (naturally, since I suggested it) but my impression from th=
e
> > earlier thread was that Paul preferred the less invasive approach of
> > your original patch (just reordering the hooks) as a short term fix wit=
h
> > an eye toward full removal of disable support in the not-too-distant fu=
ture.
>
> Unless we are seeing wide spread breakages (I don't think we are), or
> we decide we can never remove the runtime disable, I still prefer the
> hook-shuffle over the changes proposed in this patchset.

OK, I'm fine with either solution. Do you want me to rebase and resend
the reorder patch? There are some minor conflicts with Stephen's
recently merged patches.

--=20
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

