Return-Path: <SRS0=wl+Y=5A=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F2D0C5ACBF
	for <linux-security-module@archiver.kernel.org>; Sun, 15 Mar 2020 22:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5402F20674
	for <linux-security-module@archiver.kernel.org>; Sun, 15 Mar 2020 22:02:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aylEsFx8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729267AbgCOWCY (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 15 Mar 2020 18:02:24 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:25066 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729241AbgCOWCY (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 15 Mar 2020 18:02:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584309743;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lz4DnO2WkKXHBSu1IEm+Wk41mMFHHBumSjdy3IaV6s8=;
        b=aylEsFx8SXAtRHRoVzPOM6VR7yStbqK4lg+Zy22u1faL3EsTIqrkUrAFT5vwyfcp6BF2Qc
        cTbBRBIoeU9jXikHZfmN1wiaZYkxdUesEwN58fC4hdE9X39ALlq7FxUAr4V3R++XTCJ4LX
        Tb7PQvR+F4Lfu2BfzagF6pOduwjS0H0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-87-H5ZqC46uNf-Ivexagzy62A-1; Sun, 15 Mar 2020 18:02:19 -0400
X-MC-Unique: H5ZqC46uNf-Ivexagzy62A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E0A0618A8C98;
        Sun, 15 Mar 2020 22:02:16 +0000 (UTC)
Received: from llong.remote.csb (ovpn-121-65.rdu2.redhat.com [10.10.121.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3FD3E9F70;
        Sun, 15 Mar 2020 22:01:52 +0000 (UTC)
Subject: Re: [PATCH v3 3/3] KEYS: Use kvmalloc() to better handle large buffer
 allocation
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mimi Zohar <zohar@linux.ibm.com>, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Chris von Recklinghausen <crecklin@redhat.com>
References: <20200313152102.1707-1-longman@redhat.com>
 <20200313152102.1707-4-longman@redhat.com>
 <20200313164306.GA907@sol.localdomain>
 <8f2f1787-88b0-f86d-991c-34cfd2f9b4aa@redhat.com>
 <20200315215253.GG224162@linux.intel.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <74ec00b8-d7a7-0035-d650-710415660926@redhat.com>
Date:   Sun, 15 Mar 2020 18:01:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200315215253.GG224162@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 3/15/20 5:52 PM, Jarkko Sakkinen wrote:
> On Fri, Mar 13, 2020 at 01:49:57PM -0400, Waiman Long wrote:
>>>>  			if (!tmpbuf || unlikely(ret > tmpbuflen)) {
>>>>  				if (unlikely(tmpbuf))
>>>> -					kzfree(tmpbuf);
>>>> +					__kvzfree(tmpbuf, tmpbuflen);
>>> Both kzfree() and __kvzfree() handle a NULL pointer, so there's no need for the
>>> NULL check first.
>>>
>> I would like to keep this one because of the unlikely annotation.
> What (measurable) gain does it bring anyway?

It is not a performance issue. I just want to indicate that the need to
free should not happen at all. It match the unlikely tag in the if
condition above.

Cheers,
Longman

