Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793201687;
	b=ztTN/WKBT7Yf4rMyJyghe3/HEcl994D2SOhIs+0eSfDLfrgOy7KinL+VhZPngqPXipdm
	 9HJRWW4cC60xGb9HP+LCcl/cpGTsUR2MFuCGkbcupYNOLDu4BvJRInBLhoGbXZwbT+VDI
	 wVp27wZFRbQFZFKlz9dW1R5y/BeIvGCpLIAJIiGMwTwN+mYX2gBTtxZM1GeQ16fM7JS0K
	 pXB5jdHyc8K2b9Mco9Xgn1EUkK3rjOxFdUeqYehRYvClcspJCk/hYRC2L0BhJD1ONGn//
	 +dAGpamTZmrOgYkYLT5EC8RVp8oS7yM7oSGMsWtCL7ss3SAQv46JXRIs04iXTXFVZtg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793201687;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=JNFgtKDp87voFFR8yXktG0LWODrSokHg8hARj7IkQYg=;
	b=pORqOYTQiDs6b9PuNI0Cpd0Ut9A9lDM8mOfQ43J/plQU1IBAdlk7+WRX7PvY7YRNwYI3
	 KGhUcQtR1SiM2w5y7JKtBJPel/JgYdbw2r2OqaOAQ/m5GIO2OtcQVRkw6BnNuzrTWJfg6
	 SJhmdzooFkmMg/eeXNldgwf5msT0GyodzLYqWZr5wbbVVddtawNpb7N9A5uszIW4ORueR
	 ISPdUw4lJsetPiJADSOKXKeI0zCdOSNirDOdccyAIDJZGhBQC+NH2nxYek+Nx9rvDAiSG
	 q/dFNfhJiSFvmh5FEqi+P0eque572qVmDUCpYPjio1znhkxkP14whYnmeOfSgIa7v/w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ef7UxKVo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.43
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B5D606A31F
	for <linux-security-module@vger.kernel.org>; Wed, 28 Oct 2026 15:34:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36B5D606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ef7UxKVo
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-8439fe796ebso805921a34.3
        for <linux-security-module@vger.kernel.org>; Wed, 28 Oct 2026 08:34:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793201686; cv=none;
        d=google.com; s=arc-20260327;
        b=IVHECW3CCQjWk62zQbwwkZfKGD5UqncsYZKzmcQUa0bW8xvzr0z3FwETGgZS90t8pi
         kOugjes+ukA7YAcDjltzqDN35YyQhoCjkzD4S8fAFEFWOIqVv+PTRDnPOvrtHyr8rF71
         lIqmoaMv2KqqSM12WueQMRc3i7bixe9tsQTDFEW8MBqrx8tlF9Tf0rArKPsi8ROvbMbf
         XY2VnR2/dGoV1U2TGkvrnjEJSvn5DBH6o0NOuxi83ONZhS7AXUK09ehaZCYM9a0fUmid
         HI4cMzwG5gIn+ZAAw3QNMqhiX5Rbco1G244X75UZbKpC+Bu9zCcap7yXxVUkQtHlSoxl
         tCrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JNFgtKDp87voFFR8yXktG0LWODrSokHg8hARj7IkQYg=;
        fh=Fxhw3AODzOV9vhTANEgaYY2Yu3KkLm0/v7dKNFs/Jyg=;
        b=KMrKNXN7nrphldMc7SXqKtdSTk8DNh2oDUB8rA6D9XTotYo5iuLGMKS7GccRsOa/p8
         uJ4tnJ4JCC10MDjxlWMjXQiNeQacoOn3Obpz7p3s2clKu1yazlGTCCXwo/ema0B/3fUZ
         jhLOO3popMg04Kb4YIrpEeBzNA7MdeuykQ49e3Ma1zHJBLYNPkqgdJnxdKK57FK7+8gB
         jsRKF+DeIXQsmoqAntyy9vW/q3k903hi6hbTjWN62dJRXCAcM8/+7sV5+zknPzsZfSOn
         BDWTwHVnZEUJehCe7BQWPF8y4udf90UdSBJ01O4OgqQ92nEf3ZLTIEw7i+MmPnjk3Qb9
         GXUA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793201686; x=1793806486; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JNFgtKDp87voFFR8yXktG0LWODrSokHg8hARj7IkQYg=;
        b=Ef7UxKVoG+4kGFp5uykkaUkiMgN1G+lhfRLa/HcMnDuSiZ5htbI+UAqy9Z2N2Vu5x2
         AH+7Nu3jLP/OrYD/VNcTT6FgiRmooO5freMk6bEYmgd57MDL+PIpGjMbnDuc0PsaShxU
         5/3RUNC4r0BI+PdMJjPh9SHdp3hIH597VpChTatGqzIJSzF5YmFX4jXsJFMoU91acv3O
         Ue52hoB1ApBbbh+Buda7XrIKg8nxxtjLMGB26NWAc+iJw/l+fGBuodmpm0fGIbJAA621
         BxIqhM70bRBAAqgrfBdZuKZ1qmZlS/oXwRLDwosHR8d6uPolfMNbRlKOIi4wUlj1PVRO
         cGVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793201686; x=1793806486;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JNFgtKDp87voFFR8yXktG0LWODrSokHg8hARj7IkQYg=;
        b=NR7M30wyWPyBjsz/HARAUiu0M6Zyvr8Tryi4Cpp2i698rXAvwsOQyyn3FI+UikNBER
         EvCszGAybR4btcWpXP6s7/+35EbbyhM8H0MAdkB6798LGe1lVUWXa+7Oy7Q+c3+7oOKp
         YhkbiKDJlJj8ZcfaqW6yfCTK9CFlVCVYFnwpj4qw3cxhS9V99m8aiYoc9WHmOPfWPJtr
         2WAIdCEPevwv07aeAcXP0OR9ukHrtv7kEGJz/jfgeTu2+icTshAcEgjp6RoSAKqjq5FK
         tlnoFHsLcdH42LTmIjKYreC6y8NBBXHQN4b1gDPwqS1KppqDF2jNEfgebEc0qv0JjOlz
         QiSA==
