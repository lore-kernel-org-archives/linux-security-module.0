Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7EB9ECDFA1
	for <linux-security-module@archiver.kernel.org>; Tue, 25 Oct 2022 13:51:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232201AbiJYNvW (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 25 Oct 2022 09:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbiJYNvV (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 25 Oct 2022 09:51:21 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B630DE5EF2
        for <linux-security-module@vger.kernel.org>; Tue, 25 Oct 2022 06:51:19 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MxYBS3rtvz15Ly4;
        Tue, 25 Oct 2022 21:46:24 +0800 (CST)
Received: from [10.67.110.176] (10.67.110.176) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 21:51:15 +0800
Subject: Re: [PATCH] security: commoncap: fix potential memleak on error path
 from vfs_getxattr_alloc
To:     Christian Brauner <brauner@kernel.org>
CC:     <serge@hallyn.com>, <paul@paul-moore.com>, <jmorris@namei.org>,
        <linux-security-module@vger.kernel.org>
References: <20221025104544.2298829-1-cuigaosheng1@huawei.com>
 <20221025130459.kk42edsz56vsd3ur@wittgenstein>
From:   cuigaosheng <cuigaosheng1@huawei.com>
Message-ID: <8379bc32-518f-7194-70e2-03d1c648bf02@huawei.com>
Date:   Tue, 25 Oct 2022 21:51:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20221025130459.kk42edsz56vsd3ur@wittgenstein>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.176]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

> The Fixes: tag is wrong afaict. The control flow isn't changed in any
> way by the referenced commit.

Thanks for taking time to review this patch, I have update the fixes tags.
link: https://patchwork.kernel.org/project/linux-security-module/patch/20221025133357.2404086-1-cuigaosheng1@huawei.com/
> Otherwise I think you in principle have a point. Not sure if we have any
> filesystem that in practice would fail after permission checks have
> already passed with the first call to ->get() but then fail with the
> correct size passed in the second ->get() invocation. Sounds super
> unlikely but not impossible.

This problem was discovered when I was reading the code, we can build the fault
scenario by hard coding, but the probability of this problem occurring during
use should be very small, I thought we can fix it, so I submit the patch,
thanks again!

On 2022/10/25 21:04, Christian Brauner wrote:
> On Tue, Oct 25, 2022 at 06:45:44PM +0800, Gaosheng Cui wrote:
>> In cap_inode_getsecurity(), we will use vfs_getxattr_alloc() to
>> complete the memory allocation of tmpbuf, if we have completed
>> the memory allocation of tmpbuf, but failed to call handler->get(...),
>> there will be a memleak in below logic:
>>
>>    |-- ret = (int)vfs_getxattr_alloc(mnt_userns, ...)  <-- alloc for tmpbuf
>>      |-- value = krealloc(*xattr_value, error + 1, flags)  <-- alloc memory
>>      |-- error = handler->get(handler, ...)  <-- if error
>>      |-- *xattr_value = value <-- xattr_value is &tmpbuf  <-- memory leak
>>
>> So we will try to free(tmpbuf) after vfs_getxattr_alloc() fails to fix it.
> Hey Gaosheng,
>
>> Fixes: 71bc356f93a1 ("commoncap: handle idmapped mounts")
> The Fixes: tag is wrong afaict. The control flow isn't changed in any
> way by the referenced commit.
>
> The logic changed the last time with
> 82e5d8cc768b ("security: commoncap: fix -Wstringop-overread warning")
> but even that commit wouldn't have introduced the bug. It would've been
> introduced by 8db6c34f1dbc ("Introduce v3 namespaced file
> capabilities"). So update the Fixes: tag with that reference, please.
>
> Otherwise I think you in principle have a point. Not sure if we have any
> filesystem that in practice would fail after permission checks have
> already passed with the first call to ->get() but then fail with the
> correct size passed in the second ->get() invocation. Sounds super
> unlikely but not impossible.
> .
