Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.181
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793924768;
	b=GURnqgzpxw6dWaKgIObFCDFn1pT3eFhyeIyWglMds3J++BlfbvZigvXy+SLDUzsRkdlS
	 V4g+aqW7jPL3r4X4gxr4iAZcc0BiCdrDQSIAm2wFACwJO03azBYrsA2j3ntTpKBnIA0Ux
	 /tWZdnnzW2O4Pl4+Sf69pN8Fog7rMHCCu5JINZNOOvJvWQTyhXnO/uPSCnx1G91bzfAJm
	 lZjX0L6LQwnyevb3A38g2f3VdDyeHAcMC64MefUEDLvJSDa5FqGdAviB0TEgUVPSnG1A7
	 8FvkWbcdDKNs8/Rk5qC0YIIkNudGeiPVyH0Ms+94Ap8aGZ3/6RJv2SKf1T9RnnPpUjw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793924768;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=aRM0MqaYFgM8kL5oWje8tGsrwnDPxkPfJxLc62ETAs4=;
	b=FpfYyvvOpoyyYb2DgitLsKC7t9HInNOG6Hhjk9ME20dCkrxLpv0FevYzXSSAnET+eaW7
	 hQ3EfnRE0qd/rv3dwFNJh5LxFmu2LRvw4QlkLnMm8D7R089zgqeLQ6PLJx95had2w8kbp
	 hi/O9tHk+Z/mgnoP7rBNIE+vFfjJKMb75EkehppRlyhmzxMD94kL1UvZGKHlhsU9JrVf5
	 yDI65hChF3dtI8ADYjgsii/v2rRKf5xKKwcG/TjUvpe8V5wJW8ysq739dmUiIvDmJHDz7
	 Srlti89eQWZa2c1VCOtmmGjuPhlIXKy5CXYusH6jzQ11T17lIhAGjC+43FKB9pvcHJw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=d83F6fjU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.181
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD026606A326
	for <linux-security-module@vger.kernel.org>; Fri,  6 Nov 2026 00:26:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD026606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=d83F6fjU
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8a07078200fso16173b3a.2
        for <linux-security-module@vger.kernel.org>; Thu, 05 Nov 2026 16:26:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793924767; cv=none;
        d=google.com; s=arc-20260327;
        b=JLOFWXegtWDZ5Cy+DlEf4csuQmzwpQPeKEOFjasD2u/yOipfFIgTl9CQ/mEXECkoVV
         VmIPJogUWmQraDxVDWY52xXaUeWXrwMUm5W79HEJjgrndDJLkuHCBi509jPyiFwgz9NL
         91WQght2UvLb0j5Utzro8tdPSl8izPvQu28rvYy1GP6fTWi1tVtvvv+C5alwKuluGpBg
         S28QOEduciHJdfq3wimxSfCTwnaaQCfndwnCOGqfhpw+X8gblyb6RZPwTK4NrNbiqQBO
         5Z/XA7vZd6JFNqAjn0jI88RwAmb6VhxTMOPpE4Pk5jbn6aZ3sT9H9Pwpwx1Sk93Oe4tC
         +iLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aRM0MqaYFgM8kL5oWje8tGsrwnDPxkPfJxLc62ETAs4=;
        fh=HpOwerBfTMblo/gD7D6l5D4qVgKxHDZkKXEUOXob6g0=;
        b=LQ/ZZfJEtR+Y9yfC9z7Ti4bEfNsfz1B3ctKHPv2UTK1/GKn6Vu1tcpRuPwS+vQ6aNm
         EGyzwA1+bXnTIOQ1a6o2ZLgmOKLFQLhyQvt+bdrUefhBlyEW3Tlqj3ng7uFpqiOd+qoK
         n7zgoWk1KmyEpUTdsd1U9oudUR1FEWiWm+IjqznLc5p8ae/8Arw3URlQkVLjmj96Xn7h
         z5cNfR+sPeUY9e5lKoRTO8t/teIAHZCjwKh3D/XFkvjlYQMnIY349Cerae/ZsQ2Drf1h
         4BOD4mIc6Os2A5lWum711yNrwWZeul8gvhz6VnHVbFsXutFGjEyY3VGxbDG5p0U7UqCH
         KX/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1793924767; x=1794529567; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aRM0MqaYFgM8kL5oWje8tGsrwnDPxkPfJxLc62ETAs4=;
        b=d83F6fjUa1ZBrpdME9a3Bum/toMNbXvZWQohczhN8JN0lwKIZ3meGphEY30ky2t28S
         ivzluSzn1yi2zkkf1si+IKqZEPgZZCcMy7KBpXDTAWTHVwywFDMTLG+nOMJ7MRn3DWzm
         5wqy5UlwTWBrQvlKF4dxbN7koTImbbAUBjBCzavTCAtcuTZ51wrMPOa9XEOmvwrU0K+J
         95Il4LZkk5TLU6RD4SGClgPW4lQJrm+UgBHcn6n9zB6Y9lAIEpEPQ5jB/WgLLXEwlm79
         U+z+D5RdNGl18/LGAP03spv2iKDPGVhmSH8VX23yva/Ap8mXwM2h7BgH6Tk7jgMgXzv6
         bQlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793924767; x=1794529567;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aRM0MqaYFgM8kL5oWje8tGsrwnDPxkPfJxLc62ETAs4=;
        b=QG7IHqocMk1FokRvBLbi17pPNgh3vNjn5W6DvbR4uvPsubz/LAYbrE3S3AWZGOUOeW
         B7drsRPi2iQfEbd3fqzlqJOXo6WyDhB51e5VR6nOZR3kGOQtVI6brSaZoBeAxkdYdkM8
         phHbof/LmPRtvBUnR00n7090AnNc889a8koGm9AEY70TjpibkgPIurcJScbpCrYjBcAy
         i3hYjute/86KHH983O/dTFqxK0uHTD3qY3Yvwpa63WEvm+tM9z09IePqzKaFM81tq7AS
         OBsX6jj1eC8ijHuh4OZp72AGa0wyN3/LdtJVyjXJApZTKSJeXsb3N7VHibgZKkmdAMBa
         WYFw==
