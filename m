Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793228190;
	b=JbioOd4uHslYKb9o4Sc+RVuK1i6h9vI1+xaXbZXrk3AQZD6UDcHWCpf28vBeqU2G66ja
	 yPDqvIQ169fgBeHttP1e33T6c+jfuLaKofXZqSeWrEqR/G7T1+oNBmsEH+H26BojV8ALH
	 8k6gF3afNHxJVmLrzD5vmAlblnVXm54mlxKXXAEwmwO/qcsvq36xe2Ho8sosuUWqZ04u3
	 PMfoDXixhflxX7df5eVfE6+NZblXG/6QYwej2PjN358rn+lV5srqU3FvnZCokVFW605Qe
	 RB3icsjKoPAQWHVjZppusN2RZSHON+H4FHu0eJqqcrMSUnAe+npMDdaIKdvNwfSd0CQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793228190;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=V0MpBzACJCm623um40rfrBkC0GCIrNAzwGLFIF9vVVM=;
	b=2Kpx4ebWxLWXGdssy0JgLouLU1jN7TaAFvP9bzVdXUGn7rSHVj24O9sSpkrPPw2BDOTr
	 oKjq+DCKQ7TIQiGZJQWmCnI2UTRaO1LCcY9+4Dz99mwfJTZKsNEk07UktRcLdKdNuU0EJ
	 wcSikjJw3eels4X9v9iZl4XmJeF+Vh/Tb14ERM05hfpPBSuRIDxF1gw6PrIzaPdfyVpjj
	 6FVxG+tw+xik7jMPa4gUqc1FeFl4yaaT5gAR5+sLgcwafr5yVEjye8ykGwgvOBvKNVIvm
	 DPExVhmD+R2LMqYQZU5iBajD0G6g6A44HB+b2enezGFeHLCZEe8lC7AlU6d06+duAnQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=amacapital.net;
	spf=pass smtp.mailfrom=amacapital.net;
	dkim=pass header.d=amacapital-net.20260707.gappssmtp.com header.i=@amacapital-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=bZOSlVJG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.41
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D7A606A31A
	for <linux-security-module@vger.kernel.org>; Wed, 28 Oct 2026 22:56:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8D7A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amacapital-net.20260707.gappssmtp.com header.i=@amacapital-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=bZOSlVJG
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5be3cff0f6cso1096325e87.0
        for <linux-security-module@vger.kernel.org>; Wed, 28 Oct 2026 15:56:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793228183; cv=none;
        d=google.com; s=arc-20260327;
        b=ZbTEyR2qVJNKYX3qxYfjskeYPsgNwVKi/3QibEBiVa/C452hQpOTVLfgq4i4tXxqLn
         IpibGikj8HOV3F7pTzNxzsrNF7g7xEakSvn50C36fMPhpadxKgI3STvS73pq0XkIuUJj
         YefBc6RbIgnq75us1Iko268vA/Cc1SG6gO9nsjeD4i0vPNzfiJ8pzdIrcYhBIADyLLxg
         UpbbIDjteIRwsjqgHv9xqQ1d1LBz3FREmFdJ2NbtY6pkYvDJ+B445KPmrwvzdf2dPFFl
         jCoLNLYH4JJ56ANs7SaxNNK8yk9HJ8x8L7MkH3CZO+xKHIXr5KcZO4r6vUNhNRJVgDeM
         60bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=V0MpBzACJCm623um40rfrBkC0GCIrNAzwGLFIF9vVVM=;
        fh=T3GUdBS5KP9KA0AK7n3TXxwCzAkQqMyKafzxBjdWN/s=;
        b=CQP4SKS1+eKsemUbJ8OkRsUhUpo2nIlsaNtX39FtfKHaNGFhY8S0n3hWgxD6Lbe8y5
         cvwvBXXc22HHSoa1kJrHekfevwJgRwRs0urRnMmlZpFaU3gVXhMG4fhfZtt3RWSZrcp8
         bgrMJjg79whcxugeLiCF/KBbFyghlCOkgvvOPFpDxlXb6FgTjwKRQrCmpqhnGW4RNVEL
         tgp4VgC1OQWqcIaL1ygUbnVzZZf1bx+EKGJ3PG2V0zCIX48OqcqrWNoKzr3II4utswky
         eaN7HRf+sxxkylRCqogBetC4ScMFKHlB2ylHV3hTRvJXxM07M7ln6/Cbc6ooHGsRXUZI
         hTNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20260707.gappssmtp.com; s=20260707; t=1793228183; x=1793832983; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=V0MpBzACJCm623um40rfrBkC0GCIrNAzwGLFIF9vVVM=;
        b=bZOSlVJGtHEYwYd8P/JXTJGc0heKbmZ4zF6gCQsfAWUdj+V8lveZo37a35kI44zsZG
         8r9p4GP3JXlJVRf/lRQCeD7DpNu+EpwjtNRy8B/mAQWg4VrhYeyQL+tDoFWr1hQ8Js/1
         WmBu61FcofxUa9iC2o9+OqMJhIY2ZxGCvswPzn8Prxv7xx3PhcvCqjngxpEz26C3Zh5+
         QCDR/cnpyszjYnYa+NJ3GR//R0d+Eo5+XTYFDLb2ivFHUdLHCDDXia/PshsMR6SOBMAE
         M4o+rVXHudqK4Y3GjiNjn4cOkyeetgJTVfYAYDZGmr6blu+DiQE+KChOyTySu65qfvrn
         wIcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793228183; x=1793832983;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V0MpBzACJCm623um40rfrBkC0GCIrNAzwGLFIF9vVVM=;
        b=W5B//qjV+T+/UvXi8xvYy6xvckbAIceHAzvOzOw6xvpn8/aNht2SbVT206G8nMpTVh
         4wDj0j55I5ALv57qHHXTESayeN0r5Vw2XYwLKz9XqnVTW26l7pdG8Om/KiJFqzhPQL4x
         GfJmTfR7KqKZoKiSzkdCYuIVqdS3YnD1PO+xIB6MSkTvvEllUjZHbycFtYl4JMEz5vUN
         svMpjvjMpGAc81qQDwGhmgW8rCq1SbgfPWzk4TG7Z8C14T3ACSvvj+CxTt2U+3nMQNxQ
         FMluS+dD75O15bwd+uFWynMrYMkNAA7dyZvW3bviCtBV5ZicnqMZM2EMFznM8Aoi3gPk
         sJEw==
