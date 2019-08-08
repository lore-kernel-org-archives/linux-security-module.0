Return-Path: <SRS0=ikEQ=WE=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C23D6C433FF
	for <linux-security-module@archiver.kernel.org>; Thu,  8 Aug 2019 11:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 988772187F
	for <linux-security-module@archiver.kernel.org>; Thu,  8 Aug 2019 11:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565263045;
	bh=EgmzTvbmBPtgyJmYpImp81JbvFmYHBfzw7jbIIcUCDI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=s88Vm3gsPsLEP+oUJ6wb0PCbzcSzQbc+MYKPRVh7sWIhO5CAz3uvsapM1C4TVH0Lf
	 fCdUew8InZ4j0tEdvcz7dAUjI3kQvwh65kjCYsgAJIP4JQOI+w3B+qcAqjFxtpFr8u
	 wOabPz5x+tZGcYskNKtoP6X3fjBdJmItNezOtBY8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731487AbfHHLRZ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 8 Aug 2019 07:17:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:45044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730722AbfHHLRZ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 8 Aug 2019 07:17:25 -0400
Received: from localhost.localdomain (ool-18bba523.dyn.optonline.net [24.187.165.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB459216C8;
        Thu,  8 Aug 2019 11:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565263044;
        bh=EgmzTvbmBPtgyJmYpImp81JbvFmYHBfzw7jbIIcUCDI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=okDjrn1P8Gj8H4K5zBGi+k4oVfmwUO2LCPYquP2801qQ22GoIsWryj5FZmEKRS88q
         lpCPRbLxHDbeAT+1ccqMJXswwIDg4OsH/vV/pFv5q4ciTAUbHK7pNsAL7mmC/2NMOV
         qjJPuRCnwyAWXNmdX5bHA0opjXIHoN5HUOna1qjE=
Message-ID: <1565263042.4220.25.camel@kernel.org>
Subject: Re: [PATCH] ima: Fix a use after free in ima_read_modsig()
From:   Mimi Zohar <zohar@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc:     Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Date:   Thu, 08 Aug 2019 07:17:22 -0400
In-Reply-To: <20190808103310.GC30506@mwanda>
References: <20190808103310.GC30506@mwanda>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, 2019-08-08 at 13:33 +0300, Dan Carpenter wrote:
> This code frees "hdr" and then dereferences it on the next line to get
> the error code.
> 
> Fixes: 39b07096364a ("ima: Implement support for module-style appended signatures")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Thanks, Dan.  Julia already reported this.  Thiago posted a patch last
night.  Just getting to it now.  Can I add your Reviewed-by or Tested-
by?

Mimi
