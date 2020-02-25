Return-Path: <SRS0=WY9+=4N=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BEA7C35E04
	for <linux-security-module@archiver.kernel.org>; Tue, 25 Feb 2020 17:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57E7020CC7
	for <linux-security-module@archiver.kernel.org>; Tue, 25 Feb 2020 17:59:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730829AbgBYR7z (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 25 Feb 2020 12:59:55 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2464 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727983AbgBYR7z (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 25 Feb 2020 12:59:55 -0500
Received: from lhreml702-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 8C2CEBE719B78ED283CF;
        Tue, 25 Feb 2020 17:59:52 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 lhreml702-cah.china.huawei.com (10.201.108.43) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 25 Feb 2020 17:59:47 +0000
Received: from [127.0.0.1] (10.202.226.45) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5; Tue, 25 Feb
 2020 17:59:47 +0000
From:   John Garry <john.garry@huawei.com>
To:     <casey@schaufler-ca.com>, "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        <linux-security-module@vger.kernel.org>
Subject: suspicious RCU usage from smack code
CC:     Anders Roxell <anders.roxell@linaro.org>
Message-ID: <9d97e54f-a7d3-30fa-de4c-ae8d70dee087@huawei.com>
Date:   Tue, 25 Feb 2020 17:59:46 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.45]
X-ClientProxiedBy: lhreml708-chm.china.huawei.com (10.201.108.57) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi guys,

JFYI, When I enable CONFIG_PROVE_RCU=y, I get these:

[    0.369697] WARNING: suspicious RCU usage
[    0.374179] 5.6.0-rc3-00002-g619882231229-dirty #1753 Not tainted
[    0.380974] -----------------------------
[    0.385455] security/smack/smack_lsm.c:354 RCU-list traversed in 
non-reader section!!
[    0.394183]
[    0.394183] other info that might help us debug this:
[    0.394183]
[    0.403107]
[    0.403107] rcu_scheduler_active = 1, debug_locks = 1
[    0.410389] no locks held by kthreadd/2.
[    0.414770]
[    0.414770] stack backtrace:
[    0.419636] CPU: 0 PID: 2 Comm: kthreadd Not tainted 
5.6.0-rc3-00002-g619882231229-dirty #1753
[    0.429204] Call trace:
[    0.431924]  dump_backtrace+0x0/0x298
[    0.435990]  show_stack+0x14/0x20
[    0.439674]  dump_stack+0x118/0x190
[    0.443548]  lockdep_rcu_suspicious+0xe0/0x120
[    0.448487]  smack_cred_prepare+0x2f8/0x310
[    0.453134]  security_prepare_creds+0x64/0xe0
[    0.457979]  prepare_creds+0x25c/0x368
[    0.462141]  copy_creds+0x40/0x620
[    0.465918]  copy_process+0x62c/0x25e0
[    0.470084]  _do_fork+0xc0/0x998
[    0.473667]  kernel_thread+0xa0/0xc8
[    0.477640]  kthreadd+0x2b0/0x408
[    0.481325]  ret_from_fork+0x10/0x18

[   18.804382] =============================
[   18.808872] WARNING: suspicious RCU usage
[   18.813348] 5.6.0-rc3-00002-g619882231229-dirty #1753 Not tainted
[   18.820145] -----------------------------
[   18.824621] security/smack/smack_access.c:87 RCU-list traversed in 
non-reader section!!
[   18.833544]
[   18.833544] other info that might help us debug this:
[   18.833544]
[   18.842465]
[   18.842465] rcu_scheduler_active = 1, debug_locks = 1
[   18.849741] no locks held by kdevtmpfs/781.
[   18.854410]
[   18.854410] stack backtrace:
[   18.859277] CPU: 1 PID: 781 Comm: kdevtmpfs Not tainted 
5.6.0-rc3-00002-g619882231229-dirty #1753
[   18.869138] Call trace:
[   18.871860]  dump_backtrace+0x0/0x298
[   18.875929]  show_stack+0x14/0x20
[   18.879612]  dump_stack+0x118/0x190
[   18.883489]  lockdep_rcu_suspicious+0xe0/0x120
[   18.888428]  smk_access_entry+0x110/0x128
[   18.892885]  smk_tskacc+0x70/0xe8
[   18.896568]  smk_curacc+0x64/0x78
[   18.900249]  smack_inode_permission+0x110/0x1c8
[   18.905284]  security_inode_permission+0x50/0x98
[   18.910412]  inode_permission+0x70/0x1d0
[   18.914768]  link_path_walk.part.38+0x4a8/0x778
[   18.919802]  path_lookupat+0xd0/0x1a8
[   18.923871]  filename_lookup+0xf0/0x1f8
[   18.928136]  user_path_at_empty+0x48/0x58
[   18.932590]  ksys_chdir+0x8c/0x138
[   18.936366]  devtmpfsd+0x148/0x448
[   18.940146]  kthread+0x1c8/0x1d0
[   18.943732]  ret_from_fork+0x10/0x18

I haven't had a chance to check whether they are bogus or not.

Thanks,
John
