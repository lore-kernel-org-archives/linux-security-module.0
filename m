Return-Path: <SRS0=FyGa=TC=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B01CDC43219
	for <linux-security-module@archiver.kernel.org>; Thu,  2 May 2019 18:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86BD92089E
	for <linux-security-module@archiver.kernel.org>; Thu,  2 May 2019 18:04:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f6K3kASC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbfEBSEQ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 2 May 2019 14:04:16 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:43390 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbfEBSEQ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 2 May 2019 14:04:16 -0400
Received: by mail-io1-f68.google.com with SMTP id v9so2972641iol.10
        for <linux-security-module@vger.kernel.org>; Thu, 02 May 2019 11:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SU8aAABM065YNEdWIrP9VLfp6wM73Cy7sMn9LwYteHs=;
        b=f6K3kASCYwWOdpWL00hYEo/+O/+CwPAE2qa1EtzQcxap9LAXrl7bqlrPM0S9hqlXsQ
         qX1HzZF4jMJasflI6Mybe9MKHpeTHoWe5acw8gOxw8Hf9pIhift/FFiimHgdv2e4xZfb
         9kf/xiRQxrC/X8/LFpH6zxYwZ4Wn+mxVYzkhqbPxAfzwgjb60gpIKkR4SlezVynmltla
         wTVQkENc8evGTLe+QtK8AJopchFw5aKJ7SA+Gf4T3TrKQPeZB9KFLZ+YusbTSKcVvgf+
         8lb7chFVhHZ5bqsR3MBHXCsCgth8bLv9Qb4BtrcxHEASc7H/izDiylpK/cJV/CYmLy8D
         gDSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SU8aAABM065YNEdWIrP9VLfp6wM73Cy7sMn9LwYteHs=;
        b=AFLQicE1oOLCQ0qWh6vj8ag9dtsKUMXQyl1LhTYyFq+OdXunfOVlleL+sXTH/gW3kb
         c9MQ3xRKH95Y4Vi/+Zjm7ujDKrwCTkN/3sCM1vKH33a1Qps/zW+HIRu7hoqxXdwG+9Yr
         2Jh/004tVScrrgZ60Tz9iu/Gu9CmVlygotpoVjQceSFgmxNMNggOeA1Wn2XrjO7Um0N4
         5w5WME+zLiwjd70Q/L6Dxwt+IhHIsPL0hflU0lYsR8CFATcKan1kNFCgy1fPku6lhYet
         oa0a4fZSj2OVWZNNLrRU/88jYuDmiW6KKn8XXBQgCOpdkboD6seOsgFiu3HuZApuUfno
         qLgw==
X-Gm-Message-State: APjAAAVvk/eYJqquejJtJTECRl9tpzZLGWC/5YPdNJlU1FUi34xinauo
        djrbdJ79fMwobEHngSCJkAf9tV84iSn7dxjMu09NTg==
X-Google-Smtp-Source: APXvYqyOj3bra2PT4XDD15cGgua2vqDCD5l2gbA7o5aTdMvJLqabYtOM7r7Cn1WgphZlqar6cqRNgFtIRQ6JGsZ4xt0=
X-Received: by 2002:a5e:8348:: with SMTP id y8mr3682573iom.88.1556820254756;
 Thu, 02 May 2019 11:04:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190227202658.197113-1-matthewgarrett@google.com>
 <20190227202658.197113-3-matthewgarrett@google.com> <CAJzaN5pUJoOCz5-ZDSnTb6dbVPuy0QwmFD0CeofAGK+bRQx0og@mail.gmail.com>
 <CACdnJutpBPAX6TOGgs3Ng2v_cC5hAf-3pHThESvjQ9vbvQeVkA@mail.gmail.com> <CAKv+Gu9PF4u=-7QL4e36Q3S5kC4+5Z=yLYHLT9jE+eNY7YUV7A@mail.gmail.com>
In-Reply-To: <CAKv+Gu9PF4u=-7QL4e36Q3S5kC4+5Z=yLYHLT9jE+eNY7YUV7A@mail.gmail.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Thu, 2 May 2019 11:04:03 -0700
Message-ID: <CACdnJuvDuw0X9iwEqOu7EjM5ca1f+n7f=xqzrTPS9PyrmqKNHQ@mail.gmail.com>
Subject: Re: [PATCH V5 2/4] tpm: Reserve the TPM final events table
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Bartosz Szczepanek <bsz@semihalf.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, May 2, 2019 at 12:15 AM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
>
> (+ Ingo)
>
> On Tue, 30 Apr 2019 at 21:52, Matthew Garrett <mjg59@google.com> wrote:
> >
> > On Tue, Apr 30, 2019 at 6:07 AM Bartosz Szczepanek <bsz@semihalf.com> wrote:
> > >
> > > I may be a little late with this comment, but I've just tested these
> > > patches on aarch64 platform (from the top of jjs/master) and got
> > > kernel panic ("Unable to handle kernel read", full log at the end of
> > > mail). I think there's problem with below call to
> > > tpm2_calc_event_log_size(), where physical address of efi.tpm_log is
> > > passed as (void *) and never remapped:
> >
> > Yes, it looks like this is just broken. Can you try with the attached patch?
>
> I'm a bit uncomfortable with EFI code that is obviously broken and
> untested being queued for the next merge window in another tree.

The patchset was Cc:ed to linux-efi@. Is there anything else I should
have done to ensure you picked it up rather than Jarkko?
