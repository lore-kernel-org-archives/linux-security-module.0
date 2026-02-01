Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728061A254E
	for <linux-security-module@vger.kernel.org>; Sun,  1 Feb 2026 12:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769949800; cv=none; b=VoKl+ZxnecqGk7Hrl41wAneGqoR3eXkYHbBu92wTLQF/LnuoBEoOS4XrV5BzYm+UGZSGyPfhHnbyBGH/emMpO2fgHoOnuKX/TjnujwV2evkiS6lA6IRr1gLS6VBOrXhOAlKRNyjxS6z7LGxTBnMv2c8Qp3r2XBYKM809B/I88Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769949800; c=relaxed/simple;
	bh=DEED9yQtfpdNRVmSaNT+YpQV2CnxoyGCw9nYGy71MYQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=anqxsaJYgnblgdWRw8XgktGEcTyE3KLLux8wQWZA776nUIdqPkf3xgjqKJ9Uc8/a6LTsSe8IFQYm2ew6Zy94dmOn2NSl0ZgPn6YDXmfn6bDKEn+M3kFrvtA/MqKrXPwJinObbN7kxjk0km3HrPd97yvP85xPI+2a7nSdndZ1tdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bRn0ebCK; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bRn0ebCK"
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769949795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KQaIAksFy4OyCwreX2pg+p3duXVHh4+gN2s7Z4WqeOE=;
	b=bRn0ebCKt0d5YZFY/Spdk6+eTufZDcvFu1vam7J1ja1E9vAW38Q5qR/fmidkqnpDMzFQRM
	kSgewOtbczolDHFSFsgW4t/P9w3pN6S6aY63nlHVjYRvirTivAK0+vQb8upKK77awaPRJp
	z+hLNsYL1GNIPr8WBBDisuReGEG0Ceo=
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: Re: [PATCH RESEND] apparmor: Replace deprecated strcpy with memcpy in
 gen_symlink_name
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <D73FFEAA-F246-4777-8CA8-32807F378423@linux.dev>
Date: Sun, 1 Feb 2026 13:42:40 +0100
Cc: Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>,
 apparmor@lists.ubuntu.com,
 linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <3CA1F386-2217-405B-AB6E-85195AD09CA8@linux.dev>
References: <20251126165701.97158-2-thorsten.blum@linux.dev>
 <1da23c89-dc2c-41cb-8260-098deb8ae917@canonical.com>
 <D73FFEAA-F246-4777-8CA8-32807F378423@linux.dev>
To: John Johansen <john.johansen@canonical.com>
X-Migadu-Flow: FLOW_OUT

Hi John,

On 27. Nov 2025, at 11:18, Thorsten Blum wrote:
> On 27. Nov 2025, at 02:32, John Johansen wrote:
>> hey Thorsten,
>> 
>> sorry I have actually pulled these in, and tested them. I didn't send out
>> the acks yet because I have another patch that I was waiting on a proper
>> signed-off-by: on.
>> 
>> I am going to have to pull that one so I can push. I'll add acks now but
>> the push isn't going to happen for a few hours.
>> 
>> Acked-by: John Johansen <john.johansen@canonical.com>
> 
> Ah sorry for resending then, didn't know you looked at them already.

Did you ever push the commits? I can't find them anywhere.

Thanks,
Thorsten

