Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7994FC8D7
	for <linux-security-module@vger.kernel.org>; Thu,  3 Sep 2026 18:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788458657; cv=pass; b=vCHzS5Y2ZYHjp7bQDqBkZw63PiH3jJIIrc4dBQTzqgdVwRoDp44m2+Hst3mWmGrnURZ36Tlc+XX9uRd5WHz6m+NYDe32UwxQ+YY/cvSmyzdCNuX5SxDXEzssq3Om+A6eOGMzC6ryx3w2PVaMeK1bNaCa30odejI/zSUgGgU64h8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788458657; c=relaxed/simple;
	bh=rBhnMpnlpQJIqe45e7mghY2bbrkfay04f++iDuWUl10=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bZSWmhJp5U/VAo4HxX2nFVgYMubivfkxTZtmc9kBJk139mb3Wbd/ClWbuXAKTTKvzVgHz/o3Ws/CWoOwliJSheVGHn+FmBr2Zy3mXmKlKj4ObJFOJGEIACcRL17aiu3EzA4XYqiAdCXuuyWwEMIqvJVCNC1Mmc+I9fEtuThav8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RccCEGpi; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RccCEGpi"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6a5d42684d7so4197a12.3
        for <linux-security-module@vger.kernel.org>; Thu, 03 Sep 2026 11:04:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788458655; cv=none;
        d=google.com; s=arc-20260327;
        b=sDY3Zf83E+voRMkpKfAi+rfY6C16ry9cG4r/eSiBfCxoqCn1DhpLRBLWv3amHetyDk
         wkgMshp2MLSiD1xx0vTqxUw/wIcasvj1zFS34assdVXfTelaCeOQfF00/JsOg7AnU7IX
         2rdJK00SToCiHVkZ+96SdWnZsY4udb8eB59Eypfk8moieKMo/mDBHPK0OXH1NozQd09j
         2nn5tueAir9uDkKs6Mj26kII7uh/crErJ95KHqvmgYYaybXkziRZbgk8M3uUVn0NRG5I
         4NoWCvDjD+d6u5fJMsNbTslNB0Ym2X1g2F9dgiIFLCa6fHldyhaKmnxjNO8AkWd8rMpv
         2C5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uK/GuQ6nbungHJUUyJOtLDjrs+AVjPNapJ1G3ZSkOBc=;
        fh=0QVoDVaddYS2TlS9uKKbOxGXsJ8pnQhpEMMayVqScGw=;
        b=L0swDu/TGC29zA1YIUZlFKJkXpYk4eKOU0/kUEY1knRzyZ1AYlqPYDmzxL9Io4wT4z
         upj7Gg1hqYGbWj0UZZGxFW1IYRaW5fi52mvHL+NLJjWOb3nySYtOdM7Td+zaqZa5lBI6
         N+4mBY3LNvmVpKTZ6EbvWgQhCoSrACqZlbxqXWlqQ7a77eABZ4AgZeQ4PiX0TC5V7ym/
         KIwBjGS1gZtXu1FgJu8fI0biU4EbQ6RbOFKZZLYf3VW+kFhIS/pk1/lph/FajsNOnmTg
         rCoumAc2ec8ZJ95C/RuUt4DCo4O+cuNb7qIKWVliUToG6Kl5bgcdKk/N3quTBnhjovPY
         J5WA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788458655; x=1789063455; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uK/GuQ6nbungHJUUyJOtLDjrs+AVjPNapJ1G3ZSkOBc=;
        b=RccCEGpiA7D7Pf/qAQaHVXLmcQu4HvtTYkDZDCl9EtQa8UOUSWjX7VNEbGAToiTY3+
         1K8kZCa/pTbhlPrZlOZIXKz0XXv9xDSv+qWrTBbcyWDD7iZvT/xdng91f/FAYq5JEuw4
         vs5PeWxL1VX6hcuU3w54d3Gi/USbAs7D3k9Qurdvj0zwujivEJ2rzi/2HEPEMjbwruub
         7ePUCfV84U4s+4+TjRX2UyaBJh8XJexp2mioen6Q5yE8ezRjYCf7jiPHi314mMQHGWQD
         lHA32d/k/KNYFlTGdCD4R3OzjfDGuCT39rErJLZaMgRnJihS8DYZlSg0Wgd80oryWxlK
         BAPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788458655; x=1789063455;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uK/GuQ6nbungHJUUyJOtLDjrs+AVjPNapJ1G3ZSkOBc=;
        b=mTOm1xKMtvxAyRWf8ipwK0pKyCXMWGcmEEmTFboRgGlTtKAGXE4FjbT5B4juxEiOnl
         cxon/8Rni3Fno0fYgZTJqM1Ss4x1TSAmnPgZgznR8XIoWLv02dwOlq8UMtMSFHKADTU4
         /TTs4RtGekiJX79Fo3sxEhWN9KKHMGfJ7f/mg4QT2MuMJbV1VWFr1Iwb+1WFA0KgmXep
         pxNVDW/6dUQcWGcRpzr09pDBYQqatOs6IXc3ucLzJDtUgp+CKmNi1jvcdK1WSOc97UIt
         qLSSU1W7fntNKBmiZalMJg9dA5C+XFDSjTb6GI4fY3m762EgEDaercJtyw9QxR28VxqY
         3WOg==