X-Forwarded-Encrypted: i=1; AKwUvBwXJPCeJfG1XWjSYWeU0IwSDnhXQVJqIX1n1jvvppbBjyFXnpUdYaWtnImLlU0vH4RgU4CkQzkWW13p0R2LOWgfaSgr6S8=@vger.kernel.org
X-Gm-Message-State: AFq9FYKd8IYyJ6J1DuhJitjAd8A+VPBVOahZBkwYlWdcMTTdcqzB7sxW
	CaucgrKeWNqUMDJQB53sMYEFz51UcXWE6fqPwxFoj5GHqICKyWm+MBIggXEzwpgjECZka3ffM5e
	bj8I2lO1TokHtTp2KiudBxDnZCeLqTZiK14dDmbGB
X-Gm-Gg: AYBFou2uzyyJV635TRVZU3RQ04GMyFc1OeOQj/QxCZbjG9YY8/YePl0RsXgQgSffm7Y
	BoHpkCKLAFb1PzmnE6RRWMqP+e/EAv8YapO32HFyucm4WbDGbufNLnxDhThPZ9U37Qi2Ls/J0eX
	04QcVWoBiG5BYUosZlP8TPP5w+l4gh+hQPopof7/GYvXARuvG1gXccWPbimgGLLjtbopVAo9d9Q
	+e+J/UrfgIkDR00Ul6vbir6cge4YKye9pLQkywzvE3f5AQ121+kFGotx4fr39ZBzJMshL981dDa
	wg1br/T7OjiAFUOmHe2/mnQbwbBfEyEOJo5H1HXZqyjtROY/BFwMxuXD1Juwgyp1DQuC1W/uuS4
	KwtIVK1dNyd7BIqo/J1m2NgY/N0GLbXUUPW48Wg==
X-Received: by 2002:a05:6512:3e19:b0:5bf:c239:71ad with SMTP id
 2adb3069b0e04-5bfcad69127mr1282221e87.38.1793228183136; Wed, 28 Oct 2026
 15:56:23 -0700 (PDT)
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261028221705.3915340-1-halg@google.com>
In-Reply-To: <20261028221705.3915340-1-halg@google.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Wed, 28 Oct 2026 15:56:11 -0700
X-Gm-Features: AclHuK_P2NrO86m_OPGwNSCuxqmiVp7fbTt4tlVfFApQPbneLnvcqCjpUTpk6N8
Message-ID: <CALCETrW9ygriu54gxiHFLEd5+hJminQo0r8Jwd63wR69Dj4W7w@mail.gmail.com>
Subject: Re: [PATCH 0/8] userns: per-namespace capability bounding set and
 opt-in netns loopback
