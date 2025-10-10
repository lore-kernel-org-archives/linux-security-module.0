Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF302F7459
	for <linux-security-module@vger.kernel.org>; Fri, 10 Oct 2025 14:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760108390; cv=none; b=GJ7rNlOi2ZMdxqZ8qQXDQjfRkfV7C+Rv8tnf9OcWNktARTHBD8dmQMJXhEY5aF7Vme5xI9KoUO277Ts00/9DVP06l0VrQ8eH65tVcreS9GhJWA/iYuqn9qdWzqEY5p0G3KR1mwR1757Vott8U7rhn5ul+kuHBWUy2hn5NKb4RC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760108390; c=relaxed/simple;
	bh=KD4eixvngpxKs37ysDRhAqXKK6Z9EeYjwRzv8uXJu2U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M+CLrFighz/4WiDs/aCaOV54vc/MIkcjE9hEV0Lvack8VRRCyKLTv4pZUgzJX/J7pEM48sT39VKhtlDTHakRZ9Vd4bREfSgdhk3GkLvt8e3owBeTp+z77FTb+i3a2yTI10+mqoyoap63/9BPk1bfTrq3jK8RAobwkl7TimuxkHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=JCcPlXSW; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="JCcPlXSW"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-27eec33b737so32812195ad.1
        for <linux-security-module@vger.kernel.org>; Fri, 10 Oct 2025 07:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760108388; x=1760713188; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B+0sjW+oV0t2BMqgCvuWpzJUVVCqY3LbFgfCiYx9Oq0=;
        b=JCcPlXSWDH9a5m06VnHvoYfhVaiu5z+2LPT6lCbPZF4vfCfVuKfk7HuWMbOTAaheQQ
         RWevaP0t/FLJ03okG+qa6I2B6yE6h37NUbSgcr9ZZw6ahBfDsJqfufX1M2qu9hTkvVFk
         Lo/Yy1OM69mD1rxzcjVoS+iEcEGd/KfysTeD+Rd3/uQICKf1tjI1xO6TtHXJbuicQO+N
         IImmDDweBiUcpXOoGLT5HR+1iqz+9lmJJayKKqYm34p9tYzcJm5RDh9sHr9EfFkSKckz
         tvF1NYUxD3t8FFuFqGL5qR/8lGPNB+e5rgVQT4OBTIEfU96Yfp/Y0s4zDPIXaTaBA6gj
         8jZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760108388; x=1760713188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B+0sjW+oV0t2BMqgCvuWpzJUVVCqY3LbFgfCiYx9Oq0=;
        b=EZbopkBKVzqReVeHDWD+neuPyqz0GvxwsC74te4hBzMPD/Ey20KFevXbJowl5kx21/
         XqOykAhJ2h/9xBigBjuTpJazkFsONQxdlgJ9Aj5wgByA+q14jJ7Fpa6eyoo+W/x5zOqG
         AVX/znOpI4Q98fJWDPNbt9+aMfoNZPcXPFImFDlaL066/VLuRONuffmtXzmc4fRBmXK3
         JCI0h90oeRaUs89t+iwuMqPhFKIe37Nc1pDGMWqwDiBCS6aKsIjKwfpAsZvMF4g/LXtJ
         kynfZ+TrvHgtrz9tykTVGuex4A9UOWuXjqT67UxFCzFUmXijpAIUJXVKkabCTIqnpcrC
         6UEg==
X-Forwarded-Encrypted: i=1; AJvYcCWZB1mPt+ys606/gFywBgISUXxvO/WcsuL9zaBi/J7N2JP0Q09z14eBKzBRrkMfCKv+4KnIt9ymvzArT2dlY04sCUm992k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbGagfsT2I+H/bJuLzmT5yOoYsRcasSV3nADPVcbE88iVU6YIL
	pRufQyMtEQZKyoUuheaUAiBVxUa7Qa26dco1Ti7N8Qu5mNI0y9CI8pEOzoKukxchp/IhdHghyEA
	hmhRXjU83Yw66j8XywRkpgbZdGt9u6yUB6tvz8AryzdJXsUx6a26jsQ==
