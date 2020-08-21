Return-Path: <SRS0=891B=B7=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BCE4C433E1
	for <linux-security-module@archiver.kernel.org>; Fri, 21 Aug 2020 11:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED3A82072D
	for <linux-security-module@archiver.kernel.org>; Fri, 21 Aug 2020 11:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598008590;
	bh=Cd+VoXUvwJoGAVVf2MJ9G2nda7Xj5OzTfnu49z0OnaM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vMUFTk5k2VWFQ8bxfI6Vs88SupvnQGJo6Jd7mxfhzE8dpLEcm/8Xl+LtFnRN5IOb+
	 UEot0+kaTpvk8wJ3hnpzTuzlCT5+81Y8/jrjv5L0zwS2C97obqvUpjtEGyRAeglAS1
	 e4Gbmmb/JmbByWNadXBIxpFddBul4j4jxuJQeU10=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbgHULPU (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 21 Aug 2020 07:15:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:58822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726118AbgHULPR (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 21 Aug 2020 07:15:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB66120738;
        Fri, 21 Aug 2020 11:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598008516;
        bh=Cd+VoXUvwJoGAVVf2MJ9G2nda7Xj5OzTfnu49z0OnaM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=12JYQxi4ejZkUIEesZewhBfWUQ8hgtJxF8GwvPIQG/3OgM2uQnieWte9i/Yxy9Oyr
         ThPKZ9roAg3JXeLxoQS5WpzDG+5JCfH7bVG7EeI4f6Bpa5umKeLVewur4v5fRBw0AB
         6s1jA/B1G+DxBcEyy2rW2mm/IultwhXAsGdN8/Ic=
Date:   Fri, 21 Aug 2020 13:15:35 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        lkft-triage@lists.linaro.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        linux- stable <stable@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        LTP List <ltp@lists.linux.it>,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH 5.8 000/232] 5.8.3-rc1 review
Message-ID: <20200821111535.GC2222852@kroah.com>
References: <20200820091612.692383444@linuxfoundation.org>
 <CA+G9fYtebf78TH-XpqArunHc1L6s9mHdLEbpY1EY9tSyDjp=sg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+G9fYtebf78TH-XpqArunHc1L6s9mHdLEbpY1EY9tSyDjp=sg@mail.gmail.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Aug 20, 2020 at 08:57:57PM +0530, Naresh Kamboju wrote:
> On Thu, 20 Aug 2020 at 14:55, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 5.8.3 release.
> > There are 232 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Sat, 22 Aug 2020 09:15:09 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.8.3-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.8.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
> 
> > Herbert Xu <herbert@gondor.apana.org.au>
> >     crypto: af_alg - Fix regression on empty requests
> 
> Results from Linaro’s test farm.
> Regressions detected.
> 
>   ltp-crypto-tests:
>     * af_alg02
>   ltp-cve-tests:
>     * cve-2017-17805
> 
> af_alg02.c:52: BROK: Timed out while reading from request socket.
> We are running the LTP 20200515 tag released test suite.
>  https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/crypto/af_alg02.c

Looks like the crypto tests are now fixed :)

Anyway, thanks for testing all of these and letting me know.

greg k-h
