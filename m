Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DBD366DA3
	for <linux-security-module@vger.kernel.org>; Tue, 19 May 2026 20:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779223818; cv=pass; b=o3BIeUrc3PRNNzFVPuEek3m90FcjFr35JmCy83H5bc9Ei/363a2ZGPlp2uM5Fy1RXFQ3K/HNq5J4aqK5j/u9R/vPNDqDaGYEG40G2EjXJVLiFV3pLc0y+DWJYeccDWs8byLQvi635lkaDiBMacL5LffsiVwDIzWfNGx6Twb9acI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779223818; c=relaxed/simple;
	bh=dkFcUlc4fzRySYc2NVKuup3javqjiLZAjWqACwOHCrk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A324YqNxaSTEyXQLP0QdNEnsqr7mXd4YJKAGf7ic6EfD4aik5q4IiAGyDIzncW1T2ROAPL3zu8VuaIV22FaBmL2U0eF6j9f6Fx0nF51DvXeoDxvtIJ5204z4YcN2T+eQSMfgi5yBukLx8dJ8lDcHkXzJ+WvXtf5tRg546R4cdZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=EtdA27y+; arc=pass smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="EtdA27y+"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3699cdeec05so1497241a91.3
        for <linux-security-module@vger.kernel.org>; Tue, 19 May 2026 13:50:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779223817; cv=none;
        d=google.com; s=arc-20240605;
        b=Q6n5ET147st/WDdRnczD8aM2lgPLxoLzFDgYQVmY/gF60TmBVoUWTeIZWyO0RdEoB7
         34LXqOrKJLSnmU2bI0qEWbsk5ehRYX3odJ+Uy7kXqIiWt2HhD+vTdp5f+hCJobJ0/UK6
         +2xSDVZaCYzZlemavw7hgoCPCs7QZ3hlHsc3HafYpg8t+YZI2FKdCvS6gC9g+xFdQL9H
         qHFIh54xHtl+ThkcewFYovIcGVu7fLOelE/NQDEJ67oTKZ1A95/SPdQPX/JYaQPYW4iz
         lVUJz+cITxr3MTWWzQSG7HRt958jkQJPS5aZUtyqA051Mq9MkxXta0jpm2qCkPWokC/2
         NBEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=N8O9GVoY1EHAAfM0MQrVZUm+Yf00xHx28lkWL3OXgms=;
        fh=oSSjlcutnkeypCLhLJLmgQa0O+hl+XcUJJXDnohhMYo=;
        b=GUVH7JXqZmpr5StNxzaWMArvOrD0MbcNESFRj5ohQwBcGIQ2yFCOyNlDK0ykD8dAT4
         UVPmrXEZo5JUbi62aca9EDVx7FT0lqOVSZ2injoHGCjm1XhrD9v6/3PLgAQR3BVdfaT+
         KMy1UBQ+iRV8OW8MD1AnLJyddIamUq2AjjGNJQlyg+ArO0OSc1KcDaqzJ8tEClEVbMbz
         XO3lCxcMFoqnrHIEMW+1kJjtiLY5wU4WOinAj42jfHRQX8KVRsEeas3pSs/7gg6vBTzu
         dhQg0yUEgeiQ2H3bhuCcyh4yKntdtHPczawtvBU/ZQH5JwSXLE30CXvTvVBBYwpv83qf
         PhUA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1779223817; x=1779828617; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N8O9GVoY1EHAAfM0MQrVZUm+Yf00xHx28lkWL3OXgms=;
        b=EtdA27y+Rf/GNne1QZP75bT6ScTLnAp1YUAKy23OnL0hsaicNEGAcYgP//u/7xStib
         w7NVDhBCdwWR2XKJwDzyf0rzep+/MjpgqOyrlYgUSLcVlqL+cRu1MnfHqrHdoXoYEasR
         a0zRyNGifuh+D6X0r80EzQk/QEaUjLDfG9y4hCpOU3xodnb+OChoKKvZ6TEGQJcq+Xlx
         2168lM5brvj9FbLcU3gEW4GsKjvLK5u9WpmqdX+2xmehop+rItuNR49VmS7nN5yG0HnA
         rmwdRtljMcnj9uo5+W4Q9KZp21eq+bXKFJVEmdDpSFEPFTBrtiLGVbR42pd0Y/78x607
         b0oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779223817; x=1779828617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N8O9GVoY1EHAAfM0MQrVZUm+Yf00xHx28lkWL3OXgms=;
        b=YlxJZMvPtHfVq2foUMtFSqa9phYEHdIudbdkUM3rN2Pc+LYxSPJGA9b3Kth5E//Vy7
         FaH54la7ezG4JUq1MVtwB+6JYEMVu4WMsWKilbTkeCZvfaIB6GRYgZCWFhbBee+kvgO/
         S/P2Aq5hEUTDJWNwcviDbSG1XrqzesQMe4q0mw8bLD+8TWfZADoReAZMKKZrzKQYTWaI
         FXWzY6SJJrR6UwIvUOLUhxz/Ah57Co8pDfAeHlDYsyqSywbw4oqkPqJyYBIkcrXD7CqC
         xFHSKZ5O8Fe4TI28xc7YGFG5V9Bq/DnkZO5edLWkVatI3tGkujKmAVx9zyNK7YcL3wUk
         /usQ==
