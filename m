Return-Path: <SRS0=8dNN=VN=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A26AC76192
	for <linux-security-module@archiver.kernel.org>; Tue, 16 Jul 2019 20:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFEDE20659
	for <linux-security-module@archiver.kernel.org>; Tue, 16 Jul 2019 20:35:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ciR4v8Oh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbfGPUfL (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 16 Jul 2019 16:35:11 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:37154 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729076AbfGPUfH (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 16 Jul 2019 16:35:07 -0400
Received: by mail-vs1-f65.google.com with SMTP id v6so14886036vsq.4
        for <linux-security-module@vger.kernel.org>; Tue, 16 Jul 2019 13:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VTXuJjlx5q7Qe80Yz5WGd6e0nqZG+IooCpGI3pnycJ4=;
        b=ciR4v8OhapnxETOGK7wfTSZ2HGLg5se7oSc+10v/R6wCoaTEmXzWxPDt9oxHC7JyTF
         3OBlmd6OF2VFqqBP5UA5gEGCQpxr6VsxRZq+UJyxjUuhV4fZS+fn5gUYNVQmFqwerA+l
         Dvlk44dSQmMS1DBn+qEEaLADi+7J3vPMB+uAkK8S6qGv2j2B01Am1tLxy/G5/Nq7wpwm
         kELdNFdRDu3OT26VIB9t72SodzeeS67ODNGn6uZA/Izb2C5qi3+K0OTAxcOoFrC5DIFb
         OgPkZr/yEBcciExidG+IrFGISg9uEbuuiV24lVUWbVDYx8i1P5Yb4kZVXHWnuaNhCIS+
         4L6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VTXuJjlx5q7Qe80Yz5WGd6e0nqZG+IooCpGI3pnycJ4=;
        b=SZDV5h603RCcUEfD9yhEJONdxSfR1NxmWs/pmfLwakWWayF7dJ+7+1ou25pzpQ7Igq
         0j8Za8FQjXIMDnqN5HwyFisqNV+xMIynMbqPLawymnS50Xel4X8AtlpXvJI0CDXQHp9K
         dQ6fz6n/2zc/UAkPopt5hg/d0lx+dIpfXxYp5HytWR5PnZqppnFZpSEFQE6yVDr2vQTj
         E2h+8/bWFbH39OOY41fG1/ItmQUbAlVY+Slmaq/47nL+EzIrn864CWF3jlR3L+9bkQgs
         yA9UV9ZeRoAFqipcs9TT9k6rNGc15dE5681hL+SvXFZein8Noa8z6sGG6qDXRZCETUGN
         r1ow==
X-Gm-Message-State: APjAAAWk+uWUWgqR0693DZ8Qr/MvivDZ9m9fXNs1pGYKs14MeDXLx3mQ
        kvpnJc7rj4DFKQRJpwn+ebbsia641UzHH8k4BPZNcKHtuUA=
X-Google-Smtp-Source: APXvYqwULruIwhcKPZuWhSs6rndmokQERBpELkF586kigli0sXfpel4ZL/ik7omczmrrcRQVAd0KEsGFYuf4cFnxhF0=
X-Received: by 2002:a67:ff99:: with SMTP id v25mr22116833vsq.158.1563309305642;
 Tue, 16 Jul 2019 13:35:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190715195946.223443-1-matthewgarrett@google.com>
 <20190715195946.223443-16-matthewgarrett@google.com> <20190716025923.GA5793@dhcp-128-65.nay.redhat.com>
In-Reply-To: <20190716025923.GA5793@dhcp-128-65.nay.redhat.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Tue, 16 Jul 2019 13:34:54 -0700
Message-ID: <CACdnJuut9cfc1fsAy63t0Z=JVujmNELm2Xm1grEZzORF5Cuviw@mail.gmail.com>
Subject: Re: [PATCH V35 15/29] acpi: Ignore acpi_rsdp kernel param when the
 kernel has been locked down
To:     Dave Young <dyoung@redhat.com>
Cc:     James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Josh Boyer <jwboyer@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Kees Cook <keescook@chromium.org>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Jul 15, 2019 at 7:59 PM Dave Young <dyoung@redhat.com> wrote:
> I'm very sorry I noticed this late, but have to say this will not work for
> X86 with latest kernel code.

No problem, thank you for catching this! I'll update the patch and
send a new version.