X-Gm-Gg: ASbGnctXMfXvmdZ4G/LKVyPLmWaxqekkhhSY1vD+CNHcXXqxv2X4onS6C1Ny2CsRm73
	uaPx8lYlI5t3BlVBubrAlEY1i4ozNOg1T/R279VHvjMlZu5sIGN9K7IMotuY0r469P11gdBfw75
	YuR00J6WKpeEoofq1EeRXMpKDBozfPa+NT3SjhRFr9dPX8PjlKOaFKhUMfamcrvUzSkj88kSGx7
	idLNwAKks4DPMMNdCDdfM/c2A==
X-Google-Smtp-Source: AGHT+IG9hy80Ik6+ARbIl3oz3A3KG5+fo5fGn6VPEI+bWA/pwCD/ahXTgPJG7kBipRJaOCzTwImphgjwuOgiPM9OpYY=
X-Received: by 2002:a17:902:f602:b0:274:9dae:6a6d with SMTP id
 d9443c01a7336-290272c1a67mr159749285ad.34.1760108388086; Fri, 10 Oct 2025
 07:59:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709080220.110947-1-maxime.belair@canonical.com>
 <20250709080220.110947-3-maxime.belair@canonical.com> <20250820.Ao3iquoshaiB@digikod.net>
 <0c7a19cb-d270-403f-9f97-354405aba746@schaufler-ca.com>
In-Reply-To: <0c7a19cb-d270-403f-9f97-354405aba746@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 10 Oct 2025 10:59:36 -0400
X-Gm-Features: AS18NWAVS7migS1jhRtb-IPHhnKptQlfKCCpqw55Hl-FAqPL4NSJFJGx8uS1S6s
Message-ID: <CAHC9VhSXcqKF9KQ1+KanPqoTk=GRsOXs5dGNNnmTiK_BcMUV5A@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] lsm: introduce security_lsm_config_*_policy hooks
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?Maxime_B=C3=A9lair?= <maxime.belair@canonical.com>, 
	linux-security-module@vger.kernel.org, john.johansen@canonical.com, 
	jmorris@namei.org, serge@hallyn.com, kees@kernel.org, 
	stephen.smalley.work@gmail.com, takedakn@nttdata.co.jp, 
	penguin-kernel@i-love.sakura.ne.jp, song@kernel.org, rdunlap@infradead.org, 
	linux-api@vger.kernel.org, apparmor@lists.ubuntu.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 20, 2025 at 11:30=E2=80=AFAM Casey Schaufler <casey@schaufler-c=
a.com> wrote:
> On 8/20/2025 7:21 AM, Micka=C3=ABl Sala=C3=BCn wrote:
> > On Wed, Jul 09, 2025 at 10:00:55AM +0200, Maxime B=C3=A9lair wrote:
> >> Define two new LSM hooks: security_lsm_config_self_policy and
> >> security_lsm_config_system_policy and wire them into the corresponding
> >> lsm_config_*_policy() syscalls so that LSMs can register a unified
> >> interface for policy management. This initial, minimal implementation
> >> only supports the LSM_POLICY_LOAD operation to limit changes.
> >>
> >> Signed-off-by: Maxime B=C3=A9lair <maxime.belair@canonical.com>
> >> ---
> >>  include/linux/lsm_hook_defs.h |  4 +++
> >>  include/linux/security.h      | 20 ++++++++++++
> >>  include/uapi/linux/lsm.h      |  8 +++++
> >>  security/lsm_syscalls.c       | 17 ++++++++--
> >>  security/security.c           | 60 ++++++++++++++++++++++++++++++++++=
+
> >>  5 files changed, 107 insertions(+), 2 deletions(-)

...

> >> diff --git a/include/uapi/linux/lsm.h b/include/uapi/linux/lsm.h
> >> index 938593dfd5da..2b9432a30cdc 100644
> >> --- a/include/uapi/linux/lsm.h
> >> +++ b/include/uapi/linux/lsm.h
> >> @@ -90,4 +90,12 @@ struct lsm_ctx {
> >>   */
> >>  #define LSM_FLAG_SINGLE     0x0001
> >>
> >> +/*
> >> + * LSM_POLICY_XXX definitions identify the different operations
> >> + * to configure LSM policies
> >> + */
> >> +
> >> +#define LSM_POLICY_UNDEF    0
> >> +#define LSM_POLICY_LOAD             100
> > Why the gap between 0 and 100?
>
> It's conventional in LSM syscalls to start identifiers at 100.
> No compelling reason other than to appease the LSM maintainer.

If you guys make me repeat all the reasons why, I'm going to get even
crankier than usual :-P

--=20
paul-moore.com
