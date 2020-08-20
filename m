Return-Path: <SRS0=ujXN=B6=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35FDCC433DF
	for <linux-security-module@archiver.kernel.org>; Thu, 20 Aug 2020 02:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB897207DA
	for <linux-security-module@archiver.kernel.org>; Thu, 20 Aug 2020 02:18:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgHTCS2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 19 Aug 2020 22:18:28 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3071 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726707AbgHTCS2 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 19 Aug 2020 22:18:28 -0400
Received: from dggeme752-chm.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id D3309176DF76B41ECDED;
        Thu, 20 Aug 2020 10:18:21 +0800 (CST)
Received: from dggeme753-chm.china.huawei.com (10.3.19.99) by
 dggeme752-chm.china.huawei.com (10.3.19.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Thu, 20 Aug 2020 10:18:21 +0800
Received: from dggeme753-chm.china.huawei.com ([10.7.64.70]) by
 dggeme753-chm.china.huawei.com ([10.7.64.70]) with mapi id 15.01.1913.007;
 Thu, 20 Aug 2020 10:18:21 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     Kees Cook <keescook@chromium.org>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH] mm/migrate: Avoid possible unnecessary
 ptrace_may_access() call in kernel_move_pages()
Thread-Topic: [PATCH] mm/migrate: Avoid possible unnecessary
 ptrace_may_access() call in kernel_move_pages()
Thread-Index: AdZ2ltiiUzrfeGlxSAudy1KmaVsz/A==
Date:   Thu, 20 Aug 2020 02:18:21 +0000
Message-ID: <9ce6209f41b64734b2cac748783aa441@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.176.142]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Kees Cook <keescook@chromium.org> wrote:
>On Mon, Aug 17, 2020 at 07:59:33AM -0400, Miaohe Lin wrote:
>> There is no need to check if this process has the right to modify the 
>> specified process when they are same.
>> 
>> Signed-off-by: Hongxiang Lou <louhongxiang@huawei.com>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>
>NAK, please don't do this -- the ptrace and security hooks already do these kinds of self-introspection checks, and I'd like to keep a central place to perform these kinds of checks.
>

Many thanks for your reply.
We also avoid get_task_struct/ put_task_struct pair of atomic ops, rcu_lock, task_lock and so on this way.

>Is there a specific problem you've encountered that this fixes?
>

I'am sorry but there's no specific problem. I do this mainly to skip the unnecessary ptrace and security hooks.

>--
>Kees Cook

Thanks again.