X-Forwarded-Encrypted: i=1; AKwUvBxhIzjypVoeFkTPG777SbJ8oL2W7SSByb8U/JQcSOVqMIz7h2qZW47Oh4kUclsftZQePntckP2bzqae6wGhy45qGyD34nA=@vger.kernel.org
X-Gm-Message-State: APuU4Z984empD6qoP5ifgyem7CWpP7vTjowLic+n3z27WNDpUTLYmbYo
	kzj8HpdHKQLDRJjw2dxt/cfwQUqyhwUAiuJezBYUQOfSfxsd2tnHV79Gyl/oe3oJL1WjDwc7mhP
	49+WSHBrP6l0EPoh82tyv6ZA2y9IgvibS3U+wt427
X-Gm-Gg: AYBFou0s89YKSShzqhTqct4Wose4poFezp5/OoQ6OSulbfSJo4zsSGJ5CmnJ4P3A395
	o5gsDLd0cMIeNQR35QEXzGqXNo9TXxT4A3WcrqEfpvYELyBOmuC+tXp9Tl2ABEha30BoVIfe44A
	J2/apygvKJsY4VJUi9A9K4xB6ns9Kn2jmyUF0ZvTWLv92z8QLxWzeKmjX2Mmf7NVRQFWmiOHiD6
	LKP04e2hdWTXYAnay3QkTI4bwYWK0Ew4TkYNFMogrwb9C/UMITW7EV9zejvDAll/Wq1M2NYLm1S
	fW/x0Iw5wYZixzMMSIz/pmyRawZ8EN5nIwdN4Qt877tUZlVJSZSktzTIEaX3ouAMb0SHTNS7mke
	XuqG2UoNy3ykQt5pY0q82c01j/0fRbzsYl2wie7AVT+rARmG6CvsqmtkKAskQuotbG/5T
