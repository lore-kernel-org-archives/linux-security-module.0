Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 114F3C3DA78
	for <linux-security-module@archiver.kernel.org>; Fri, 13 Jan 2023 19:58:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbjAMT6Y (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 13 Jan 2023 14:58:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbjAMT6L (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 13 Jan 2023 14:58:11 -0500
Received: from smtp-bc09.mail.infomaniak.ch (smtp-bc09.mail.infomaniak.ch [IPv6:2001:1600:3:17::bc09])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7EB687F1B
        for <linux-security-module@vger.kernel.org>; Fri, 13 Jan 2023 11:58:09 -0800 (PST)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4NtsfQ2klhzMqxJX;
        Fri, 13 Jan 2023 20:58:06 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4NtsfP5DhjzFXg;
        Fri, 13 Jan 2023 20:58:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1673639886;
        bh=GgZ5gPtDuZKrb/8BIHNeEuXFCuTSzpZM2LSjcosFW3E=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=O27MnDt4ky9Y22RmWu2myDpgqWatchR71k8RUA84j/aR+1m3oGVrB6YwbizaXNg9l
         4NzoxZRJuLKPk2k4wDpJda3fn0mBHuDlP0aPbYEWHTM1KUwXitXQ2ceNHB8afMgOlb
         kEx3HeUXrtjyLgIVFdq3AiWdnfw3+t4ecFibamqw=
Message-ID: <ab279390-84e1-0bcc-29ca-eea673fdd14c@digikod.net>
Date:   Fri, 13 Jan 2023 20:58:05 +0100
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH v8 0/1] selftests/landlock: fix fs_tests when overlayfs
Content-Language: en-US
To:     jeffxu@chromium.org
Cc:     jorgelo@chromium.org, keescook@chromium.org,
        linux-security-module@vger.kernel.org, groeck@chromium.org,
        gnoack@google.com, Jeff Xu <jeffxu@google.com>
References: <20230113053229.1281774-1-jeffxu@google.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <20230113053229.1281774-1-jeffxu@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Thanks Jeff! I pushed this patch in -next: 
https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git/log/?h=next


On 13/01/2023 06:32, jeffxu@chromium.org wrote:
> From: Jeff Xu <jeffxu@google.com>
> 
> Overlayfs can be disabled in kernel config, causing related tests to
> fail. Adding a check for overlayfs’s supportability at runtime,
> so we can call SKIP() when needed.
> 
> Note:
> Below comments are raised during V7 discussion:
> 
> Currently SKIP() is applied to FIXTURE_SETUP, FIXTURE_TEARDOWN,
> TEST_F_FORK, this is because SKIP() apply within the function
> scope, not the testcase.
> 
> We would like test infra to have a dedicated environment
> check hook (FIXTURE_ENV_CHECK) in test infra, called before
> FIXTURE_SETUP(). If the environment check fails, the remaining
> of the test will be skipped. The benefit of these are two:
> 1> if env check pass, in theory, the test should pass.
> 2> if env check fail, no need to call setup, so no need to cleanup
> resource.
> 
> v8:
> style change, no logic change.
> 
> v7:
> https://lore.kernel.org/all/20221229211446.3154454-1-jeffxu@google.com/
> Fix bug in supports_overlayfs().
> Manual test with kernel with and without overlayfs.
> 
> v6: https://lore.kernel.org/all/20221229201215.3006512-1-jeffxu@google.com/
> In v4, the SKIP() was applied at FIXTURE_SETUP() after mount() fail,
> however, FIXTURE_TEARDOWN() will fail. It might be complicated
> for test infra or testcase itself to have cleanup code handing the
> success/failure of steps in SETUP().
> 
> This patch changes the approach, it calls supports_overlay() and SKIP()
> at the beginning of FIXTURE_SETUP(), FIX_TEARDOWN(), TEST_F_FORK().
> Because no modification of system is done by the test, cleanup is not
> needed.
> 
> v4:
> https://lore.kernel.org/all/20220823010216.2653012-1-jeffxu@google.com/
> 
> 
> Jeff Xu (1):
>    selftests/landlock: skip overlayfs test when not support
> 
>   tools/testing/selftests/landlock/fs_test.c | 48 ++++++++++++++++++++++
>   1 file changed, 48 insertions(+)
> 
> 
> base-commit: 963a70bee5880640d0fd83ed29dc1e7ec0d2bd4a
