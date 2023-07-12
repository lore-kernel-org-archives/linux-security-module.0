Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36885EB64D9
	for <linux-security-module@archiver.kernel.org>; Wed, 12 Jul 2023 10:55:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232675AbjGLKzm (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 12 Jul 2023 06:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231858AbjGLKzk (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 12 Jul 2023 06:55:40 -0400
Received: from smtp-8faa.mail.infomaniak.ch (smtp-8faa.mail.infomaniak.ch [83.166.143.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E3EF11D
        for <linux-security-module@vger.kernel.org>; Wed, 12 Jul 2023 03:55:39 -0700 (PDT)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4R1F5Q0CZJzMq5rd;
        Wed, 12 Jul 2023 10:55:38 +0000 (UTC)
Received: from unknown by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4R1F5N64HnzMpppc;
        Wed, 12 Jul 2023 12:55:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1689159337;
        bh=g26zDWpY4FTWv4wdoXV+8vauu/BFLBR6hFzkUK+11HQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=CFdHqbYTSxkRxJz1xoN451SJIqO85PXVureUtgDBKNjLzp/kGsY7/CmsPzGC/qXCd
         VOb0Gpck1NUZTpSCtFdx5RdBL3qi8R3wywbPs8Q0UsyI0yOmiWiGL8uaRpEsGWDN+z
         w+Htt5FZLskYoXWk1b8p3lTC3P+YvvH6z5LuGJoM=
Message-ID: <d3031654-71b3-477a-10e6-1bb4f561df7d@digikod.net>
Date:   Wed, 12 Jul 2023 12:55:36 +0200
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH v2 1/6] landlock: Increment Landlock ABI version to 4
Content-Language: en-US
To:     =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack@google.com>,
        linux-security-module@vger.kernel.org
Cc:     Jeff Xu <jeffxu@google.com>,
        Jorge Lucangeli Obes <jorgelo@chromium.org>,
        Allen Webb <allenwebb@google.com>,
        Dmitry Torokhov <dtor@google.com>,
        Paul Moore <paul@paul-moore.com>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        linux-fsdevel@vger.kernel.org
References: <20230623144329.136541-1-gnoack@google.com>
 <20230623144329.136541-2-gnoack@google.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <20230623144329.136541-2-gnoack@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

This patch should be squashed with 2/6 (LANDLOCK_ACCESS_FS_IOCTL). 
Please take into account my previous review from the initial RFC, for 
this patch and the next ones.


On 23/06/2023 16:43, Günther Noack wrote:
> Increment the Landlock ABI version in preparation for the ioctl
> feature.
> 
> Signed-off-by: Günther Noack <gnoack@google.com>
> ---
>   security/landlock/syscalls.c                 | 2 +-
>   tools/testing/selftests/landlock/base_test.c | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
> index 245cc650a4dc..c70fc9e6fe9e 100644
> --- a/security/landlock/syscalls.c
> +++ b/security/landlock/syscalls.c
> @@ -129,7 +129,7 @@ static const struct file_operations ruleset_fops = {
>   	.write = fop_dummy_write,
>   };
>   
> -#define LANDLOCK_ABI_VERSION 3
> +#define LANDLOCK_ABI_VERSION 4
>   
>   /**
>    * sys_landlock_create_ruleset - Create a new ruleset
> diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing/selftests/landlock/base_test.c
> index 792c3f0a59b4..646f778dfb1e 100644
> --- a/tools/testing/selftests/landlock/base_test.c
> +++ b/tools/testing/selftests/landlock/base_test.c
> @@ -75,7 +75,7 @@ TEST(abi_version)
>   	const struct landlock_ruleset_attr ruleset_attr = {
>   		.handled_access_fs = LANDLOCK_ACCESS_FS_READ_FILE,
>   	};
> -	ASSERT_EQ(3, landlock_create_ruleset(NULL, 0,
> +	ASSERT_EQ(4, landlock_create_ruleset(NULL, 0,
>   					     LANDLOCK_CREATE_RULESET_VERSION));
>   
>   	ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr, 0,
