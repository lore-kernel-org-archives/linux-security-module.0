Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B740417BE1
	for <linux-security-module@vger.kernel.org>; Thu, 23 Jul 2026 17:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784826540; cv=pass; b=RjdOV4XRoRCRwMJYFZQ38y2mGQ2e+i4+NKxpvOpL2WcPiXS51XuFf7ANhPrLQeBi4MuvVcecQBkl4VYjbTxSzbYgxRR4K31QlEuT6gFVuXfZpGLkcdRpwWzvyQ+R5oblsGOFJZUsZJkymnkTod1gC7qWi1EwDK07cIIvVtwgk50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784826540; c=relaxed/simple;
	bh=NiiYRzQsUFiN1+TD02VJ+BmECv/IikD8nONP1A+hrEk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GH8n64Pp7MrV2fD4RvEHHTSpsWMU1HmLQEFhV24CYqPfRdWUtuF21OinLP2gJesGWCIgP1tJtX4GQKSl0k75klzOfad33Aq6VD7KRcU79Mj6zofFVODA93n1rt4D0zNyu9nEk/c3n1W6XnSc0f7vNNfc/Szrm6DSxw9XR6gtL70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=J3wAn9Ut; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="J3wAn9Ut"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ceed7018c8so7161765ad.1
        for <linux-security-module@vger.kernel.org>; Thu, 23 Jul 2026 10:08:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784826532; cv=none;
        d=google.com; s=arc-20260327;
        b=cuNy02C2j4XX4LfSUwcSx1qssT4x+PSLlFwLjP8gHG7VoMv8ox+MWK6CrRQrAbTlEY
         zPqB7B8P0oPu1X954thY+stm0fdemJF3QR98PFx6fIssmGcxmxzhpEVtZs/4teUT8svu
         OTWEvXNsFBEHref4O8mZo34q25QflWd2cw7d27SRxXtVQfNGHicQg98gAhYaFR28kHuU
         DkQcXYEspzv86O2vmlMRhXSeCs4KgdYat07+2QFNrh/ca0NJspPBB1vgijuh9yZu11kx
         CK0MQ1DTCun3n8F2CHjb5Ei3rXZk7kwx/+I0wvwcRUTp3V7z7lLS5PgFap/zqvNHvcWm
         jv/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aFTb/2FRfHUFQVIctrwu1c31Fg909Xp9UiG9IarcWrM=;
        fh=AUCNutk5kGVTfQl+CT21lDmZBizRzbtxaVZzxVyxWb0=;
        b=psXKkUFhhbLswrFtv58Tk4gpVC8sVjhRvYsHtUBsKbKkh+LgeD+j6e1WZ2iXoWc9GO
         EM9nwOB2E2yVnQ8qS+Tp7cJ93MYLkiOPb0CbRMZHcdibPIz1I1ttnKHwaFyPr9t/1EHG
         Z/RxhbmuMn2+M9lT1zzY+e1WDD7LiSoDYF9gXZQV0arAytgu+z0hvun+99Z7o4J6H+x2
         yZnUaL3+Nlq+hLEep6u7gJFuhkAJNapAWn23E79cDpUND0GzjTIKIphKE4sIPb3DzGUZ
         Fp2UpTjJBKN1bIN8tpvO/gHiVwekoyKWLDRFh3sv0AMru5k0ybS6hf7Kv0/DETxxNUSE
         NVlA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1784826532; x=1785431332; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aFTb/2FRfHUFQVIctrwu1c31Fg909Xp9UiG9IarcWrM=;
        b=J3wAn9UtvnQGhHOZgC9LsQ/fbNR+vOvJvlegnk70K3OsdIqMNyb4dGKMbvPgFxNxCZ
         eu43Gbiq5e52LcbTMSepoNODMkMMfYMsqRlK6S38F5A64Cd/QhkQ4OC7y+AkfkqlMwwh
         bMDL1KgO3g4AGcyTGrGxSx7ErugmVPo8KicRDZWNPEAKaf/FH1/C4G/KnTxk1VmbMmAC
         xDeLa7A6nUQo0TiO0fRbEHTRK1P80SYSRA0IlncXMQy08k+Y7iA9KXYH5nEWrEfC+N8k
         +WgcoRcbO4mS1PzLpthrztomhrvhNc7OGAtCLkjJHzFk678z9q5YwM/QdbNBIxuJFUjF
         Z4oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784826532; x=1785431332;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aFTb/2FRfHUFQVIctrwu1c31Fg909Xp9UiG9IarcWrM=;
        b=XXUNlppNNd8dXPUcgCwUVTGAfzhdXp2OV/4IZS0TCQHXhTrX+lrhHxsBVNei7XbJhb
         zbshTrMC6+zSZqCD/MTwoMTCSkDgMm1cnjHl0H29kTgHONgN+9Lmq7v4jnXyXsfnk0J5
         Eu4pMbdTk+XAJgHjysruimhFeeWFqIzU6oOEjotNwMnPTha+nvyTQrNpBKGh1xSQOcy0
         RvTNWRQVEq3y6paCPbY8zzm6yTF6jtAk5g0VUVAMTcHJPSUP4ZDmTOCffXYer8GAgd78
         i9gGWBKyjky948ntk0yqpmEXNVafJXwPGF3/a1TsPQxClSrct0H26dzD/tm365SM+/At
         jRiA==
