Return-Path: <SRS0=J6Wv=NB=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB3CAECDE43
	for <linux-security-module@archiver.kernel.org>; Sun, 21 Oct 2018 09:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8583820843
	for <linux-security-module@archiver.kernel.org>; Sun, 21 Oct 2018 09:01:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8583820843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbeJUROl (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 21 Oct 2018 13:14:41 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:41381 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727182AbeJUROl (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 21 Oct 2018 13:14:41 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 1EE05CEC657E1;
        Sun, 21 Oct 2018 17:00:59 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.408.0; Sun, 21 Oct 2018
 17:00:58 +0800
Subject: Re: [PATCH v2 -next] KEYS: trusted: remove set but not used variable
 'keyhndl'
To:     James Bottomley <jejb@linux.ibm.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
References: <1539241599-140866-1-git-send-email-yuehaibing@huawei.com>
 <1539949699-74650-1-git-send-email-yuehaibing@huawei.com>
 <1539966623.2819.3.camel@linux.ibm.com>
CC:     <linux-integrity@vger.kernel.org>, <keyrings@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <853ddba3-32ce-2ba8-9e23-ee7583ef3743@huawei.com>
Date:   Sun, 21 Oct 2018 17:00:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <1539966623.2819.3.camel@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2018/10/20 0:30, James Bottomley wrote:
> On Fri, 2018-10-19 at 11:48 +0000, YueHaibing wrote:
>> Fixes gcc '-Wunused-but-set-variable' warning:
>>
>> security/keys/trusted.c: In function 'tpm_unseal':
>> security/keys/trusted.c:592:11: warning:
>>  variable 'keyhndl' set but not used [-Wunused-but-set-variable]
>>   uint32_t keyhndl;
>>
>> It never used since introduction in 
>> commit d00a1c72f7f4 ("keys: add new trusted key-type")
> 
> This triggered an "er, shouldn't we be using the SRK parent by
> default?"  search through the code, but it turns out that's all taken
> care of in trusted_options_alloc() where we'll set up the SRK as parent
> with well known auth and unless overridden on the command line, that's
> what we use, so I'm happy this is simply left over code from a
> different implementation of that use case.

Thank you for comment.

> 
> James
> 
> 
> .
> 

