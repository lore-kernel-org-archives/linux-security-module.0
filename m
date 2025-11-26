Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E990D2FF660;
	Wed, 26 Nov 2025 14:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764166946; cv=none; b=c2aJKDeENzJCM58Oz2ZDQeJAS5PPLiZu2FCmgPwDxWqtGJ237436dcLmmFeXJW/OBG4fCxDjndX6uQj8rNIOwBrdJmSDnHv+pNHmaSxVp0otTJwbdD0gXih2VSTfm+24kEa+bd/00dkHWI7tyL4pkx7CVwZvvL+mzFC7VUvUFm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764166946; c=relaxed/simple;
	bh=z5FIxDXllboetR03RwbxcPzxZiO6lryG6EVe9V1+Ceo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YiY2B1PoyUYZR2fScPj9LBDPp2Noe6MNrA7rAZ9bnUFCJFTQ0i+VMWpQJWoCySxsFD3rnYFARwCQif3iqwpher+4RLPZTVXS0HHro68+dddfbDv1yEHAKqWzHShRAZ4Q2cQLYGSUAevX6VlQzIZ6Ihh3bOAu2Fv535gEiQPFS+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=runbox.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=RwQJfWTl; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=runbox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="RwQJfWTl"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight@runbox.com>)
	id 1vOGPU-009Woy-88; Wed, 26 Nov 2025 15:22:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date;
	bh=YwKsPVfX1KHUuq2yYyN+2sXinjTSQFZoVSP6b1bZh1s=; b=RwQJfWTlxSa4ByUNV2dybXnp4b
	52BSyPx2+lJ4/f1gtrOguQ14dgJs7VPHJ80abnw0+peZLzNPW1xQz/hDAwArxBHC3FNE40ZNL0vAG
	zEwDAmJBLCODPOxjec4QRRqhp9v7Dir5bqW85nPzxvTk//dJOrJGFAlaQpyCIvYEU3arJBqWN8pQ5
	vYcxmWKVj4PbLR47TIwDRkJxSiet6mlYZQnTZ0E3C8Qp0INvHmVdIqR0NY44UQxU40+eJkvdySs+y
	7ZQwSruUIhGUfKZblj4Xy7HWIZ6AVVRZ3AuArXRbWDHVMMrbJpQxm0Xw/csH+oBhSpqYYLbyoYTD2
	cSfRzW4Q==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight@runbox.com>)
	id 1vOGPT-0001SZ-GA; Wed, 26 Nov 2025 15:22:19 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vOGPD-00DeWx-Gw; Wed, 26 Nov 2025 15:22:03 +0100
Date: Wed, 26 Nov 2025 14:22:01 +0000
From: david laight <david.laight@runbox.com>
To: Helge Deller <deller@gmx.de>
Cc: John Johansen <john.johansen@canonical.com>, Helge Deller
 <deller@kernel.org>, John Paul Adrian Glaubitz
 <glaubitz@physik.fu-berlin.de>, linux-kernel@vger.kernel.org,
 apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
 linux-parisc@vger.kernel.org
Subject: Re: [PATCH 0/2] apparmor unaligned memory fixes
Message-ID: <20251126142201.27e23076@pumpkin>
In-Reply-To: <4034ad19-8e09-440c-a042-a66a488c048b@gmx.de>
References: <20250531150822.135803-1-deller@kernel.org>
	<bc21bee14ca44077ae9323bfc251ad12390fa841.camel@physik.fu-berlin.de>
	<aRxT78fdN5v2Ajyl@p100>
	<90513f85cc8d060ebccd3972cc7709e4b6f13f34.camel@physik.fu-berlin.de>
	<be9c143d-1d5e-4c5b-9078-4a7804489258@gmx.de>
	<ba3d5651-fa68-4bb5-84aa-35576044e7b0@canonical.com>
	<aSXHCyH_rS-c5BgP@p100>
	<e88c32c2-fb18-4f3e-9ec2-a749695aaf0a@canonical.com>
	<c192140a-0575-41e9-8895-6c8257ce4682@gmx.de>
	<d35010b3-7d07-488c-b5a4-a13380d0ef7c@canonical.com>
	<20251126104444.29002552@pumpkin>
	<4034ad19-8e09-440c-a042-a66a488c048b@gmx.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Nov 2025 12:03:03 +0100
Helge Deller <deller@gmx.de> wrote:

> On 11/26/25 11:44, david laight wrote:
...   
> >> diff --git a/security/apparmor/match.c b/security/apparmor/match.c
> >> index 26e82ba879d44..3dcc342337aca 100644
> >> --- a/security/apparmor/match.c
> >> +++ b/security/apparmor/match.c
> >> @@ -71,10 +71,10 @@ static struct table_header *unpack_table(char *blob, size_t bsize)
> >>    				     u8, u8, byte_to_byte);  
> > 
> > Is that that just memcpy() ?  
> 
> No, it's memcpy() only on big-endian machines.

You've misread the quoting...
The 'data8' case that was only half there is a memcpy().

> On little-endian machines it converts from big-endian
> 16/32-bit ints to little-endian 16/32-bit ints.
> 
> But I see some potential for optimization here:
> a) on big-endian machines just use memcpy()

true

> b) on little-endian machines use memcpy() to copy from possibly-unaligned
>     memory to then known-to-be-aligned destination. Then use a loop with
>     be32_to_cpu() instead of get_unaligned_xx() as it's faster.

There is a function that does a loop byteswap of a buffer - no reason
to re-invent it.
But I doubt it is always (if ever) faster to do a copy and then byteswap.
The loop control and extra memory accesses kill performance.

Not that I've seen a fast get_unaligned() - I don't think gcc or clang
generate optimal code - For LE I think it is something like:
	low = *(addr & ~3);
	high = *((addr + 3) & ~3);
	shift = (addr & 3) * 8;
	value = low << shift | high >> (32 - shift);
Note that it is only 2 aligned memory reads - even for 64bit.

	David



