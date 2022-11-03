Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1B8DC4332F
	for <linux-security-module@archiver.kernel.org>; Thu,  3 Nov 2022 14:21:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbiKCOVl (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 3 Nov 2022 10:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbiKCOVi (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 3 Nov 2022 10:21:38 -0400
Received: from smtp-42ae.mail.infomaniak.ch (smtp-42ae.mail.infomaniak.ch [IPv6:2001:1600:4:17::42ae])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A252AEF
        for <linux-security-module@vger.kernel.org>; Thu,  3 Nov 2022 07:21:36 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4N35Xt2xcVzMq6JJ;
        Thu,  3 Nov 2022 15:21:34 +0100 (CET)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4N35Xt0WdJzxX;
        Thu,  3 Nov 2022 15:21:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1667485294;
        bh=v5u5mCyz0QZSIJuFUsjZ3UkchgaRwxVwFQY5u4vnDXs=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=xyGlCAkvypEwwAKHJxA/guDczI0YrCtQENqQbNbz7ZneBOCEMvAIuNVBcc17fFd+e
         tQ+SBAzxaoB4XJ9bf5iuxHOhkRxIMKFk1puxcBW/srqjdIeNT43C27NHD9536WIIxF
         mPDuuZpjqA+C+//8Ph7l2pjkEAubVloSR7HTqsL0=
Message-ID: <cbe72a75-b077-e5d2-52a8-db20432e15bc@digikod.net>
Date:   Thu, 3 Nov 2022 15:21:32 +0100
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH] samples/landlock: Document best-effort approach for
 LANDLOCK_ACCESS_FS_REFER
Content-Language: en-US
To:     =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack3000@gmail.com>,
        linux-security-module@vger.kernel.org
References: <20221030061107.2351-1-gnoack3000@gmail.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <20221030061107.2351-1-gnoack3000@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Thanks Günther. Here are small changes:

On 30/10/2022 07:11, Günther Noack wrote:
> Add a comment to clarify how to handle best-effort backwards
> compatibility for LANDLOCK_ACCESS_FS_REFER.
> 
> The "refer" access is special because these operations are always
> forbidden in ABI 1, unlike most other operations, which are permitted
> when using Landlock ABI levels where they are not supported yet.
> 
> Signed-off-by: Günther Noack <gnoack3000@gmail.com>
> ---
>   samples/landlock/sandboxer.c | 16 +++++++++++++++-
>   1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
> index fd4237c64fb2..901acb383124 100644
> --- a/samples/landlock/sandboxer.c
> +++ b/samples/landlock/sandboxer.c
> @@ -234,7 +234,21 @@ int main(const int argc, char *const argv[], char *const *const envp)
>   	/* Best-effort security. */
>   	switch (abi) {
>   	case 1:
> -		/* Removes LANDLOCK_ACCESS_FS_REFER for ABI < 2 */
> +		/*
> +		 * Removes LANDLOCK_ACCESS_FS_REFER for ABI < 2
> +		 *
> +		 * Note: The "refer" operations (file renaming and linking
> +		 * across different directories) are always forbidden when using
> +		 * Landlock with ABI 1.
> +		 *
> +		 * If only ABI 1 is available, the sample tool knowingly forbids

s/the sample tool/this sandboxer/

> +		 * refer operations.
> +		 *
> +		 * If a program *needs* to do refer operations after enabling
> +		 * Landlock, it can not use Landlock at ABI level 1.  To be
> +		 * compatible across different kernels, such programs should
> +		 * fall back to not using Landlock instead.

To be compatible with different kernel versions, such programs should 
then fall back to not restrict themselves at all if the running kernel 
only supports ABI 1.


> +		 */
>   		ruleset_attr.handled_access_fs &= ~LANDLOCK_ACCESS_FS_REFER;
>   		__attribute__((fallthrough));
>   	case 2:
> 
> base-commit: 4bc90a766ea5af69c12ca1ea00b7fc5fe1d68831