X-Received: by 2002:a05:6a20:938c:b0:3e2:78cf:8882 with SMTP id
 adf61e73a8af0-3ebb29700f1mr1259512637.25.1793924767156; Thu, 05 Nov 2026
 16:26:07 -0800 (PST)
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1791023194.git.tjdqudcks0424@naver.com> <d7e10b50556ab3b79c7132018249f6f7c608411b.1791023194.git.tjdqudcks0424@naver.com>
 <asLNxHYQ/xQ6KaWy@hallyn.com>
In-Reply-To: <asLNxHYQ/xQ6KaWy@hallyn.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 5 Nov 2026 19:25:54 -0500
X-Gm-Features: AclHuK_pI_J9bw4ryN_WOBlGRzUjsAkahBqoHmTF4zFuyNsNV4GbMdflTnlEfv0
Message-ID: <CAHC9VhRMCfahvx89HjSoHfyKR27swLdt2HZuM1enmoi_gxRyRg@mail.gmail.com>
Subject: Re: [PATCH 1/2] security: safesetid: use real GID for GID policy lookup
To: Micah Morton <mortonm@chromium.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>, tjdqudcks0424@naver.com, 
	linux-security-module@vger.kernel.org, James Morris <jmorris@namei.org>, 
	Thomas Cedeno <thomascedeno@google.com>, Shuah Khan <shuah@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, security@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 4, 2026 at 6:05=E2=80=AFPM Serge E. Hallyn <serge@hallyn.com> w=
rote:
> On Sat, Oct 03, 2026 at 07:34:15PM +0900, tjdqudcks0424@naver.com wrote:
> > From: Sung Byeongchan <tjdqudcks0424@naver.com>
> >
> > SafeSetID policies constrain the ID transitions available to a task for
> > each source ID.  id_permitted_for_cred() always builds that source key
> > from the old real UID, even when it is checking a GID transition.  If t=
he
> > real UID and real GID differ, the policy attached to the real GID is
> > therefore missed and the lookup can return the unconstrained default.
> >
> > On current mainline, a test task with real UID 1000, real GID 2000 and
> > only CAP_SETGID obtained non-allowlisted GID 2002 despite a 2000:2001 G=
ID
> > policy.  The bypass reproduced for setgid(), setegid(), setregid(),
> > setresgid(), setfsgid() and setgroups() across three clean QEMU boots,
> > and enabled access to a synthetic group-protected resource.  This shows
> > a SafeSetID GID policy bypass and group privilege expansion; it does no=
t
> > show direct UID 0 elevation or a universal local privilege escalation.
> >
> > Build the source key from the old real UID for UID policy checks and th=
e
> > old real GID for GID policy checks.  In three fixed-kernel boots, all
> > tested non-allowlisted transitions were blocked while the allowed targe=
t,
> > existing-ID, no-policy and UID-policy controls, and the existing SafeSe=
tID
> > selftest continued to pass.
> >
> > Fixes: 5294bac97e12 ("LSM: SafeSetID: Add GID security policy handling"=
)
> > Cc: stable@vger.kernel.org
> > Assisted-by: OpenAI Codex
> > Signed-off-by: Sung Byeongchan <tjdqudcks0424@naver.com>
>
> Seems obviously correct.  Thanks for the find and the fix.
>
> Reviewed-by: Serge Hallyn <serge@hallyn.com>

Looks good to me too, thanks!

Reviewed-by: Paul Moore <paul@paul-moore.com>

Micah, assuming this looks good to you, are you planning to pick this
up?  If you would like me to take this via the LSM tree, please let me
know.

--=20
paul-moore.com