X-Forwarded-Encrypted: i=1; AFNElJ9rx1hshM2qkIKgtxvP0gaw5uocfe4jzWSURGvcG/mkaDUpnfot0ssBXcDufxlIdIj1Rg0ffnjmDgWNoclyFsNZNBFMqEg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8/T9b07eIHRs7R7dtkBI39WOgFi/qQ3mBKJoeYRKrslFSm/+8
	SB7zjvDXrMzz6PdTkRXduub1zSJ9bFyyE6WOWjPTDzMtmjqH1yRki7eISXmz/Zv3eNnRzc4TGZs
	DJg886AMXq8KW6oMk1XPDJlyavnqoId7e1KHckmeg
X-Gm-Gg: Acq92OFxAaeZfXOst3XLWvIGkl8UKmTkzJKpLeRBKoQlvzAEdI1jFw8/hu4oBF0Id4b
	NVrDRwLDprxKxZijrx5u3tmPqxczyXZWEh0iDdXSygLNjxhqx+1KIApKc8TZO9sQRYsByhtFL51
	Y6Y50KhAoD25/mUo3ViwIzEGPRpGSErBj+WUPHmYjfQ8WajsvrNajMkA95fYY8TwKy+LtdxrJA+
	ORKFtao5/1e3fDw6sB5mQoj8J17k/5t5VLwVeOtv5zs7OkZDl7Stda/u3jP3mhMTWxufnj02OfB
	34sUTGs/zQoVgoWRUA==
X-Received: by 2002:a17:90b:3811:b0:35f:bfdd:f5a1 with SMTP id
 98e67ed59e1d1-36951b711c1mr19794993a91.13.1779223816741; Tue, 19 May 2026
 13:50:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507070547.2268452-1-sashal@kernel.org> <CAHC9VhTwDt2Bx8n0io9Qge_fUEnrHsxrFAQY+KaemKWqJqBQxw@mail.gmail.com>
 <CAPhsuW4TJRqQKXgcBYog8YgFLU2h2Zq9ReahxTYp_zpDyvO8AA@mail.gmail.com>
 <CAHC9VhS1DJNs9gDB6gD9WKhL08giSVajBskZ+=mY0AWRCAsw7Q@mail.gmail.com>
 <aguvV8QCxK28ZHct@laps> <CAHC9VhTEs7rCaoPG7cWAzyVkN3ztdadHAq0g8mEy_MgCiCe=0g@mail.gmail.com>
 <agzBd9mMt3Zf7j1j@laps>
In-Reply-To: <agzBd9mMt3Zf7j1j@laps>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 19 May 2026 16:50:03 -0400
X-Gm-Features: AVHnY4KCfX5Y0PjhjYuSYVFhPqpM3ke1eUGUAa_yfyARFQTZnpheXYisH7aJzTY
Message-ID: <CAHC9VhRL1L99N9k4nYy_cN=TXHJC7dys00=zfhXeFej3XPnF8g@mail.gmail.com>
Subject: Re: [PATCH] killswitch: add per-function short-circuit mitigation primitive
To: Sasha Levin <sashal@kernel.org>
Cc: Song Liu <song@kernel.org>, corbet@lwn.net, akpm@linux-foundation.org, 
	skhan@linuxfoundation.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	gregkh@linuxfoundation.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 4:00=E2=80=AFPM Sasha Levin <sashal@kernel.org> wro=
te:
> On Mon, May 18, 2026 at 11:08:38PM -0400, Paul Moore wrote:
> >On Mon, May 18, 2026 at 8:31=E2=80=AFPM Sasha Levin <sashal@kernel.org> =
wrote:
> >> On Mon, May 18, 2026 at 05:29:32PM -0400, Paul Moore wrote:
> >> >From my perspective there are two different issues here: should
> >> >killswitch be a LSM, and should killswitch leverage kprobes to be abl=
e
> >> >to "kill" security related symbols.  After all, are we okay with
> >> >killswitch killing capable() and friends?
> >>
> >> killswitch doesn't do it on it's own. It may be instructed by root to =
do that,
> >> at which point that is root's problem.
> >
> >As I mentioned previously, there are cases where we can restrict
> >root's privileges today, but a functional killswitch would allow that
> >restriction to be bypassed.  My last email to Song has an example with
> >SELinux.
>
> This would be handled by just disabling killswitch in those scenarios lik=
e how
> we do with lockdown, no?

One could presumably deny access to killswitch, but that pushes the
burden of choice onto the users/admins.  Yes, that is the easy way to
solve thorny use case conflicts like this, but it would be nice if we
could do better for those who have to deal with this in the wild.

> >> >In my opinion, making killswitch an LSM is more of a procedural item
> >> >that deals with how we view a capability like killswitch.  I
> >> >personally view killswitch as somewhat similar to Lockdown, which is
> >> >why I made the suggestion.
> >>
> >> Maybe I'm not all that familiar with LSMs, but we would need to be abl=
e to stop
> >> "random" code paths from executing, and I don't think we can create LS=
M hooks
> >> at that granularity, no?
> >
> >I don't see any LSM hooks in this revision of killswitch, and as long
> >as it is based on a kprobes I can't imagine it would ever use any.  As
> >I mentioned above, my killswitch-as-a-LSM comment is primarily about
> >killswitch filling a role very similar to Lockdown.
>
> My question was more about how to structure killswitch as an LSM. I want =
to be
> able to poke at pretty much any function in the kernel, rather than restr=
ict
> access to a known list of functions.

Well, like I said in my last reply to you, I can't imagine a kprobes
based killswitch would need to worry about the LSM hooks.  Structuring
killswitch as an LSM would be mostly a few lines of code to register
it as an LSM and that's about it.  Benefits would be minor, and likely
a matter of opinion, it's mostly about how we view something like
killswitch in the kernel.  If we view it as a security mechanism
similar to lockdown, then it makes sense as a LSM, if we view this as
a completely different thing then it can be whatever it wants to be.

--=20
paul-moore.com
