Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434AF2EB5C2
	for <linux-security-module@vger.kernel.org>; Mon, 16 Jun 2025 11:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750073078; cv=none; b=SLNASV/vGmY+8IDybtVJnjiGd21Wkuf/1p0Da63jp6lmv3/YwuMLW9s6Hkqn95TpI6BdCgocwHgy40cun5ieJi40r/lSE/0Eaz2I45AMFO/2AihGYWYPezBvrPRmfAUSy1229FAhtjoZuiQY36M2gzpW5HR8ujVktWfkeK3ri7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750073078; c=relaxed/simple;
	bh=B7wsTto2FyDh4IvPPOOCovbmTz+p4WzVPHb9FzTZ+uc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tpjxaj9UOoBoAMFQ/edZChNBEVEleXQhCGmD/0ScPHaXeTsA/b/zzR3546f9fEKlVWmUrcbBtEQm6VymSJqYa1G1ftvhoMusJI+GuMSdOOeFWdL69V23xFN8cMR+XrOT2au+ZUlP9EKV71TY4O817/YgQ0IoLSNBh1QRowLNXj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=gZlJdMaD; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="gZlJdMaD"
Message-ID: <a268bbe8-3e12-4093-8d83-fb5111605322@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1750073070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RRiHBQSq/1DKKumGKq8y2IZMal4iyXILxnNW32Zvik0=;
	b=gZlJdMaDxqI3XssuqmnTOO2jvoAmxehwfU9trH5joH2Htu4VJBLBtrVb0tvHpuALZx/5dw
	xMjRSmlyeFxQnJxp8umetDutTidQi1KUFJT27COs84vDlyAgTQZQr3MANof6SKCEKkFVIf
	jtQ5k02emBWqL9honZbwTmYdZs8hjAM=
Date: Mon, 16 Jun 2025 14:25:27 +0300
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re[2]: [PATCH 2/5] smack: fix bug: SMACK64TRANSMUTE set on
 non-directory
Content-Language: en-US
To: Roberto Sassu <roberto.sassu@huaweicloud.com>,
 Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-security-module@vger.kernel.org
References: <20250616010745.800386-1-andreev@swemel.ru>
 <20250616010745.800386-3-andreev@swemel.ru>
 <c9d0b5e758a3dcf7e5aed7ca597ecec02c72dc52.camel@huaweicloud.com>
From: Konstantin Andreev <andreev@swemel.ru>
In-Reply-To: <c9d0b5e758a3dcf7e5aed7ca597ecec02c72dc52.camel@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 16 Jun 2025 11:24:29.0336 (UTC) FILETIME=[39881980:01DBDEB1]

Roberto Sassu, 16 Jun 2025 10:42:16 +0200:
> On Mon, 2025-06-16 at 04:07 +0300, Konstantin Andreev wrote:
>> When a new file system object is created
>> and the conditions for label transmutation are met,
>> the SMACK64TRANSMUTE extended attribute is set
>> on the object regardless of its type:
>> file, pipe, socket, symlink, or directory.
>>
>> However,
>> SMACK64TRANSMUTE may only be set on directories.
>>
>> This bug is a combined effect of the commits [1] and [2]
>> which both transfer functionality
>> from smack_d_instantiate() to smack_inode_init_security(),
>> but only in part.
>>
>> Commit [1] set blank  SMACK64TRANSMUTE on improper object types.
> 
> Hi Konstantin
> 
> I didn't see where, can you point where it is done?

Hi, Roberto.

I didnt investigate this thoroughly, but, I guess,
this proceeds like:

1) smack_inode_init_security() indeed sets "TRUE"
    for SMACK64TRANSMUTE in xattr for inode of any type.

2) smack_d_instantiate() then “confirms” "TRUE"
    only for directories.

At the moment of [1] both smack_inode_init_security()
and smack_d_instantiate() had the responsibility for
initialization of the inode Smack security.

So, user-visible SMACK64TRANSMUTE exists, but blank,
while on-disk xattr still "TRUE".

After [2] smack_d_instantiate() no longer participates
in the initialization of new filesystem objects,
so user-visible SMACK64TRANSMUTE became "TRUE".

You can check the user-visible effect
by building the kernel of version [1].

Konstantin.

>> Commit [2] set "TRUE" SMACK64TRANSMUTE on improper object types.
>>
>> [1] 2023-06-10,
>> Fixes: baed456a6a2f ("smack: Set the SMACK64TRANSMUTE xattr in smack_inode_init_security()")
>> Link: https://lore.kernel.org/linux-security-module/20230610075738.3273764-3-roberto.sassu@huaweicloud.com/
>>
>> [2] 2023-11-16,
>> Fixes: e63d86b8b764 ("smack: Initialize the in-memory inode in smack_inode_init_security()")
>> Link: https://lore.kernel.org/linux-security-module/20231116090125.187209-5-roberto.sassu@huaweicloud.com/
>>
>> Signed-off-by: Konstantin Andreev <andreev@swemel.ru>
>> ---
>>   security/smack/smack_lsm.c | 24 +++++++++++++-----------
>>   1 file changed, 13 insertions(+), 11 deletions(-)
>>
>> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
>> index a7292d286f7c..2d3186e50c62 100644
>> --- a/security/smack/smack_lsm.c
>> +++ b/security/smack/smack_lsm.c
>> @@ -1028,18 +1028,20 @@ static int smack_inode_init_security(struct inode *inode, struct inode *dir,
>>   		if (!trans_cred)
>>   			issp->smk_inode = dsp;
>>   
>> -		issp->smk_flags |= SMK_INODE_TRANSMUTE;
>> -		xattr_transmute = lsm_get_xattr_slot(xattrs,
>> -						     xattr_count);
>> -		if (xattr_transmute) {
>> -			xattr_transmute->value = kmemdup(TRANS_TRUE,
>> -							 TRANS_TRUE_SIZE,
>> -							 GFP_NOFS);
>> -			if (!xattr_transmute->value)
>> -				return -ENOMEM;
> 
> To avoid having another indentation, you could also set xattr_transmute
> to NULL initially, and call lsm_get_xattr_slot() only for directories.
> Setting SMK_INODE_TRANSMUTE in issp->smk_flags should be done of course
> if xattr_transmute != NULL.
> 
> Either way is fine for me.
> 
> Roberto
> 
>> +		if (S_ISDIR(inode->i_mode)) {
>> +			issp->smk_flags |= SMK_INODE_TRANSMUTE;
>> +			xattr_transmute = lsm_get_xattr_slot(xattrs,
>> +							     xattr_count);
>> +			if (xattr_transmute) {
>> +				xattr_transmute->value = kmemdup(TRANS_TRUE,
>> +								 TRANS_TRUE_SIZE,
>> +								 GFP_NOFS);
>> +				if (!xattr_transmute->value)
>> +					return -ENOMEM;
>>   
>> -			xattr_transmute->value_len = TRANS_TRUE_SIZE;
>> -			xattr_transmute->name = XATTR_SMACK_TRANSMUTE;
>> +				xattr_transmute->value_len = TRANS_TRUE_SIZE;
>> +				xattr_transmute->name = XATTR_SMACK_TRANSMUTE;
>> +			}
>>   		}
>>   	}
