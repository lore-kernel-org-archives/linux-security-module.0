Return-Path: <SRS0=gxm9=BB=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB48DC433E3
	for <linux-security-module@archiver.kernel.org>; Wed, 22 Jul 2020 20:20:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85F45207BB
	for <linux-security-module@archiver.kernel.org>; Wed, 22 Jul 2020 20:20:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbgGVUUF (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 22 Jul 2020 16:20:05 -0400
Received: from smtprelay0162.hostedemail.com ([216.40.44.162]:37558 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726841AbgGVUUE (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 22 Jul 2020 16:20:04 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id A061C1810988C;
        Wed, 22 Jul 2020 20:20:03 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: goat25_55034d926f38
X-Filterd-Recvd-Size: 2322
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Wed, 22 Jul 2020 20:20:01 +0000 (UTC)
Message-ID: <b60f9b3e07b86d0f8631f6990f61b5172c43841f.camel@perches.com>
Subject: Re: [PATCH v2] KEYS: remove redundant memset
From:   Joe Perches <joe@perches.com>
To:     Tom Rix <trix@redhat.com>, dhowells@redhat.com,
        jarkko.sakkinen@linux.intel.com, jmorris@namei.org,
        serge@hallyn.com, denkenz@gmail.com, marcel@holtmann.org
Cc:     keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 22 Jul 2020 13:20:00 -0700
In-Reply-To: <e36c364e-22f4-c520-04da-ca1196fec049@redhat.com>
References: <20200722134610.31947-1-trix@redhat.com>
         <2bdd6b8ec731d180023d593b679afc66def19b4f.camel@perches.com>
         <e36c364e-22f4-c520-04da-ca1196fec049@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, 2020-07-22 at 13:10 -0700, Tom Rix wrote:
> On 7/22/20 1:02 PM, Joe Perches wrote:
> > On Wed, 2020-07-22 at 06:46 -0700, trix@redhat.com wrote:
> > > From: Tom Rix <trix@redhat.com>
> > > 
> > > Reviewing use of memset in keyctrl_pkey.c
> > > 
> > > keyctl_pkey_params_get prologue code to set params up
> > > 
> > > 	memset(params, 0, sizeof(*params));
> > > 	params->encoding = "raw";
> > > 
> > > keyctl_pkey_query has the same prologue
> > > and calls keyctl_pkey_params_get.
> > > 
> > > So remove the prologue.
> > > 
> > > Fixes: 00d60fd3b932 ("KEYS: Provide keyctls to drive the new key type ops for asymmetric keys [ver #2]")
> > At best, this is a micro optimization.
> Yes
> > How is this appropriate for a Fixes: line?
> Removing unneeded code is not a fix?

IMO: there's no "bug" here.

It's not a logic defect causing some unintended outcome.
It doesn't need backporting to stable branches.

Documentation/process/submitting-patches.rst-If your patch fixes a bug in a specific commit, e.g. you found an issue using
Documentation/process/submitting-patches.rst:``git bisect``, please use the 'Fixes:' tag with the first 12 characters of
Documentation/process/submitting-patches.rst-the SHA-1 ID, and the one line summary.



