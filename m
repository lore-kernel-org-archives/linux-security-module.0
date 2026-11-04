Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.177
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793830884;
	b=kCIIf7E1uayWCHpLjZ6DiQxU9Z5rmYqHVKY0jI/iADDRoTrb2UGsMlpzHEQf6qAUZNdp
	 DJpS+hOyi5xKcbmk30+tVks0KDTz3lF8wIZBS94jsJq3TSlvLHyQtw9H/WSwSMqjcIrZ9
	 6IGJlwPOQB+Q/eEUszLxRjmYQA6fHBNrM6lF2IjNZJsLkqm9FTAztzV4/Q7R5vt2uEGzL
	 yt8yNilGAr5osa9GaovP+thX9TLw7sGPo2wAjPH0Y7abgamcupRuyScizIBxvFT4HfafC
	 q5mPWmwipOu/W8jk4l6Q7MAIb1TGlplm9HjLrixY8dQ/Bc6DbZ3YMPm8n4szS21+B7Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793830884;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=XrcDhqT71gfute5nPvMdg2Lwyb2czRWgca3cvWgJJoA=;
	b=C+aDeTGGb0640zJGNf4XefiE998p+PMsdRvk9tvydCuNIBcpVLWg1tVA7WUGNSF4mFua
	 wXaGPAZ7xBQCO9lol55JHVDF36Lwg3X8uKCW67z+i22Mkt2Al+Gi9+Sf8ZC1KA81rKFcp
	 yZMJNSLBRnNgeXWeQ0Glmw8/uPV7dwZt6zSWye3KohAGjv1O/9DXE8kYFNDr5Unb3/fd5
	 TEQNWiAY57O/8Yu6pGEP4kHZ5OAXHwtA0Rl1u0neMv5b7CeNrb0zSh2/YwobAhF52e/s6
	 SCFEZu9ykv2ue9in+pPMzBrPK077plRz0WpiT19W2gYNCCfM9KUc/Zh83Wl593hYa/A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=EwbACUWh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.177
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7349606E831
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 22:21:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7349606E831
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=EwbACUWh
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2e99b1e5b4cso7453925ad.0
        for <linux-security-module@vger.kernel.org>; Wed, 04 Nov 2026 14:21:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793830883; cv=none;
        d=google.com; s=arc-20260327;
        b=glZtYY1pppcbn3lIshwVoRi2runw3IUGFpXhkoz/syG04PiNRHo3DiLr5dH8Qt68bH
         fkCOjKSfLWWWExkkpHjmL/TKC/4DIxQj3awPFJaoi+Yu+oQop8cEmzymVAla5qloadt2
         977+A/lfK1vJMeBPEUujby8bAex20dIsMNwlt+HZhMTen3684qmSQf5DbucbpDfbIGz2
         S+ndDh2XovJiUZ7SiewKNTVJglQfyBUFELAtyBqyhRPgtekigSM1BD7rfU+QMcUNMWFT
         vy+5YxqK5wVkpX7x8wW2RxUKcOypAsKoqcThYhk7x5G0XoVycEDp8i7hA1mP3UUNF/r8
         OOGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XrcDhqT71gfute5nPvMdg2Lwyb2czRWgca3cvWgJJoA=;
        fh=75TIXL0ePJiGRPjIrmpPxNC7QzqziJt3ITrvlGp6Y3A=;
        b=saTLpbTKoaWZsXgYZB0zgEvRKxWawfe+Oys7VG5lzVgd0bEQ2fNnW1OuIh1aPBQHZv
         0bNqs6rVGC+T6KXnH+gzEi0mtTb2T+yL+gCYSHyhdGsdsAWnPyaVaElSMyS5aDAbjder
         lQFH7vzNMtTVA4XPgphb8h7MAreWZhNFvoWJD4EQUAopRV65eSNqWAmPvzw6pZMF5qq7
         VcxToWZ5UvuY1f4Jsai3hj/Fga9k/ogQhIeSv543gC05bbFC+xIcVV+VwOliy5TJ6Phu
         dIocWElb5gxmCOEOf3SMu2bBPGHRsolj5/uRA10mlphZRqT0P6nGBemFsp/djdDblpy5
         mqAw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1793830883; x=1794435683; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XrcDhqT71gfute5nPvMdg2Lwyb2czRWgca3cvWgJJoA=;
        b=EwbACUWh/ILFz9HQIvFu0Z5/9U+Ll2wTb4c5C2ojq2TV+gEhLFLnyn4y0Zai2GqGlm
         /MgYagyd58nnbjUOJ6Tn72s23vRbFBp0GrIJCTUVnoKN6Is1WQs/+VQJhU5RcYtvS6u/
         JXxxf71qFUOVPKibUcANVu+EzxvOdEQY4CoAA7q1vFUFO8IZBjh8pa57u6wkCYaTGZ4F
         EoXn2DSTIjbuRxFZFJ/Fq6tO0O4GjboBcYpYX27MMtgA2szoYdkFFStk+bfcUpOv0PNW
         oib9lAUSpgacm4txxkostDDgImlBXxnN+hhzaEguOWR5J52J9z0wiJkrsZ6tqNVjagk8
         C5tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793830883; x=1794435683;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XrcDhqT71gfute5nPvMdg2Lwyb2czRWgca3cvWgJJoA=;
        b=qR4zfHULoIfPkjM32Og5dYZKFQ8ZKzih63IWAaHhC2/G0LbG5fQr1zr9xlvLyYFfBi
         1qlKX4rYHRnhywDvbepx/mVjxTx9Lasn3dPj30KpAoRmKf1HvkJ6VsEMWDqY3BTgOEoh
         jnYGvKWQ6Ta++LmDsy2C3uzJjXkijNgLNbuTRIi5555MrQ0Sna07dPYhfajC6g1iRxjb
         ALeP9S+KZhWEjpbheirwyLx7kLaa62Ed9498s2wajOHICSHlMCMh+PJdpEN2uv0+aAN9
         UuHW9t/OxxFWj8orZXArxD4rb9gwRQnukXEn7pPxeoJB9O/BG7qvQC4Y+PMz/0dnf8Nj
         gbGA==
