Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD1CECAAD5
	for <linux-security-module@archiver.kernel.org>; Thu,  8 Sep 2022 05:15:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiIHFPt (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 8 Sep 2022 01:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiIHFPs (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 8 Sep 2022 01:15:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F25DBD125;
        Wed,  7 Sep 2022 22:15:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F212461AA9;
        Thu,  8 Sep 2022 05:15:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FA11C433D6;
        Thu,  8 Sep 2022 05:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662614146;
        bh=Io4hPQb/4ib6C/OclvWwiJmI804Uk3nYcD0NAArjtoE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hPEEGOK34fjccZ5KZRG0lYYpmWSbp27utytfYbqUlK4n6o75igA4PIkUD1CT+0rnl
         m8HuzvWuZqOcQbb9KssYdSPDkCRX/2nhhp5pLzEAV1vvGmfp9TRui1hD+6YWNXO1NA
         JDb35v2hHGjSqmhIzjHPA+ipwmiFsA9NpaJ3bm1ku3Pdg0AWDdfrwu9IQDddEbplqJ
         GrBV2sVpJca5cbP+z0zjpN/f4JyRVBDapTatvHLUV+cHh+Uza0KvWQFU9BdU85iVcx
         sePdocMCgQ3jcO52hFMRIu3RpW0vR3IgwGC7wpToKHY+Y9RauhZaWUFOK1hdsYXq8s
         fmiMLW7m9G6lw==
Date:   Thu, 8 Sep 2022 08:15:40 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>
Subject: Re: [PATCH] security/keys: Remove inconsistent __user annotation
Message-ID: <Yxl6fJ/6c+KS9SsZ@kernel.org>
References: <20220907121230.21252-1-vincenzo.frascino@arm.com>
 <f1cefdb9-363a-c938-f02a-851173431610@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1cefdb9-363a-c938-f02a-851173431610@infradead.org>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Sep 07, 2022 at 07:05:55AM -0700, Randy Dunlap wrote:
> 
> 
> On 9/7/22 05:12, Vincenzo Frascino wrote:
> > The declaration of keyring_read does not match the definition
> > (security/keys/keyring.c). In this case the definition is correct
> > because it matches what defined in "struct key_type::read"
> > (linux/key-type.h).
> > 
> > Fix the declaration removing the inconsistent __user annotation.
> > 
> > Cc: David Howells <dhowells@redhat.com>
> > Cc: Jarkko Sakkinen <jarkko@kernel.org>
> > Cc: Paul Moore <paul@paul-moore.com>
> > Cc: James Morris <jmorris@namei.org>
> > Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> > ---
> > Note: This issue was discovered during the porting of the linux kernel
> > on Morello [1].
> > 
> > [1] https://git.morello-project.org/morello/kernel/linux
> 
> FTR, I have sent this same patch 3 times.
> Good luck.
> 
Right.

I'll pick this to my tree https://lore.kernel.org/keyrings/20220830191940.1498-1-rdunlap@infradead.org/

And need to clearly sync up better with David.

BR, Jarkko