To: "Hallgrimur H. Gunnarsson" <halg@google.com>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>, Kees Cook <kees@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jan Kara <jack@suse.cz>, 
	James Morris <jmorris@namei.org>, Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Jann Horn <jannh@google.com>, =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	KP Singh <kpsingh@kernel.org>, Jonathan Calmels <jcalmels@3xx0.net>, 
	Casey Schaufler <casey@schaufler-ca.com>, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-api@vger.kernel.org, 
	containers@lists.linux.dev, netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2026 at 3:18=E2=80=AFPM Hallgrimur H. Gunnarsson
<halg@google.com> wrote:
>
> When an unprivileged process creates a new user namespace, it is granted
> a full set of capabilities (CAP_FULL_SET) scoped to that namespace.
> While these capabilities are isolated to the namespace, they allow
> unprivileged local users to reach deep kernel subsystems (most notably
> networking configuration and raw sockets via CAP_NET_ADMIN and
> CAP_NET_RAW) that historically assumed a trusted caller and have
> accounted for a large share of local privilege escalation
> vulnerabilities.
>
> Many workloads and sandboxes use unprivileged user namespaces strictly
> for basic UID/GID, mount, PID, or network isolation and never need
> high-risk capabilities like CAP_NET_ADMIN or CAP_NET_RAW. Likewise,
> system administrators often want a host-wide policy ceiling restricting
> which capabilities unprivileged user namespaces may acquire, without
> disabling unprivileged user namespaces altogether.
>
> Prior work by Jonathan Calmels [1] proposed addressing this via a sixth
> per-thread capability set (cap_userns) alongside a global sysctl mask.
> During that discussion [1, 2], feedback (e.g. from Casey Schaufler)
> suggested that rather than adding another per-thread capability set and
> prctl() interface, capability restrictions could be integrated directly
> into struct user_namespace and configured via clone3(). At the same
> time, as noted in [1], a clone3() flag alone is not sufficient for
> administrators who need to enforce a host-wide ceiling on unprivileged
> user namespaces without modifying every userspace callsite.
>
> This series combines both pieces of feedback: it embeds a capability
> bounding set (cap_bset) directly into struct user_namespace, reusing
> the existing task cap_bset, cap_permitted, and cap_effective sets on
> namespace entry, and provides both a system-wide sysctl ceiling for
> unprivileged user namespaces and a CLONE_NEWUSER_BSET flag for
> voluntary per-namespace restriction via clone3().

Why should the task's cap masks affect this?  *Maybe* cap_bset makes
sense, but I'm struggling a bit to see why cap_permitted and
cap_effective should matter.

Also, I think that Docker in non-userns mode restricts cap_bset, and
the purpose of that restriction is rather at odds with interpreting it
as a restriction on newly created user namespaces for purposes of
vulnerability mitigation.

>
> In addition, because restricting CAP_NET_ADMIN at user namespace
> creation time prevents userspace from bringing up the loopback
> interface in new network namespaces, the series first introduces
> an opt-in flag to automatically enable loopback on network namespace
> creation:
>
> 1. Opt-in loopback activation on netns creation (Patch 1)
>
>   New network namespaces start with the loopback interface (lo) DOWN by
>   default, requiring CAP_NET_ADMIN over the owning user namespace to
>   bring it up. To block external network access while preserving
>   localhost networking, sandboxes commonly create an isolated network
>   namespace with only the loopback interface enabled.
>

The whole unshare/clone flag situation is getting out of hand, IMO.
And this new thing makes logical sense but is really about reducing
exposure.

Perhaps we should instead have a small list associated with a userns
(extensible in the future) of things that the ns's admin (i.e. whoever
has CAP_SYS_ADMIN relative to the ns) may do.  That list could
include:

- Create loopback with sensible defaults for ipv4 and/or ipv6 (i see
no obvious reason to separate them)
- Create tun/tap interfaces in that ns (and attach them, etc)

And add a very simple new API to do these things.  Actually, the
tun/tap could just use the normal mechanism.

Thoughts?

--=20
Andy Lutomirski
AMA Capital Management, LLC