X-Forwarded-Encrypted: i=1; AKwUvBzIOc+tHngvpB2qKwlcl9MOLEwoZZGPWBrUHFjM6LMTNJQRKw5StNNVHsPxTFFIr0Wiyri5sX695IoolghqU3rOF5nCQIc=@vger.kernel.org
X-Gm-Message-State: APuU4Z8cifyON21WqyT2Y0en75ck20s9FD62Zm2XiqhZGVzv90Q+QUzU
	4V5AKv4hQCTJSBdogAd0ZftF6y17QMy4ZdGh5PXJx8LFP1EwviOfJlZOM+UDd4y4q+/3Y6xluYI
	8wB1S5jvbL8GQA1s+Q7/v27wY0naUGEgfpRFb+Tvx
X-Gm-Gg: AYBFou21GvNy7CZN6Y8Mv4URFeP8kXkntpVJplUGxEvKNKheROr6k7qQyS08k1YPykt
	/RZRvLQGjjaWZfXuHJbMlO1j3jED/KVRJa2AoEHmKei8TFH7wxLc2bshkbqRybSfmDtPHZLpbCk
	QdLNuVmMOQssecj2o5oXm4ih/qyCMbkoAppU0Y5oJYKSy8oal8v3W3ZIw/DjdlTr2mXlkSaIJLb
	ciTbTXo8zi1OJXGOA4Ff4ypWWr5Kf2Hy95wROHiZgcsMoajn06YpzD3hdIdcP/lgtZ4FLcfguiu
	SGQGbUIPip/myGxVLHCaCpcdqE40S5diDxHthJYkV84dR5qvQkNf8IoleqSuJnibK9MEEjoanRF
	XLKCA9V9eOo/580PffVF3NZPGaeacootsFDBPPOlpubpI66XQNCeJmeYeMPjRe8G547gK
X-Received: by 2002:a17:90b:184c:b0:3ac:80dc:f40a with SMTP id
 98e67ed59e1d1-3ae897ccf87mr13484262a91.16.1793830882894; Wed, 04 Nov 2026
 14:21:22 -0800 (PST)
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260918143142.19435-2-stephen.smalley.work@gmail.com>
 <20260925-gebaggert-ersehen-serpentinen-a6e61570e1b7@brauner>
 <CAHC9VhTga1k7SnT+JXWgmCdfsEDkm83PwjonVBpNeNm+q3UWVA@mail.gmail.com> <CAEjxPJ7w-8J37OjPUNzLzofbPezq41yK_GtsZJxRDNbDRZnw+A@mail.gmail.com>
