Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76A443CEFE
	for <linux-security-module@vger.kernel.org>; Wed,  1 Jul 2026 12:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782907968; cv=pass; b=FCfxS4/yuuWN+JON1Tv4rj/yA63deaHEOxRTV3FuIsla3LtUZYZTWjoJRqUZ2wm8ixV13RLDgF/pbqjWQlWfXvpkOO9p4S76/SIn3wIAhaq31eD/BNvCkFYf+bgO72kAJMNH+yo3YqrG+JEeKsv0fCZmG4j8QhgfllnsIiBkJOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782907968; c=relaxed/simple;
	bh=Fk8PD7DHIxYkylROYr9KgJtjNuKi7EFq1m7jUmi/2yA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eOXqdgoB7NbxbwhJUHHTzOjUepcERI5n4biYKLiRlUCzHXrQDqoBTSttImL+Uw5hafLzkSaAcx8EYJ2h42dp/uqL54QbgjCW170BFHuiLkQVgMkPZPGM+8EBTbbEhFQM8mfbCIaGbal9uFzBsM3HiteAkL70O/h7tHOfPfD8eMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=HWNFwAuy; arc=pass smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="HWNFwAuy"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c9d1fc053e0so311628a12.1
        for <linux-security-module@vger.kernel.org>; Wed, 01 Jul 2026 05:12:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782907966; cv=none;
        d=google.com; s=arc-20260327;
        b=RT1vN2upKiVOacyAFXoNcbdWDkCmEJHIuBl4vO5Twv9xl5jLJJ4KLCXcJG9SfqM/JY
         Eqdo1zttg/K14xB54pWtkGETQ9RJ/0rJZslcD1H2AkhpvvCRG7+eXX3iKffx971xrpVR
         h4Hnrxt2Bsit+nZXqLmEil6QdpAcvnPVSO6DzFllkMY4qlUwB2kNPxcdlInHYJejdwj1
         g1RFTTHp+t41HUwXjavXolu2cKWiVJA6sewXobBjLK+a3qGkE1xCo8oUgM9yKf3lTTVg
         fgOctFlrIl+2clrGCf7bIWZ93PazCd8Fs5ZVY2Z+DRjMuSx02q4zfEh/BzXIum/kJphX
         OE+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=v+RmTpdSNJcnbFj51/rDNICNavYVs5s5tmOS41AN5HI=;
        fh=Mpdu12EsIP1TSKDKUdS9fI74HnCFD2pMJAahAeePL5M=;
        b=g3/5KOHjwpwS2rZpvkP054l7x+U0JhRAorBV8PMc9fNiN1HcoHLONxTeckJH78483b
         kFOyExtAkK5nRTSNKmRF8ZwB9bLRZb2uCIyFKOzkUHCbkYfXSuFPZvHNd84PPGRSUoAv
         QZKxez5Pqm0M6rF1fEOQZg2m1FQr+bg9rsgiZowMw3aphf3QSx8gK9VxYViIgtD+1mu3
         7ojieGMf7rd5NblbRE6SDBQG1cGO+Auv31BIDKNYfgvZtba+jBx0ieGeu8FO7/ThxEsV
         hsgM0wu9h/fe2HXDlZy21n82zS5VPuaPRFiw9MXL8xYpaq05KJyrB1NPnMb3/CUmU/e0
         FMZg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1782907966; x=1783512766; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v+RmTpdSNJcnbFj51/rDNICNavYVs5s5tmOS41AN5HI=;
        b=HWNFwAuyF9faYBiKPwy/0ShIU4GCX4wa8/hc/SOe9F1q6tq9fkzadaCiz8K7nKYUps
         NpttmbGGEfEuTuLNSy8f4TGD7jG0Zpxg0iAE9BzzCM3xE8Voz4C/sKSlXqrbtPC0NFb/
         ascm4R4G6ggQ/8xtWBrJMlGiKNK+4pHnswraCYIM2tZuaj5rZ6GgCXYl8u9qerzeER+Q
         ZRZexYuBnlnePZ8w/f+27PT+QqZf9f331aWKtJrU6Oi7oHSiJU4FNN9o9jB55DuoblSO
         Si6/GSNg/N8/pWcI6bl2bpqpfdWah69vJTFIJ9WOcKR7J8D8npYORHpmI1VFRfzjZ1D+
         5LXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782907966; x=1783512766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v+RmTpdSNJcnbFj51/rDNICNavYVs5s5tmOS41AN5HI=;
        b=QjqAxN/fLNRJUJtIpkNZ8mC+hDDinfDbg7wcCL0zNUVbDWp5nS6L/xqn0VDkryQbXg
         T7EEXV5kyBl7PDdv6ghMhJwvF+tC2lYFBE/0z9XtW+eOdRUimeLLk4lCfmlRRIUJ8AwH
         bpLxdHDM0NLfO5aVgyKcnAUG8lFE+M/opxa3TuDAZIn63D3hMcoslDg1KHVdTs3rIpJI
         6aTTE7O3NEHY+bz/Aeg0lAkxgT/Bjba8oHlloZSubdmepuRl26xS3pqDM3tGZJ/tkol9
         fL+JkIM8qSzDHY09Uz+g5PuDlKTIiYIaS14TduFTzIjuOuzMU0dGs02AVVOdzA8E2b9J
         8lww==
