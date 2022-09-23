Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D12EC07E9D
	for <linux-security-module@archiver.kernel.org>; Fri, 23 Sep 2022 17:42:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232165AbiIWRm5 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 23 Sep 2022 13:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbiIWRm4 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 23 Sep 2022 13:42:56 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C8F3F1DE
        for <linux-security-module@vger.kernel.org>; Fri, 23 Sep 2022 10:42:55 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-1278624b7c4so1247265fac.5
        for <linux-security-module@vger.kernel.org>; Fri, 23 Sep 2022 10:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=xbj6epvJJhhapTMVuodevN96OG6IhecVF0uzFcA1js8=;
        b=PdNbfG7dLZJPXXVVrSSHaozoV7dVWBYqD6KfJj9NhK2ugy4djDTBaPYwhD2Vv0/Oov
         1UCF3DLjngt6G3egCCdPI26bLOTMe6clFwf1MNrsuZ3K0GfZZRJ8Duy2W9G4voez3lIZ
         fUK5MxfSmOE0fEa8yv6WKDO0IIaRReAQXykoRc0P8jN4vv1yrEud17v1XQkW3cktemg9
         QVK6K8Ft45rbwaew/ArnYpokLoxmrLXeYGYK7zhTPVjZK+B6yHS5Kj4I6s4rHtCYyeEK
         OlxcW7D5ZrSHC0DP55D4XMDKYBlxhLdtgSPjRCcMwDCbqv4Es2F7DxHAFOzM8+kdqqXP
         oqJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=xbj6epvJJhhapTMVuodevN96OG6IhecVF0uzFcA1js8=;
        b=CFI3I2jFZP0fmPA2dMy+7TiCipnglozugiGFg5d9zjxZ/EmAASeJwnXUnnmcNn2VD2
         YeQXjXZbMU+D9E+Vq5bv10OdrBm9UiuC3FRpUL7RGiq/tspu41D+xivE0E6gjahzlHS2
         50mS4aPBdJMrXoEui3Hkj00Gik+lEU5QOpwc5egCMTkJG/7w0gUiXDcrug6VM+wQrfr4
         hGbSJF94kbpOFCrjn+8UeoGaXW1WxdIp1gpsD/VWFcyoRGibEyZGP2xI939DdkALKTZb
         bgkDkF8/HcQXj+9VZ8SL8CxqJzAkKIHa62JiPCxY2Hw5R47z7pPaNk/HZ7aHiUjDujz2
         Podw==
X-Gm-Message-State: ACrzQf2rLdiiau/QjtzbZpuVUT92Wz4yZd9Hz4DPJk8MmfqF9E5NfNX0
        vDXRyrau7lJZ81Jx0qgFCj0Q9SyGURbZpE2RaEnF
X-Google-Smtp-Source: AMsMyM4nOntxYIBjWoQA+kOV867HFzXiGgpCE78cV/95Rz3YJow53XHYaEDcWLh0KFgMR8Uyo6DYBMSMy8TBaVBR9AI=
X-Received: by 2002:a05:6870:15c9:b0:101:e18b:d12d with SMTP id
 k9-20020a05687015c900b00101e18bd12dmr12107961oad.51.1663954974870; Fri, 23
 Sep 2022 10:42:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220922193817.106041-1-nathanl@linux.ibm.com>
 <20220922193817.106041-3-nathanl@linux.ibm.com> <CAHC9VhTWMFbCxQFAEJZzS3Kd5cSFigmvHac5y5ypVU7TqRqpTA@mail.gmail.com>
 <87wn9uzhqr.fsf@mpe.ellerman.id.au> <878rmaqeuw.fsf@linux.ibm.com>
