Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C791FFC5D
	for <linux-security-module@vger.kernel.org>; Mon, 19 May 2025 21:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747691801; cv=none; b=c4n50PVib2+B/X9RX7E5wyV9Acz/UwKEIa7J63YpCvWH7pStwfvyfWiiHCJ8cBLOlH93CA39glmKK43LYwmVuUJgF1LNgm24x4NhpMzXjsME0hEJI5QNXHpoHDu2nvwoAM4npeSEzOyVD8D11S/HE1KVpFFt7Rh1HNXySOVa/e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747691801; c=relaxed/simple;
	bh=misrursprD1V5FCR5HbBlMSYeABECRK6PDQlgJ4YyzI=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=E8oizosYOhwmAK1lCghwn8OTOhncIWERfrev/KTQSd+E3djZT2UZFUObdFj+ukYckVtpvG3p8eWPX2D0t13FqxxmsO91yRhkqU6eFRaKwv210KUumchuxPoVtgOpqkbHchKyncUFJWOsr2UcKV27niq0J6Y1CMFCkInBm72WWJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zetier.com; spf=pass smtp.mailfrom=zetier.com; dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b=ArITGP1s; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zetier.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zetier.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b="ArITGP1s"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7cd0a7b672bso333016685a.2
        for <linux-security-module@vger.kernel.org>; Mon, 19 May 2025 14:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zetier.com; s=gm; t=1747691798; x=1748296598; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EOXEar3JMt8I5wIbojUBGclJ2Cwt6fvo5ECJsqLXQfs=;
        b=ArITGP1samHuiTU06TIRk9Ma3wp+FWNQBsybNViIr968to8dkMWWZZdg7YQ2uexmIY
         ehkgRTpJoI1cVGgLuaM0XGCo9CZcUcuUWYFkZKZAmXCKHFsBsMxFlTLGRby69DQedp+L
         4XtVRJRQ6RdecvaciYXVxWeupjia4n5+Y6H2YJWqvrKcGXl/OjhJXYQWFvf951uaEcIt
         Y7K4nZ6hL+8APKhb0JyoEe3ee3m0tjBvmu/kahnkNDbMGnDXxn6B3ofSr5AM6tnbCX0K
         95t1WxC2mEY34qfytd3vMpP8KUgwUozPMRzMhmw06SceQcsR2sei1M1CGPt5NdMbtJ3j
         WcsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747691798; x=1748296598;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EOXEar3JMt8I5wIbojUBGclJ2Cwt6fvo5ECJsqLXQfs=;
        b=jks7Y1WmzKGPcUq3pIzgCfJo4TypAHNyOnueNlCbh3UNaeEdQ3pTyhFzXh3lWKx2Ml
         CpjrfOCGsu9xFGTYqX3OIn3+kPCDOLlOkdZvYdFprdzN3UgZ9Jof72YuMFWyFX8fUIaQ
         Czcr8eEs0zWEYyLZVxS/iZO3/TVptSvpE10yrODSgGF4u8/u6/0ROMiJ3fkZlWBiQozS
         aQhbHjOEON5MVS6nDXUo9Seym/m04ZwXGh0te9tBml2dNYHeFVrQiNVuPiZB/LAoLhHk
         K8k5K0JsS/093qCnEtPdgcETDyLa12qJISbMGVFbbbwytOAooI0K2mbZuvY2cCRSU77b
         6iVA==
X-Forwarded-Encrypted: i=1; AJvYcCWSr3pM1qiq5b4Tcm5DvaGWmvYCZha3L47G04L/HfvrggK1gN+X1HJoWobbairKZf4uennfkP/zD1s2vBHtl+lOlNa8eaw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSMnVDYnwvEBzpszKUszSFoIjJaHE4L4bdRXTVYs4AtoFTdR8k
	5LzxRCTy0nSXr4ZsSwArdPtVXsAH5e2Rmxq/6dbPnOrv/RWu4pC4XkKJOTYaSF5oWwY=
X-Gm-Gg: ASbGncsq1QXPbrc5+DU8pgncshg+052M+MQ1bsbei3/dUkJCOCprVziYAv9BCp7IRPU
	y9ft/r6g+7TaWAKYpklT4MQFCnvlSRybYnYk4yqbw75dQa9Yke13Lwy432wTea93k6QiVOBn6C+
	/3pytqoamkA5Byc9AxC8Zknkmdl3sM2ZtoSxIrPrFpJHrpiBaVXmstySCBGJKly39QgMbtjYGAs
	LgARljCd8UymxLegVPYLniAwQFsZTfJh4imGh5n5bIt1c48t9rI6tjAduO+s9i9WPkkg/kCAaCA
	wKYGeHdEUyNe4f0COzmYHP0Q+ESyKM6F1v2rsCuZGM/iKP14EznrOixc3PLMhPmhGQ==