X-Forwarded-Encrypted: i=1; AHgh+Ro1s+VZQ+yUg16SYftuJeGx2OBxaVRWx5rAgl1AVDZ7FJ5PfMkTt3qn6baG/QRh+z7ECTfdRK+y/lgmvLe9rzpa9NW7zNw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZh0nPJmHAC2sGppfwxDKOj/8WBgCq/pEtsNSjhuB1q822lwg8
	Lr6A9/OOOCfDBS+s9eYpy6N7wJwzXk5RFhoGJTTWb49Z63TTwJUazOesjma372yJlIiKNLgavpv
	np6wetse41DAjRuLkLPA3Eobv4ETjsCjCmlYCKlcJ
X-Gm-Gg: AfdE7cnB62F+4LyMMcMjCve99SLBOaFkBF24MT787uC3yuxqR5JQY2PjSMJlBDdODhA
	ahj9oW+tvmOTvCqGRNi209QZjMNE9FXIKtthw8x920K3w4qwWZ9vKaBTP/jpjLR0yRJ6MxM3bKb
	cm4NvZCNHQ9ydrGEvbYmHJQZoKaO/mIPgyzkELXAZeYp6+wDhp9OJmwjOKWT3tkg4R+9AbupJ1N
	H6FM3Xtv+DYTIwt/hAtpMD+2woTNpX7s7c8bmrdohhXlDyQf8Wd9XvDRIZxIm8/4aCEJBPv
X-Received: by 2002:a05:6a20:5484:b0:3bf:6c08:2842 with SMTP id
 adf61e73a8af0-3bff42c92cdmr553443637.49.1782907966065; Wed, 01 Jul 2026
 05:12:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407200157.3874806-1-utilityemal77@gmail.com>
 <20260407200157.3874806-7-utilityemal77@gmail.com> <20260701.ze4eph1eKo7a@digikod.net>
In-Reply-To: <20260701.ze4eph1eKo7a@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 1 Jul 2026 08:12:34 -0400
X-Gm-Features: AVVi8CeqewfdSkYjjmrhNYrv7bEJMOVzvMagAf7bsF5eyhzqBn0BNZSrdfQn4sM
Message-ID: <CAHC9VhRfqSoM89WC6TdQHapUVQe8a18rW2c-F7+tu6EjM9EdCA@mail.gmail.com>
Subject: Re: [RFC PATCH 06/20] bpf: lsm: Add Landlock kfuncs
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Justin Suess <utilityemal77@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	kpsingh@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	kees@kernel.org, gnoack@google.com, jack@suse.cz, jmorris@namei.org, 
	serge@hallyn.com, song@kernel.org, yonghong.song@linux.dev, 
	martin.lau@linux.dev, m@maowtm.org, eddyz87@gmail.com, 
	john.fastabend@gmail.com, sdf@fomichev.me, skhan@linuxfoundation.org, 
	bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Frederick Lawler <fred@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 1, 2026 at 6:59=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digiko=
d.net> wrote:
> On Tue, Apr 07, 2026 at 04:01:28PM -0400, Justin Suess wrote:
> > Create 2 kfuncs exposing control over Landlock functionality to BPF
> > callers. Export an opaque struct bpf_landlock_ruleset preventing caller=
s
> > from accessing unstable internal Landlock fields.

Generally speaking we don't want to provide APIs, either in-kernel or
at the userspace/kernel boundary, that are specific to a single LSM,
see the LSM syscalls or the security_current_getlsmprop_subj()
function as examples.

Yes, Landlock does have its own syscalls, but those are
"grandfathered" and not something I want to see emulated across other
LSMs.  If a BPF program wants to interact with a LSM, it should go
through a LSM framework API.

There have been some initial efforts to develop a LSM wide policy API
for userspace, and while it was put on hold to sort out some namespace
issues, we could move forward with an in-kernel API now.  We don't
have strict API stability guarantees for LSM hooks/APIs so we have
some more freedom to do something now, even if it isn't perfect, and
refine it at a later date.

--=20
paul-moore.com
