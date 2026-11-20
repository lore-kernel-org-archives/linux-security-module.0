Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795174506;
	b=M34u2QZlNmR9e/FSMitipfSqXn3TgLqsZo2NuO3TM96Ei7xPLl8OAdROg1qNR3LlSEg/
	 JQ6jVa39GU0jw/mGF4KDrfOjATjDb4aRoLkLj2bJGv7emUHyxbEdib8x21+feNFJwhUjI
	 j7jZUCVPvPiJ+M6wGkHuDri8c9gBzO+uBidGaT5RqxsQjNmLX+xzEFYcXqmXxgxnZe8OE
	 E+wOnL5sN+eIDn1y0LjKrDELJJRJuJLgeXBlHTpsIstlpMKYCHDfipF3FmBFxJUbKJfb7
	 mBSpGGjqzPImgjgW/fwwMQVnuxEJ1HMFQ1U/E1XVUlxh6oKgJaz/T6p76MYbJeGKwfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795174506;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=bkrqVl4fOtFiXo/UNE5/tK7V61bZnqlZiu3NzPQivMI=;
	b=jZTxr9oO4uZ08QPbY6NWiJGZG87IcXkpSsz0K1zOM+mKg7eIzS0tRtGL2g9idmE1TWOP
	 dfz7Ax8YXNiF2ZNdxvDJqeZzEfokN1o6Bl5/hEBY9rPltJ0lML15TixQIPlbz/pXf8maq
	 jE0XQqk+8gfcg9Gg3Ik6HsHm9A0pNmRIHbqEWVo9Lhefa/p8oUdBHnONJZqq6PdRYL4+T
	 m4qkgMWEwkjBGvWpwuCS8V7tKYsLaT82ALFvAX3CZnqFKxsxWsLh4569uYk9Wtl/vpcQn
	 7V0GVruDfJZbYtwhvFhhA7ycMtoEY6u0drfKyajcxnFao/0ZJ7rHSLPrXAqnEjGTvgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--halg.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=W6WXLOxR;
	arc=none smtp.remote-ip=209.85.218.71
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C2F606A326
	for <linux-security-module@vger.kernel.org>; Fri, 20 Nov 2026 11:35:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83C2F606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--halg.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=W6WXLOxR
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c50e035a2d5so110073066b.3
        for <linux-security-module@vger.kernel.org>; Fri, 20 Nov 2026 03:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795174505; x=1795779305; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bkrqVl4fOtFiXo/UNE5/tK7V61bZnqlZiu3NzPQivMI=;
        b=W6WXLOxR59uIfbaLpHw1RDG/aYC7BEPo6GMxxJsEX9hnvcfGjS1k3ZxVFqUv0AFkjU
         0HKbTZarlk3QbD7la/aeB8WWyj+L/d5uqI0/Kldt/z/TyOE1+EH/09J3/nHTMQyK0IBx
         jSis/yb2mQuZrhseR1h8momD+rFSWBeTNFj84rX/cxm2Dnpnmfrw8z/DCwxAxLfXy2Ur
         mKJvD3oJuijaym9T8sS6/FoceuszJAg3EDkJLxqhHXEGmp09BkqY60UVtQ1/yZMV4Kcy
         hZHrQmG+9lVrEffHnUR4gsfHbCOME9UhqkRa+c6QImLe+mLEXqYh+04zjVrAMvWLEN3A
         JZew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795174505; x=1795779305;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bkrqVl4fOtFiXo/UNE5/tK7V61bZnqlZiu3NzPQivMI=;
        b=SEuSoVugGUJ04lgZ+rpWKgnVb1PFXjEJaTnrXIGWLcjQeFyKQnisTvVqibg/TbRRae
         cBwqjNpqeldJcP+yak0/Cwd/F0JqwvcLqK+dc60XQAgXS2Vs7iVfwEifIeSRTxFb1/Rw
         hAAp/Ynk4VFmAsr9rgyv//wX6A2euTc0UWzuUjNM5hDqtpeLu78EAgoO7hXA9ASgeXvk
         A3bAV/Z1KO/M3toL7W0huFREittnpCNPAh0wcpJRLnLC5bdMLMIcsrnQ5tT1PFMPpHud
         gCNQ8FdLXMAtVBhsGSfpMGpdScqOdz/91fedVibKtU9Fafstp/ysMrolamYA+DfBvITV
         sPeA==
