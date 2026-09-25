Received: from mail-pz2-f13.google.com (mail-pz2-f13.google.com [74.125.228.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A2344239B
	for <linux-security-module@vger.kernel.org>; Fri, 25 Sep 2026 09:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790327700; cv=pass; b=mu0zlnGZsm83vpxROb0N2mBodMvu52TmGsh1xGiLwci/rXnzVnp2pLgF6bge6HNMSPt+SY8IBF1i7CwAHQqRuw+uq1vG3/U+zMAQJCg4zN1TOEiFqJiMJn2EAnKFRLjzM1FghKBYYGv0C9INPNl5bso4yGn2k54MwmU4f1G0ABQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790327700; c=relaxed/simple;
	bh=p9nwhpNShwsCELITN+2tBnZ+go6kbcsWckBkl8WHBog=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=T28IfB6vjPU09njs7iyQMCXlz4aEROM+2dsTk5acvfLyeE5S4wNr9HquaR7JZN+i/E4F5NoHQ4af86IucQ3DYLeZtCu3sKEu4AwbP1VcbVtgX8M/dITVC9VvagEMlSnSXIfLQh2x05rbmBrmSp7aXM6kLr7OkNBeA8APlyXb8qo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aTlntkfK; arc=pass smtp.client-ip=74.125.228.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aTlntkfK"
Received: by mail-pz2-f13.google.com with SMTP id 41be03b00d2f7-cc4cdc0d663so226771a12.3
        for <linux-security-module@vger.kernel.org>; Fri, 25 Sep 2026 02:14:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790327698; cv=none;
        d=google.com; s=arc-20260327;
        b=bOhqSsysdVIqhN5bxPz+LRSz7iBsKcmsNDkEn1PcA+O0SClpVBra+VHT8o+QghC9Q5
         InABq9R+F7uhYoHVkktoOzgJU8QMcdWmD4AJhNNITetT5pAQNu1vWnVUkxQzLntozZc1
         YALukZoQwnpRLK3ziYa6Xq6h/bSNPD1dYXGVM9rWlf2Cs3s+tM93MZKoK/RX40wD7bq9
         jZsRLQkuE/1+rmSabLUeDUihPwFbo2ffx16iZu7jL8hMiOSOn0C4tzvePY8IE0NYzKDS
         E2+oFjE5DP0hjq7uIGRbVeiHW/7YDDsHb9X/kKZfGUIBh56oNgR4yGFJBBnH6aK5WV67
         g2sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=p9nwhpNShwsCELITN+2tBnZ+go6kbcsWckBkl8WHBog=;
        fh=G1JSHDV/ktx280/GaH8FX16EmG5/AFTIDRxfnDlK/3s=;
        b=IG345gX9SWaAYSsKHKNFiSFnR/kLPZ8nEQckN04Mko+44I1t1LUUKsu3NHy7TfBVy+
         XXBdKBs/K7bUeVGYNJdHw6Hs3X/sE3iwfwJpaPpXgcdKsjgjHTLG3V2RohRR1BU/OEkX
         EpKzuenCq8FQIELLOfgdbAidLomOTJWuipsppGLFZeSso/dpL1wGPYW156sOgEUFO72Z
         BvcAEoGsYcyTqoG2wLpXOpF7MtqfzLSiDDrkCk3Ai2zRCRiPfjs9e2pPaFzsXAsWK9w5
         ZHFWMnBglv8+3pVg/4ksWRuexcH3dNpwXyi0MaIqoBQ5koGwdnLsULinhlunEa9Baj0N
         NrKg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790327698; x=1790932498; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=p9nwhpNShwsCELITN+2tBnZ+go6kbcsWckBkl8WHBog=;
        b=aTlntkfKJkoqbN60iz3gwUodLrkSOg73DMmBvnGIFfcnnsMl2DzYbYExcwSSQ8UAt+
         TT8C0gTemP1q6L2FooOxMTmlpV1bz0gXiimCwKqczT9QfaIeeUu5f4IScg8BnfB9PuxF
         gQZZe9v2G/z75bmOeLWaQkLATMD4v+cLjzDJ2TE+YMcmNFjbQNBcEQV4elflvp5JlSZT
         J9cq2I7HmRFeDaJy6aqK9vbn4IpgdRHb22ZYC4HmsvU/0hd/WxOYFplEgevKKbu7KOBo
         3qzIGydNUPkNJDmF157edZ4LslcyrkuJ4b6pX7O66leMqhPZ47P8Zhg9eIIq3cuFRDC2
         TTLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790327698; x=1790932498;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=p9nwhpNShwsCELITN+2tBnZ+go6kbcsWckBkl8WHBog=;
        b=l+kRwkB6tD6r4sgt7qivkAXPoMPPhXDAxu3djHik9IOJh7OVvBzKHmjpMhmYEKq5yj
         CP2x58Dwx9uQ2pH50/QNNNZlZ20eLEQopvPwhhye0DTuCioXqV+HVqaOG29qyB8BtGLE
         GftjVb/Z5OaNwfi+6l0T8RieLCdwAA+UWLgJ83XcFoVAsTJhyuWVYWLpnlj6YJbwNcLR
         YLlHguU6Fo10IpXp2/PYxprOzPnSivEs5Y28r8DFry2TC0AyuZDeZIBl2bTbX4HIS6Ot
         0nnEy3K+1YK4C9YibBNR/v+W/pVQLTNbbdQ5uzVX0UOYA8azTlWxD4baqcoUUcJ4pfn0
         iu3A==
X-Gm-Message-State: AFuF++n+pDbrW3jqV5tXpiwKItPpDCVzQMJUYO8Y4cIT/leB4xqu6LWw
	SkFuuBMner4JrFete0hyUbsOa0U/47VbeEUHC7W+vmEXfAJnewa/w1f/8ww4KLOFrOu5Bjk0PJl
	qiNcuOh7eLVu5XrBp4pV0RIjBaA2KdfA2U24RojU=
X-Gm-Gg: AYBFou2K2rQIRB5pokiU6fkhA0EeZxGlxjgN2WKx9IZKCLg8Aw+rfuTW5wY9pWacrZU
	6oJxwNdGOKdsHQ9yHp5wXXK4eZyZHG3Aj20pSe72v0M2q9EatPrm4BGx/sI3035kcpyBXoaX8C+
	tSTd5xec/yTfdBlHdhzMv7pPrmcoGKdnOK/bdJeNleMRnumtrMJrr0UwRO2RfnkSl95XlhY2L7h
	wBmcn5YQ74rwXpkTyG5N9bMVpREAM/SSKllAXJ4gtEus4mgIEA8s4hNP9w4dMG7FfZqjcY++c6N
	zi+xxVUo1rpHHJNgkl0TJsglGma8ASWU2NtP0c75J/jDrPy+PVLWZQ==
X-Received: by 2002:a17:903:324c:b0:2dd:c100:80b5 with SMTP id
 d9443c01a7336-2df7e6644a0mr38012105ad.48.1790327697988; Fri, 25 Sep 2026
 02:14:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?5rSb56We6JG1?= <chengjna@gmail.com>
Date: Fri, 25 Sep 2026 17:14:46 +0800
X-Gm-Features: AclHuK93wbhjjM2-7srtIZwrbaXXOw3HXafZeMMpj52e39XQN_y1Uupp1neqqdg
Message-ID: <CAHDTbUFX=8aAQnwv32hqmwHKkeJR0UA5XfZtMZRD1H+kV7uCzA@mail.gmail.com>
Subject: [RFC] Proposal for a standard Competitive / Protected Session API in Linux
To: linux-security-module@vger.kernel.org
Cc: linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

I would like to propose an idea for a Linux API intended for
competitive games, online games, and potentially other applications
that require a high-integrity execution environment.

Linux already provides a number of relevant security mechanisms,
including ptrace restrictions, process memory access controls, LSM,
Secure Boot, kernel lockdown, and kernel module signing.

However, these mechanisms are currently exposed separately. A game
that wants to establish a trusted competitive environment may need to
detect and combine several different mechanisms on its own.

I would like to ask whether it would make sense to provide a unified
Protected Session / Competitive Session API.

The basic model could be relatively simple.

When a game starts, it requests a protected session, for example:

competitive_session_create(...)

The kernel checks whether the current environment satisfies the
requested protection level and returns something similar to:

ALLOWED: the environment satisfies the requested requirements;

DENIED: the environment does not satisfy them, together with a
standardized reason.

While the protected session is active, Linux would protect processes
belonging to that session from unauthorized interference.

For example, depending on the selected protection level, this could
restrict other processes from:

debugging or attaching to the protected process through ptrace;

reading or modifying its process memory;

obtaining sensitive information through /proc;

using other kernel interfaces to observe or interfere with the
protected process.

The exact interfaces covered by such a mechanism would of course need
further discussion.

The game may explicitly terminate the protected session:

competitive_session_close(...)

Normal system behavior would then be restored.

If the game crashes, is terminated, or the protected process exits,
the session should automatically be destroyed by the kernel.

This would ensure that the system cannot accidentally remain in a
competitive/protected state if the application fails to shut down
cleanly.

A major advantage of this model is that game developers would not need
broad permission to scan the user's system, inspect unrelated files,
or monitor every other application.

Instead, Linux itself would establish and enforce the protected environment.

The game would only need to know:

"Does the current system satisfy the requirements for this protected session?"

In other words, the API would provide a trusted execution environment
for the application rather than granting the application broader
system-monitoring privileges.

A simplified lifecycle would look like this:

Game starts
|
v
Request Protected Session
|
v
Linux checks the environment
|
v
ALLOWED / DENIED
|
v
Game enters competitive mode
|
v
Game exits or explicitly closes the session
|
v
Protected Session is automatically destroyed

My main questions are:

Does Linux already provide a unified interface with similar semantics?

If not, would a Protected Session abstraction like this be worth
discussing as a generic userspace API?

Competitive gaming is the most obvious use case, but such a mechanism
could potentially also be useful for other applications that need
stronger protection of their process integrity or confidentiality, so
I do not think it necessarily needs to be designed as a game-specific
API.

Thank you.