X-Gm-Message-State: AOJu0YzwgzoQw/nmgxDKc3Gkaz1d7e0o/ZettoxsHfJzLInPYoq4MC7h
	8gD7MViJi7O7xkXIlCr1doTbhrnxBoAoEj4RIio66RsZWhVrxDeblt3hI9Z9WdFxwClCZnu0Xg+
	rfOuzzF4d1A1J3A/chcbBlO7gqEoJhNe6yELnjApC
X-Gm-Gg: AR+sD13hJhQn5Rz5C1oYavihIn6JPFnUD3s5ZY/8HJiTfmUBwxAv9KSrVrM09jCwr19
	QQrQA+Ce+on8KtVpVh8/NhOVFq1cmvdcmh7AqTP6VRq+d059d3yBtlLTZ31UAVzmlxRDFB4kaPL
	fjfuiyG/TFo5Qzffi6/MZrxH+DDjOZHf5dQj7NGUof1NgaL2EOfzi+Gcj6UQgRVjC1VkyU75geT
	b+TlYrmOzsYbYj6gnJiU6VDQHGLHTu61KJT+nrDwDwZJNnd+NMHaAhjNcg5hQ==
X-Received: by 2002:a17:903:1b07:b0:2ca:b8fd:f31 with SMTP id
 d9443c01a7336-2cfa6b77a8fmr50112675ad.15.1784826532031; Thu, 23 Jul 2026
 10:08:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723165209.226050-1-rdunlap@infradead.org>
In-Reply-To: <20260723165209.226050-1-rdunlap@infradead.org>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 23 Jul 2026 13:08:38 -0400
X-Gm-Features: AUfX_mzB8JGCp_D29RH-y14rd6X3iHAHVYlF1CP1VcGG7jakmF8NGLPKn6PwUIA
Message-ID: <CAHC9VhSxv-=sszc-he+oupu2ZAUCoQ9+RfF4=ZG9UajYfTK5wA@mail.gmail.com>
Subject: Re: [PATCH] capability: remove non-kernel-doc comments
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-security-module@vger.kernel.org, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 12:52=E2=80=AFPM Randy Dunlap <rdunlap@infradead.or=
g> wrote:
>
> Convert 2 "/**" comments to use plain C "/*" comment style to avoid
> kernel-doc warnings:
>
> Warning: include/uapi/linux/capability.h:114 expecting prototype for
>  POSIX(). Prototype was for CAP_CHOWN() instead
> Warning: include/uapi/linux/capability.h:175 expecting prototype for
>  Linux(). Prototype was for CAP_SETPCAP() instead
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: James Morris <jmorris@namei.org>
> Cc: "Serge E. Hallyn" <serge@hallyn.com>
>
>  include/uapi/linux/capability.h |   12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

I'm assuming Serge will take this via the capabilities tree, but I can
always take it via the LSM tree if he prefers.

Reviewed-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
