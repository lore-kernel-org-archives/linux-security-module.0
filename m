Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19FA8C6FA8E
	for <linux-security-module@archiver.kernel.org>; Tue, 27 Sep 2022 16:24:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232739AbiI0QYI (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 27 Sep 2022 12:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231993AbiI0QYH (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 27 Sep 2022 12:24:07 -0400
Received: from smtp-8fa8.mail.infomaniak.ch (smtp-8fa8.mail.infomaniak.ch [83.166.143.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D31B15E452
        for <linux-security-module@vger.kernel.org>; Tue, 27 Sep 2022 09:24:03 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4McQ1F2SLfzMqKy5;
        Tue, 27 Sep 2022 18:24:01 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4McQ1C6yrSzx0;
        Tue, 27 Sep 2022 18:23:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1664295841;
        bh=YhvKIaFsE/mTgyc5JuWtSNn0I9aERdaCkohDydV2LIM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=KyFyHY7cdvTSpdBHZn45J5FcQox5j5iIFwuRHWUMZFqPYnPS1drDIiiJlOn3Mha/e
         w0Aca54KcYDFwSdpwwBHV3yQv+6l2WYaKNHH3w6Hm6v3LdC4E0a1iYEBrd/VcQPl4w
         c615IeZx2pmVcMjX9cWk2Qg3fwj8qEh2qS5mpv4E=
Message-ID: <80be55d6-ffd4-5c3e-3076-70ec10ed91bf@digikod.net>
Date:   Tue, 27 Sep 2022 18:23:59 +0200
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH v1 1/3] samples/landlock: Print hints about ABI versions
Content-Language: en-US
To:     =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack3000@gmail.com>
Cc:     James Morris <jmorris@namei.org>, Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Alejandro Colomar <alx.manpages@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        linux-doc@vger.kernel.org, linux-security-module@vger.kernel.org
References: <20220923154207.3311629-1-mic@digikod.net>
 <20220923154207.3311629-2-mic@digikod.net> <Yy4e0nTiO6dv/Eif@nuc>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <Yy4e0nTiO6dv/Eif@nuc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


On 23/09/2022 23:02, Günther Noack wrote:
> Reviewed-by: Günther Noack <gnoack3000@gmail.com>
> 
> This patch is a strict improvement over what the sample code was
> before, so that's fine with me review wise.
> 
> I still think it would be good to point out more explicitly that the
> "refer" right needs a different fallback strategy for the best effort
> mode than the other rights will do in the future, as discussed in [1].
> 
> In many "best effort" scenarios that people need for their code, the
> part that is actually fixed are the access rights that their code
> declares that it needs. So if they actually need the "refer" right for
> their programs to work, they cannot use Landlock on kernels that only
> support Landlock ABI v1, because under ABI v1 they will never be able
> to hardlink or rename between directories when Landlock is enabled.
> 
> The way that the sandboxer example is dealing with it, it just gives
> the user a smaller set of access rights than they requested if the
> kernel just supports ABI v1. It's somewhat reasonable for the
> sandboxer tool to do because it doesn't give hard guarantees in its
> command line interface, but it might not be negotiable in more
> practical examples. :)
> 
> [1] https://docs.google.com/document/d/1SkFpl_Xxyl4E6G2uYIlzL0gY2PFo-Nl8ikblLvnpvlU/edit

I agree. The sandboxer is a sample, and such sandboxer is not the best 
place to configure Landlock according to the app semantic. At the end it 
should be done in the app itself.

I would like this sample to be as simple as possible but still useful. 
To properly handle all "refer" use cases, it would require a dedicated 
configuration (e.g. LL_FS_REFER), which will make it more difficult to 
understand, and this approach will not scale with future (FS) access rights.

We can maybe add a comment in this sample to explain that. Your 
explanation looks like a good start. If you agree, could you send a 
patch to add such comment (on top of this series)?

> 
> —Günther
> 
> On Fri, Sep 23, 2022 at 05:42:05PM +0200, Mickaël Salaün wrote:
>> Extend the help with the latest Landlock ABI version supported by the
>> sandboxer.
>>
>> Inform users about the sandboxer or the kernel not being up-to-date.
>>
>> Make the version check code easier to update and harder to misuse.
>>
>> Cc: Günther Noack <gnoack3000@gmail.com>
>> Cc: Paul Moore <paul@paul-moore.com>
>> Signed-off-by: Mickaël Salaün <mic@digikod.net>
>> Link: https://lore.kernel.org/r/20220923154207.3311629-2-mic@digikod.net
>> ---
>>   samples/landlock/sandboxer.c | 37 ++++++++++++++++++++++++++++--------
>>   1 file changed, 29 insertions(+), 8 deletions(-)
>>
>> diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
>> index 3e404e51ec64..f29bb3c72230 100644
>> --- a/samples/landlock/sandboxer.c
>> +++ b/samples/landlock/sandboxer.c
>> @@ -162,11 +162,10 @@ static int populate_ruleset(const char *const env_var, const int ruleset_fd,
>>   	LANDLOCK_ACCESS_FS_MAKE_SYM | \
>>   	LANDLOCK_ACCESS_FS_REFER)
>>   
>> -#define ACCESS_ABI_2 ( \
>> -	LANDLOCK_ACCESS_FS_REFER)
>> -
>>   /* clang-format on */
>>   
>> +#define LANDLOCK_ABI_LAST 2
>> +
>>   int main(const int argc, char *const argv[], char *const *const envp)
>>   {
>>   	const char *cmd_path;
>> @@ -196,8 +195,12 @@ int main(const int argc, char *const argv[], char *const *const envp)
>>   			"\nexample:\n"
>>   			"%s=\"/bin:/lib:/usr:/proc:/etc:/dev/urandom\" "
>>   			"%s=\"/dev/null:/dev/full:/dev/zero:/dev/pts:/tmp\" "
>> -			"%s bash -i\n",
>> +			"%s bash -i\n\n",
>>   			ENV_FS_RO_NAME, ENV_FS_RW_NAME, argv[0]);
>> +		fprintf(stderr,
>> +			"This sandboxer can use Landlock features "
>> +			"up to ABI version %d.\n",
>> +			LANDLOCK_ABI_LAST);
>>   		return 1;
>>   	}
>>   
>> @@ -225,12 +228,30 @@ int main(const int argc, char *const argv[], char *const *const envp)
>>   		}
>>   		return 1;
>>   	}
>> +
>>   	/* Best-effort security. */
>> -	if (abi < 2) {
>> -		ruleset_attr.handled_access_fs &= ~ACCESS_ABI_2;
>> -		access_fs_ro &= ~ACCESS_ABI_2;
>> -		access_fs_rw &= ~ACCESS_ABI_2;
>> +	switch (abi) {
>> +	case 1:
>> +		/* Removes LANDLOCK_ACCESS_FS_REFER for ABI < 2 */
>> +		ruleset_attr.handled_access_fs &= ~LANDLOCK_ACCESS_FS_REFER;
>> +
>> +		fprintf(stderr,
>> +			"Hint: You should update the running kernel "
>> +			"to leverage Landlock features "
>> +			"provided by ABI version %d (instead of %d).\n",
>> +			LANDLOCK_ABI_LAST, abi);
>> +		__attribute__((fallthrough));
>> +	case LANDLOCK_ABI_LAST:
>> +		break;
>> +	default:
>> +		fprintf(stderr,
>> +			"Hint: You should update this sandboxer "
>> +			"to leverage Landlock features "
>> +			"provided by ABI version %d (instead of %d).\n",
>> +			abi, LANDLOCK_ABI_LAST);
>>   	}
>> +	access_fs_ro &= ruleset_attr.handled_access_fs;
>> +	access_fs_rw &= ruleset_attr.handled_access_fs;
>>   
>>   	ruleset_fd =
>>   		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
>> -- 
>> 2.37.2
>>
> 