In-Reply-To: <878rmaqeuw.fsf@linux.ibm.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 23 Sep 2022 13:42:43 -0400
Message-ID: <CAHC9VhRW5X4-7yOtEbWeMnTCtbnKHW0Nt8BFp8S3M65kFDKXoA@mail.gmail.com>
Subject: Re: [PATCH 2/2] powerpc/rtas: block error injection when locked down
To:     Nathan Lynch <nathanl@linux.ibm.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, jmorris@namei.org, serge@hallyn.com,
        ajd@linux.ibm.com, gcwilson@linux.ibm.com, nayna@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Sep 23, 2022 at 11:40 AM Nathan Lynch <nathanl@linux.ibm.com> wrote:
> Michael Ellerman <mpe@ellerman.id.au> writes:
> > Paul Moore <paul@paul-moore.com> writes:
> >> On Thu, Sep 22, 2022 at 3:38 PM Nathan Lynch <nathanl@linux.ibm.com> wrote:
> >>>
> >>> The error injection facility on pseries VMs allows corruption of
> >>> arbitrary guest memory, potentially enabling a sufficiently privileged
> >>> user to disable lockdown or perform other modifications of the running
> >>> kernel via the rtas syscall.
> >>>
> >>> Block the PAPR error injection facility from being opened or called
> >>> when locked down.
> >>>
> >>> Signed-off-by: Nathan Lynch <nathanl@linux.ibm.com>
> >>> ---
> >>>  arch/powerpc/kernel/rtas.c | 25 ++++++++++++++++++++++++-
> >>>  include/linux/security.h   |  1 +
> >>>  security/security.c        |  1 +
> >>>  3 files changed, 26 insertions(+), 1 deletion(-)
> >>
> >> ...
> >>
> >>> diff --git a/include/linux/security.h b/include/linux/security.h
> >>> index 1ca8dbacd3cc..b5d5138ae66a 100644
> >>> --- a/include/linux/security.h
> >>> +++ b/include/linux/security.h
> >>> @@ -123,6 +123,7 @@ enum lockdown_reason {
> >>>         LOCKDOWN_BPF_WRITE_USER,
> >>>         LOCKDOWN_DBG_WRITE_KERNEL,
> >>>         LOCKDOWN_DEVICE_TREE,
> >>> +       LOCKDOWN_RTAS_ERROR_INJECTION,
> >>
> >> With the understanding that I've never heard of RTAS until now, are
> >> there any other RTAS events that would require a lockdown reason?  As
> >> a follow up, is it important to distinguish between different RTAS
> >> lockdown reasons?
>
> 1. Not to my current knowledge.
> 2. Yes, I think so, see below.
>
> >>
> >> I'm trying to determine if we can just call it LOCKDOWN_RTAS.
> >
> > Yes I think we should.
> >
> > Currently it only locks down the error injection calls, not all of RTAS.
> >
> > But firmware can/will add new RTAS calls in future, so it's always
> > possible something will need to be added to the list of things that need
> > to be blocked during lockdown.
> >
> > So I think calling it LOCKDOWN_RTAS would be more general and future
> > proof, and can be read to mean "lockdown the parts of RTAS that need
> > to be locked down".
>
> RTAS provides callable interfaces for a broad variety of functions,
> including device configuration, halt/reboot/suspend, CPU online/offline,
> NVRAM access, firmware upgrade, platform diagnostic data retrieval, and
> others.
>
> Currently I don't know of other RTAS-provided functions that should be
> restricted. But if we were to add more, then -- in answer to Paul -- yes
> I think it would be important to have distinct reasons and
> messages. Taking the point of view of someone diagnosing lockdown denial
> messages and relating them to kernel code and user space activity, I
> would rather we err toward specificity.

As I said before, RTAS is a great mystery to me, if it can be extended
in the future then having a targeted lockdown name makes perfect
sense.

> So a single RTAS catch-all lockdown reason doesn't appeal to me, but
> lockdown reasons and messages aren't ABI (right?) ...

Correct.  Or at least that is my understanding, but there have been
some odd rulings on lockdown in the past so my advice would be to make
*very* sure you get this right the first time.  From what you and
Michael have said, it seems like a function specific name is the way
to go here, and based on your explanations of the situation it seems
like putting this in the integrity bin is the right way to go.

-- 
paul-moore.com
