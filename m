Return-Path: <SRS0=S0ZR=RH=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54088C43381
	for <linux-security-module@archiver.kernel.org>; Mon,  4 Mar 2019 14:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6FED2063F
	for <linux-security-module@archiver.kernel.org>; Mon,  4 Mar 2019 14:41:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="ZlcK+77s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbfCDOlu (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 4 Mar 2019 09:41:50 -0500
Received: from ucol19pa11.eemsg.mail.mil ([214.24.24.84]:16827 "EHLO
        UCOL19PA11.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbfCDOlu (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 4 Mar 2019 09:41:50 -0500
X-EEMSG-check-017: 648678874|UCOL19PA11_EEMSG_MP9.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.58,440,1544486400"; 
   d="scan'208";a="648678874"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UCOL19PA11.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 04 Mar 2019 14:41:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1551710508; x=1583246508;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=F38ZyFQt0lTICSTjy2ofDx60TsJwz7m6vIK4dmvococ=;
  b=ZlcK+77sZhmcfWEZQKRvA6ErXJo4zht5vqBjW+qIeI9vGKITeVwLo73b
   oBcJ8dA4XC4Vp5m1MjA8rZu7Bh2RVOQDcmypCp3qDtbPvJ+uY89b3+TGB
   YB0N7Os3LPEcSZgvu+noHjjP65J6Jo4FE9NMauDXSbq7q9ZxoADBIDlrB
   fejxw2a6GmFfxOQqng76pRQ8LsQbyt6rrblczkVWZbe8e0r6W2ndr/21R
   hDnMjKGhFzFYVwK7DmwcwT9/o8wOZ4jfb01lsLetI9kWC4VvEEjX5hU0T
   y+OdgzenlWWaQr3/0ux0vUe6sTY8sXceP9fGDbK1oiBSspkoJQlLpVnNP
   g==;
X-IronPort-AV: E=Sophos;i="5.58,440,1544486400"; 
   d="scan'208";a="21086552"
IronPort-PHdr: =?us-ascii?q?9a23=3ArepfKR98vx/xqv9uRHKM819IXTAuvvDOBiVQ1K?=
 =?us-ascii?q?B+0uoXIJqq85mqBkHD//Il1AaPAd2Lraocw8Pt8InYEVQa5piAtH1QOLdtbD?=
 =?us-ascii?q?Qizfssogo7HcSeAlf6JvO5JwYzHcBFSUM3tyrjaRsdF8nxfUDdrWOv5jAOBB?=
 =?us-ascii?q?r/KRB1JuPoEYLOksi7ze+/94HQbglSmDaxfa55IQmrownWqsQYm5ZpJLwryh?=
 =?us-ascii?q?vOrHtIeuBWyn1tKFmOgRvy5dq+8YB6/ShItP0v68BPUaPhf6QlVrNYFygpM3?=
 =?us-ascii?q?o05MLwqxbOSxaE62YGXWUXlhpIBBXF7A3/U5zsvCb2qvZx1S+HNsDtU7s6RS?=
 =?us-ascii?q?qt4LtqSB/wiScIKTg58H3MisdtiK5XuQ+tqwBjz4LRZoyaM+dwfr7GfdMCW2?=
 =?us-ascii?q?VOQtpRWSJGAoO5dYQPDuwBNvtco4Tyo1YCqB2zCge2BOPr1zRGmHn406Mn2O?=
 =?us-ascii?q?glCA3KwRAsE9cIvX/Jrtv6Kb0SXPiowqfWwzXNb/BY1znz54fHcB8uvf6CUK?=
 =?us-ascii?q?lsccfT00QjCx/Jg1uSpIHjIjib1v4Ns2+e7+d4SOyvl3AoqxlxojexwMcnl5?=
 =?us-ascii?q?THhocPxVDA8SV23oY0LsC/RU5gfNGkC4Bdtz2aNoRqQsMiRHtkuCAhyrIco5?=
 =?us-ascii?q?K7cy8KyIo+yhPZdveJfY+I4hf5W+aQJzd1nHVleKmiiBa060SgyPX8WtGu31?=
 =?us-ascii?q?ZStipFicHMtncR1xDJ9seHTf5980G80jiMzwDe8vxILE87mKbBK5Mt36Q8mo?=
 =?us-ascii?q?QcvEjdBCP6hUP7h7KMeEo+4Oin8eHnb63jpp+bKoB7lBnzMr8rmsyjGeQ4NR?=
 =?us-ascii?q?UOX3SD9eS8yrLj+Ur5Ta1WjvIsiKnZsY3aJd8Bqq6lAw5azoYj6xGlAzegzN?=
 =?us-ascii?q?sYhmUIIEhAeBKGi4jlI1DOIPbmAvejm1mgjThmyv/cMrDhH5nBNGbPnbj/cb?=
 =?us-ascii?q?pn9kJQ0A8zwspe55JQBLEBOvXzWkrpudzDExA5KBe5w/rnCdph1oMeXniDAq?=
 =?us-ascii?q?mCMKzIq1OI6eUvI/eUaI8PpDn9M+Ql5+LpjXIhgV8SY6+p3ZQKaHC5GPRqOk?=
 =?us-ascii?q?aZbmT2gtcHD2gKuhEzTO3zhF2GVj5TeWi9U7gn5j4hC4KmEJ3DSZq3jLyHwi?=
 =?us-ascii?q?i3BJ9WZnheAFCWDXjob5mEW+sLaC+KIM9hlzsEVaK7S48gzhGjrwn6xKBiLu?=
 =?us-ascii?q?XK+y0Ur5Xj1MJ65+fLjxE96SR0D9iB02GKV2x0mmIIRzkr3KFwuEB90UmM3r?=
 =?us-ascii?q?Rlg/xCFNxT+/NIXh4/NZ7b0uN6FtTyVRzac9eXR1apXM+mDSsyTt0v2d8OZV?=
 =?us-ascii?q?hyG9G4ghDExSqqDOxdq7veOJEo6b/bl1j4Icp0gyLe2a8uklggB8hCL2urgo?=
 =?us-ascii?q?Z+sgzUGYOPiEyairyjM6IRmizVoiPL72OLsVoQdQlqS6TeFSQdY0zMt9Xizk?=
 =?us-ascii?q?XLSrKvT7M9PV0S59SFL/5xdtDxjVhADMzmMdDabnP5z3y8Hj6U17iMa8zsYG?=
 =?us-ascii?q?xb0yLDXhtX2zsP9GqLYFBtThyqpHjTWXkwTF8=3D?=
X-IPAS-Result: =?us-ascii?q?A2BCAACbOH1c/wHyM5BlHAEBAQQBAQcEAQGBUQcBAQsBg?=
 =?us-ascii?q?WUqaIEDJ4QIiBqMFgEBAQEBAQaBECWJPI5lgXswCAGEQAKEJSI0CQ0BAQMBA?=
 =?us-ascii?q?QECAQMCAWwcDII6KYJnAQEBAQIBIxU1DBALDgoCAiYCAlcGAQwGAgEBgl8/A?=
 =?us-ascii?q?YFoBQgPqFOBL4VEhGGBCyQBiycXeIEHgTgMgjEugx4EGIEQg0GCVwKRMDuSG?=
 =?us-ascii?q?QmHQ4srBhmBdFiFCotMimSFW442OIFWKwgCGAghD4MnCYVvgwaHayEDMIEFA?=
 =?us-ascii?q?QGNQYJNAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 04 Mar 2019 14:41:47 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x24Efkse006578;
        Mon, 4 Mar 2019 09:41:46 -0500
Subject: Re: [PATCH] tomoyo: Add a kernel config option for fuzzing testing.
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        James Morris <jmorris@namei.org>
Cc:     linux-security-module@vger.kernel.org
References: <1551362770-8655-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <19e3dbac-d3ac-53b2-6e98-faf927bc72b3@i-love.sakura.ne.jp>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <05b05166-d24a-3c50-6556-472f50a239b9@tycho.nsa.gov>
Date:   Mon, 4 Mar 2019 09:34:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <19e3dbac-d3ac-53b2-6e98-faf927bc72b3@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 3/4/19 8:35 AM, Tetsuo Handa wrote:
> James, please include this patch for 5.1-rc1, for failing to include
> this patch will prevent various trees (SELinux/Smack/AppArmor) from
> proper testing due to this problem because syzbot is enabling both
> TOMOYO and one of SELinux/Smack/AppArmor via lsm= boot parameter.
> 
> By including this patch and building kernels with this config option
> enabled, syzbot will be able to continue proper testing.

Could you clarify the status of upstream TOMOYO?  Is its MAINTAINERS 
entry still accurate?  Is it still actively maintained?  Its existing 
documentation (in-tree and the tomoyo.osdn.jp site) seem to suggest that 
using the pre-LSM version and/or AKARI are preferred to using the 
upstream version. Is that still true, and do you envision it changing?

> 
> On 2019/02/28 23:06, Tetsuo Handa wrote:
>> syzbot is reporting kernel panic triggered by memory allocation fault
>> injection before loading TOMOYO's policy [1]. To make the fuzzing tests
>> useful, we need to assign a profile other than "disabled" (no-op) mode.
>> Therefore, let's allow syzbot to load TOMOYO's built-in policy for
>> "learning" mode using a kernel config option. This option must not be
>> enabled for kernels built for production system, for this option also
>> disables domain/program checks when modifying policy configuration via
>> /sys/kernel/security/tomoyo/ interface.
>>
>> [1] https://syzkaller.appspot.com/bug?extid=29569ed06425fcf67a95
>>
>> Reported-by: syzbot <syzbot+e1b8084e532b6ee7afab@syzkaller.appspotmail.com>
>> Reported-by: syzbot <syzbot+29569ed06425fcf67a95@syzkaller.appspotmail.com>
>> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
>> ---
>>   security/tomoyo/Kconfig  | 10 ++++++++++
>>   security/tomoyo/common.c | 13 ++++++++++++-
>>   2 files changed, 22 insertions(+), 1 deletion(-)
>>

