Return-Path: <SRS0=TKeG=AU=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB56C433E0
	for <linux-security-module@archiver.kernel.org>; Thu,  9 Jul 2020 02:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A38A20760
	for <linux-security-module@archiver.kernel.org>; Thu,  9 Jul 2020 02:00:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CwsXjCv5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbgGICAt (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 8 Jul 2020 22:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbgGICAs (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 8 Jul 2020 22:00:48 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41BE8C061A0B
        for <linux-security-module@vger.kernel.org>; Wed,  8 Jul 2020 19:00:48 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id x72so309954pfc.6
        for <linux-security-module@vger.kernel.org>; Wed, 08 Jul 2020 19:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rmO2BXbiMq3J9h0ibI9lJkabwxTiAwSLD0udRPDmL+Q=;
        b=CwsXjCv5bK+ffSpsr3j3Lg1cU+PHJAYaRaHrydOoGtxVQKEDbRUgW3w/Vu406xayEY
         tjzf1ZQhr1CHrqpMLYXSensYQa803V7cP0wj3nodypiUNNikG8BHKi3aB5WpbeP2IrOs
         KrSBcKNZAXTmfYXOPoIPnd6urScrHUwuVpzus=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rmO2BXbiMq3J9h0ibI9lJkabwxTiAwSLD0udRPDmL+Q=;
        b=kgKXsHM0eDp1evqCOaF2AdcRpxoFZI4tJaJJub7onJUiQ+ydxk2YlYBkSQF6sX0h0E
         4yXKtNxTMv8WDS0t3wEKfMwcBkBgiNkKc7xCoJtLU0sRtE1IUb6MBqE9Hxl7tKg1pNxx
         W5UZ+rpk/w2Nt49qrdM8fDUe2VJriBZemxBLlIlNc5pMsEYvYiyZ6RZth0rh9i7uEEGo
         +oDAX0vj5jP9EzatEDl1FWCBZp7t/N6MJ11doDT64cbk4zOvPvKa9QkqwHiX+ULcXuZ1
         lcpFgF3oL1BLKtVk3eYTOmklGS6R+GzrWAkBWIbCuVDAuGEOXfCP+iqnXAzxz71ZHZsu
         1FCQ==
X-Gm-Message-State: AOAM531NJT7v3g7D9Xrq0sH06c9Iwaj5UaILpizsQMEv3R1pfEp9M6nX
        MlOCPooE7/zBFr1bom9JEPCpGw==
X-Google-Smtp-Source: ABdhPJyI00rLJubx80Dv+/G4eRgVwFRzwZLXhBDdORHUusN/3bFGhY+NEgoWJMW6UQwA9EuKbuvIKQ==
X-Received: by 2002:a62:192:: with SMTP id 140mr48349974pfb.53.1594260047674;
        Wed, 08 Jul 2020 19:00:47 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b21sm867641pfp.172.2020.07.08.19.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 19:00:46 -0700 (PDT)
Date:   Wed, 8 Jul 2020 19:00:45 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        James Morris <jmorris@namei.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Scott Branden <scott.branden@broadcom.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jessica Yu <jeyu@kernel.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Garrett <matthewgarrett@google.com>,
        David Howells <dhowells@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        KP Singh <kpsingh@google.com>, Dave Olsthoorn <dave@bewaar.me>,
        Peter Jones <pjones@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Boyd <stephen.boyd@linaro.org>,
        Paul Moore <paul@paul-moore.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH 0/4] Fix misused kernel_read_file() enums
Message-ID: <202007081859.A305745@keescook>
References: <20200707081926.3688096-1-keescook@chromium.org>
 <3c01073b-c422-dd97-0677-c16fe1158907@redhat.com>
 <f5e65f73-2c94-3614-2479-69b2bfda9775@redhat.com>
 <20200708115517.GF4332@42.do-not-panic.com>
 <8766279d-0ebe-1f64-c590-4a71a733609b@redhat.com>
 <20200708133004.GG4332@42.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708133004.GG4332@42.do-not-panic.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Jul 08, 2020 at 01:30:04PM +0000, Luis Chamberlain wrote:
> On Wed, Jul 08, 2020 at 01:58:47PM +0200, Hans de Goede wrote:
> > Hi,
> > 
> > On 7/8/20 1:55 PM, Luis Chamberlain wrote:
> > > On Wed, Jul 08, 2020 at 01:37:41PM +0200, Hans de Goede wrote:
> > > > Hi,
> > > > 
> > > > On 7/8/20 1:01 PM, Hans de Goede wrote:
> > > > > Hi,
> > > > > 
> > > > > On 7/7/20 10:19 AM, Kees Cook wrote:
> > > > > > Hi,
> > > > > > 
> > > > > > In looking for closely at the additions that got made to the
> > > > > > kernel_read_file() enums, I noticed that FIRMWARE_PREALLOC_BUFFER
> > > > > > and FIRMWARE_EFI_EMBEDDED were added, but they are not appropriate
> > > > > > *kinds* of files for the LSM to reason about. They are a "how" and
> > > > > > "where", respectively. Remove these improper aliases and refactor the
> > > > > > code to adapt to the changes.
> > > > > > 
> > > > > > Additionally adds in missing calls to security_kernel_post_read_file()
> > > > > > in the platform firmware fallback path (to match the sysfs firmware
> > > > > > fallback path) and in module loading. I considered entirely removing
> > > > > > security_kernel_post_read_file() hook since it is technically unused,
> > > > > > but IMA probably wants to be able to measure EFI-stored firmware images,
> > > > > > so I wired it up and matched it for modules, in case anyone wants to
> > > > > > move the module signature checks out of the module core and into an LSM
> > > > > > to avoid the current layering violations.
> > > > > > 
> > > > > > This touches several trees, and I suspect it would be best to go through
> > > > > > James's LSM tree.
> > > > > > 
> > > > > > Thanks!
> > > > > 
> > > > > 
> > > > > I've done some quick tests on this series to make sure that
> > > > > the efi embedded-firmware support did not regress.
> > > > > That still works fine, so this series is;
> > > > > 
> > > > > Tested-by: Hans de Goede <hdegoede@redhat.com>
> > > > 
> > > > I made a mistake during testing I was not actually running the
> > > > kernel with the patches added.
> > > > 
> > > > After fixing that I did find a problem, patch 4/4:
> > > > "module: Add hook for security_kernel_post_read_file()"
> > > > 
> > > > Breaks module-loading for me. This is with the 4 patches
> > > > on top of 5.8.0-rc4, so this might just be because I'm
> > > > not using the right base.
> > > > 
> > > > With patch 4/4 reverted things work fine for me.
> > > > 
> > > > So, please only add my Tested-by to patches 1-3.
> > > 
> > > BTW is there any testing covered by the selftests for the firmware
> > > laoder which would have caputured this? If not can you extend
> > > it with something to capture this case you ran into?
> > 
> > This was not a firmware-loading issue. For me in my tests,
> > which were limited to 1 device, patch 4/4, which only touches
> > the module-loading code, stopped module loading from working.
> > 
> > Since my test device has / on an eMMC and the kernel config
> > I'm using has mmc-block as a module, things just hung in the
> > initrd since no modules could be loaded, so I did not debug
> > this any further. Dropping  patch 4/4 from my local tree
> > solved this.
> 
> Thanks Hans!
> 
> Kees, would test_kmod.c and the respective selftest would have picked
> this issue up?

I need to check -- I got a (possibly related) 0day report on it too.

Since I have to clean it up further based on Mimi's comments, and adapt
it a bit for Scott's series, I'll need to get a v2 spun for sure. :)

-- 
Kees Cook
