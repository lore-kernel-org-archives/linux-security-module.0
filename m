Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A49E6FE31
	for <linux-security-module@archiver.kernel.org>; Mon, 25 Sep 2023 23:49:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbjIYXte (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 25 Sep 2023 19:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjIYXtd (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 25 Sep 2023 19:49:33 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F1F4FB;
        Mon, 25 Sep 2023 16:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695685767; x=1727221767;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=o4UGOstkYMKSTDEBD6eiJUra05gPDpzN03VLDsHK1nc=;
  b=nY7+VvuSlNZ0kFr1jP73gX6lmmsqdOloct2+Rdo7xbsVuePUNp2QHw3E
   PT79OfwORX3ana0IFMjIqEJKR2Z74ulB7q7GCZjnsmc3dwNHXaO/mV1R3
   OsxlIRWnQVk7KELmFin4lG4DhistgeRVD2KQQrVva/DqNzHoDGFtZ2o/x
   qBND82iGhpt73wIcJQWNWg7SG+OYxUZtZBmCdbbeBUYPhRVwrG5Yruvoq
   iQRxgBl1GT325WsRQ/07scE8HUKwcAuFXl5rqcFEarwtFz8lRHJ+A7VPz
   V8KFsvd77aJAPpVxuqxGH+Hb88CpFXxOOO3khF+EkSXtcI8+kux4YnkdV
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="360821167"
X-IronPort-AV: E=Sophos;i="6.03,176,1694761200"; 
   d="scan'208";a="360821167"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 16:49:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="922200708"
X-IronPort-AV: E=Sophos;i="6.03,176,1694761200"; 
   d="scan'208";a="922200708"
Received: from jbuzinsk-mobl1.amr.corp.intel.com (HELO vcostago-mobl3) ([10.212.11.99])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 16:49:26 -0700
From:   Vinicius Costa Gomes <vinicius.gomes@intel.com>
To:     Mateusz Guzik <mjguzik@gmail.com>,
        John Johansen <john.johansen@canonical.com>
Cc:     linux-security-module@vger.kernel.org, apparmor@lists.ubuntu.com,
        linux-kernel@vger.kernel.org
Subject: Re: [apparmor] use per-cpu refcounts for apparmor labels?
In-Reply-To: <CAGudoHFfG7mARwSqcoLNwV81-KX4Bici5FQHjoNG4f9m83oLyg@mail.gmail.com>
References: <CAGudoHFfG7mARwSqcoLNwV81-KX4Bici5FQHjoNG4f9m83oLyg@mail.gmail.com>
Date:   Mon, 25 Sep 2023 16:49:25 -0700
Message-ID: <87a5t9bypm.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi Mateusz,

Mateusz Guzik <mjguzik@gmail.com> writes:

> I'm sanity-checking perf in various microbenchmarks and I found
> apparmor to be the main bottleneck in some of them.
>
> For example: will-it-scale open1_processes -t 16, top of the profile:
>   20.17%  [kernel]                   [k] apparmor_file_alloc_security
>   20.08%  [kernel]                   [k] apparmor_file_open
>   20.05%  [kernel]                   [k] apparmor_file_free_security
>   18.39%  [kernel]                   [k] apparmor_current_getsecid_subj
> [snip]
>
> This serializes on refing/unrefing apparmor objs, sounds like a great
> candidate for per-cpu refcounting instead (I'm assuming they are
> expected to be long-lived).
>
> I would hack it up myself, but I failed to find a clear spot to switch
> back from per-cpu to centalized operation and don't want to put
> serious effort into it.
>
> Can you sort this out?

I was looking at this same workload, and proposed a patch[1] some time
ago, see if it helps:

https://lists.ubuntu.com/archives/apparmor/2023-August/012914.html

But my idea was different, in many cases, we are looking at the label
associated with the current task, and there's no need to take the
refcount.

>
> Thanks,
> -- 
> Mateusz Guzik <mjguzik gmail.com>
>

Cheers,
-- 
Vinicius
