Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194E92D662F
	for <linux-security-module@vger.kernel.org>; Fri, 20 Feb 2026 18:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771612241; cv=pass; b=rQSNyE8D21tl+33X9y7mPY6KqNOx4NaR5mN7PSaRoBEHgjEVPVoTIX8GIct/JilNgprRAlu0vbUjLTadkE8Ek1QTeqh2JiQABOhdZ9A/0N3gRPBrRm+hUFHU0IFm/6ar4m3ltKbW1d8NDBSy9MnADVzU6o+99V5K88fsCR92gFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771612241; c=relaxed/simple;
	bh=i/XkIiKCZ10kdPMCUX6PC3bB1lsMgrfAPEq1MVPtP8M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PwErNiUdHDnlbJYy9U2rr8I7pLnGcGNiFaRCttcdrty+WPscix8DrNhEDQ/Z9PbZrWHZ9TZGo4+HYUf95PsupfrPH5pusG8XuMSdg8eEMEAK9GuzY3kRGTiv7x62Hf+qBmL7LxlHFkMTCyFFNPmm1J6bhoPNLJ3DmBKcCSKp1cU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4qK35Zxs; arc=pass smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4qK35Zxs"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-124afd03fd1so3306877c88.0
        for <linux-security-module@vger.kernel.org>; Fri, 20 Feb 2026 10:30:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771612239; cv=none;
        d=google.com; s=arc-20240605;
        b=gxxmb2umdLrUrrq5IS6+z9VEf+x0n531IIzEZD5EJ456Eq08V/BTJSPBW1T88nV237
         M0CauHOcxSFtPtBVcs24rWxScgl17lpB7rODQki7lB0KCgd4kBY0c7vP2kamDp8Yn6lg
         VPbixQ+FteytrmMpo0Psw7Cnw+9FPbMfXEBRtxoOzz+e+aHtLApWdXQRnIB/DHGxQtBZ
         sZkNISvxEouunqbp5v7XSomMbpGG8Gnq8Tv8Vbf5iCJ5PfGAc345moEuPom1KaNA+Yhv
         XDDahw7KYQAtqiBDeG9VJCx2o4wRYmYM0o3DD07rtqkARKcetdCwzYtFMSxFG+olnrBJ
         Ffpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jf9LumeETLRd4Q+S7TnWTRR4BmxsyhjwKcm4GLmlrxQ=;
        fh=S9BUhGmvW0/dLdLZS+2dWn38auv5gRQC3fA5ncFRbwI=;
        b=T2TSZC9/rUVp9qNPNTuKkYkorLpUk4n31PpvpaOXwMMc+eLTpd/4NPy8VeS3UDfMk0
         wb2b6FY4xt89UjgXxA382B73KD6gN8iKH8A6/YWZW59hbY7hwOgpQ7ODC/oDpETZqotI
         cNSpCGrn/JWQL6IHjLZHEUIDuxHTxVrj7a1emOrl56UqCM1lZqC1nLfuD/INDVHeGkef
         hV1TBIczGxYM+h7FoQTEx/R/iU+av5M7pdlgNvpy+C9gQq4/cxUhtpaG5NMMgkAxGLjw
         OyMJo5w9gbzuOhO/HxTvebvWXz0ZUUmIYbrh0NLGpJ0dZl7vHfZqP+8833lqSqbhIJqL
         rGuA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771612239; x=1772217039; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jf9LumeETLRd4Q+S7TnWTRR4BmxsyhjwKcm4GLmlrxQ=;
        b=4qK35Zxs6ncmFgMTMXVM3Jgn69RzaY+vmVv9ngotqZ37INtv8lx6jlgMkTfC1XQ2zP
         kt5kIz+sPnO4+hVVNncCDTaqWYBsoVTosMiQuWVQSSr51MXs8yBNc9oOY1TuBTXNt/Uj
         MeRnZ0BvQhwKNs+cFIt3kRETNXI1gvXy+ZNkS5j8VYg1mGa/nu/VSJP7lYqjKVh30zSk
         8yF2n72tC5bZNIvK3V1NaW2Q34VkOTabpDZvpM/CVpkvTWHyVnnKoymWL9i3qWGCPJO+
         lMIz62bX4P4zhXxLoUbzjVgvDEGXZC0Ag2MhFYy+b494UiKSGPEiCwu20TJVvMAE9O40
         rRTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771612239; x=1772217039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jf9LumeETLRd4Q+S7TnWTRR4BmxsyhjwKcm4GLmlrxQ=;
        b=jCBHvqSr+AADT+9KupgtfXHT+xLuwtXoY0AsM+lKF0zCQWV9qgRWq9kYq49HERDTro
         +XIJYmwF0jc6aRuhaZcytSwC2ZP9QqqVFX69vnh/qoVuXx7fshim+v2IfpOPCs6kcLVo
         Dg7ceRR6pxSkjjv6aaEfazHKTRPgrzGh6zn05DuHO5/6jNhYVc3nGeE5gdjPH62VVgb2
         +a+KjDTzdZBQlUCIZrkXJf8/n2i4FQRMR3QFKWlxfejZMkiYIXIpQYzgUbQrSvZVWX2W
         PRjG2Lbe63JrnQAmD4F6TPikzVYJWgw0Rzuaz/20DV3P8jDvV9u4wKUsqE5rcylVsL/J
         SKzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQaqK2dV5b6aMYxq0GPPw3AuBaDifu4ixdk+Qxqk/UsAWLEXcpAbaZvJzaAHziAaAbeLtoJQwLHmttZNQ3Pd+jehOw23c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWIzlDPVSlXPSFT4eWBI+qe/1dPRLVu9LGantE0QUcg6nqMS1E
	/HGUNGzNmDTlTkg1siqFnI9LT03tFOFk3x9aTGujnzbLfJdcR573TJtd8duoIYgFuSiLzllVrrn
	T0gmt4fmS5g5eaccYRRkOwXINGgLqtqJCCoOVqWf3
