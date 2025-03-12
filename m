Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E51C19882B
	for <linux-security-module@vger.kernel.org>; Wed, 12 Mar 2025 09:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741771788; cv=none; b=CIqcxSEA80xtCvRNbmherPjgU9WkxK5XJ6WjDxgbZx4+kGwt2AEhBGZ0JB6HlMZ94ED064fUc3TbWt3xDUo2rdlmuL9FX/Ua7/hrriWK9+pXrou5iW92Av7Jq/AFjH/9v637cCok0jEJwdEfDkhWR4sjrsgMyVh2XwYyob2ZsTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741771788; c=relaxed/simple;
	bh=/F99078QzUb/9ZkV2xO2yCESwz4vZpNRfqL+CG68/JE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=aKJuLD+hQj323dLulKVlFdeh/lnk3nLEltfaA1BRdTVrAL0uQUakpEK6gZpc4tYpbQL3XS3h7Tsx65uGyjpbKFH+UPgNFA74o+VQMtBWwWplHEUW6RsW5zgmYcuOWVaX80gnnpWHQgtaPinMsnPENd/on8tHVVl4jcd8OQUOssc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=KkS83Mls; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="KkS83Mls"
Message-ID: <593b1df7-062b-4751-a8b8-6e83f7091987@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1741771774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=91PMXOvc+YtH1ss0CjNh7mZVzGPku+rEamTsRicXFUc=;
	b=KkS83MlsVDDPEbUOTsxeaM/sjRyPLlxsrFmieu6hpAPc1dbJhQ/psglNaSBWPB3KJRoHUA
	jc1Adu08DSjPTQ7nNMN/nQrkjAZUI2EetEP1f/vYmTKek9DO9oQIHgQif2ZcWMB+wRYmPH
	hxfsVKxvT1cLlxgUlHKsN0Hbk6Ua2+U=
Date: Wed, 12 Mar 2025 12:30:29 +0300
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re[6]: [PATCH 0/2] smack: fix two bugs in setting task label
To: Casey Schaufler <casey@schaufler-ca.com>
References: <20250306224317.416365-1-andreev@swemel.ru>
 <b3b4585b-c9f3-4c87-9a9b-bc4137ecea47@schaufler-ca.com>
Content-Language: en-US
From: Konstantin Andreev <andreev@swemel.ru>
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <b3b4585b-c9f3-4c87-9a9b-bc4137ecea47@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Mar 2025 09:29:34.0030 (UTC) FILETIME=[43F3E6E0:01DB9331]

Casey Schaufler, 11/03/2025:
> On 3/6/2025 2:43 PM, Konstantin Andreev wrote:
>> These two patches have distinct subjects,
>> but work on the same object,
>>    security/smack/smack_lsm.c`do_setattr()
>> and the second patch partially overwrites first,
>> so I combine them in a series.
>>
>> Konstantin Andreev (2):
>>    smack: fix bug: unprivileged task can create labels
>>    smack: fix bug: setting task label silently ignores input garbage
> 
> There is a problem with this change. Some applications include a
> trailing '\0' when writing to /proc/self/attr/smack/current, which
> fails with this change. It may not be "correct", but it is expected.

Understood. Given this, for any "label"
three input variants should be accepted:

   "label"    (5 bytes)
   "label\0"  (6 bytes)
   "label\n"  (6 bytes)

but not

   "label\0\n"
   "label\n\0"
   etc...

right?

Thank you for paying attention.

--
Konstantin Andreev
