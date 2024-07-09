Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B3913211E
	for <linux-security-module@vger.kernel.org>; Tue,  9 Jul 2024 22:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720565274; cv=none; b=ZfdBsGfAaV+gumceQnUfrO7jTYb/ARiKioyiroOeS6xLPuEvaI3B2Z46DiaumTnI7t5G2e0qff8R1jiL4JtUi8Z76HppCTJ9YLMA0BRplsq4dd1dfRaAI9PLrdz5uPbCZ417MkPhXothrkbtymwdrSe+uy+eQAOvISBNIMnhQw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720565274; c=relaxed/simple;
	bh=JBdrFRcP+K2dAjklmI75MuK7GXFtG659GBXqS8fcTCE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SGy+dcIWszUM0WckwOwm9hjMi+/diYkLB+R+PV5fWVMgWTcn507ChWnmGE1d2IhSLXXc1c2KS52760ilJaWtPweK2Xd7c261dbAqT3IB90/OSga47qmC29r8fhwmoNGW9CDFl8VDDLXlH7OpKhMPFKxFBZkcNZvtYK3xFCCSI9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=oooywzbL; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="oooywzbL"
Received: from [192.168.192.84] (unknown [50.39.103.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id D08423F1D1;
	Tue,  9 Jul 2024 22:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1720565269;
	bh=KSuA1WoqJzDB+idGNWfl/9kE+VUKeM98Pe0SeYWZndM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=oooywzbLc0VNi82xOqTYTYwprXUQD0eShPzoTIzprvP7s6KscX+JL/6ZsbS41YhS/
	 P1531/QTPYK4IZdgurKl1/J2lCorXPC9N1vlTOHVOERPKUP6s6hfXSvzvmHvNy0WZ5
	 BuNTHbvhMf1I576XbPJ6r4tkhj9RCV9pFVPNNHPVhZh0AKcikAV3XLcOF8dmn/WIEO
	 Tba/GKedUFsGBTCcDm8GaxSC7jeWlIwhRnRTwZrRdeJvFR5RvHGGHSoOSRSuXwvaQY
	 ehmGuQY34hsAD/GAylOKTKdYc4M8jlHLZCrlc+ksivt58i49xpIFLNo1Ezp395i/ib
	 MjObYAugtMfSQ==
Message-ID: <af2cfc52-e91a-4d1e-bb74-43322d1cea20@canonical.com>
Date: Tue, 9 Jul 2024 15:47:45 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] LSM: Infrastructure management of the key security
 blob
To: Paul Moore <paul@paul-moore.com>, Casey Schaufler
 <casey@schaufler-ca.com>, linux-security-module@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
 penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
 mic@digikod.net
References: <20240708213957.20519-3-casey@schaufler-ca.com>
 <8088e9a23a22fef35159b86760a9ab8e@paul-moore.com>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <8088e9a23a22fef35159b86760a9ab8e@paul-moore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/9/24 15:08, Paul Moore wrote:
> On Jul  8, 2024 Casey Schaufler <casey@schaufler-ca.com> wrote:
>>
>> Move management of the key->security blob out of the
>> individual security modules and into the security
>> infrastructure. Instead of allocating the blobs from within
>> the modules the modules tell the infrastructure how much
>> space is required, and the space is allocated there.
> 
> Perhaps mention that the key_free hook is being removed as it is not
> currently needed after this change?
> 
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> ---
>>   include/linux/lsm_hooks.h         |  1 +
>>   security/security.c               | 41 +++++++++++++++++++++++++++++--
>>   security/selinux/hooks.c          | 23 +++++------------
>>   security/selinux/include/objsec.h |  7 ++++++
>>   security/smack/smack.h            |  7 ++++++
>>   security/smack/smack_lsm.c        | 33 +++++++++++--------------
>>   6 files changed, 75 insertions(+), 37 deletions(-)
> 
> ...
> 
>> diff --git a/security/security.c b/security/security.c
>> index 5e93a72bdca6..aae37481b7be 100644
>> --- a/security/security.c
>> +++ b/security/security.c
>> @@ -227,6 +227,9 @@ static void __init lsm_set_blob_sizes(struct lsm_blob_sizes *needed)
>>   		blob_sizes.lbs_inode = sizeof(struct rcu_head);
>>   	lsm_set_blob_size(&needed->lbs_inode, &blob_sizes.lbs_inode);
>>   	lsm_set_blob_size(&needed->lbs_ipc, &blob_sizes.lbs_ipc);
>> +#ifdef CONFIG_KEYS
>> +	lsm_set_blob_size(&needed->lbs_key, &blob_sizes.lbs_key);
>> +#endif
> 
> Since the lsm_blob_sizes struct is going to have the lsb_key field
> regardless of CONFIG_KEYS (which is good, I'm not arguing that), we
> should be okay to call lsm_set_blob_size() on the lsb_key field, right?

yes

> 
>>   	lsm_set_blob_size(&needed->lbs_msg_msg, &blob_sizes.lbs_msg_msg);
>>   	lsm_set_blob_size(&needed->lbs_sock, &blob_sizes.lbs_sock);
>>   	lsm_set_blob_size(&needed->lbs_superblock, &blob_sizes.lbs_superblock);
>> @@ -402,6 +405,9 @@ static void __init ordered_lsm_init(void)
>>   	init_debug("file blob size       = %d\n", blob_sizes.lbs_file);
>>   	init_debug("inode blob size      = %d\n", blob_sizes.lbs_inode);
>>   	init_debug("ipc blob size        = %d\n", blob_sizes.lbs_ipc);
>> +#ifdef CONFIG_KEYS
>> +	init_debug("key blob size        = %d\n", blob_sizes.lbs_key);
>> +#endif /* CONFIG_KEYS */
> 
> This one makes sense.
> 
>> @@ -5301,7 +5337,8 @@ int security_key_alloc(struct key *key, const struct cred *cred,
>>    */
>>   void security_key_free(struct key *key)
>>   {
>> -	call_void_hook(key_free, key);
>> +	kfree(key->security);
>> +	key->security = NULL;
>>   }
> 
> A note to future devs, we can add the key_free hook back if needed, but
> currently nobody is using it beyond basic memory management.
> 
>>   /**
>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>> index 19346e1817ff..b3de2e941ef7 100644
>> --- a/security/selinux/hooks.c
>> +++ b/security/selinux/hooks.c
>> @@ -6981,6 +6968,9 @@ struct lsm_blob_sizes selinux_blob_sizes __ro_after_init = {
>>   	.lbs_file = sizeof(struct file_security_struct),
>>   	.lbs_inode = sizeof(struct inode_security_struct),
>>   	.lbs_ipc = sizeof(struct ipc_security_struct),
>> +#ifdef CONFIG_KEYS
>> +	.lbs_key = sizeof(struct key_security_struct),
>> +#endif /* CONFIG_KEYS */
> 
> We can probably get rid of the Kconfig conditional.  I understand the
> desire to keep this to only what is needed, but since this only really
> has an impact on boot, and the impact is some basic math, I'd rather
> not run the risk of rot due to conditional compilation.
> 

sure, the counter argument is why isn't this conditional when other parts
for keys is. That inconsistency introduces it own issues that can cause
problems down the road. I really don't have an opinion on which way
is better, just playing devils advocate.


>>   	.lbs_msg_msg = sizeof(struct msg_security_struct),
>>   	.lbs_sock = sizeof(struct sk_security_struct),
>>   	.lbs_superblock = sizeof(struct superblock_security_struct),
> 
> ...
> 
>> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
>> index a931b44bc959..17bcc9cbf584 100644
>> --- a/security/smack/smack_lsm.c
>> +++ b/security/smack/smack_lsm.c
>> @@ -5010,6 +5005,9 @@ struct lsm_blob_sizes smack_blob_sizes __ro_after_init = {
>>   	.lbs_file = sizeof(struct smack_known *),
>>   	.lbs_inode = sizeof(struct inode_smack),
>>   	.lbs_ipc = sizeof(struct smack_known *),
>> +#ifdef CONFIG_KEYS
>> +	.lbs_key = sizeof(struct smack_known *),
>> +#endif /* CONFIG_KEYS */
> 
> See above, but ultimately this is Smack code so it's your call.

I think we should be consistent, either it goes everywhere or it stays
everywhere. It is going to be confusing for other people coming in and
looking at the code as to why one is conditional and one isn't.

> 
>>   	.lbs_msg_msg = sizeof(struct smack_known *),
>>   	.lbs_sock = sizeof(struct socket_smack),
>>   	.lbs_superblock = sizeof(struct superblock_smack),
> 
> --
> paul-moore.com

