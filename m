Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6A22C4332F
	for <linux-security-module@archiver.kernel.org>; Fri,  6 May 2022 12:31:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391990AbiEFMfS (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 6 May 2022 08:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392009AbiEFMfP (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 6 May 2022 08:35:15 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0294269496;
        Fri,  6 May 2022 05:31:30 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Kvqfx6wQ6zhYtn;
        Fri,  6 May 2022 20:31:05 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 6 May 2022 20:31:29 +0800
Received: from [10.67.108.193] (10.67.108.193) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 6 May 2022 20:31:28 +0800
Subject: Re: [PATCH 3/3] ima: Append line feed to
 ima/binary_runtime_measurements
To:     Mimi Zohar <zohar@linux.ibm.com>, <dmitry.kasatkin@gmail.com>,
        <jmorris@namei.org>, <serge@hallyn.com>
CC:     <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-integrity@vger.kernel.org>
References: <20220505132301.124832-1-wangweiyang2@huawei.com>
 <20220505132301.124832-4-wangweiyang2@huawei.com>
 <c6df072a55a29f670357e2dda384ec7c9ef332c9.camel@linux.ibm.com>
From:   wangweiyang <wangweiyang2@huawei.com>
Message-ID: <d24ec59e-59a6-0c11-681a-63b9ad85877c@huawei.com>
Date:   Fri, 6 May 2022 20:31:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <c6df072a55a29f670357e2dda384ec7c9ef332c9.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.108.193]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi Mimi,

Sorry I didn't think thoroughly. Just ignore this patch.

Thanks.

在 2022/5/6 19:16, Mimi Zohar 写道:
> On Thu, 2022-05-05 at 21:23 +0800, Wang Weiyang wrote:
>> There is no LF in binary_runtime_measurements output. It is little weird,
>> so append LF to it.
>>
>> Example:
>>
>> / # cat /sys/kernel/security/ima/binary_runtime_measurements
>> ...imaboot_aggregate/ #
> 
> Why would you cat a binary file?!.  Doesn't make sense.
> 
> Mimi
> 
>>
>> Signed-off-by: Wang Weiyang <wangweiyang2@huawei.com>
> 
> .
> 