X-Google-Smtp-Source: AGHT+IEeehA3260v/sJrplNOZECEEJwqIceBm8RU+ybEqdrPBGXdNY+WO7ZTIA9CiXoD1PBDCEBmkQ==
X-Received: by 2002:a05:622a:4c0c:b0:494:8930:9fb7 with SMTP id d75a77b69052e-494ae23bb3amr225583471cf.0.1747691798406;
        Mon, 19 May 2025 14:56:38 -0700 (PDT)
Received: from localhost ([65.222.209.234])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-494ae528466sm60835491cf.67.2025.05.19.14.56.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 May 2025 14:56:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 19 May 2025 17:56:37 -0400
Message-Id: <DA0H1BQ9UO2G.3ATO7SJM7L25X@gabriel.zetier.com>
From: "Gabriel Totev" <gabriel.totev@zetier.com>
To: "John Johansen" <john.johansen@canonical.com>
Cc: <apparmor@lists.ubuntu.com>, <linux-security-module@vger.kernel.org>,
 <dillon@zetier.com>
Subject: Re: [PATCH 1/2] apparmor: shift ouid when mediating hard links in
 userns
X-Mailer: aerc 0.8.2
References: <20250416224209.904863-1-gabriel.totev@zetier.com>
 <cddd7197-4286-4e44-b143-88fdc263c631@canonical.com>
In-Reply-To: <cddd7197-4286-4e44-b143-88fdc263c631@canonical.com>

On Sat May 17, 2025 at 4:40 AM EDT, John Johansen wrote:
> On 4/16/25 15:42, Gabriel Totev wrote:
> > When using AppArmor profiles inside an unprivileged container,
> > the link operation observes an unshifted ouid.
> > (tested with LXD and Incus)
> >=20
> > For example, root inside container and uid 1000000 outside, with
> > `owner /root/link l,` profile entry for ln:
> >=20
> > /root$ touch chain && ln chain link
> > =3D=3D> dmesg
> > apparmor=3D"DENIED" operation=3D"link" class=3D"file"
> > namespace=3D"root//lxd-feet_<var-snap-lxd-common-lxd>" profile=3D"linki=
t"
> > name=3D"/root/link" pid=3D1655 comm=3D"ln" requested_mask=3D"l" denied_=
mask=3D"l"
> > fsuid=3D1000000 ouid=3D0 [<=3D=3D should be 1000000] target=3D"/root/ch=
ain"
> >=20
> > Fix by mapping inode uid of old_dentry in aa_path_link() rather than
> > using it directly, similarly to how it's mapped in __file_path_perm()
> > later in the file.
>
> so unfortunately this isn't correct. Yes some mapping needs to be
> done but it needs to be relative to different policy namespaces. I
> need to spend some time on this

Not sure I understand... I based this patch and its sibling on similar
code for making path_cond structs from the lsm.c functions:
- apparmor_path_rename()
- apparmor_file_open()
- common_perm_cond()
- common_perm_rm()

Are hard links (and Unix sockets) different in terms of figuring out the
correct uid? Or should all these functions be updated to be relative to
policy namespaces? Perhaps they already are and I can't tell? (not sure
what this would look like or how uids would be affected)

I'm by no means an AppArmor expert but I'd like to understand and if
possible help get this fixed as it prevent Snaps from running correctly
in LXD/Incus containers. I've built and tested with these patches and it
seems to work: Snaps now don't attract spurious denials and the ouid
from my example above gets the correct value of 1000000 rather than 0.
However, I can't be totally sure I'm not introducing any regressions or
vulnerabilities.

If there's anything I can do to help with this effort, please let me know!

> >=20
> > Signed-off-by: Gabriel Totev <gabriel.totev@zetier.com>
> > ---
> >   security/apparmor/file.c | 6 ++++--
> >   1 file changed, 4 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/security/apparmor/file.c b/security/apparmor/file.c
> > index 5c984792cbf0..ecd36199337c 100644
> > --- a/security/apparmor/file.c
> > +++ b/security/apparmor/file.c
> > @@ -430,9 +430,11 @@ int aa_path_link(const struct cred *subj_cred,
> >   {
> >   	struct path link =3D { .mnt =3D new_dir->mnt, .dentry =3D new_dentry=
 };
> >   	struct path target =3D { .mnt =3D new_dir->mnt, .dentry =3D old_dent=
ry };
> > +	struct inode *inode =3D d_backing_inode(old_dentry);
> > +	vfsuid_t vfsuid =3D i_uid_into_vfsuid(mnt_idmap(target.mnt), inode);
> >   	struct path_cond cond =3D {
> > -		d_backing_inode(old_dentry)->i_uid,
> > -		d_backing_inode(old_dentry)->i_mode
> > +		.uid =3D vfsuid_into_kuid(vfsuid),
> > +		.mode =3D inode->i_mode,
> >   	};
> >   	char *buffer =3D NULL, *buffer2 =3D NULL;
> >   	struct aa_profile *profile;

