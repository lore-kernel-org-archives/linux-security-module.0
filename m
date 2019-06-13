Return-Path: <SRS0=ug0r=UM=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB23AC31E45
	for <linux-security-module@archiver.kernel.org>; Thu, 13 Jun 2019 16:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84AE820449
	for <linux-security-module@archiver.kernel.org>; Thu, 13 Jun 2019 16:34:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730806AbfFMQeq (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:34:46 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:33006 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730759AbfFMHuU (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 13 Jun 2019 03:50:20 -0400
Received: from LHREML712-CAH.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id A19D6E914C223B4B4993;
        Thu, 13 Jun 2019 08:50:18 +0100 (IST)
Received: from [10.220.96.108] (10.220.96.108) by smtpsuk.huawei.com
 (10.201.108.35) with Microsoft SMTP Server (TLS) id 14.3.408.0; Thu, 13 Jun
 2019 08:50:12 +0100
Subject: Re: [PATCH v3 0/2] ima/evm fixes for v5.2
To:     Janne Karhunen <janne.karhunen@gmail.com>
CC:     Mimi Zohar <zohar@linux.ibm.com>, <dmitry.kasatkin@huawei.com>,
        <mjg59@google.com>, <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <silviu.vlasceanu@huawei.com>
References: <20190606112620.26488-1-roberto.sassu@huawei.com>
 <CAE=NcraYOw9B3RFu3_DbJs9nPT87AtQEptC7zF4kAu4FP8YhxA@mail.gmail.com>
 <d9efe3c7-20dd-bbb0-40d8-40f69cba5b88@huawei.com>
 <CAE=NcraHqzST=SZNcrSgpv5EqfyUfpCCb7iQ0Oh6uohL3yiCdw@mail.gmail.com>
 <c13c6b4f-1302-35fb-f077-00b7f84fea08@huawei.com>
 <CAE=NcrZiyWjZUuxdLgA9Bq89Cpt1W6MLAzPkLHVgfOqSo2i1hQ@mail.gmail.com>
 <144bf319-ea0c-f6b6-5737-0aac34f37186@huawei.com>
 <CAE=NcrZgQSENPOtRdU=u1y6kqy0ouaaj-gioKHaUxZUcbUHwqA@mail.gmail.com>
From:   Roberto Sassu <roberto.sassu@huawei.com>
Message-ID: <3911846b-f836-592a-81e1-a2fd25470d98@huawei.com>
Date:   Thu, 13 Jun 2019 09:50:20 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <CAE=NcrZgQSENPOtRdU=u1y6kqy0ouaaj-gioKHaUxZUcbUHwqA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.220.96.108]
X-CFilter-Loop: Reflected
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 6/13/2019 9:39 AM, Janne Karhunen wrote:
> On Thu, Jun 13, 2019 at 9:57 AM Roberto Sassu <roberto.sassu@huawei.com> wrote:
> 
>>> Ok, I see the use case. Now, if you pull a urandom key that early on
>>> during the boot, the state of the system entropy is at all time low,
>>> and you are not really protecting against any sort of offline attack
>>> since the file is created during that boot cycle. Is there really use
>>> for using such key? Wouldn't it be possible to create a new config
>>> option, say IMA_ALLOW_EARLY_WRITERS, that would hold the NEW_FILE flag
>>> until the persistent key becomes available? In other words, it would
>>> start the measuring at the point when the key becomes online?
>>
>> I also thought about similar solutions. Another is for example to keep
>> the appraisal flags at file close, if security.ima is successfully
>> added to the file.
>>
>> Initializing EVM with a key is not a trivial change, but it seemed
>> better to me as it does not introduce exceptions in the IMA behavior.
> 
> Would the appraise actually need any changes, just keep the
> IMA_NEW_FILE in ima_check_last_writer()? Of course it's not that easy
> (it never is) as the iint could go away and things like that, but with
> some tweaks?

I think the problem would be that the code that sets the status to
INTEGRITY_PASS is not executed, because the file gets security.ima after
the first write.

Roberto

-- 
HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Bo PENG, Jian LI, Yanli SHI
