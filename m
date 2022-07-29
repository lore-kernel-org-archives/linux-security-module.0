Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F9CC00144
	for <linux-security-module@archiver.kernel.org>; Fri, 29 Jul 2022 10:31:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235391AbiG2KbO (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 29 Jul 2022 06:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231830AbiG2KbO (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 29 Jul 2022 06:31:14 -0400
Received: from smtp-8faf.mail.infomaniak.ch (smtp-8faf.mail.infomaniak.ch [IPv6:2001:1600:3:17::8faf])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FDA327B34
        for <linux-security-module@vger.kernel.org>; Fri, 29 Jul 2022 03:31:12 -0700 (PDT)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4LvP1p3gVSzMrvf8;
        Fri, 29 Jul 2022 12:31:10 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4LvP1n1lLxzlqwsj;
        Fri, 29 Jul 2022 12:31:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1659090670;
        bh=DXGfGTdycajokiLwyQLK+R9c5/f5UT0aytg6HJT2do4=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=BaQ6dbMRrXcee/Nx0cxGNCAvHxRlhmEB6O6aYfnvoZCav7QRMYsJDK47V5optx6fl
         ma3vSIJ5bm4GDMC2MKMVZXNa4+ilRpHoANkPW58aBMTXfuSGPTNRdlIwXH60pnZGa1
         Qe+hiocSZ/PiSoACCrBzBygja45L+xk7H7jmVdVw=
Message-ID: <a300def1-587f-a770-2c3a-045e4da8d56a@digikod.net>
Date:   Fri, 29 Jul 2022 12:31:08 +0200
MIME-Version: 1.0
User-Agent: 
Content-Language: en-US
To:     =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack3000@gmail.com>,
        linux-security-module@vger.kernel.org
Cc:     James Morris <jmorris@namei.org>, Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>
References: <20220712211405.14705-1-gnoack3000@gmail.com>
 <20220712211405.14705-4-gnoack3000@gmail.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Subject: Re: [PATCH v2 3/4] samples/landlock: Extend sample tool to support
 LANDLOCK_ACCESS_FS_TRUNCATE
In-Reply-To: <20220712211405.14705-4-gnoack3000@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


On 12/07/2022 23:14, Günther Noack wrote:
> The sample tool will restrict the truncate operation if possible with
> the current kernel.

"Update the sandboxer sample to restrict truncate actions.  This is 
automatically enabled by default if the running kernel supports 
LANDLOCK_ACCESS_FS_TRUNCATE, except for the paths listed in the LL_FS_RW 
environment variable."


> 
> Signed-off-by: Günther Noack <gnoack3000@gmail.com>
> Link: https://lore.kernel.org/all/20220707200612.132705-1-gnoack3000@gmail.com/
> ---
>   samples/landlock/sandboxer.c | 15 +++++++++++++--
>   1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
> index 3e404e51ec64..4c3ed0097ffd 100644
> --- a/samples/landlock/sandboxer.c
> +++ b/samples/landlock/sandboxer.c
> @@ -76,7 +76,8 @@ static int parse_path(char *env_path, const char ***const path_list)
>   #define ACCESS_FILE ( \
>   	LANDLOCK_ACCESS_FS_EXECUTE | \
>   	LANDLOCK_ACCESS_FS_WRITE_FILE | \
> -	LANDLOCK_ACCESS_FS_READ_FILE)
> +	LANDLOCK_ACCESS_FS_READ_FILE | \
> +	LANDLOCK_ACCESS_FS_TRUNCATE)
>   
>   /* clang-format on */
>   
> @@ -160,11 +161,15 @@ static int populate_ruleset(const char *const env_var, const int ruleset_fd,
>   	LANDLOCK_ACCESS_FS_MAKE_FIFO | \
>   	LANDLOCK_ACCESS_FS_MAKE_BLOCK | \
>   	LANDLOCK_ACCESS_FS_MAKE_SYM | \
> -	LANDLOCK_ACCESS_FS_REFER)
> +	LANDLOCK_ACCESS_FS_REFER | \
> +	LANDLOCK_ACCESS_FS_TRUNCATE)
>   
>   #define ACCESS_ABI_2 ( \
>   	LANDLOCK_ACCESS_FS_REFER)
>   
> +#define ACCESS_ABI_3 ( \
> +	LANDLOCK_ACCESS_FS_TRUNCATE)
> +
>   /* clang-format on */
>   
>   int main(const int argc, char *const argv[], char *const *const envp)
> @@ -226,6 +231,12 @@ int main(const int argc, char *const argv[], char *const *const envp)
>   		return 1;
>   	}
>   	/* Best-effort security. */
> +	if (abi < 3) {
> +		ruleset_attr.handled_access_fs &= ~ACCESS_ABI_3;
> +		access_fs_ro &= ~ACCESS_ABI_3;
> +		access_fs_rw &= ~ACCESS_ABI_3;
> +	}

I think it is a good time to start replacing this "if" check with a 
switch one:

switch (abi) {
case 1:
	ruleset_attr.handled_access_fs &= ~ACCESS_ABI_2;
	access_fs_rw &= ~ACCESS_ABI_2;
	__attribute__((fallthrough));
case 2:
	ruleset_attr.handled_access_fs &= ~ACCESS_ABI_3;
	access_fs_rw &= ~ACCESS_ABI_3;
}


> +
>   	if (abi < 2) {
>   		ruleset_attr.handled_access_fs &= ~ACCESS_ABI_2;
>   		access_fs_ro &= ~ACCESS_ABI_2;
