Return-Path: <SRS0=cbB2=A4=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 294F5C433E1
	for <linux-security-module@archiver.kernel.org>; Fri, 17 Jul 2020 19:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC4E120739
	for <linux-security-module@archiver.kernel.org>; Fri, 17 Jul 2020 19:24:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="FAI7jW8F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbgGQTYv (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 17 Jul 2020 15:24:51 -0400
Received: from linux.microsoft.com ([13.77.154.182]:45484 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727999AbgGQTYv (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 17 Jul 2020 15:24:51 -0400
Received: from sequoia (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id BAD8220B4909;
        Fri, 17 Jul 2020 12:24:49 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BAD8220B4909
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1595013890;
        bh=ivjTtf6Ir0rqIr7x6YfCCMUhM1xuE0XyXrXJpxur7rU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FAI7jW8F3YgEhMYTHqpP+4G6Cumfh3qHHczB0F/kTToXYJ8WbOp272vrjIBUMeqQQ
         dfhbsNzplo0z71UPAkvHoO/GlCvTpMyw7ysT91MzeGukBhYou4t2R90AuHNI9974v0
         GM2TG8zi568RF1zxV9VXRzh+m97ZsYkr/CyjZm7s=
Date:   Fri, 17 Jul 2020 14:24:47 -0500
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Nayna <nayna@linux.vnet.ibm.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Prakhar Srivastava <prsriva02@gmail.com>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Janne Karhunen <janne.karhunen@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [PATCH v3 01/12] ima: Have the LSM free its audit rule
Message-ID: <20200717192447.GO3673@sequoia>
References: <20200709061911.954326-1-tyhicks@linux.microsoft.com>
 <20200709061911.954326-2-tyhicks@linux.microsoft.com>
 <5ee27a51-7ff9-5763-c85f-e99e62458657@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5ee27a51-7ff9-5763-c85f-e99e62458657@linux.vnet.ibm.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2020-07-17 15:20:22, Nayna wrote:
> 
> On 7/9/20 2:19 AM, Tyler Hicks wrote:
> > Ask the LSM to free its audit rule rather than directly calling kfree().
> 
> Is it to be called audit rule or filter rule ?  Likewise in subject line.

The security hooks call this "audit rule" but Mimi explained the
reasoning for IMA referring to this as an "audit filter" here:

 https://lore.kernel.org/lkml/1593466203.5085.62.camel@linux.ibm.com/

I would be fine with her renaming/rewording this patch, accordingly, in
next-integrity-testing.

Tyler

> 
> Thanks & Regards,
> 
>     - Nayna
