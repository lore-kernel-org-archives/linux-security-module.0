Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE895C38145
	for <linux-security-module@archiver.kernel.org>; Wed,  7 Sep 2022 14:06:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbiIGOGA (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 7 Sep 2022 10:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbiIGOGA (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 7 Sep 2022 10:06:00 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BADE67E814;
        Wed,  7 Sep 2022 07:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=/er90jz3XhSjwxV6BXeghY119eyGz9IxZW6xIbS/7mI=; b=fAtx79q791GXA5jH6/opXz3/dE
        3s+JBEjsnf0lhHB5Hq8IMHlNxzUwHYxQYoIfTtcyngogWhyOghP1ubKHHNFqOjeC51XLuEIFvzAxz
        45N0rTa5i7HYF60PqHal2bI3O2/3HUqG1o21s8NB3E9SZi21kH9aSlB7oRUn9++b3np8COFLn5i2N
        80qYjWIvyELvh2gqbkHYojX/HNRSQjIfk2S0ykB7sKTotwRBu+vfzoYtSyejYVl2kwqG8h5cjRRWE
        Vt66MQ4na9b/l9H68PihX7YatKkFhqM3Tv1HMNeU1jdRI6W5iOTSmxr3wyxLHeZdjo/qz9TpPjYlx
        L4Wup//w==;
Received: from [2601:1c0:6280:3f0::a6b3]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oVvgj-006iIw-DQ; Wed, 07 Sep 2022 14:05:57 +0000
Message-ID: <f1cefdb9-363a-c938-f02a-851173431610@infradead.org>
Date:   Wed, 7 Sep 2022 07:05:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH] security/keys: Remove inconsistent __user annotation
Content-Language: en-US
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>
References: <20220907121230.21252-1-vincenzo.frascino@arm.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220907121230.21252-1-vincenzo.frascino@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>



On 9/7/22 05:12, Vincenzo Frascino wrote:
> The declaration of keyring_read does not match the definition
> (security/keys/keyring.c). In this case the definition is correct
> because it matches what defined in "struct key_type::read"
> (linux/key-type.h).
> 
> Fix the declaration removing the inconsistent __user annotation.
> 
> Cc: David Howells <dhowells@redhat.com>
> Cc: Jarkko Sakkinen <jarkko@kernel.org>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: James Morris <jmorris@namei.org>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
> Note: This issue was discovered during the porting of the linux kernel
> on Morello [1].
> 
> [1] https://git.morello-project.org/morello/kernel/linux

FTR, I have sent this same patch 3 times.
Good luck.

>  security/keys/keyring.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/keys/keyring.c b/security/keys/keyring.c
> index 5e6a90760753..4448758f643a 100644
> --- a/security/keys/keyring.c
> +++ b/security/keys/keyring.c
> @@ -79,7 +79,7 @@ static void keyring_revoke(struct key *keyring);
>  static void keyring_destroy(struct key *keyring);
>  static void keyring_describe(const struct key *keyring, struct seq_file *m);
>  static long keyring_read(const struct key *keyring,
> -			 char __user *buffer, size_t buflen);
> +			 char *buffer, size_t buflen);
>  
>  struct key_type key_type_keyring = {
>  	.name		= "keyring",

-- 
~Randy
