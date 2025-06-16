Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9FC29CB53
	for <linux-security-module@vger.kernel.org>; Mon, 16 Jun 2025 11:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750074327; cv=none; b=OqCfV2KYoA2/iqo6ZqGarF5IuHEsfO2hVs/r0w78xdRcUQih5PD/vghJXrmGbqdZNqN0Wwii4zbrJtXfiLXMkPwG1s2CZgJd2W6OFuHBqzlwyxSGVsFE2vdFs5Lz3+yuZu5iDSDSoXm9N/fSLg0Ib9Ul2Pa5rBP+7KbQ9eLR+sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750074327; c=relaxed/simple;
	bh=a2VgYobm3AQ4gy0NX8CEq/p4Ronu1rDDnhx+Xu6Sf1o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VuPYF3GBZy1iA88TriYYN+TzFEXH8uKiyQVG17dCS7ici7nN1IcygJZSXtPv7VqpX0FxmtozOxRoGLfhqj0uqqAEQ7oTQwJWortRBAy2I+pq3NePyRXW1E9W2ogZkmxdr3ZxcNP4KUNMwEkJSFg/bmI4KteevYKcRqjnC0ifSCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=tmxBikfl; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="tmxBikfl"
Message-ID: <df5f6bdd-b7f7-47df-8fc7-a5aa32e2f92a@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1750074321;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XdkRjk75rtk108YCQu0fZ+cHoyiN2kIOBxzLwLZmEiA=;
	b=tmxBikfljtqBr7H9QTnmAVJllC5UuTAW7jI4oNW8A5ghA+J23Em3VaLtHI5ePko9BAltz6
	hrjagODvFtX/NYZuQNt9fJK3dOIxAmMnCRPRjjhv/VAOvi1uadTcKAKkNRKE6oIwH25KKw
	t/1FYoPDlVUaRHYCUSTcc71lw4Xv4gY=
Date: Mon, 16 Jun 2025 14:46:18 +0300
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re[2]: [PATCH 5/5] smack: fix bug: invalid label of unix socket file
Content-Language: en-US
To: Roberto Sassu <roberto.sassu@huaweicloud.com>,
 Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-security-module@vger.kernel.org
References: <20250616010745.800386-1-andreev@swemel.ru>
 <20250616010745.800386-6-andreev@swemel.ru>
 <147eb5a5c06ed28eec9cf33a877cfb200e9a6103.camel@huaweicloud.com>
From: Konstantin Andreev <andreev@swemel.ru>
In-Reply-To: <147eb5a5c06ed28eec9cf33a877cfb200e9a6103.camel@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Jun 2025 11:45:20.0656 (UTC) FILETIME=[23606100:01DBDEB4]

Roberto Sassu, 16 Jun 2025 11:05:11 +0200:
> On Mon, 2025-06-16 at 04:07 +0300, Konstantin Andreev wrote:
>> According to [1], the label of a UNIX domain socket (UDS)
>>
>> [irrelevant portion of the message deleted]
>>
>> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
>> index fb23254c8a54..1b41ae053966 100644
>> --- a/security/smack/smack_lsm.c
>> +++ b/security/smack/smack_lsm.c
>> @@ -1021,6 +1021,16 @@ static int smack_inode_init_security(struct inode *inode, struct inode *dir,
>>   	bool trans_cred;
>>   	bool trans_rule;
>>   
>> +	/*
>> +	 * UNIX domain sockets use lower level socket data. Let
>> +	 * UDS inode have fixed * label to keep smack_inode_permission() calm
>> +	 * when called from unix_find_bsd()
>> +	 */
>> +	if (S_ISSOCK(inode->i_mode)) {
>> +		/* forced label, no need to save to xattrs */
>> +		issp->smk_inode = &smack_known_star;
>> +		goto instant_inode;
> 
> Maybe you could also set SMK_INODE_INSTANT here and just return.

Certainly.

But I personally avoid duplication even of small cleanups
and avoid multiple returns at the price of few gotos.

A matter of style. Either way is fine for me.
Let Casey decide.

Konstantin

[the rest of the message deleted]
