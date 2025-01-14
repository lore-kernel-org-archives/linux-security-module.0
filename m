Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AB6284A44
	for <linux-security-module@vger.kernel.org>; Tue, 14 Jan 2025 10:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736849759; cv=none; b=mos5Wo/wYajT9jOtFNyzJFeeRTM+ipg9aI2CGAG2fDPGhtZGCB7r2KpDmlXieWPTzKiUYIZfaI65DPyOoYP4FHp7c3Ry2xKD8nGRzUaVLcmVvHpYLvLuwSslSUMs4UM63TNZeqv/zAwXPA5//tXm8rPK7JSHBJldUJsJelNp4kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736849759; c=relaxed/simple;
	bh=bBtKwBJJF3kIGA+W0zafJ3YIrB+JswL1Emy/I54xEGI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=sbAxjCMZU4/tWphNJ7eAghc79iXerWC3avF9O7L/Z2CYjU03gtgFmGiQwvWMrIZUpgiTlWyOjZ+W4Y9S9QYQ9DYdXFYtFroskX4wtXAB2tVRRuN44JmPGaDl0kS5aMQy8c5fmEOcAhtJWiyaSrYRSGAT+AQnjk+SDCfiAY+nvj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=X6ug2YME; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="X6ug2YME"
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1736849740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bBtKwBJJF3kIGA+W0zafJ3YIrB+JswL1Emy/I54xEGI=;
	b=X6ug2YMEjtmZVcDUjqVbzuREDnaiepfgWWuyZmyyC7S3sDZbeMCJVbAm8tUnsa+YbKPEIV
	2gnbVc6ycBj1X8G5C7HFBGEk+BN0X8SMTNcMdBxnUm6qBmCCtt3xtyc+D4LO17MNZdSKRK
	nf7GdJoylD13jHycnXbuboYFQ9T3sRE=
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: Re: [RESEND PATCH] apparmor: Use str_yes_no() helper function
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <d93ed7bb-b184-4153-8084-b693eb1e2b85@canonical.com>
Date: Tue, 14 Jan 2025 11:15:27 +0100
Cc: Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>,
 apparmor@lists.ubuntu.com,
 linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <1C3FAFB6-14DB-4E2D-8310-06022B2BB20A@linux.dev>
References: <20241220192243.1856-1-thorsten.blum@linux.dev>
 <d93ed7bb-b184-4153-8084-b693eb1e2b85@canonical.com>
To: John Johansen <john.johansen@canonical.com>
X-Migadu-Flow: FLOW_OUT

On 20. Dec 2024, at 21:19, John Johansen wrote:
> On 12/20/24 11:22, Thorsten Blum wrote:
>> Remove hard-coded strings by using the str_yes_no() helper function.
>> Fix a typo in a comment: s/unpritable/unprintable/
>> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
>=20
> Hey Thorsten,
>=20
> sorry for the delay on this I am just really backlogged and will try =
to catch-up
> on the mailing list traffic this weekend.
>=20
> Acked-by: John Johansen <john.johansen@canonical.com>
>=20
> I have pulled this into my tree and it should migrate into linux-next =
soon

Hi John, I can't find this in linux-next yet. Any ideas?

Thanks,
Thorsten=
