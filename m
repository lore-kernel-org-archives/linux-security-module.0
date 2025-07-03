Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B17291C08
	for <linux-security-module@vger.kernel.org>; Thu,  3 Jul 2025 06:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751524107; cv=none; b=DhMNeXJ5C/NZz829TPlmaZvl0gS6C8xfs0GE65P85qQDGS0WAlUp3AudYY0UPlSrEtiAM4KNV9bvTRJ22RQQG4aTktf+LoBNsekUgHKfmXkaer6AZUAgjlJ9G3ZiCNJgxX4N5Vx3T4a6sdWIK0zmdN3yaKQry7vBehjEgxhUpnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751524107; c=relaxed/simple;
	bh=MO59kQdKIQ3jRqDULHDpVDumKyq+YbjeeZVE+XaSpoE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G3lUDOBh3qDVvxTDq5IA5tyhChAotDC0Ws1MubP+ef+3B1W/2hvVaaCTJFKAWLze8iQq/BkjeVamM7Uov76/PAxztWmHKx52WKMXJQHECmArUDFZfMZYIBgFtxFwmqumCqT4AzgFY2TM4nlnNDl50MAlxUI+HMd64UpsTM/KGlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xACxaZEt; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xACxaZEt"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a4f379662cso4436492f8f.0
        for <linux-security-module@vger.kernel.org>; Wed, 02 Jul 2025 23:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751524104; x=1752128904; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MO59kQdKIQ3jRqDULHDpVDumKyq+YbjeeZVE+XaSpoE=;
        b=xACxaZEtZzNddQVaa69kh/phyWzwSRWQdUHdNE5V+SqhMVH2BpcAWZkmwfrX8rCIh/
         6kirOdzkO33H4dimHfcc7LNDuSf4u1ErTsT2eION8QZS2uSmUju8kholZu51b18MmUzU
         RnJYhc2Ppxb3VNMlDUxNZSDQmISKWm3Y8GxbRdjbkYnUSKWWI8ZpHiKIDUoqyFXmCW2h
         uVgr4L/HIuUlSFsfakqR2wsjWZA1/LfU5rlGEnLhbEuLdRS1JMIHao/mbmFX3uN5kLns
         pEfMwIICqPvR/Qz4j7WdxGV/Vg75yTIHrYzQbKCTgQlv2I0oPDWEp81E1HoT3Hoba3Qj
         UorA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751524104; x=1752128904;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MO59kQdKIQ3jRqDULHDpVDumKyq+YbjeeZVE+XaSpoE=;
        b=ZTuoWsP9dyOtO0UEztO4yNRcYw3H0A6REVUS5fC/IHUBjNSqfqFxI0JnvoDkJ3Mk3q
         tdznuzmbEIMiDLPsTjdI6mcDS0n9FLJobAsrlL5TDxixQhi950V4ImuVmsSzZ0AaPQ8m
         iJioLIUu4y3w0vzXwkmZ8htuhWxx+FzRq8YB9bibmZ+Ia2ZOapEiOmekK5/gd4WZtEon
         pta/bOiM7w93UZfPksConK/BYyD/3I8FJzlSGIKIyiTEh7MrZMlZFLtaTgsb9bLUeKrh
         v7T7u/71nj4Mvr2qg5tNsVheLAUD+6iQKgP7h7RoGkri6+gwTvavd9orX0NVN2H3Ex/f
         nPsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZFCSX1qM4G7M1VHUd3SkO56+xTHuc3uTpxpl1emGCGeqONh264x5/aMb22DsxZMma1INov+qav1gEiuwLeNQUh3/gWos=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+VLYeh7MGr9qNla5dILONUTKMmIKzQm9F3A+8W9sPKPnpkShz
	FzB3iiPY50P5ML+j8XazrkbR5t45SsEqRfdjBPfUIoVzY2UnqraY7Ihc5ztFVbAnm1w=
X-Gm-Gg: ASbGncvc+70Od6Ugdj03RNw/7MCSgyJbtgrW09vg/jC7p8XXdWh6YSngG6oTqy2FwYr
	XwpsFfrnFUpVy6mhVtzlfYbsWETzIMqzEnxGZNazBDANyaYv4Es3dKCjpWXs3ae4UIDae63F/EM
	XooGXfdrMQsRzi6bMjOwXTWux2S6xf1wZf4lSWCRarqQE5WyDNu+FCklNtAJeN0Wc9bk28gIfa8
	luBmYLJmJBWXapJfI4V8902M8SlLaVVnk2Aa+9I7nGElu2Frc18KS5lxe0VSGFrEVozAwGtG5T1
	d7wL6us+vHL0GlO3zBgCqekHa0SETf5SMt2AfaDdpiFualKunRUis6SN/ZXdQchTKZCaN5HYW76
	q
X-Google-Smtp-Source: AGHT+IF5h/wZ6d5NNeUR6agDG/7PLqUPnsk7I84b3H4DX8EaAsYMBom8LuJRN2UToI44f6ice+Jz5g==
X-Received: by 2002:a05:6000:703:b0:3a4:f6ba:51c8 with SMTP id ffacd0b85a97d-3b1fe5c082fmr4402569f8f.14.1751524104371;
        Wed, 02 Jul 2025 23:28:24 -0700 (PDT)
Received: from [10.1.1.59] ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454a997b1ecsm17126905e9.11.2025.07.02.23.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 23:28:23 -0700 (PDT)
Message-ID: <e3a974d1f7fd1ed2a631d3ddf46eceec3a386615.camel@linaro.org>
Subject: Re: [PATCH v3 bpf-next 1/4] kernfs: remove iattr_mutex
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Song Liu <song@kernel.org>, bpf@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, kernel-team@meta.com,
 andrii@kernel.org, 	eddyz87@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, 	viro@zeniv.linux.org.uk,
 jack@suse.cz, kpsingh@kernel.org, 	mattbobrowski@google.com,
 amir73il@gmail.com, gregkh@linuxfoundation.org, 	tj@kernel.org,
 daan.j.demeyer@gmail.com, Will McVicker <willmcvicker@google.com>,  Peter
 Griffin <peter.griffin@linaro.org>, Tudor Ambarus
 <tudor.ambarus@linaro.org>, kernel-team@android.com
Date: Thu, 03 Jul 2025 07:28:22 +0100
In-Reply-To: <20250702-hochmoderne-abklatsch-af9c605b57b2@brauner>
References: <20250623063854.1896364-1-song@kernel.org>
	 <20250623063854.1896364-2-song@kernel.org>
	 <78b13bcdae82ade95e88f315682966051f461dde.camel@linaro.org>
	 <20250702-hochmoderne-abklatsch-af9c605b57b2@brauner>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1+build1 
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-07-02 at 14:17 +0200, Christian Brauner wrote:
> I'm folding:
>=20
> diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
> index 3c293a5a21b1..457f91c412d4 100644
> --- a/fs/kernfs/inode.c
> +++ b/fs/kernfs/inode.c
> @@ -142,9 +142,9 @@ ssize_t kernfs_iop_listxattr(struct dentry *dentry, c=
har *buf, size_t size)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct kernfs_node *kn =3D ker=
nfs_dentry_node(dentry);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct kernfs_iattrs *attrs;
>=20
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 attrs =3D kernfs_iattrs_noalloc(kn)=
;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 attrs =3D kernfs_iattrs(kn);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!attrs)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 return -ENODATA;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 return -ENOMEM;
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return simple_xattr_list(d_ino=
de(dentry), &attrs->xattrs, buf, size);
> =C2=A0}
>=20
> which brings it back to the old behavior.

Yes, that makes sense and works for me too.

Thanks Christian!
