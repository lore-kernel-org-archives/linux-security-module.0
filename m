Return-Path: <SRS0=4koF=W7=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07503C3A5A8
	for <linux-security-module@archiver.kernel.org>; Wed,  4 Sep 2019 16:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE9DB208E4
	for <linux-security-module@archiver.kernel.org>; Wed,  4 Sep 2019 16:51:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i3Woe2pW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732256AbfIDQva (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 4 Sep 2019 12:51:30 -0400
Received: from mail-io1-f41.google.com ([209.85.166.41]:39855 "EHLO
        mail-io1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732209AbfIDQv3 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 4 Sep 2019 12:51:29 -0400
Received: by mail-io1-f41.google.com with SMTP id d25so43173818iob.6
        for <linux-security-module@vger.kernel.org>; Wed, 04 Sep 2019 09:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WZhwDl6poxhpjErg8726fERGH8TrIU1vOsYDyQkch3E=;
        b=i3Woe2pWDCqAw20ncPSTH8Ql/DNWO3edrHq446JMjqWucW0BQjssI4ttLhKd71iIyA
         s4xgPPgqhtUZDObsdTA0/iwkPfmg+Uz/cfT/9iJpj/RDTX/MtG83BLLsK+bHQxU+LbCJ
         Jse0xUFXD6Uzij7kOt7TziTiqtDRxp8wvxVVPsLKaCquivp6GEMrHerFs7w64WsyQDoy
         Ki44kzBodecZCrKnR4RzT9Nw1C94M2ntE8SKSIbn+OzoGXMEuGDuYKmYPX6bb2yvC1lr
         ChOh5yXl2tF0pod2DjqiglMA155srRe6QOwrzQBKXSalbNM9bk2Hfr1AgrVFR7xavRyN
         7J1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WZhwDl6poxhpjErg8726fERGH8TrIU1vOsYDyQkch3E=;
        b=U+tWM84LkV/55y0HWUrz/ZVZlV3hpdidGA0dJgBadQ/7DRdpXHNSwzbvpMn6KZOWj1
         TAQ0H/xze640a7vIzUlZfyWTQU4WDvgSXicCKbqpF+Gi9LCZnL/v7DsJp8uxCLdKQ5Ec
         rarAo3Ae+eThqUuGAg9Dq8PJnB09UFSEsMoIAAHWvixIMHnoDc2sK3uYGTXC8yvkVRdL
         vZ0EwXiah/Oyqr0zSRFagoL1KSIEtli2CJM5B0xxoyvt2WYydWfacfr8sMRGkQ3cTj3X
         uu1fIYAf+ofUq2nOdZ78hqZFyYeH3UU3F/FFmK+aBfeqrPt2113mDyFYaH2Gokdz9W9y
         Dw3g==
X-Gm-Message-State: APjAAAWlfA+dqMqeRFMzPW16tKf5QTMGkKfV4Tgys79adw9qTRJXbx8N
        5A+CKLwnt7RWhPk58wGccxrzjj0VV6XrOnuAMZdMRsdDPhE=
X-Google-Smtp-Source: APXvYqwjRF8a99iUluCFFe+DjE80oak9svxYnq42f+Yw74Cq7sqW1SVYbnVAS0cHrDmZBYUEGkazDlwCG7/YSNLiOY8=
X-Received: by 2002:a6b:6303:: with SMTP id p3mr5303269iog.169.1567615888614;
 Wed, 04 Sep 2019 09:51:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190820001805.241928-1-matthewgarrett@google.com>
 <20190820001805.241928-4-matthewgarrett@google.com> <3440.1567182506@warthog.procyon.org.uk>
In-Reply-To: <3440.1567182506@warthog.procyon.org.uk>
From:   Matthew Garrett <mjg59@google.com>
Date:   Wed, 4 Sep 2019 09:51:16 -0700
Message-ID: <CACdnJuvR7mqhpzEQZdgw9EE_PsM-QWQ_JmwFLcoeLbAuKCHnOA@mail.gmail.com>
Subject: Re: [PATCH V40 03/29] security: Add a static lockdown policy LSM
To:     David Howells <dhowells@redhat.com>
Cc:     James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Aug 30, 2019 at 9:28 AM David Howells <dhowells@redhat.com> wrote:
>
> Matthew Garrett <matthewgarrett@google.com> wrote:
>
> > +static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
>
> const char *const maybe?

Seems reasonable.

> > +static enum lockdown_reason lockdown_levels[] = {LOCKDOWN_NONE,
> > +                                              LOCKDOWN_INTEGRITY_MAX,
> > +                                              LOCKDOWN_CONFIDENTIALITY_MAX};
> > +
>
> const?
>
> Isn't this also a 1:1 mapping?

Sorry, a 1:1 mapping to what?

> > +static int lock_kernel_down(const char *where, enum lockdown_reason level)
>
> Is the last parameter the reason or the level?  You're mixing the terms.

Fair.
