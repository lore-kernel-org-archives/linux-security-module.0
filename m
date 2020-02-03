Return-Path: <SRS0=n7+0=3X=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC86C35247
	for <linux-security-module@archiver.kernel.org>; Mon,  3 Feb 2020 19:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CCAE2086A
	for <linux-security-module@archiver.kernel.org>; Mon,  3 Feb 2020 19:04:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725372AbgBCTEL (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 3 Feb 2020 14:04:11 -0500
Received: from smtprelay0024.hostedemail.com ([216.40.44.24]:50008 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727073AbgBCTEL (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 3 Feb 2020 14:04:11 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 94C4D8383F91;
        Mon,  3 Feb 2020 19:04:09 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: cloth99_5e4a75d69f62c
X-Filterd-Recvd-Size: 3039
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Mon,  3 Feb 2020 19:04:07 +0000 (UTC)
Message-ID: <94cf0aee8fd8b78718e252488458cfea105c0469.camel@perches.com>
Subject: Re: [PATCH] security/integrity: Include __func__ in messages for
 easier debug
From:   Joe Perches <joe@perches.com>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Mimi Zohar <zohar@linux.ibm.com>, jmorris@namei.org,
        serge@hallyn.com, mpe@ellerman.id.au, erichte@linux.ibm.com,
        nayna@linux.ibm.com, yuehaibing@huawei.com
Cc:     linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 03 Feb 2020 11:02:57 -0800
In-Reply-To: <475ab05c-300b-fdbe-5de0-6fce8d1a360d@linuxfoundation.org>
References: <20200130020129.15328-1-skhan@linuxfoundation.org>
         <ab2e19123cc15e3f8039b0d36e6ebae385db700e.camel@perches.com>
         <1580736077.5585.4.camel@linux.ibm.com>
         <475ab05c-300b-fdbe-5de0-6fce8d1a360d@linuxfoundation.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, 2020-02-03 at 11:55 -0700, Shuah Khan wrote:
> On 2/3/20 6:21 AM, Mimi Zohar wrote:
> > On Wed, 2020-01-29 at 19:08 -0800, Joe Perches wrote:
> > > On Wed, 2020-01-29 at 19:01 -0700, Shuah Khan wrote:
> > > > Change messages to messages to make it easier to debug. The following
> > > > error message isn't informative enough to figure out what failed.
> > > > Change messages to include function information.
> > > > 
> > > > Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> > > > ---
> > > >   .../integrity/platform_certs/load_powerpc.c     | 14 ++++++++------
> > > >   security/integrity/platform_certs/load_uefi.c   | 17 ++++++++++-------
> > > >   2 files changed, 18 insertions(+), 13 deletions(-)
> > > > 
> > > > diff --git a/security/integrity/platform_certs/load_powerpc.c b/security/integrity/platform_certs/load_powerpc.c
> > > 
> > > perhaps instead add #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > > so all the pr_<level> logging is more specific.
> > > 
> > > This would prefix all pr_<level> output with "integrity: "
> 
> Joe! Sorry for the delay in getting back to you.
> 
> > Agreed.  Joe, could you post a patch with a proper patch description
> > for this?
> > 
> 
> I have been looking into this a bit more and there is an opportunity
> here to add #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt to integrity.h
> and get rid of duplicate defines.

That might work but:

$ git grep --name-only 'integrity\.h' security | xargs grep pr_fmt
security/integrity/digsig.c:#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
security/integrity/digsig_asymmetric.c:#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
security/integrity/evm/evm_main.c:#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
security/security.c:#define pr_fmt(fmt) "LSM: " fmt

Here security.c already uses "LSM: "

Does anyone care about the LSM: prefix?


