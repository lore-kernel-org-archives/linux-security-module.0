Return-Path: <SRS0=n6I0=QT=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CBA2C282C4
	for <linux-security-module@archiver.kernel.org>; Tue, 12 Feb 2019 19:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 358D2222C0
	for <linux-security-module@archiver.kernel.org>; Tue, 12 Feb 2019 19:02:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728136AbfBLTCA (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 12 Feb 2019 14:02:00 -0500
Received: from namei.org ([65.99.196.166]:51838 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728032AbfBLTCA (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 12 Feb 2019 14:02:00 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x1CJ1fWF015753;
        Tue, 12 Feb 2019 19:01:42 GMT
Date:   Wed, 13 Feb 2019 06:01:41 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Wei Yongjun <weiyongjun1@huawei.com>
cc:     "Serge E. Hallyn" <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>,
        Micah Morton <mortonm@chromium.org>,
        linux-security-module@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] LSM: fix return value check in
 safesetid_init_securityfs()
In-Reply-To: <20190212075831.114668-1-weiyongjun1@huawei.com>
Message-ID: <alpine.LRH.2.21.1902130601300.15293@namei.org>
References: <20190212075831.114668-1-weiyongjun1@huawei.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, 12 Feb 2019, Wei Yongjun wrote:

> In case of error, the function securityfs_create_dir() returns ERR_PTR()
> and never returns NULL. The NULL test in the return value check should
> be replaced with IS_ERR().
> 
> Fixes: aeca4e2ca65c ("LSM: add SafeSetID module that gates setid calls")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-general

-- 
James Morris
<jmorris@namei.org>

