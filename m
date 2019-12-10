Return-Path: <SRS0=PCLm=2A=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47198C2D0BF
	for <linux-security-module@archiver.kernel.org>; Tue, 10 Dec 2019 19:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D12F20836
	for <linux-security-module@archiver.kernel.org>; Tue, 10 Dec 2019 19:16:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="LyKla2v+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbfLJTQI (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 10 Dec 2019 14:16:08 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41752 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727654AbfLJTQI (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 10 Dec 2019 14:16:08 -0500
Received: by mail-lf1-f68.google.com with SMTP id m30so14616738lfp.8
        for <linux-security-module@vger.kernel.org>; Tue, 10 Dec 2019 11:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x7Ly+kFcY9v41W0Yea6eldt67FJ9rQnUT+trJTG6+Xc=;
        b=LyKla2v+ft5Potq4hfBOyqRFw/cMaj4PcpgLni4B1h2XGMuwdiIcgEBJVer+fW8JTw
         HlS9Jacjm4c9JF4zRDK4+Smjj6jl6XYyoADKrz7o6sFvE4rfNfxlYDIzouy+sBgM9O9k
         AomjW/lGgjAyjzhIDXIFQe1+e8daEft3o9x3NSsj9c5Y3toSpTnLsYtRVTNEYI/7ExD/
         j5sO1wp9msJ8fqjpbV+cWh2d5KIVmeGa/3ctA/4PuRHCDhch29FSvQXAaf2CCgYso7Gg
         gFXKFXV1PnFLBLyKRg8Kruz6KTfNrQU6L8Vgwa0B9b4GQ/eUddi35/fqgcc2frFAp9q+
         rhMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x7Ly+kFcY9v41W0Yea6eldt67FJ9rQnUT+trJTG6+Xc=;
        b=QbvsSaCBzsPiqFGmg8Qv86dfDw3J2OijsCslDWncNNZtGWlqL3rEhcB51yfMdxDajk
         mhLZLsVlM1EFv20BfeQI/qbXGJH956mKsLspeJfFk+URJmHnXehZGfLeR2b9ySnug0d3
         Q6zwfmYJ9V3l6Ilc+xVXRsTEgNQWTEZ7GzCMLK0DSGVmnQEQkiEVaOLvRWr3mW6/VAsp
         SVSGdxCkKpFNbXaNlHewH4+5u8j0HTRxGOvApEhnQW/+v1nT71jBun4WemJJ2SvBezWd
         ABx66SBh09V3taC+w/3YF/toeVrczfATIfdFCVGzEZptqWY+iI3WQlXaGXBRlODTYDtQ
         5r5w==
X-Gm-Message-State: APjAAAVshuJZJIOnBfY1YmRm8Ym4yvqs5dIKfBAwYT5CDFOzu7n8e5Xv
        04Lqh7xQKLUAM/nxGDHJ2KE3C/hkdGcjbPlKUqpa
X-Google-Smtp-Source: APXvYqzeIvo9MtJbPbux8OasVwNKp66VtrSv68Mg4neHZLu1UIs3yW5CziyvWWX7G8TYK5FShvquGUXIbancx+AALC4=
X-Received: by 2002:a19:f514:: with SMTP id j20mr18471703lfb.31.1576005365522;
 Tue, 10 Dec 2019 11:16:05 -0800 (PST)
MIME-Version: 1.0
References: <20191210165541.85245-1-sds@tycho.nsa.gov>
In-Reply-To: <20191210165541.85245-1-sds@tycho.nsa.gov>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 10 Dec 2019 14:15:54 -0500
Message-ID: <CAHC9VhRnqfuVUTDZA+8G-_OTqqN8M7XJhOpiO1m3t0XhY584Xw@mail.gmail.com>
Subject: Re: [PATCH] security: only build lsm_audit if CONFIG_SECURITY=y
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-next@vger.kernel.org, jamorris@linux.microsoft.com
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Dec 10, 2019 at 11:55 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> The lsm_audit code is only required when CONFIG_SECURITY is enabled.
> It does not have a build dependency on CONFIG_AUDIT since audit.h
> provides trivial static inlines for audit_log*() when CONFIG_AUDIT
> is disabled.  Hence, the Makefile should only add lsm_audit to the
> obj lists based on CONFIG_SECURITY, not CONFIG_AUDIT.
>
> Fixes: 59438b46471a ("security,lockdown,selinux: implement SELinux lockdown")
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
>  security/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Merged into selinux/next in order to fix the linux-next build
breakage.  James, if you would prefer a different fix, let us know.

> diff --git a/security/Makefile b/security/Makefile
> index be1dd9d2cb2f..746438499029 100644
> --- a/security/Makefile
> +++ b/security/Makefile
> @@ -22,7 +22,7 @@ obj-$(CONFIG_SECURITY)                        += security.o
>  obj-$(CONFIG_SECURITYFS)               += inode.o
>  obj-$(CONFIG_SECURITY_SELINUX)         += selinux/
>  obj-$(CONFIG_SECURITY_SMACK)           += smack/
> -obj-$(CONFIG_AUDIT)                    += lsm_audit.o
> +obj-$(CONFIG_SECURITY)                 += lsm_audit.o
>  obj-$(CONFIG_SECURITY_TOMOYO)          += tomoyo/
>  obj-$(CONFIG_SECURITY_APPARMOR)                += apparmor/
>  obj-$(CONFIG_SECURITY_YAMA)            += yama/
> --
> 2.23.0

-- 
paul moore
www.paul-moore.com
