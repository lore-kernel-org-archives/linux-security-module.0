Return-Path: <SRS0=peEt=DO=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A20DC4727E
	for <linux-security-module@archiver.kernel.org>; Wed,  7 Oct 2020 18:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5472A21707
	for <linux-security-module@archiver.kernel.org>; Wed,  7 Oct 2020 18:35:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbgJGSf6 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 7 Oct 2020 14:35:58 -0400
Received: from smtprelay0149.hostedemail.com ([216.40.44.149]:55726 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726197AbgJGSf6 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 7 Oct 2020 14:35:58 -0400
X-Greylist: delayed 530 seconds by postgrey-1.27 at vger.kernel.org; Wed, 07 Oct 2020 14:35:58 EDT
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave08.hostedemail.com (Postfix) with ESMTP id 54CB3182D5124;
        Wed,  7 Oct 2020 18:27:09 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id D3A08100E7B49;
        Wed,  7 Oct 2020 18:27:07 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: point10_6007cd0271d1
X-Filterd-Recvd-Size: 1995
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Wed,  7 Oct 2020 18:27:06 +0000 (UTC)
Message-ID: <55ae0b6152c84013d483b1bbecb28a425801c408.camel@perches.com>
Subject: Re: [PATCH] ima: Fix sizeof mismatches
From:   Joe Perches <joe@perches.com>
To:     Colin King <colin.king@canonical.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Roberto Sassu <roberto.sassu@polito.it>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 07 Oct 2020 11:27:04 -0700
In-Reply-To: <20201007110243.19033-1-colin.king@canonical.com>
References: <20201007110243.19033-1-colin.king@canonical.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, 2020-10-07 at 12:02 +0100, Colin King wrote:
> An incorrect sizeof is being used, sizeof(*fields) is not correct,
> it should be sizeof(**fields). This is not causing a problem since
> the size of these is the same. Fix this in the kmalloc_array and
> memcpy calls.
[]
> diff --git a/security/integrity/ima/ima_template.c b/security/integrity/ima/ima_template.c
[]
> @@ -216,11 +216,11 @@ int template_desc_init_fields(const char *template_fmt,
>  	}
>  
>  	if (fields && num_fields) {
> -		*fields = kmalloc_array(i, sizeof(*fields), GFP_KERNEL);
> +		*fields = kmalloc_array(i, sizeof(**fields), GFP_KERNEL);
>  		if (*fields == NULL)
>  			return -ENOMEM;
>  
> -		memcpy(*fields, found_fields, i * sizeof(*fields));
> +		memcpy(*fields, found_fields, i * sizeof(**fields));

Maybe use kmemdup instead.

	if (fields && num_fields) {
		*fields = kmemdup(found_fields, i * sizeof(**fields), GFP_KERNEL);
		etc...


