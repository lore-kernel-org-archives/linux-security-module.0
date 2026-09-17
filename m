Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9163D9522;
	Thu, 17 Sep 2026 07:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789628962; cv=none; b=L9AzVq7linUh4+MHVh3A/dQVzES+3Z6tIezlyamrhlrwYsCqLqWPXwocfz9UYBvAx59jWjVguVmoaiMkq9Ed55rGmPWxOZF/l5/oXFpe2uh1zAh5sbqeGFVtrzgCNUrMvFNLuCTEcxjHCR0R4n/tSqNXfK+WVt3nJf6rseJ6RdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789628962; c=relaxed/simple;
	bh=YuFr3g55RjF1JuBuvkUfi/7kTrg/Re+Ath2LMU1l5wY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JQU8i2+Gq1L5U+5VBNzkyuk1cLcIIwHFjVO2+oAjrKb1KuS2tCIjBonGPbUjS0xAByHEQ1i6169827rEwwqcLuG6r4wDuVT+YRDopXtnTQAuGpNoadQjLTNx2jcfNGhBHpQWvNg0R4NRFRWIPOpAUDVcP60BNXaMcQVLV1btflU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=H2RDGXvW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BQ5fVFDL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="H2RDGXvW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BQ5fVFDL"
Date: Thu, 17 Sep 2026 09:09:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1789628956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KmoOzql2YcauqS8+uEcaOyn1yIVt4dhXoiJnVQB4CBE=;
	b=H2RDGXvWp5ZR8Kv7Kll024zrS1vLQtR9T2wHHVEt1KO7GXS+Y/ILx99js5akok26KPvU9N
	L3M/643gT40YINkz2357VxQxMAA820LvZnJvaIuqFKFg6fU9rnYCNNudeqNF/8z5n/tUs2
	0yUDwHNudIcbVMPmcKti5cf2b812il81caPfKWPvvZL+uif3dYJO47XaSahtOozvmjsLso
	E8Gp2ZW7FI9FaKJbur2S1JUPjs0j+G4QRRyKbBv++guP+/TXudovKvLkLV6JSc41ju9R87
	W4jk58PY9ikGkVbszDMQhKVsrWl/9QytjEqy1TEJgkPuDJDt20IM5+uXqFz3zg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1789628956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KmoOzql2YcauqS8+uEcaOyn1yIVt4dhXoiJnVQB4CBE=;
	b=BQ5fVFDLX+010Mc6g7BilKvn5pVN5LpzycbqU230561+0xxV+zxhcbmIzVbrsreAamY5ml
	5XviFc2fNj5xN6AQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
	Arnd Bergmann <arnd@kernel.org>, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, Tingmao Wang <m@maowtm.org>,
	Justin Suess <utilityemal77@gmail.com>,
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] landlock: work around gcc-16 -Wuninitialized warning
Message-ID: <20260917070915.Ix8TOn5Y@linutronix.de>
References: <20260915201036.3527935-1-arnd@kernel.org>
 <20260916084947.6QDy8KZQ@linutronix.de>
 <20260916.shai0tha3IPa@digikod.net>
 <57b5869d-7411-46e8-ade6-6d2a7fea02ac@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <57b5869d-7411-46e8-ade6-6d2a7fea02ac@app.fastmail.com>

On 2026-09-16 23:06:30 [+0200], Arnd Bergmann wrote:
> As far as I can tell, 16.2 is still affected, even though it should be
> fixed in HEAD. gcc-16.3 won't be released until spring 2027 though.
> 
> It is possible that there are additional configuration options that
> have to be set just right to reproduce the issue. I've attached a
> configuration that triggered it for me this week.

This is from v7.2. I tried this and v7.3-rc3 and did not notice a
warning (other than unrelated stack size from drm). I did notice:

-CONFIG_CC_VERSION_TEXT="x86_64-linux-gcc (GCC) 16.2.0"
+CONFIG_CC_VERSION_TEXT="gcc (Debian 16.2.0-2) 16.2.0"
 CONFIG_GCC_VERSION=160200
-CONFIG_AS_VERSION=20285426
+CONFIG_AS_VERSION=24700
-CONFIG_LD_VERSION=20285426
+CONFIG_LD_VERSION=24700
+CONFIG_CC_HAS_MARCH_NATIVE=y

which might be the culprit. There were other things, too, so the
oldconfig was not clean (such as missing CONFIG_VIRTUALIZATION).

>       Arnd

Sebastian
