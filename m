Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60F130DD22
	for <linux-security-module@vger.kernel.org>; Mon, 18 May 2026 23:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779146584; cv=none; b=RbrK+ubvMwoF0zP+PxXmzr/RpvVeY7kbe0uvTFbkDtT1t8hxRB6ruG8MIRJxzzBoXCnZ10mrDIFIQYE5eIHoMozLSKyqMXcoAKDcISfINCfKpFDPC1XG2Fjbqg1c5LcF4J8C/2sGijJQqli4VxfYwY59CY59r47jyUD2kVmQ2C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779146584; c=relaxed/simple;
	bh=OB6kYmMn6vo3vaMVZ12Q4bsdsJGNYLvDRQKnvb3ZEx4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D3Iu58LMxl3TsrY/v9YZEMUvS4khJ2V1eL2voruLVgA1oLVWUJQEuZ/7hT9OJUX+dagOBiSq1IC9Uorjt9QLgWJsZ2bVy0Tr14HALxRDVZg/X9OJ5+EyOMf1lvfCtuJ3FjQgMgCkVt1tEtPkXcqvaEwo6Jt2Hu6QCfjV3ZrbHg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sD9fCqpi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sD9fCqpi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9021C2BCF7
	for <linux-security-module@vger.kernel.org>; Mon, 18 May 2026 23:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779146584;
	bh=OB6kYmMn6vo3vaMVZ12Q4bsdsJGNYLvDRQKnvb3ZEx4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sD9fCqpibOhaCsh9QdseTFrYYosUHQiE3ih5+9gDujAgvob5ZpfQAJtx2mS6uoOAm
	 GOcO3pgTHMd723zt9zOrSbcvrrf4OdElyMPwnmBSLXggjbNWPip7Z1Lyh41wYOgaQ8
	 oVILPTTdJfTF1KM7M7UpbjkDoNmd824M2i50WqcmgiGMQtnCKNByIx4PlD9E6E1bVH
	 YoRdwA/uMclT1UuqCxyoD4s4z+oTQSW/sDtERRFruGNIaTQL0byWc4lami3+gYVhA5
	 eE5ME5daoGT7m/SpjSxVK1axMdav4pikB7rQzlACyF240tXMb/gjdfM10J0l8HccyN
	 h4pwL0LBYM6tA==
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8b9f2295a9dso34824266d6.3
        for <linux-security-module@vger.kernel.org>; Mon, 18 May 2026 16:23:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/+kM04DR5rjvvE4n7Q6TaAw+tMvdfExje4misOr1EqhVWFEEYGd5il9HUFSVkN2X+pShot8BNlWtXuQXcuBMByjYYy+2U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfK+VyOcTwhrfRqnNSmJklCzIRGvHQfljMWxzzkK2uCUavhAQf
	d7UHs4b3kDLkS3T/BJksLwYbodTopEeoXdrOBP9OSwTlPxLtH6fSjZKAa9veIZxuC3JbunWZRfi
	oR5eaTtGiEg5S0ZfkOmODYAqvVPw823s=
X-Received: by 2002:a05:6214:ac5:b0:8ca:10aa:e1f9 with SMTP id
 6a1803df08f44-8ca10aae3f5mr290946326d6.42.1779146583902; Mon, 18 May 2026
 16:23:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507070547.2268452-1-sashal@kernel.org> <CAHC9VhTwDt2Bx8n0io9Qge_fUEnrHsxrFAQY+KaemKWqJqBQxw@mail.gmail.com>
 <CAPhsuW4TJRqQKXgcBYog8YgFLU2h2Zq9ReahxTYp_zpDyvO8AA@mail.gmail.com> <CAHC9VhS1DJNs9gDB6gD9WKhL08giSVajBskZ+=mY0AWRCAsw7Q@mail.gmail.com>
In-Reply-To: <CAHC9VhS1DJNs9gDB6gD9WKhL08giSVajBskZ+=mY0AWRCAsw7Q@mail.gmail.com>
From: Song Liu <song@kernel.org>
Date: Mon, 18 May 2026 16:22:52 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5jQOzRTi1ea+=UPhx5W9bkBdivPagRE=O=nx0zf_vb8w@mail.gmail.com>
X-Gm-Features: AVHnY4LBviQM2Wc3xspaZE5GnjsB83lBdOh9pKPiqYN81JHKPUgKpxqJif3TGBc
Message-ID: <CAPhsuW5jQOzRTi1ea+=UPhx5W9bkBdivPagRE=O=nx0zf_vb8w@mail.gmail.com>
Subject: Re: [PATCH] killswitch: add per-function short-circuit mitigation primitive
To: Paul Moore <paul@paul-moore.com>
Cc: Sasha Levin <sashal@kernel.org>, corbet@lwn.net, akpm@linux-foundation.org, 
	skhan@linuxfoundation.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	gregkh@linuxfoundation.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2026 at 2:29=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
[...]
> In my opinion, making killswitch an LSM is more of a procedural item
> that deals with how we view a capability like killswitch.  I
> personally view killswitch as somewhat similar to Lockdown, which is
> why I made the suggestion.
>
> The use of kprobes, while an interesting idea, presents problems as
> allowing any kernel symbol to be killed introduces the potential for
> security regressions.  As a reminder, some LSMs, as well as other
> kernel subsystems, have mechanisms in place to restrict root and/or
> enforce one-way configuration locks; while many people equate "root"
> with full control, in many cases today that is not strictly correct.
>
> Yes, kprobes have been around for some time, this is not a new
> problem, but killswitch makes it far more convenient and accessible to
> do dangerous things with kprobes.  If killswitch makes it past the RFC
> stage without any significant changes to its kill mechanism, we may
> need to start considering more liberal usage of NOKPROBE_SYMBOL()
> which I think would be an unfortunate casualty.

I don't think we can use NOKPROBE_SYMBOL(). There are functions
that we don't want to killswitch, but still want to trace.

Thanks,
Song
