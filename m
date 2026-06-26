Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F8D2E2EEE
	for <linux-security-module@vger.kernel.org>; Fri, 26 Jun 2026 02:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782439268; cv=none; b=TqVXTkDTCk1eTscmb+x+fRZxTXg8gJ4QXkTBfgaurthK9n9PLeBAxAIWYvfpM5YeJ1c9fXlEfucUm2cR3NIP8KDDxBSztzY3ZRctfYTRZFYcElTAlNtZXQrdyNV2HrMyr4zXUi4bMYNGbFH8rUkpBC+6xKHp57xtb01AC8WpQHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782439268; c=relaxed/simple;
	bh=Lh8oXrP1xibgtkVbMaxAE7Bs5bJd2E8n8XUos3XinnA=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=fTj4j6Zi9q/THnWtn5SQ5W/pT+A1F/by3unmPWyqKGTo4tFFWEwrakdyaW54lC2mYHeAsbi+OBECgJSseitclGHuVI19XfxlyoWqQIQjzSWiyvvsXsue9gFJ89jBbqWh1gk0MFBu+EW7DtcsrR39uKHSQFMYrIVNnWY/K4fS7Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=T7hvKDQP; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="T7hvKDQP"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-915d64fead9so162666885a.0
        for <linux-security-module@vger.kernel.org>; Thu, 25 Jun 2026 19:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1782439265; x=1783044065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R0i6zOpZ6BVT9WWXIWxceZ1rEM+Y8Lvo4LC7l/NlLRM=;
        b=T7hvKDQPPsRoSOdYwJffO9ayu5VGc9fYV1HsiazpYsbXhbmVd0wYtgsbIz7tqioeog
         Mo5CScOy2jfwb5E28A1D0xdZ9+MR0Ztwll+cOxz5V91j/O53Q+0WXR6m45G3/x+UJI4z
         OeLhZfW9hjeGLB2ptltWDNgCJNeTf9xjjxdIGTIo6U4cLTzTdAoZO9ZcFr1FcQHfSyO+
         /9F5HWajXEFca7WifQDjuCPMylXY+lgXNaphUlHziJGEAc/Cu+yG2p8MimVGWUdEPkRK
         4UiqCZbluJviEkqtK28o0bDm5IwTcRgwhD76+Ch3h1LYse/mrlOR2sGPjQ/D+FpfSlml
         pskQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782439265; x=1783044065;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R0i6zOpZ6BVT9WWXIWxceZ1rEM+Y8Lvo4LC7l/NlLRM=;
        b=EMHaSM++KyXhP0Ybv0MKZHPIALtXsBMpO1bEsCrsNM7p6elME2En4O0uP4rNiR6FKV
         kEHJbLbkux0qqN4/Aiatn48lEKCeV3Kljz+HMvgVaNuZV9kmsEy3j8fn5ss5EGS5c0lC
         +hf8SeWnGF71Ki8ys1eAIBM5F5L7n7anw5tsrSXvC+VMmYAiYVHKFv0oN7kwIRrvACkH
         hC1Dz7iJNyEKo9YnpGySJ1ASjzTQV1YhBMXVT6B+o+OvfoqFOEAELrnQJ49TpbLoQKih
         LC83tO5Gwga0u6XS7xIYHVOYzaNLydBqDP3b/X1pY2lyWn7vm+Joz9HAfFvt5QREs2iu
         kr7A==
X-Forwarded-Encrypted: i=1; AFNElJ9nLKQCtTMciOKHL57CN+55H4MhkNwXsRTr0mGwwIzFkmJ/oaOz7O9yswhCL1tMzsP+UUC/m1+oH83K60yascbuAcUcf18=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+kgeRojTfU1YDCdkQPpSQrOdZ7h06UCU17UCoX+SQDqEXv6ay
	rZ4iDv5CXwFlX3pSTA5Ir3zUJezxRn+ua5bw6NeAuEYwf7ScfIoHZTMtAYFhfoVkdXUF95jecpA
	U4LID/g==
