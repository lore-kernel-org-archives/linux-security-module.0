Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 699F1EB64D9
	for <linux-security-module@archiver.kernel.org>; Mon, 19 Jun 2023 14:42:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbjFSOmK (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 19 Jun 2023 10:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231724AbjFSOmJ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 19 Jun 2023 10:42:09 -0400
Received: from smtp-8fa8.mail.infomaniak.ch (smtp-8fa8.mail.infomaniak.ch [IPv6:2001:1600:4:17::8fa8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D0310CE
        for <linux-security-module@vger.kernel.org>; Mon, 19 Jun 2023 07:41:57 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4QlCC708RJzMq3SJ;
        Mon, 19 Jun 2023 14:41:55 +0000 (UTC)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4QlCC639Zkz4LS;
        Mon, 19 Jun 2023 16:41:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1687185714;
        bh=HlP+NfGNNJg5gGWG5lCwYvIerY/jTZsa8kvff5U/i2A=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=aDRQx8fZgVh8O6MD42BBWsA41/wN2uPl8qUlqLx+egba6FdP316DqE6d49xre8WtT
         bu8vnzxxBUueoUQSghhBbuTB2Ra73Na8omDpHPgaRUuVW/zjhwnZAW8Euy3qrMxj05
         dHXNxWVZRf1F2mUEQji4UYdCAqcnMaxB6oqFtmDA=
Message-ID: <1d6b4222-bfa4-bf39-d296-9f3410f5b170@digikod.net>
Date:   Mon, 19 Jun 2023 16:41:53 +0200
MIME-Version: 1.0
User-Agent: 
Subject: Re: [RFC 1/4] landlock: Increment Landlock ABI version to 4
Content-Language: en-US
To:     =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack3000@gmail.com>,
        linux-security-module@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
References: <20230502171755.9788-1-gnoack3000@gmail.com>
 <20230502171755.9788-2-gnoack3000@gmail.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <20230502171755.9788-2-gnoack3000@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

We should increment the version with the (next) commit that enables the 
feature. This helps avoid a backport with a wrong version.


On 02/05/2023 19:17, Günther Noack wrote:
> Increment the Landlock ABI version in preparation for the ioctl
> feature.
> 
> Signed-off-by: Günther Noack <gnoack3000@gmail.com>
> ---
>   security/landlock/syscalls.c                 | 2 +-
>   tools/testing/selftests/landlock/base_test.c | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
> index 245cc650a4d..c70fc9e6fe9 100644
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
> index 792c3f0a59b..646f778dfb1 100644
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
