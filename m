Return-Path: <SRS0=fcCn=55=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB607C2BBC7
	for <linux-security-module@archiver.kernel.org>; Mon, 13 Apr 2020 02:23:41 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBF8820708
	for <linux-security-module@archiver.kernel.org>; Mon, 13 Apr 2020 02:23:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBF8820708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbgDMCXk (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 12 Apr 2020 22:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:39650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727520AbgDMCXk (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 12 Apr 2020 22:23:40 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEBCFC0086C7;
        Sun, 12 Apr 2020 19:23:39 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04397;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0TvJd4lf_1586744615;
Received: from 30.27.118.45(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0TvJd4lf_1586744615)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 13 Apr 2020 10:23:36 +0800
Subject: Re: [PATCH v2 0/2] support to read and tune appraise mode in runtime
To:     Nayna <nayna@linux.vnet.ibm.com>, zhang.jia@linux.alibaba.com
Cc:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, jmorris@namei.org,
        serge@hallyn.com, zhangliguang@linux.alibaba.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200409103440.47946-1-tianjia.zhang@linux.alibaba.com>
 <1e160d08-788a-0c3b-0f9f-2077e55b286a@linux.vnet.ibm.com>
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Message-ID: <f892b420-315c-72aa-82d6-1a6a17b99b3a@linux.alibaba.com>
Date:   Mon, 13 Apr 2020 10:23:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1e160d08-788a-0c3b-0f9f-2077e55b286a@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>



On 2020/4/12 5:43, Nayna wrote:
> 
> On 4/9/20 6:34 AM, Tianjia Zhang wrote:
>> Support the read and write operations of ima_appraise by adding a
>> securifyfs file 'appraise_mode'.
>>
>> In order to tune appraise mode in runtime, writing a PKCS#7 signature
> 
> I am curious to know why would you tune appraise mode in runtime ?
> 
> Thanks & Regards,
> 
>        - Nayna

Mainly used for emergency shutdown under some abnormal conditions.

Thanks,
Tianjia
