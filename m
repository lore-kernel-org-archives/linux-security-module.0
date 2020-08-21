Return-Path: <SRS0=891B=B7=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D70BAC433E1
	for <linux-security-module@archiver.kernel.org>; Fri, 21 Aug 2020 06:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD2BF20748
	for <linux-security-module@archiver.kernel.org>; Fri, 21 Aug 2020 06:51:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgHUGvJ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 21 Aug 2020 02:51:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:54880 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726119AbgHUGvJ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 21 Aug 2020 02:51:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 36528B663;
        Fri, 21 Aug 2020 06:51:35 +0000 (UTC)
Date:   Fri, 21 Aug 2020 08:51:05 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LTP List <ltp@lists.linux.it>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org, patches@kernelci.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux- stable <stable@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [LTP] [PATCH 5.8 000/232] 5.8.3-rc1 review
Message-ID: <20200821065105.GB11908@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20200820091612.692383444@linuxfoundation.org>
 <CA+G9fYtebf78TH-XpqArunHc1L6s9mHdLEbpY1EY9tSyDjp=sg@mail.gmail.com>
 <20200820182516.GA49496@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200820182516.GA49496@sol.localdomain>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi all,

> On Thu, Aug 20, 2020 at 08:57:57PM +0530, Naresh Kamboju wrote:
> > On Thu, 20 Aug 2020 at 14:55, Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:

> > > This is the start of the stable review cycle for the 5.8.3 release.
> > > There are 232 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.

> > > Responses should be made by Sat, 22 Aug 2020 09:15:09 +0000.
> > > Anything received after that time might be too late.

> > > The whole patch series can be found in one patch at:
> > >         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.8.3-rc1.gz
> > > or in the git tree and branch at:
> > >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.8.y
> > > and the diffstat can be found below.

> > > thanks,

> > > greg k-h

> > > Herbert Xu <herbert@gondor.apana.org.au>
> > >     crypto: af_alg - Fix regression on empty requests

> > Results from Linaro’s test farm.
> > Regressions detected.

> >   ltp-crypto-tests:
> >     * af_alg02
> >   ltp-cve-tests:
> >     * cve-2017-17805

> > af_alg02.c:52: BROK: Timed out while reading from request socket.
> > We are running the LTP 20200515 tag released test suite.
> >  https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/crypto/af_alg02.c

> > Summary
> > ------------------------------------------------------------------------

> > kernel: 5.8.3-rc1
> > git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> > git branch: linux-5.8.y
> > git commit: 201fff807310ce10485bcff294d47be95f3769eb
> > git describe: v5.8.2-233-g201fff807310
> > Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-5.8-oe/build/v5.8.2-233-g201fff807310

> > Regressions (compared to build v5.8.2)
> > ------------------------------------------------------------------------

> > x15:
> >   ltp-crypto-tests:
> >     * af_alg02

> >   ltp-cve-tests:
> >     * cve-2017-17805


> Looks like this test is still "broken" because it assumes behavior that isn't
> clearly specified, as previously discussed at
> https://lkml.kernel.org/r/20200702033221.GA19367@gondor.apana.org.au.

> I sent out LTP patches to fix it:
> https://lkml.kernel.org/linux-crypto/20200820181918.404758-1-ebiggers@kernel.org/T/#u

FYI fix for LTP merged.

Kind regards,
Petr

> - Eric
