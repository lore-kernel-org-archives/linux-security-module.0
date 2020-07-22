Return-Path: <SRS0=gxm9=BB=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A0DC433E0
	for <linux-security-module@archiver.kernel.org>; Wed, 22 Jul 2020 20:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E76E122B43
	for <linux-security-module@archiver.kernel.org>; Wed, 22 Jul 2020 20:02:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732543AbgGVUCd (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 22 Jul 2020 16:02:33 -0400
Received: from smtprelay0037.hostedemail.com ([216.40.44.37]:40610 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726462AbgGVUCd (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 22 Jul 2020 16:02:33 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id B60D41842C03F;
        Wed, 22 Jul 2020 20:02:30 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: force93_1a17f4e26f38
X-Filterd-Recvd-Size: 1832
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Wed, 22 Jul 2020 20:02:28 +0000 (UTC)
Message-ID: <2bdd6b8ec731d180023d593b679afc66def19b4f.camel@perches.com>
Subject: Re: [PATCH v2] KEYS: remove redundant memset
From:   Joe Perches <joe@perches.com>
To:     trix@redhat.com, dhowells@redhat.com,
        jarkko.sakkinen@linux.intel.com, jmorris@namei.org,
        serge@hallyn.com, denkenz@gmail.com, marcel@holtmann.org
Cc:     keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 22 Jul 2020 13:02:27 -0700
In-Reply-To: <20200722134610.31947-1-trix@redhat.com>
References: <20200722134610.31947-1-trix@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, 2020-07-22 at 06:46 -0700, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> Reviewing use of memset in keyctrl_pkey.c
> 
> keyctl_pkey_params_get prologue code to set params up
> 
> 	memset(params, 0, sizeof(*params));
> 	params->encoding = "raw";
> 
> keyctl_pkey_query has the same prologue
> and calls keyctl_pkey_params_get.
> 
> So remove the prologue.
> 
> Fixes: 00d60fd3b932 ("KEYS: Provide keyctls to drive the new key type ops for asymmetric keys [ver #2]")

At best, this is a micro optimization.

How is this appropriate for a Fixes: line?

> diff --git a/security/keys/keyctl_pkey.c b/security/keys/keyctl_pkey.c
[]
> @@ -166,8 +166,6 @@ long keyctl_pkey_query(key_serial_t id,
>  	struct kernel_pkey_query res;
>  	long ret;
>  
> -	memset(&params, 0, sizeof(params));
> -
>  	ret = keyctl_pkey_params_get(id, _info, &params);
>  	if (ret < 0)
>  		goto error;

