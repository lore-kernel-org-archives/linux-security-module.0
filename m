Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E20632FA2F
	for <linux-security-module@vger.kernel.org>; Wed, 19 Nov 2025 14:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763563512; cv=none; b=AW6nQSbDiHBNhYgsjADMlbktpYm4EVe7Nri16jW69b3L/8B58wdK+KpGvsNw4DG1qZ4mKjI2SnOUKpYgV2wjPyLYjC/yFC6Ibr2icq/aKtGwqKrnyfzV6ecdFS8KQ0dustPRgGMVoBwepH5kFj+sISr0YriRE5uUFpFHLc3BmsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763563512; c=relaxed/simple;
	bh=lrb00y6uGsIWW3VAlnHGMzLSI26EzNLA1W/wtqFFvm8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=hkwRD6mnM54DSHhXUY++kOFcz3pQZoHt6P1MDEGWbZUhK16az+X+WSCmQEEfihZLyMD7en4f5pG4pOK9cPWVMLeM5kSfP8XC/68BNMjAmcOGZLtu3xrifVa4Isw9+EoDGHO4XTFARqOsH54RkHj82xZ3OaJpEAGOdXgqLacOJ6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZPBb6PBl; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZPBb6PBl"
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763563508;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O5eB5R3KhKTh4SL2bkwwFe1+9RO/J8AQ627rC4N+gXI=;
	b=ZPBb6PBlRfqf5p3bWOpqovbaULqqILB2bZwUS2TiXMYP9quvbSq6YuHmtTiWTm7pV2vB0A
	BvcihvMRamdevjrS91WHWEg0BCpGiexn7Vx+0AR6ftQsfcTBgkOzVgj1XX7rvcgyRsWGUU
	1mPa0CqFYNpq9rp0yUktUNa1VWwlzYY=
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH] KEYS: encrypted: Use pr_fmt()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <aR0v9mLOKJsr_0Zm@kernel.org>
Date: Wed, 19 Nov 2025 15:45:02 +0100
Cc: Mimi Zohar <zohar@linux.ibm.com>,
 David Howells <dhowells@redhat.com>,
 Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>,
 linux-integrity@vger.kernel.org,
 keyrings@vger.kernel.org,
 linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <83C83079-0354-4642-A980-DBC7AE572A53@linux.dev>
References: <20251113123544.11287-2-thorsten.blum@linux.dev>
 <aR0v9mLOKJsr_0Zm@kernel.org>
To: Jarkko Sakkinen <jarkko@kernel.org>
X-Migadu-Flow: FLOW_OUT

On 19. Nov 2025, at 03:48, Jarkko Sakkinen wrote:
> On Thu, Nov 13, 2025 at 01:35:44PM +0100, Thorsten Blum wrote:
>> Use pr_fmt() to automatically prefix all pr_<level>() log messages =
with
>=20
> This fails to describe what "use" means.

I don't understand what you mean. What's wrong with "use ... to ..."?

>> "encrypted_key: " and remove all manually added prefixes.
>>=20
>> Reformat the code accordingly and avoid line breaks in log messages.
>>=20
>> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
>> ---
>> security/keys/encrypted-keys/encrypted.c | 74 =
+++++++++++-------------
>> security/keys/encrypted-keys/encrypted.h |  2 +-
>> 2 files changed, 35 insertions(+), 41 deletions(-)
>>=20
>> diff --git a/security/keys/encrypted-keys/encrypted.c =
b/security/keys/encrypted-keys/encrypted.c
>> index 513c09e2b01c..a8e8bf949b4b 100644
>> --- a/security/keys/encrypted-keys/encrypted.c
>> +++ b/security/keys/encrypted-keys/encrypted.c
>> @@ -11,6 +11,8 @@
>>  * See Documentation/security/keys/trusted-encrypted.rst
>>  */
>>=20
>=20
> Should have undef prepending.

Why is this necessary when the #define is at the top of a source file?
The kernel documentation [1] doesn't mention this anywhere. Isn't #undef
only needed when redefining 'pr_fmt' in the middle of a file to avoid a
compiler warning/error?

>> +#define pr_fmt(fmt) "encrypted_key: " fmt
>> +
>> [...]

Thanks,
Thorsten

[1] https://docs.kernel.org/core-api/printk-basics.html

