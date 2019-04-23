Return-Path: <SRS0=iQUf=SZ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD73C282DD
	for <linux-security-module@archiver.kernel.org>; Tue, 23 Apr 2019 08:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71FD620645
	for <linux-security-module@archiver.kernel.org>; Tue, 23 Apr 2019 08:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556008311;
	bh=sChlkpZNBPV7qVu8wP7DemgiHFo8Ohz2zHcR69ubJCI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=k6jnzqsnqXOgRY3+8jZkIvrtiz0NmsXNX9/63l0wyKb64wLW0O8cjQG3Gm4cAnZg7
	 emFLo65tcvXbhoVJhp0Tf7t6jCdlFYnK9TZXUtgvIaKcgBrGl9G80/gp9Smf5d6Eb1
	 0vDJXepSLbbqGYiL3BIOMbfM8ijszVWaVGQ7rHJ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725946AbfDWIbv (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 23 Apr 2019 04:31:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:47696 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725939AbfDWIbu (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 23 Apr 2019 04:31:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 86760AED6;
        Tue, 23 Apr 2019 08:31:49 +0000 (UTC)
Date:   Tue, 23 Apr 2019 10:31:48 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Alexander Potapenko <glider@google.com>, akpm@linux-foundation.org,
        cl@linux.com, dvyukov@google.com, keescook@chromium.org,
        labbott@redhat.com, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Subject: Re: [PATCH 1/3] mm: security: introduce the init_allocations=1 boot
 option
Message-ID: <20190423083148.GF25106@dhcp22.suse.cz>
References: <20190418154208.131118-1-glider@google.com>
 <20190418154208.131118-2-glider@google.com>
 <981d439a-1107-2730-f27e-17635ee4a125@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <981d439a-1107-2730-f27e-17635ee4a125@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu 18-04-19 09:35:32, Dave Hansen wrote:
> On 4/18/19 8:42 AM, Alexander Potapenko wrote:
> > This option adds the possibility to initialize newly allocated pages and
> > heap objects with zeroes. This is needed to prevent possible information
> > leaks and make the control-flow bugs that depend on uninitialized values
> > more deterministic.
> 
> Isn't it better to do this at free time rather than allocation time?  If
> doing it at free, you can't even have information leaks for pages that
> are in the allocator.

I would tend to agree here. Free path is usually less performance sensitive
than the allocation. Those really hot paths tend to defer the work.

I am also worried that an opt-out gfp flag would tend to be used
incorrectly as the history has shown for others - e.g. __GFP_TEMPORARY.
So I would rather see this robust without a fine tuning unless there is
real use case that would suffer from this and we can think of a
background scrubbing or something similar.

-- 
Michal Hocko
SUSE Labs
