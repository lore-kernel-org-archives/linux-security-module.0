Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD282877C3
	for <linux-security-module@vger.kernel.org>; Mon, 16 Jun 2025 17:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750096338; cv=none; b=A6sRODqLM6t8tx7GJJBVLfdWp6JQxhPh1u0YmQ8hFned29oqB6gW+/K92XV5Ymkj2D9GV6IhJb69TXDzjuUgqkgL7DrC1+TB7nvBH7B2/YZTOOkT3ZtTqqgS2yoKRqVDu/9Ono7vB7A7d6+NWDUQbHG157RrOSfQco9lCCZ+fgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750096338; c=relaxed/simple;
	bh=jqeKvSwlEsQUwPl7wMTohyGo9bLBOQH6YwfI6h54+w4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a3xFG875c512TiiTmdEYM+TS3ktNXXRpc3TNNhy7BWSO0Dis1XDZXTdoPJlpXlQCKQEPmBOXAyD5m2lWB89cBuy1A0bdxHMDKKotNdCcPB3je3kfxNq90rDDI7iS0h0bnxghu62bQpfeJGHrNMRRNj1f6Dyrizs5G9lt6S3uL0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=VnANErBR; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="VnANErBR"
Message-ID: <8e6b065b-8c98-4977-8c7d-f335c16e99f7@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1750096330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OBIW8NQ56uFhK3CJarW/p/JpDvLcpIQHQ6Nc069W/oI=;
	b=VnANErBRTWVTtc80benFW4rWiSLhGGgIXkWiGQWAqPdJGBk/TYAYMjz6w3+KuoOqqzBH0J
	BqFVi/CDNz7eNoRrskv6SbjG9zte/ynTcuwjvbl7Su1uVDeHLRSHmT+41Xl+vceixHvkiw
	cpDgpJ6fxvrj8PgUsdcAFo9acEvrMW0=
Date: Mon, 16 Jun 2025 20:53:07 +0300
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re[4]: [PATCH 5/5] smack: fix bug: invalid label of unix socket file
Content-Language: en-US
To: Casey Schaufler <casey@schaufler-ca.com>,
 Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: linux-security-module@vger.kernel.org
References: <20250616010745.800386-1-andreev@swemel.ru>
 <20250616010745.800386-6-andreev@swemel.ru>
 <147eb5a5c06ed28eec9cf33a877cfb200e9a6103.camel@huaweicloud.com>
 <df5f6bdd-b7f7-47df-8fc7-a5aa32e2f92a@swemel.ru>
 <38c13fcb-2ed5-4b17-850e-b57562321683@schaufler-ca.com>
From: Konstantin Andreev <andreev@swemel.ru>
In-Reply-To: <38c13fcb-2ed5-4b17-850e-b57562321683@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 16 Jun 2025 17:52:10.0218 (UTC) FILETIME=[621904A0:01DBDEE7]

Casey Schaufler, 16 Jun 2025 10:11:55 -0700:
> On 6/16/2025 4:46 AM, Konstantin Andreev wrote:
>> Roberto Sassu, 16 Jun 2025 11:05:11 +0200:
>>> On Mon, 2025-06-16 at 04:07 +0300, Konstantin Andreev wrote:
>>>>
>>>> [irrelevant portion of the message deleted]
>>>>
>>>> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
>>>> index fb23254c8a54..1b41ae053966 100644
>>>> --- a/security/smack/smack_lsm.c
>>>> +++ b/security/smack/smack_lsm.c
>>>> @@ -1021,6 +1021,16 @@ static int smack_inode_init_security(struct
>>>> inode *inode, struct inode *dir,
>>>>        bool trans_cred;
>>>>        bool trans_rule;
>>>>    +    /*
>>>> +     * UNIX domain sockets use lower level socket data. Let
>>>> +     * UDS inode have fixed * label to keep smack_inode_permission() calm
>>>> +     * when called from unix_find_bsd()
>>>> +     */
>>>> +    if (S_ISSOCK(inode->i_mode)) {
>>>> +        /* forced label, no need to save to xattrs */
>>>> +        issp->smk_inode = &smack_known_star;
>>>> +        goto instant_inode;
>>>
>>> Maybe you could also set SMK_INODE_INSTANT here and just return.
>>
>> Certainly.
>>
>> But I personally avoid duplication even of small cleanups
>> and avoid multiple returns at the price of few gotos.
> 
> I generally prefer
> 
> 	if (xyzzy)
> 		return -ESOMETHING;
> 
> to
> 
> 	if (xyzzy)
> 		goto err_out;
> 	...
> err_out:
> 	return -ESOMETHING;
> 
> I grew up in the era of "gotos considered harmful". When
> err_out does more than just return a goto is fine, but a goto
> that has nothing but a return is unnecessary and adds code that
> needn't be there.

Got it. There is one line more than just return here:

| instant_inode:
|	issp->smk_flags |= (SMK_INODE_INSTANT | transflag);
|	return rc;
| }

What would you prefer in this case, leave it at that or convert to

| if (S_ISSOCK(inode->i_mode)) {
|    /* forced label, no need to save to xattrs */
|    issp->smk_inode = &smack_known_star;
|    // goto instant_inode; // <<<< to be removed
|    issp->smk_flags |= SMK_INODE_INSTANT;
|    return 0;
| }


[the rest of the message deleted]
