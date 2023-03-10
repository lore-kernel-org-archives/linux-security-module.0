Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B756DC6FD19
	for <linux-security-module@archiver.kernel.org>; Fri, 10 Mar 2023 19:47:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbjCJTr4 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 10 Mar 2023 14:47:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjCJTrz (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 10 Mar 2023 14:47:55 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D7112084E;
        Fri, 10 Mar 2023 11:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678477673; x=1710013673;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=vFmOS6tH4fTn1rJ5ojoDPetfpQVdjsiIuUV/Va2DQkM=;
  b=MTFsr95HrLtcmrkonZOJtsKBCxvbwRxkNgGBpzJn05gr8d1blnRK8toi
   uiLGt/zxt2hy3JsGxIqCeYnnkZUAOc08yScCL/gJw+qGU3OUwavnrE0E+
   XSjJ/+Xci4lQdgrV2fksJ0bG68Bj1EM8lnoDw6w6mNAQDgS33srpCKNTI
   evGHlia/AvaQXcMBs4/IC8WzpExIrcJKpsAbikO8opDPIbZmlpgNFm28+
   EBcnWN02qc2IMxf4J1UIpxMBa+VEN0u9ByFTrjn9+dVLnnZnIW3iurtbH
   HwRKjwWzJ6ESBv2Seefyo1mLnRkkIdODV42J2rY+sd4QiW/32VrauG9nX
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="336837182"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="336837182"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 11:47:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="746840002"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="746840002"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 10 Mar 2023 11:47:49 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1paiiR-0017Rf-2I;
        Fri, 10 Mar 2023 21:47:47 +0200
Date:   Fri, 10 Mar 2023 21:47:47 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mirsad Goran Todorovac <mirsad.goran.todorovac@alu.hr>
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Paul Moore <paul@paul-moore.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Christian =?iso-8859-1?Q?G=F6ttsche?= <cgzones@googlemail.com>,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        Frederick Lawler <fred@cloudflare.com>
Subject: Re: [PATCH v1 1/2] Add release hook to LSM
Message-ID: <ZAuJY1MM3hEiT0ri@smile.fi.intel.com>
References: <20230310194159.GB528@domac.alu.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230310194159.GB528@domac.alu.hr>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Mar 10, 2023 at 08:42:00PM +0100, Mirsad Goran Todorovac wrote:
> 
> Add release() hook to the definition of the LSM modules, to enable calling
> destructors and deallocating allocated resources cleanly.
> 
> Signed-off-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>

> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

I haven't given you this tag. Sorry, you must not add something
which was not explicitly given.

> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Mimi Zohar <zohar@linux.ibm.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Thomas Weiﬂschuh <linux@weissschuh.net>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Use --cc parameter to `git send-email`.

-- 
With Best Regards,
Andy Shevchenko