X-Gm-Gg: AfdE7clv5Dyng9VeEgi/DnJjehPpbKGu+ZhCNWtgJvrLlGBzpnyJVuxmjJyM6WnxxPK
	Yqc44hbTiTRdyeXS+oCCTUwZEL5wgOaK1iVtUYELESpTHe5s0S9JxaNUTh4NFQ6G3T+GOqlz9r7
	mCOPOBxzbFwgjNtsiMsx+HY1GmfHXM/Vd6dh+hkymfPx43P+Xe6zXCAqS8lPRVkisTbdDQHuUH9
	/ef8zdbY77lgN+SaHi9jHNjKJfyamLYWSWOf/anqYoew9DFOy3utCnBMxoVJXgPKhd/KCQFWDfn
	bicguFuTvohChnJozIg2tRc4bXFjR7jU3etHEw5/JiEYX95NFV/bYBoGXfZqdlv/z2De2U88Wmf
	UkY9mAYBdz/GSVa0fX/cBHwT9RXAEAEZ61rMEMm/ibcRG0T6NgZ/SlX6OM8BTF6U0LGu/5jwhOL
	6vRr3gjog70KIQPE4YHHESv6bffib3sQT7vPoZ5Lkt30d6pVxvyXcisabZmXqgvg==
X-Received: by 2002:a05:620a:4613:b0:915:aa65:6e95 with SMTP id af79cd13be357-926039b55abmr1151848885a.44.1782439265487;
        Thu, 25 Jun 2026 19:01:05 -0700 (PDT)
Received: from [192.168.7.16] (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-925fa56463dsm1007413685a.0.2026.06.25.19.01.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2026 19:01:04 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, KP Singh <kpsingh@kernel.org>, James Bottomley <James.Bottomley@hansenpartnership.com>, Blaise Boscaccy <bboscaccy@linux.microsoft.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, bpf <bpf@vger.kernel.org>, LSM List <linux-security-module@vger.kernel.org>
Date: Thu, 25 Jun 2026 22:01:04 -0400
Message-ID: <19f01a8bf00.2843.85c95baa4474aabc7814e68940a78392@paul-moore.com>
In-Reply-To: <CAADnVQLdDZR+q66XgCgprPnikhE_Zf_LH3XTFh43u_ks62cWRg@mail.gmail.com>
References: <20260624140301.93421-1-daniel@iogearbox.net>
 <20260624140301.93421-2-daniel@iogearbox.net>
 <CAHC9VhRar1x7kyjhgdmJ=Mfz4Msarv=wQ1821v723CaVdk1uTA@mail.gmail.com>
 <603d0f6f-bf02-48ec-af90-f16a239bad85@iogearbox.net>
 <CAHC9VhTF6_VaSm0uOjW1eV05CvsaaL+2jimVuPTXHeLGEQcMPg@mail.gmail.com>
 <c4dc3117-ad84-4c94-952a-cf0642cb42e7@iogearbox.net>
 <CAHC9VhRV9jW+dwNf7mW+1zTCsZ1xstBAugWL-TJ-DVNARdzC=Q@mail.gmail.com>
 <DJIL18C2F40B.39U9WHD43SDBR@gmail.com>
 <CAHC9VhQsjW0OJhKYUNEdkt_31oo56aMusDTANDOAQFNQwCpo4A@mail.gmail.com>
 <CAADnVQLdDZR+q66XgCgprPnikhE_Zf_LH3XTFh43u_ks62cWRg@mail.gmail.com>
User-Agent: AquaMail/1.59.0 (build: 105900627)
Subject: Re: [PATCH bpf-next v2 1/5] bpf: Verify signed loader metadata at load time
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On June 25, 2026 9:44:54 PM Alexei Starovoitov 
<alexei.starovoitov@gmail.com> wrote:
> On Thu, Jun 25, 2026 at 6:38 PM Paul Moore <paul@paul-moore.com> wrote:
>>
>> On Thu, Jun 25, 2026 at 9:16 PM Alexei Starovoitov
>> <alexei.starovoitov@gmail.com> wrote:
>>> On Thu Jun 25, 2026 at 5:59 PM PDT, Paul Moore wrote:
>>>>
>>>> For all the reasons I gave previously, I can't support moving the
>>>> existing security_bpf_prog_load() hook at this point in time.
>>>
>>> Paul,
>>> it's not up to you to approve or deny where security_bpf_prog_load()
>>> is called within bpf subsystem as long as it doesn't affect behavior.
>>> Daniel's patch doesn't change observable state from LSMs pov.
>>> It merely moves the call from syscall.c to verifier.c.
>>
>> Alexei,
>> It is my responsibility to speak up and voice my opinion about LSM
>> hook placement; arguably that is one of the LSM maintainer's larger
>> responsibilities.  Non-trivial work, including several allocations
>> (which can be quite large in some cases), occurs between the current
>> placement of security_bpf_prog_load() and Daniel's proposed location.
>> We must preserve the existing security_bpf_prog_load() call site.
>
> I don't think you read the patch because you're saying nonsense.


I've read the patch, as well as the code between the existing and proposed 
call sites that is outside the patch's context, that is the basis of my 
comment.

--
paul-moore.com



