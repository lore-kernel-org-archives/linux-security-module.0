Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4CB181333
	for <linux-security-module@vger.kernel.org>; Tue, 14 May 2024 19:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715716515; cv=none; b=YbLbbMXA4llht6L8g6uq8p7imnfP+QejlUoA2FbTdBkXcADRk83+kKoXWRy7oHuXerk79tY+9dT3Xb5JEK7wx+9HQFU0DC2GTjz2OpLgXDYNrY2r6hjbh+NFQNgTvIGFq2e2h07DS5CO7xjP7CsVD4FDO7BXcmcREIqfWav3tEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715716515; c=relaxed/simple;
	bh=Tn7ggDBZ467fewog7X29iTchxNr3w1imZ5QlMHFp0v0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fNZS3q2vcDyN33xgpAzS7P9SCSYzG4TYfn9tEiGVIJqAgysWkevX14uivGQVLPSuDijYQugb9/7zvb+wdfPQ+LqkbayzQN3ggNOZTzsvVLrdz3qRJ5hI/A3sqQWdusSqtGmzZDIajRo3ZjPWqjYi6D/JHfL+yL43Vit4QNwSDsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=BQ5nTcrJ; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="BQ5nTcrJ"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dbed0710c74so5193130276.1
        for <linux-security-module@vger.kernel.org>; Tue, 14 May 2024 12:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1715716512; x=1716321312; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I5DfaKSvWBjSuruH8QpkzwqbDWxyqIe8ntp5STBjhPE=;
        b=BQ5nTcrJeiDGmJPbk+0RbPTElKvyqninC22tbUnOXLGS1LGq1NMiBlKd/vEdzgWmX3
         J6CyOwcl5ivwV579DFEK3+TPJNedRbX5ta4rufuEGc9PXSFysi/1ahLWwCZ145ht6Uyl
         Bw6LPtcCw4jhHWxePof5VARvVKrO7Gny5IjBXAEBH3jl2fhWU277pEPsN/aRwtFOao6H
         alRLOYOxC3Mw4O3SYM24cutTSjj6riCyqehsqMkh76Ix8NCPvVfYnaoGWhA3ar0CMRBO
         uOblc/Ql1V5KS6OL2dGv81/5AuDDrkYhB4Q5bH42HhK8obCcNSuLZXmuVzWWpy725Av5
         SDxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715716512; x=1716321312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I5DfaKSvWBjSuruH8QpkzwqbDWxyqIe8ntp5STBjhPE=;
        b=w2Kvnm2EmUxIlGs/lIBM3JP9PBqbB35bi2IFweqrX+KHaNFMIFKu5PpMH52CLYkftO
         rpy5MK30UTnEPBOCF5xbRKMPDi3NPB3DBTv2sqkEBJGc3/auF2Lg7MgasBDkCoc1P98P
         FkbXN4IbmKNqOaxAPhgBZwv01v6AWXhTIiYo04JNRnl+BhMgxyhTgX1raVWbl7TncdHf
         thGnAp/vL2M9LAZof5RvzLA4IMBCX11dISEZDKLcjvAbUgHe1f61PjfuGVa3IcQO/bGp
         ZrKi92m4nOnUJQhKJ5wgCIwYEAGQF0rVWlocY0qehGoT+GaXlTYSWgRQRkB+ajyedJ65
         VDmA==
X-Forwarded-Encrypted: i=1; AJvYcCVzxmQi8vXpBmJ2miVgLR660d4/mNL9jPpmN11+Lypk7OvTstZRskZssKku9l2JGsgC/PkRoCT/AkJCInq05ptkoVeo10IoRVPVoZL9fuOzxoTXO3uP
X-Gm-Message-State: AOJu0YzNuH/QB11Y5gq7CFwvNhu3fIcvVlyz9Ek4hFQZ95kN7WAB9mjq
	e4m3XdoAZnvSNs/wz3Wfvs6IHyPjxLdH1Nov2g3miUHuT898SjexRn33gtlGMiA42/iGn+cMqIQ
	oiN6pj37fGUMkR+RcsuuHcJCSvITVYyCa9FAG
X-Google-Smtp-Source: AGHT+IGVq5mRXTNrK/KaBwurMBldLnV/6qJN5uwTdGazOX6+s8bWL81rsv23lU+ZbyujJVMk8Qdjk3/8J+Z+jQ3+QZk=
X-Received: by 2002:a25:ad50:0:b0:de4:619a:fbd with SMTP id
 3f1490d57ef6-dee4f2f6cb8mr13359322276.9.1715716512499; Tue, 14 May 2024
 12:55:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1714775551-22384-1-git-send-email-wufan@linux.microsoft.com> <1714775551-22384-17-git-send-email-wufan@linux.microsoft.com>
In-Reply-To: <1714775551-22384-17-git-send-email-wufan@linux.microsoft.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 14 May 2024 15:55:01 -0400
Message-ID: <CAHC9VhTK4WS6BOXqLJ4sNKXR9a17gT3vXJUBc1F11cZ_QaOYBA@mail.gmail.com>
Subject: Re: [PATCH v18 16/21] fsverity: expose verified fsverity built-in
 signatures to LSMs
To: ebiggers@kernel.org
Cc: Fan Wu <wufan@linux.microsoft.com>, corbet@lwn.net, zohar@linux.ibm.com, 
	jmorris@namei.org, serge@hallyn.com, tytso@mit.edu, axboe@kernel.dk, 
	agk@redhat.com, snitzer@kernel.org, eparis@redhat.com, 
	linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, fsverity@lists.linux.dev, 
	linux-block@vger.kernel.org, dm-devel@lists.linux.dev, audit@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Deven Bowers <deven.desai@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 3, 2024 at 6:32=E2=80=AFPM Fan Wu <wufan@linux.microsoft.com> w=
rote:
>
> This patch enhances fsverity's capabilities to support both integrity and
> authenticity protection by introducing the exposure of built-in
> signatures through a new LSM hook. This functionality allows LSMs,
> e.g. IPE, to enforce policies based on the authenticity and integrity of
> files, specifically focusing on built-in fsverity signatures. It enables
> a policy enforcement layer within LSMs for fsverity, offering granular
> control over the usage of authenticity claims. For instance, a policy
> could be established to permit the execution of all files with verified
> built-in fsverity signatures while restricting kernel module loading
> from specified fsverity files via fsverity digests.
>
> The introduction of a security_inode_setintegrity() hook call within
> fsverity's workflow ensures that the verified built-in signature of a fil=
e
> is exposed to LSMs. This enables LSMs to recognize and label fsverity fil=
es
> that contain a verified built-in fsverity signature. This hook is invoked
> subsequent to the fsverity_verify_signature() process, guaranteeing the
> signature's verification against fsverity's keyring. This mechanism is
> crucial for maintaining system security, as it operates in kernel space,
> effectively thwarting attempts by malicious binaries to bypass user space
> stack interactions.
>
> The second to last commit in this patch set will add a link to the IPE
> documentation in fsverity.rst.
>
> Signed-off-by: Deven Bowers <deven.desai@linux.microsoft.com>
> Signed-off-by: Fan Wu <wufan@linux.microsoft.com>

Eric, are you okay with the fs-verity patches in v18?  If so, it would
be nice to get your ACK on this patch at the very least.

While it looks like there may be a need for an additional respin to
address some new/different feedback from the device-mapper folks, that
shouldn't affect the fs-verity portions of the patchset.

--=20
paul-moore.com