In-Reply-To: <CAEjxPJ7w-8J37OjPUNzLzofbPezq41yK_GtsZJxRDNbDRZnw+A@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 4 Nov 2026 17:21:10 -0500
X-Gm-Features: AclHuK8oAOcmQr9QeNcZUG9DLGm0Kon1y4YmBx18Q9hBBgLq5tR5otd_ITe4khY
Message-ID: <CAHC9VhTugsLKwxQaREShdP-7+Dc=ndSRQxAAuJGu+tJkFoTQfA@mail.gmail.com>
Subject: Re: [PATCH v3] lsm,nscommon: initialize the security blob for the
 initial namespaces
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, linux-security-module@vger.kernel.org, 
	mic@digikod.net, serge@hallyn.com, jack@suse.cz, jmorris@namei.org, 
	omosnacek@gmail.com, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 1, 2026 at 12:38=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Tue, Sep 29, 2026 at 9:59=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> > On Fri, Sep 25, 2026 at 9:58=E2=80=AFAM Christian Brauner <brauner@kern=
el.org> wrote:
> > > On Fri, Sep 18, 2026 at 10:31:43AM -0400, Stephen Smalley wrote:
> > > > Commit f675d2e95569 ("lsm: add LSM blob and hooks for namespaces")
> > > > added a security blob to struct ns_common and allocates it from
> > > > __ns_common_init(). Most initial namespaces (init_user_ns,
> > > > init_uts_ns, init_pid_ns, init_mnt_ns, and, depending on
> > > > configuration, init_ipc_ns, init_cgroup_ns and init_time_ns) are
> > > > however set up statically via NS_COMMON_INIT() and never pass throu=
gh
> > > > __ns_common_init(), so their ns_security pointer is left NULL for t=
he
> > > > lifetime of the system. Any LSM that registers an lbs_ns blob and
> > > > dereferences its slice on one of those namespaces (for example from
> > > > the namespace_install hook when a task setns()'s back into an initi=
al
> > > > namespace) will fault.
> > > >
> > > > Allocate the blob and run the namespace_init hook for each of these
> > > > namespaces at the end of security_init(), after all ordered LSMs ha=
ve
> > > > registered their hooks, so every LSM sees the initial namespaces th=
e
> > > > same way it sees init_net (which is initialized at runtime via
> > > > ns_common_init(&init_net) from net_ns_init() immediately after
> > > > security_init()) and does not need to special-case them in its own
> > > > ->init() callback.
> > > >
> > > > Provide a ns_common_init_security() helper in kernel/nscommon.c so
> > > > that the list of statically-defined initial namespaces and their
> > > > Kconfig guards live next to the rest of the ns_common
> > > > infrastructure. init_net is intentionally excluded: pre-initializin=
g
> > > > it here would leak once __ns_common_init() clears ns_security and
> > > > re-allocates.
> > > >
> > > > Fixes: f675d2e95569 ("lsm: add LSM blob and hooks for namespaces")
> > > > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > > > ---
> > >
> > > Seems good to me,
> > > Reviewed-by: Christian Brauner (Amutable) <brauner@kernel.org>
> > >
> > > I'm waiting for Paul and then I would pick this into namespace-7.4.mi=
sc.
> >
> > Since we already have the other LSM/namespace patches in lsm/dev I'd
> > prefer to merge this patch into lsm/dev so it is we have the core
> > LSM/namespace patches rooted in one branch.  Going forward we can
> > stick with the topic branch approach.
> >
> > Are we all okay with that for this patch?
>
> That's fine with me.

With the v7.4 changes now in Linus' tree, it doesn't matter much to me
where this lands; if Christian insists this go up to Linus via him,
that's fine with me (my signoff is in the branch below).  However, in
the interest in getting this into linux-next sooner rather than later,
I've merged this into lsm/topic-7.5-01-lsm_init_ns_alloc branch and
will plan to send this up to Linus during the v7.5 merge window unless
someone screams foul.

https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git/log/?h=3Dto=
pic-7.5-01-lsm_init_ns_alloc

--=20
paul-moore.com
