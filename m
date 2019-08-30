Return-Path: <SRS0=wEfZ=W2=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E301C3A59B
	for <linux-security-module@archiver.kernel.org>; Fri, 30 Aug 2019 17:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07FB223426
	for <linux-security-module@archiver.kernel.org>; Fri, 30 Aug 2019 17:44:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="KED8qxWK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbfH3RoH (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 30 Aug 2019 13:44:07 -0400
Received: from smtp95.iad3a.emailsrvr.com ([173.203.187.95]:50681 "EHLO
        smtp95.iad3a.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727304AbfH3RoH (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 30 Aug 2019 13:44:07 -0400
X-Greylist: delayed 532 seconds by postgrey-1.27 at vger.kernel.org; Fri, 30 Aug 2019 13:44:06 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20190130-41we5z8j; t=1567186514;
        bh=n7hTUdN9s4PvV8dF+MWb216T+hESknP4YQTOjf2fNtE=;
        h=Subject:To:From:Date:From;
        b=KED8qxWK62KE8kUFWHKGaaUvlef8HI/ljERlj0tbpOeEodtWAKQ8H7bAweWIelJvn
         KgswDYkF5Nmr/eUhR649yI2K70dNNdsWatfVD0uknW3TZuvrfypiribZ9LdYPYesT9
         HUSq05I7y635uP6fItlu2r3cF92bBw9YXW8i+L3g=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp28.relay.iad3a.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id ADA61517B;
        Fri, 30 Aug 2019 13:35:13 -0400 (EDT)
X-Sender-Id: abbotti@mev.co.uk
Received: from [10.0.0.173] (remote.quintadena.com [81.133.34.160])
        (using TLSv1.2 with cipher AES128-SHA)
        by 0.0.0.0:465 (trex/5.7.12);
        Fri, 30 Aug 2019 13:35:14 -0400
Subject: Re: [PATCH 1/2] staging: comedi: Restrict COMEDI_DEVCONFIG when the
 kernel is locked down
To:     Ben Hutchings <ben@decadent.org.uk>, jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        Matthew Garrett <mjg59@google.com>,
        David Howells <dhowells@redhat.com>,
        H Hartley Sweeten <hsweeten@visionengravers.com>
References: <20190830154549.vss6h5tlrl6d5r5y@decadent.org.uk>
From:   Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
Message-ID: <ea330943-9d3e-d01d-a6cf-8de08e042ec6@mev.co.uk>
Date:   Fri, 30 Aug 2019 18:35:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190830154549.vss6h5tlrl6d5r5y@decadent.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 30/08/2019 16:45, Ben Hutchings wrote:
> The COMEDI_DEVCONFIG ioctl can be used to configure I/O addresses and
> other hardware settings for non plug-and-play devices such as ISA
> cards.  This should be disabled to preserve the kernel's integrity
> when it is locked down.

I haven't boned up on the lockdown mechanism yet, but just FYI, this is 
only possible if the "comedi_num_legacy_minors" module parameter is 
non-zero (which it isn't by default).

> 
> Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
> Cc: Matthew Garrett <mjg59@google.com>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Ian Abbott <abbotti@mev.co.uk>
> Cc: H Hartley Sweeten <hsweeten@visionengravers.com>
> ---
>   drivers/staging/comedi/comedi_fops.c | 6 ++++++
>   include/linux/security.h             | 1 +
>   security/lockdown/lockdown.c         | 1 +
>   3 files changed, 8 insertions(+)
> 
> diff --git a/drivers/staging/comedi/comedi_fops.c b/drivers/staging/comedi/comedi_fops.c
> index f6d1287c7b83..fdf030e53035 100644
> --- a/drivers/staging/comedi/comedi_fops.c
> +++ b/drivers/staging/comedi/comedi_fops.c
> @@ -27,6 +27,7 @@
>   
>   #include <linux/io.h>
>   #include <linux/uaccess.h>
> +#include <linux/security.h>
>   
>   #include "comedi_internal.h"
>   
> @@ -813,11 +814,16 @@ static int do_devconfig_ioctl(struct comedi_device *dev,
>   			      struct comedi_devconfig __user *arg)
>   {
>   	struct comedi_devconfig it;
> +	int ret;
>   
>   	lockdep_assert_held(&dev->mutex);
>   	if (!capable(CAP_SYS_ADMIN))
>   		return -EPERM;
>   
> +	ret = security_locked_down(LOCKDOWN_COMEDI_DEVCONFIG);
> +	if (ret)
> +		return ret;
> +

You might consider moving that check to be done after the following 'if 
(!arg)' block, since that should be safe.  (It detaches an already 
configured device from the comedi core.)

>   	if (!arg) {
>   		if (is_device_busy(dev))
>   			return -EBUSY;
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 429f9f03372b..b16365dccfc5 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -113,6 +113,7 @@ enum lockdown_reason {
>   	LOCKDOWN_ACPI_TABLES,
>   	LOCKDOWN_PCMCIA_CIS,
>   	LOCKDOWN_TIOCSSERIAL,
> +	LOCKDOWN_COMEDI_DEVCONFIG,
>   	LOCKDOWN_MODULE_PARAMETERS,
>   	LOCKDOWN_MMIOTRACE,
>   	LOCKDOWN_DEBUGFS,
> diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
> index 0068cec77c05..971bb99b9051 100644
> --- a/security/lockdown/lockdown.c
> +++ b/security/lockdown/lockdown.c
> @@ -28,6 +28,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
>   	[LOCKDOWN_ACPI_TABLES] = "modifying ACPI tables",
>   	[LOCKDOWN_PCMCIA_CIS] = "direct PCMCIA CIS storage",
>   	[LOCKDOWN_TIOCSSERIAL] = "reconfiguration of serial port IO",
> +	[LOCKDOWN_COMEDI_DEVCONFIG] = "reconfiguration of Comedi legacy device",
>   	[LOCKDOWN_MODULE_PARAMETERS] = "unsafe module parameters",
>   	[LOCKDOWN_MMIOTRACE] = "unsafe mmio",
>   	[LOCKDOWN_DEBUGFS] = "debugfs access",
> 


-- 
-=( Ian Abbott <abbotti@mev.co.uk> || Web: www.mev.co.uk )=-
-=( MEV Ltd. is a company registered in England & Wales. )=-
-=( Registered number: 02862268.  Registered address:    )=-
-=( 15 West Park Road, Bramhall, STOCKPORT, SK7 3JZ, UK. )=-