X-Forwarded-Encrypted: i=1; AKwUvBw6dk9vg4sWJTEkWcg8GRfkoAsa2v7FJdW//jNRy0BtxrBa5bOg/jghT3K18f2lHOFlZkGVQx9LroykFKy5b5lbKR450rc=@vger.kernel.org
X-Gm-Message-State: AFuF++ng0e957mgA57kPEk5LKGIrxx1Xo3rAxW0mEi2sIZCHAi7CG1w0
	ajgGZyAPNAOoK3b4nJlibc6ZI0tTfyetbUf7lais6aFybofVNdv/SrGdfV8vP++hpEgqhO5sY0U
	ChtjPZxZdr6ng4/rbiQRSEbQtxiDY1cw=
X-Gm-Gg: AYBFou0fRcNYZe8kNsFArnYIUcB9zw5h155HPf9od6xoc6TBqP9+jzeVyQnPmrwZ9Du
	ewaKGGaoBOosj9wvfocFpgkHS1PIyb/LiXR1YpRXD9rPSoE98/V46QtlkgRQxt38sUy9X3pU05i
	iS4pLTyEGeiBh3Zvp/gmLtwqU8c1VmFy1PLsPNHXk8WIYKINgxNUONnrHRs5slgYe2hWKjNFjNL
	NBfBszKhLnxfS80uQ8knjpcqqtF+7bDSE9ILL6jN/hHzxzLSYkSfsEVuFDGXcmTKyK0L6XpE8Dn
	cvW4kfwfaHWTKhyasBxKu6t+XkkdzyDoh+RxX8Sk3Q76qwu69cxxKn6No02pUiMIoYwCn/BrhTg
	=
X-Received: by 2002:a05:6402:440b:b0:6a1:d68:338a with SMTP id
 4fb4d7f45d1cf-6a6818d6c95mr5674598a12.0.1788458654598; Thu, 03 Sep 2026
 11:04:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260823152858.3839939-1-nicoyip.dev@gmail.com> <apC0xGqWTIXTIgBU@kernel.org>
In-Reply-To: <apC0xGqWTIXTIgBU@kernel.org>
From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Fri, 4 Sep 2026 02:04:02 +0800
X-Gm-Features: AcwNN1Vixc56lPwOlEAr0jNOgKZcPkT3QtgHqPSwQ2VM7-p1rr5p9dczVDYtyP8
Message-ID: <CAAo+4rXK_MpdsSbmuu+oHP2STUxApG2XRBkKUcpvcTKETEznOQ@mail.gmail.com>
Subject: Re: [PATCH] keys: Fix key_user use-after-free during ownership changes
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Serge Hallyn <sergeh@kernel.org>, 
	keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2026 at 6:06=E2=80=AFAM Jarkko Sakkinen <jarkko@kernel.org>=
 wrote:
>
> I hope you don't mind that I sanity check a bit:
>
> =EE=9A=91 git grep "user->uid" security/keys
> security/keys/internal.h:       uid =3D key->user->uid;
> security/keys/key.c:            if (uid_lt(uid, user->uid))
> security/keys/key.c:            else if (uid_gt(uid, user->uid))
> security/keys/key.c:            unsigned maxbytes =3D uid_eq(key->user->u=
id, GLOBAL_ROOT_UID) ?
> security/keys/proc.c:           if (kuid_has_mapping(user_ns, user->uid))
> security/keys/proc.c:   unsigned maxkeys =3D uid_eq(user->uid, GLOBAL_ROO=
T_UID) ?
> security/keys/proc.c:   unsigned maxbytes =3D uid_eq(user->uid, GLOBAL_RO=
OT_UID) ?
> security/keys/proc.c:              from_kuid_munged(seq_user_ns(m), user-=
>uid),
> security/keys/process_keys.c:   uid_t uid =3D from_kuid(user_ns, cred->us=
er->uid);
> security/keys/process_keys.c:           uid_keyring =3D keyring_alloc(buf=
, cred->user->uid, INVALID_GID,
> security/keys/process_keys.c:           session_keyring =3D keyring_alloc=
(buf, cred->user->uid, INVALID_GID,
> security/keys/process_keys.c:                                            =
   cred->user->uid));
>
> Have you audited these and reflected against your current patch?
>
> BR, Jarkko
>

Right, there are more sites that take and dereference key->user but
not serialized to prevent the UAF. I am going to send a v2 to protect
other sites affected by the data race.

Best regards,
Chengfeng