X-Forwarded-Encrypted: i=1; AKwUvBxx6JGgz7RNOCfXD4z1QOfgLQTQNIvkIc2OpJ3a0bCAP/GyuoOuBkC4XIR4Vwg2BCWUfsEZkfpSaPmCEc8ijj5KdNYs8vY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ6JykBa2ec+8IMFlt2nePjCKs4WbdhYV6hacPgSZDI2iXvL+Sy
	yO/SBu4puSwI14WJqypc3OMlKpXnZ+RHRR9QOlUD935pNQatMZbf/zua5pa9WJ+Kk54Pjy2514D
	C8uRX2sPDy4qRRN283vm65vELnBMZ9LU=
X-Gm-Gg: AYBFou2l+S/ubLiRtTMfzaRyx924EHVEt/br9sT8+KPJO+5/hwUg4F9GL6Ig9W2WfbL
	TqZ4560WbgUn3FSvdgghqx5stLyM+V1IJLmw2uVKk1NqHyIvXHERuij+3JcN6S7kHzR7aI6qsgB
	4iMS+jn8zV/myqlFOhe6MqeXCxT6kHaAv6a+XquLNcbn+m7odKCT1KLdosAphwhB6FY+Vi3DpQ6
	j+F/pIpnu21hB8J8pZEylsatPsd12XQBLhaO2wn2SofvyBeJhZvh9WjEj3RLZ2aOF8BMV/Z2tdL
	lq7vdjH9m2Aw8PCTGEw9jSykimpwXsl7K0oS+5UgJVCJf3snce5eMI0JC0scC8DRlQa3a3HSfYT
	ad/fbdTbQa7/YMuKTpxxz9fajCX2z2AtWAJw=
X-Received: by 2002:a05:6830:2304:b0:846:e5a3:c8bb with SMTP id
 46e09a7af769-85ac012e9bamr2225801a34.15.1793201686073; Wed, 28 Oct 2026
 08:34:46 -0700 (PDT)
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1793094611.git.chris@chrisdown.name>
In-Reply-To: <cover.1793094611.git.chris@chrisdown.name>
From: Andrei Vagin <avagin@gmail.com>
Date: Wed, 28 Oct 2026 08:34:34 -0700
X-Gm-Features: AclHuK81v527zBLgjPgT7UgeAn0ZRsnw4w8kJ2Fr9s5y5HrZvwNULUli5C61ZOA
Message-ID: <CANaxB-zEaaDaaR2Fszx0D4TAcKAapOfcxQ2MzZbFVAhR2n3SOA@mail.gmail.com>
Subject: Re: [PATCH 0/3] mseal sysmap: Choose system mapping sealing at boot
To: Chris Down <chris@chrisdown.name>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, David Hildenbrand <david@kernel.org>, Kees Cook <kees@kernel.org>, 
	Jeff Xu <jeffxu@chromium.org>, Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	linux-mm@kvack.org, linux-hardening@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 4:42=E2=80=AFAM Chris Down <chris@chrisdown.name> w=
rote:
>
> System mapping sealing is currently a build time choice. Hosts which
> want it and hosts which need to move or unmap these mappings therefore
> need separate kernels, which is not ideal. Let's allow the administrator
> to choose at boot time.
>
> Chris Down (3):
>   mseal sysmap: Add mseal_system_mappings=3D boot parameter
>   mseal sysmap: Allow with CHECKPOINT_RESTORE, default off

This isn't just about CRIU. For example, gVisor does not depend on
CHECKPOINT_RESTORE, but it still needs to unmap the vDSO. Other
sandboxing solutions likely need to manipulate vDSO mappings as well. I
think this toggle should be off by default, regardless of
CHECKPOINT_RESTORE.

Thanks,
Andrei
