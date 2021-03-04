Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF36C433E6
	for <linux-security-module@archiver.kernel.org>; Thu,  4 Mar 2021 20:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94D6164E6C
	for <linux-security-module@archiver.kernel.org>; Thu,  4 Mar 2021 20:07:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237815AbhCDUHP (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 4 Mar 2021 15:07:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238056AbhCDUHM (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 4 Mar 2021 15:07:12 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4356AC06175F
        for <linux-security-module@vger.kernel.org>; Thu,  4 Mar 2021 12:06:32 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id s23so7889100pji.1
        for <linux-security-module@vger.kernel.org>; Thu, 04 Mar 2021 12:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lnJjHLK9ZFNv1LfwcSxXM5rm17wtY4Bt/ImB5tn9sNA=;
        b=aS4Br3QxJPduwCSP0G16n1nsbN0FRnu22xdxKkv1cSH5NA92NnwfdbKDMF5IbhT0TU
         K02WJ3RrNk5vJXbC5kcu7u5ccTtJl+9ez7DVTfj1WqjC0ZiI5FeFP7UJ2Re1ROE41kQP
         tJbdd9Cblairk3TMEaJO0YirXtRZ8c0p3AsdE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lnJjHLK9ZFNv1LfwcSxXM5rm17wtY4Bt/ImB5tn9sNA=;
        b=KNEToncFHz1VAgSJvL03DalrtQF9QVibeFGt0BolynQzWoR7KGixwGy2zmOEdeEUr7
         g1Xi9e74d0RWjs+VtBnTFEGJvRzBttRtTZulTyZNvA0SXIUC9wK49CXNncO34+bmbYFA
         ceMHT1003GO9PLUH9FRnHVD1i4786x0ivv9ekoUBZVWU9Gib9bLm9UQG7CNWuOmOwfZk
         YGcyHF8vPqcdyeD9opoAaskyys8iiMYl19QhUk2opwU/L1wzi5wUUyqMgupEALk/EYwq
         qqA8ct9DAwErZWFT6Uct2ec4tE4lErWqJkMX3HkNqtIZcGFNjBKQdRclLH93KbhE0Ytb
         QTkQ==
X-Gm-Message-State: AOAM532uTX61feUtBfMy0Xbcn5jFCj0e6WiVk+I/PztvQUfMXf+mUlSa
        mTk6BMVgkmaPBie/PocZOR+JFQ==
X-Google-Smtp-Source: ABdhPJyF2fNxbvWj5AWkAFxyulMHQvPSvmvbNBivEVEqAGckfXq+s6pB6gv45igmOgG0WhRvHJ1yKQ==
X-Received: by 2002:a17:90a:fb47:: with SMTP id iq7mr6463323pjb.159.1614888391652;
        Thu, 04 Mar 2021 12:06:31 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k4sm214009pfg.102.2021.03.04.12.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 12:06:31 -0800 (PST)
Date:   Thu, 4 Mar 2021 12:06:30 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Vadim Pasternak <vadimp@nvidia.com>,
        platform-driver-x86@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Andy Shevchenko <andy@infradead.org>,
        linux-hardening@vger.kernel.org,
        Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Flipping firmware write-protection bits from within the kernel
 (was Re: [PATCH RFC platform-next 8/8] Documentation/ABI: Add new line card
 attributes for mlxreg-io sysfs interfaces)
Message-ID: <202103041202.08F8D8533@keescook>
References: <20210203173622.5845-1-vadimp@nvidia.com>
 <20210203173622.5845-9-vadimp@nvidia.com>
 <009a1a80-62ca-35ce-5f02-b43b25e5ebd1@redhat.com>
 <96f705e0-2d34-3c8e-3f13-8585dbbb74bf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96f705e0-2d34-3c8e-3f13-8585dbbb74bf@redhat.com>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Mar 04, 2021 at 11:48:10AM +0100, Hans de Goede wrote:
> Hi Kees, et al.,
> 
> Kees, you were the first person who came to mind to ask about this, feel free to
> point me to someone else.
> 
> While reviewing a patch-set for hw-enablement of some upcoming Melanox platforms,
> the addition of some sysfs files which flip write-protect bits for various firmwares
> found on the platform on/off stood out to me.

Eeek :(

> As I mention in me reply to the below patch adding the docs for this at a minimum
> this must (IMHO) tie into the new lockdown framework and disallow enabling
> fw-updates this way depending on the lockdown mode.

I would agree: lockdown (integrity mode) should, IMO, block these kinds
of firmware writes if there isn't some kind of cryptographic attestation
happening.

(Probably there are many of these holes already in the kernel, but we
should avoid adding more.)

> 
> Are there any other security checks which the code should/could do here ?
> 
> Maybe tie into the audit code somehow ?

I'll leave that to the audit folks to answer. :)

-Kees

> 
> Regards,
> 
> Hans
> 
> 
> 
> 
> On 3/4/21 11:39 AM, Hans de Goede wrote:
> > Hi,
> > 
> > On 2/3/21 6:36 PM, Vadim Pasternak wrote:
> >> Add documentation for the new attributes for line cards:
> >> - CPLDs versioning.
> >> - Write protection control for 'nvram' devices.
> >> - Line card reset reasons.
> >> - Enabling burning of FPGA and CPLDs.
> >> - Enabling burning of FPGA and gearbox SPI flashes,
> >> - Enabling power of whole line card.
> >> - Enabling power of QSFP ports equipped on line card.
> >> - The maximum powered required for line card feeding.
> >> - Line card configuration Id.
> >>
> >> Signed-off-by: Vadim Pasternak <vadimp@nvidia.com>
> >> ---
> >>  Documentation/ABI/stable/sysfs-driver-mlxreg-io | 92 +++++++++++++++++++++++++
> >>  1 file changed, 92 insertions(+)
> >>
> >> diff --git a/Documentation/ABI/stable/sysfs-driver-mlxreg-io b/Documentation/ABI/stable/sysfs-driver-mlxreg-io
> >> index 1d1a8ee59534..a22e9d6c0904 100644
> >> --- a/Documentation/ABI/stable/sysfs-driver-mlxreg-io
> >> +++ b/Documentation/ABI/stable/sysfs-driver-mlxreg-io
> >> @@ -326,3 +326,95 @@ Description:	This file unlocks system after hardware or firmware thermal
> >>  		locking.
> >>  
> >>  		The file is read/write.
> >> +
> >> +What:		/sys/devices/platform/mlxplat/i2c_mlxcpld.*/i2c-*/i2c-*/i2c-*/*-0032/mlxreg-io.*/hwmon/hwmon*/cpld1_pn
> >> +What:		/sys/devices/platform/mlxplat/i2c_mlxcpld.*/i2c-*/i2c-*/i2c-*/*-0032/mlxreg-io.*/hwmon/hwmon*/cpld1_version
> >> +What:		/sys/devices/platform/mlxplat/i2c_mlxcpld.*/i2c-*/i2c-*/i2c-*/*-0032/mlxreg-io.*/hwmon/hwmon*/cpld1_version_min
> >> +Date:		March 2021
> >> +KernelVersion:	5.12
> >> +Contact:	Vadim Pasternak <vadimp@nvidia.com>
> >> +Description:	These files show with which CPLD major and minor versions
> >> +		and part number has been burned CPLD device on line card.
> >> +
> >> +		The files are read only.
> >> +
> >> +What:		/sys/devices/platform/mlxplat/i2c_mlxcpld.*/i2c-*/i2c-*/i2c-*/*-0032/mlxreg-io.*/hwmon/hwmon*/fpga1_pn
> >> +What:		/sys/devices/platform/mlxplat/i2c_mlxcpld.*/i2c-*/i2c-*/i2c-*/*-0032/mlxreg-io.*/hwmon/hwmon*/fpga1_version
> >> +What:		/sys/devices/platform/mlxplat/i2c_mlxcpld.*/i2c-*/i2c-*/i2c-*/*-0032/mlxreg-io.*/hwmon/hwmon*/fpga1_version_min
> >> +Date:		March 2021
> >> +KernelVersion:	5.12
> >> +Contact:	Vadim Pasternak <vadimp@nvidia.com>
> >> +Description:	These files show with which FPGA major and minor versions
> >> +		and part number has been burned FPGA device on line card.
> >> +
> >> +		The files are read only.
> >> +
> >> +What:		/sys/devices/platform/mlxplat/i2c_mlxcpld.*/i2c-*/i2c-*/i2c-*/*-0032/mlxreg-io.*/hwmon/hwmon*/ini_wp
> >> +What:		/sys/devices/platform/mlxplat/i2c_mlxcpld.*/i2c-*/i2c-*/i2c-*/*-0032/mlxreg-io.*/hwmon/hwmon*/vpd_wp
> >> +Date:		March 2021
> >> +KernelVersion:	5.12
> >> +Contact:	Vadim Pasternak <vadimp@nvidia.com>
> >> +Description:	These files allow to overwrite line card VPD and firmware blob
> >> +		hardware write protection mode. When attribute is set 1 - write
> >> +		protection is disabled, when 0 - enabled. By default both are
> >> +		write protected.
> >> +
> >> +		The files are read/write.
> > 
> > This seems to have some serious security implications. IMHO this should be tie into the
> > kernel's new(ish) lockdown system, so that if the system is in locked-down mode writing
> > these will not be allowed.
> > 
> >> +
> >> +What:		/sys/devices/platform/mlxplat/i2c_mlxcpld.*/i2c-*/i2c-*/i2c-*/*-0032/mlxreg-io.*/hwmon/hwmon*/reset_aux_pwr_or_ref
> >> +What:		/sys/devices/platform/mlxplat/i2c_mlxcpld.*/i2c-*/i2c-*/i2c-*/*-0032/mlxreg-io.*/hwmon/hwmon*/reset_dc_dc_pwr_fail
> >> +What:		/sys/devices/platform/mlxplat/i2c_mlxcpld.*/i2c-*/i2c-*/i2c-*/*-0032/mlxreg-io.*/hwmon/hwmon*/reset_fpga_not_done
> >> +What:		/sys/devices/platform/mlxplat/i2c_mlxcpld.*/i2c-*/i2c-*/i2c-*/*-0032/mlxreg-io.*/hwmon/hwmon*/reset_from_chassis
> >> +What:		/sys/devices/platform/mlxplat/i2c_mlxcpld.*/i2c-*/i2c-*/i2c-*/*-0032/mlxreg-io.*/hwmon/hwmon*/reset_line_card
> >> +What:		/sys/devices/platform/mlxplat/i2c_mlxcpld.*/i2c-*/i2c-*/i2c-*/*-0032/mlxreg-io.*/hwmon/hwmon*/reset_pwr_off_from_chassis
> >> +Date:		March 2021
> >> +KernelVersion:	5.12
> >> +Contact:	Vadim Pasternak <vadimp@nvidia.com>
> >> +Description:	These files show the line reset cause, as following: power
> >> +		auxiliary outage or power refresh, DC-to-DC power failure, FPGA reset
> >> +		failed, line card reset failed, power off from chassis.
> >> +		Value 1 in file means this is reset cause, 0 - otherwise. Only one of
> >> +		the above causes could be 1 at the same time, representing only last
> >> +		reset cause.
> >> +
> >> +		The files are read only.
> >> +
> >> +What:		/sys/devices/platform/mlxplat/i2c_mlxcpld.*/i2c-*/i2c-*/i2c-*/*-0032/mlxreg-io.*/hwmon/hwmon*/cpld_upgrade_en
> >> +What:		/sys/devices/platform/mlxplat/i2c_mlxcpld.*/i2c-*/i2c-*/i2c-*/*-0032/mlxreg-io.*/hwmon/hwmon*/fpga_upgrade_en
> >> +Date:		March 2021
> >> +KernelVersion:	5.12
> >> +Contact:	Vadim Pasternak <vadimp@nvidia.com>
> >> +Description:	These files allow CPLD and FPGA burning. Value 1 in file means burning
> >> +		is enabled, 0 - otherwise.
> >> +
> >> +		The files are read/write.
> > 
> > Same remark as above.
> > 
> >> +
> >> +What:		/sys/devices/platform/mlxplat/i2c_mlxcpld.*/i2c-*/i2c-*/i2c-*/*-0032/mlxreg-io.*/hwmon/hwmon*/qsfp_pwr_en
> >> +What:		/sys/devices/platform/mlxplat/i2c_mlxcpld.*/i2c-*/i2c-*/i2c-*/*-0032/mlxreg-io.*/hwmon/hwmon*/pwr_en
> >> +Date:		March 2021
> >> +KernelVersion:	5.12
> >> +Contact:	Vadim Pasternak <vadimp@nvidia.com>
> >> +Description:	These files allow to power on/off all QSFP ports and whole line card.
> >> +		The attributes are set 1 for power on, 0 - for power off.
> >> +
> >> +		The files are read/write.
> >> +
> >> +What:		/sys/devices/platform/mlxplat/i2c_mlxcpld.*/i2c-*/i2c-*/i2c-*/*-0032/mlxreg-io.*/hwmon/hwmon*/agb_spi_burn_en
> >> +What:		/sys/devices/platform/mlxplat/i2c_mlxcpld.*/i2c-*/i2c-*/i2c-*/*-0032/mlxreg-io.*/hwmon/hwmon*/fpga_spi_burn_en
> >> +Date:		March 2021
> >> +KernelVersion:	5.12
> >> +Contact:	Vadim Pasternak <vadimp@nvidia.com>
> >> +Description:	These files allow gearboxes and FPGA SPI flash burning.
> >> +		The attributes are set 1 to enable burning, 0 - to disable.
> >> +
> >> +		The file is read/write.
> > 
> > Same remark as above.
> > 
> >> +
> >> +What:		/sys/devices/platform/mlxplat/i2c_mlxcpld.*/i2c-*/i2c-*/i2c-*/*-0032/mlxreg-io.*/hwmon/hwmon*/max_power
> >> +What:		/sys/devices/platform/mlxplat/i2c_mlxcpld.*/i2c-*/i2c-*/i2c-*/*-0032/mlxreg-io.*/hwmon/hwmon*/config
> >> +Date:		March 2021
> >> +KernelVersion:	5.12
> >> +Contact:	Vadim Pasternak <vadimp@nvidia.com>
> >> +Description:	These files provide the maximum powered required for line card
> >> +		feeding and line card configuration Id.
> >> +
> >> +		The files are read only.
> >>
> > 
> > Regards,
> > 
> > Hans
> > 
> 

-- 
Kees Cook