X-Forwarded-Encrypted: i=1; AL+hErEn3H3zhYRhEMSzXKcxPSnOZVZeIPk4/hl/nOW+jY5S17/RNYVxn7f9rB+p6gi8kYbELAETLeXBfq9XyySHviXQrGekh98=@vger.kernel.org
X-Gm-Message-State: APuU4Z8ezmZG9mp7hDDy4wQ69c9TrLtSkhC2rWph15k28rBiDncIp/Ng
	xcyv8xEPtudN3mIbhXAxVyoCMUAOoW4lEVehDAOH5l8eiw2+4lqbuYWSfYCG6QnPCcNRsmN0nw=
	=
X-Received: from ejcmy22.prod.google.com ([2002:a17:906:5a56:b0:c50:5767:f11e])
 (user=halg job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:3e28:b0:c41:7e99:c6c2
 with SMTP id a640c23a62f3a-c513ac99405mr295016666b.44.1795174504655; Fri, 20
 Nov 2026 03:35:04 -0800 (PST)
Date: Fri, 20 Nov 2026 11:35:04 +0000
In-Reply-To: <sashiko-outbox-223014@kernel.org>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261119104208.782900-1-halg@google.com> <20261119104208.782900-2-halg@google.com>
 <sashiko-outbox-223014@kernel.org>
Message-ID: <awAwaJugal622uZf@google.com>
Subject: Re: [PATCH v2 1/4] userns: introduce capability bounding set for user namespaces
From: "Hallgrimur H. Gunnarsson" <halg@google.com>
To: sashiko-reviews@lists.linux.dev, Christian Brauner <brauner@kernel.org>, 
	Serge Hallyn <sergeh@kernel.org>, Andy Lutomirski <luto@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>, Kees Cook <kees@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, 
	"=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?=" <mic@digikod.net>, Jonathan Calmels <jcalmels@3xx0.net>, Jann Horn <jannh@google.com>, 
	"=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack@google.com>, KP Singh <kpsingh@kernel.org>, 
	Casey Schaufler <casey@schaufler-ca.com>, linux-security-module@vger.kernel.org, 
	keyrings@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	containers@lists.linux.dev, linux-api@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Thu, Nov 19, 2026 at 11:11:50AM +0000, sashiko-bot@kernel.org wrote:
> [Severity: Medium]
> Does bounding implicit owner capabilities by userns_has_cap(ns, cap) break
> cap_ptrace_access_check() and cap_ptrace_traceme() for a parent namespace
> owner when CAP_SYS_PTRACE is excluded from the child namespace's cap_bset?

This is working as intended. Implicit parent-owner capabilities in
cap_capable_helper() are uniformly bounded by the owned namespace's
cap_bset.

Concretely, this only prevents an unprivileged parent task from
getting implicit CAP_SYS_PTRACE via ownership of a child userns
where CAP_SYS_PTRACE was explicitly stripped. Holding explicit
CAP_SYS_PTRACE in an ancestor userns (or owning an ancestor userns
that still includes CAP_SYS_PTRACE) still allows tracing.

This is also unlikely to come up in practice, since typical denylist
configurations would only strip high-risk capabilities like
CAP_NET_ADMIN and CAP_NET_RAW.

If we wanted to make an exception for ptrace() to still allow
same-UID owner tracing when CAP_SYS_PTRACE is stripped,
cap_ptrace_access_check() and cap_ptrace_traceme() already allow
same-userns tracing without CAP_SYS_PTRACE when the target's
capabilities (and userns ceiling) are a subset of the tracer's.
Extending that check across owned namespaces (similar to
cred_cap_issubset()) would be straightforward, though I'd prefer
to keep the stricter, uniform behavior in v2 unless there are
objections.
