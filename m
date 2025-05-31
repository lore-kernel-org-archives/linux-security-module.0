Received: from mail.cs.ucla.edu (mail.cs.ucla.edu [131.179.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C6ADDAD;
	Sat, 31 May 2025 15:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.179.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748705117; cv=none; b=Ab5yTWP4WS1PrRKqSgQqcHbDLsbsgO0YpY1dvJVdhK+AItW5jQQ35f4e5/mKMkkl13VbrRl4EZ4A4rl/4gTSI7d/ON90mQtb1QmEbV1OWlsKItbP2/6TKby7Kk97mwgVikq2zHauYMLeLf6cc3rXwTw7cVwgviqcBtYGvIMKaLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748705117; c=relaxed/simple;
	bh=9nQXULhGaUY3fT+0057uy4rFTlDoovaGBf5GLq37yzc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cXoM5pPLlKX9jLZbXSFuv/JWq2iY5Zwv3RIm4M1yGjVfVo/P6MehwoMenxaf/rJntnLsfcK+9ipsmh7mu5lefwekplbGoDxwxG4GRWKyA0Vx2IvAmCG20MDa59kIUdoActdWgkTdTQ9JTdFMjf1S+acVFC3AwEuUkRU8Cscod10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.ucla.edu; spf=pass smtp.mailfrom=cs.ucla.edu; dkim=pass (2048-bit key) header.d=cs.ucla.edu header.i=@cs.ucla.edu header.b=AMpsqAdj; arc=none smtp.client-ip=131.179.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.ucla.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.ucla.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.ucla.edu header.i=@cs.ucla.edu header.b="AMpsqAdj"
Received: from localhost (localhost [127.0.0.1])
	by mail.cs.ucla.edu (Postfix) with ESMTP id 3C6E13C010860;
	Sat, 31 May 2025 08:25:08 -0700 (PDT)
Received: from mail.cs.ucla.edu ([127.0.0.1])
 by localhost (mail.cs.ucla.edu [127.0.0.1]) (amavis, port 10032) with ESMTP
 id OU7HBfK13_e8; Sat, 31 May 2025 08:25:08 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.cs.ucla.edu (Postfix) with ESMTP id 10EAB3C0149D7;
	Sat, 31 May 2025 08:25:08 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.cs.ucla.edu 10EAB3C0149D7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cs.ucla.edu;
	s=9D0B346E-2AEB-11ED-9476-E14B719DCE6C; t=1748705108;
	bh=9nQXULhGaUY3fT+0057uy4rFTlDoovaGBf5GLq37yzc=;
	h=Message-ID:Date:MIME-Version:To:From;
	b=AMpsqAdj5fMZEDTVG6PjdjtR/ph15+glOYhRx/z/MfWcLAg1W8ATvjgbUCNePSRNy
	 Fqq5iwmVB23cEj7qemKjJXOW9mnitb1XNaVloBM2su9isYX6E5V5L2IU8uIsQZ6h0u
	 TIxJq4NRfaXFWO5EYvSFAIRrCCSio2N9NyuThLjfRYdyDKdZIC+tjd6c+oMcm7MW2f
	 aNvuLYLOHQU4zQbW7n/CoQC19mZe4NW8TH07w30bRJ5bnQEnx86y1blrLwli5JKlDb
	 30f2Ey4G/px1mr4qL+hXZ6htzpOQz7tVXgV/IoAZ6OvuiYZmHZ0+YNH+73qo3bJnlw
	 e/KJ5qxgipkNw==
X-Virus-Scanned: amavis at mail.cs.ucla.edu
Received: from mail.cs.ucla.edu ([127.0.0.1])
 by localhost (mail.cs.ucla.edu [127.0.0.1]) (amavis, port 10026) with ESMTP
 id OCT5IDQ-QFp4; Sat, 31 May 2025 08:25:07 -0700 (PDT)
Received: from penguin.cs.ucla.edu (unknown [47.143.215.226])
	by mail.cs.ucla.edu (Postfix) with ESMTPSA id DF1053C010860;
	Sat, 31 May 2025 08:25:07 -0700 (PDT)
Message-ID: <be46b324-db6c-4ebb-96c3-0280d32aac66@cs.ucla.edu>
Date: Sat, 31 May 2025 08:25:07 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: bug#77597: listxattr() should return ENOTSUP for sysfs / tmpfs
 entries, not 0
To: =?UTF-8?Q?P=C3=A1draig_Brady?= <P@draigBrady.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-security-module@vger.kernel.org,
 Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: 77597@debbugs.gnu.org, Rahul Sandhu <nvraxn@gmail.com>
References: <D8Z6FP3UZG2G.I8H42ZV6DM08@gmail.com>
 <41067aa3-0e72-456f-b3f2-7bd713242457@cs.ucla.edu>
 <c7d16a13-79c9-4e81-996a-0f32bcff79cc@draigBrady.com>
 <2e24f40d-b475-4199-b53b-e4c266d0d314@cs.ucla.edu>
 <60b2252d-9295-4d03-921e-a596444da960@draigBrady.com>
 <64b14829-381d-4295-8878-f6b06906ef3c@draigBrady.com>
 <c0a1f475-b973-40a8-a7cc-6947791af38a@draigBrady.com>
Content-Language: en-US
From: Paul Eggert <eggert@cs.ucla.edu>
Organization: UCLA Computer Science Department
In-Reply-To: <c0a1f475-b973-40a8-a7cc-6947791af38a@draigBrady.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 2025-05-23 04:38, P=C3=A1draig Brady wrote:
> FYI this should be addressed with:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3D8b0ba61d

Thanks for letting me know, as this led me to further testing that found=20
some other kernel bugs in this area, possibly introduced by that kernel=20
commit. Please see:

"flistxattr with right size wrongly fails with ERANGE, breaking 'cp -a'=20
etc" <https://bugzilla.redhat.com/show_bug.cgi?id=3D2369561>

The email thread starting at "[PATCH] Fix listxattr-related races and=20
stack overflows"=20
<https://lists.nongnu.org/archive/html/acl-devel/2025-05/msg00003.html>.