X-Gm-Gg: AZuq6aJnThhqdJDTuLEcWxsSnEyaxg1lbyaJfnlxYYRycg6FgcWl5Pjrre6mhG3m0ql
	8tr5wA5e9NUWwNuPaZiHIsDAMhmESrG6SKj4R1DYl+z6g/wU8BideEwdLaQLo6iPzm3hVd5ObJL
	FPSnHClSXiTzMr2Q/qw99yiixWYA77khRN2F2WPK4318VG3RqQSdGKDzM2Qx1QvDcFKleoN7E4p
	UMthhEDE0OnQVaLikR7xLg7eOMC1YdGGyIwJszVigxQ0/x/Ph9LI6kJAScnXnQq9rrLkNY/hgpP
	YSVYZl4Y+BlTEcfTufcEiXTMYKS9xwTQdeIsjg==
X-Received: by 2002:a05:7022:628c:b0:11d:fc64:9562 with SMTP id
 a92af1059eb24-1276acb7d4fmr205670c88.1.1771612238525; Fri, 20 Feb 2026
 10:30:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260125192526.782202-1-jarkko@kernel.org> <20260125192526.782202-2-jarkko@kernel.org>
 <06a08cbbe47111a1795e5dcd42fb8cc4be643a72.camel@linux.ibm.com>
In-Reply-To: <06a08cbbe47111a1795e5dcd42fb8cc4be643a72.camel@linux.ibm.com>
From: Chris Fenner <cfenn@google.com>
Date: Fri, 20 Feb 2026 10:30:26 -0800
X-Gm-Features: AaiRm52JS0oQZAXHG6_Gu7bOcgYYVkEln_usNB3YNMY_WcEL-1j3ijEwzY-7EWQ
Message-ID: <CAMigqh1H1NKP9gddjhf4M1v-aM=+EpW9O4KJmu=UysOWhn4ryA@mail.gmail.com>
Subject: Re: [PATCH v9 01/11] KEYS: trusted: Use get_random-fallback for TPM
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, linux-integrity@vger.kernel.org, 
	Jonathan McDowell <noodles@earth.li>, Eric Biggers <ebiggers@kernel.org>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, David Howells <dhowells@redhat.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, "open list:KEYS-TRUSTED" <keyrings@vger.kernel.org>, 
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	Roberto Sassu <roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

My conclusion about TCG_TPM2_HMAC after [1] and [2] was that
TPM2_TCG_HMAC doesn't (or didn't at the time) actually solve the
threat model it claims to (active interposer adversaries), while
dramatically increasing the cost of many kernel TPM activities beyond
the amount that would have been required to just solve for
passive/bus-sniffer interposer adversaries. The added symmetric crypto
required to secure a TPM transaction is almost not noticeable; the big
performance problem is the re-bootstrapping of the session with ECDH
for every command.

My primary concern at that time was, essentially, that TCG_TPM2_HMAC
punts on checking that the key that was used to secure the session was
actually resident in a real TPM and not just an interposer adversary.
I wrote up my understanding at
https://www.dlp.rip/decorative-cryptography, for anyone who wants a
long-form opinionated take :).

Unless I'm wrong, or TCG_TPM2_HMAC has changed dramatically since
August, I don't think "TPM2_TCG_HMAC makes this too costly" is a
compelling reason to make a security decision. (There could be other
reasons to make choices about whether to use the TPM as a source of
randomness in the kernel! This just isn't one IMHO.)

The version of TCG_TPM2_HMAC that I'd like to see someday would be one
that fully admits that its threat model is only passive interposers,
and sets up one session upon startup and ContextSaves/ContextLoads it
back into the TPM as needed in order to secure parameter encryption
for e.g., GetRandom() and Unseal() calls.

[1]: https://lore.kernel.org/linux-integrity/CAMigqh2nwuRRxaLyOJ+QaTJ+XGmkQ=
j=3DrMj5K9GP1bCcXp2OsBQ@mail.gmail.com/
[2]: https://lore.kernel.org/linux-integrity/20250825203223.629515-1-jarkko=
@kernel.org/

Thanks
Chris

On Fri, Feb 20, 2026 at 10:04=E2=80=AFAM Mimi Zohar <zohar@linux.ibm.com> w=
rote:
>
> [Cc: Chris Fenner, Jonathan McDowell, Roberto]
>
> On Sun, 2026-01-25 at 21:25 +0200, Jarkko Sakkinen wrote:
> > 1. tpm2_get_random() is costly when TCG_TPM2_HMAC is enabled and thus i=
ts
> >    use should be pooled rather than directly used. This both reduces
> >    latency and improves its predictability.
>
> If the concern is the latency of encrypting the bus session, please remem=
ber
> that:
>
> - Not all environments expose the TPM bus to sniffing.
> - The current TPM trusted keys design is based on TPM RNG, but already al=
lows it
> to be replaced with the kernel RNG via the "trusted_rng=3Dkernel" boot co=
mmand
> line option.
> - The proposed patch removes that possibility for no reason.
>
> Mimi & Elaine
>
>
