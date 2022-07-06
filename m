Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08DF8C433EF
	for <linux-security-module@archiver.kernel.org>; Wed,  6 Jul 2022 19:19:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234306AbiGFTTn (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 6 Jul 2022 15:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232575AbiGFTTm (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 6 Jul 2022 15:19:42 -0400
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE09275E6
        for <linux-security-module@vger.kernel.org>; Wed,  6 Jul 2022 12:19:40 -0700 (PDT)
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id 43323666; Wed,  6 Jul 2022 14:19:38 -0500 (CDT)
Date:   Wed, 6 Jul 2022 14:19:38 -0500
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     James Morris <jmorris@namei.org>
Cc:     linux-security-module@vger.kernel.org
Subject: Re: Maintainer update
Message-ID: <20220706191938.GA29427@mail.hallyn.com>
References: <c513dcdb-17f9-377a-1329-2b8fee8dc28c@namei.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c513dcdb-17f9-377a-1329-2b8fee8dc28c@namei.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Jul 07, 2022 at 04:56:31AM +1000, James Morris wrote:
> Hi Folks,
> 
> I'm now a manager and don't get as much time to focus directly on 
> development work.
> 
> I'd like to propose that we add Paul Moore as a maintainer of the Security 
> Subsystem, and for him to take the lead on that, in addition to his 
> SELinux and other maintainer work.
> 
> With LSMs pushing directly to Linus, this maintainer role is now mostly 
> about merging new LSMs and major LSM changes, and integrating bugfixes.
> 
> Paul has been taking many LSM bugfixes through his SELinux tree for a 
> while, so this would be somewhat a formalization of things there. In terms 
> of new LSMs and major changes, this is and will remain a collaborative 
> process with the LSM community.
> 
> 
> Any thoughts, concerns, objections?

+1 from me.  Thanks for all the time you've put into it!
