Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A476222AE76
	for <linux-security-module@vger.kernel.org>; Thu, 27 Feb 2025 10:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740653268; cv=none; b=meZzbX5bF7atNIWGJbX/KaIjrAkyxvt9CdeQCgooUkqbig8RhK+WqX4FYi83+ORc/nC4TnEYi4jG2KrXPFogghFRF7TuXgHQvYb7BH8P10FP63gv4vMzHLuYM+oDeD/ubRTZhionJFyFVGHSNHg/VQd/MgGqH+E6AyC5UVft+M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740653268; c=relaxed/simple;
	bh=voqDI+sR3cgQLpRJNz2L7lClXa4i8MTgaVBRLvybSdM=;
	h=From:Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:
	 References:In-Reply-To; b=Yd6/SBbwzywjjijQLiNjzWW+EHD6bTr2XXDeKBzyezscXBF7RXYO3nURXg/uchgEEihVdQhu6gGqG20a2F+8jOQ4mKghWp0Wo84ZEpgeaRSE2ZdE7czazfZPJ6fOUumv3XMZ7EuC+OXh9yZU1CgVo1WD9CDZbcFlT26pF19XycQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EfBCFwJP; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EfBCFwJP"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5ded51d31f1so1293822a12.3
        for <linux-security-module@vger.kernel.org>; Thu, 27 Feb 2025 02:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1740653264; x=1741258064; darn=vger.kernel.org;
        h=in-reply-to:references:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hwYrgbQrysBcAd8WRw0jB/UCnkIW4vR+8ZOYC92wVf4=;
        b=EfBCFwJPvX3mJBaI1iMIG6qRcCc/ZE0MBX6+7rU2JyA55KjwnWRARWDOtWMpATTJti
         9qUmo44uX1c6pWtCIbFfYfLsskm0Z+OJJTDPwaPVPGrCOUs4Ug+GbrP5n5QpXGkoXfmc
         f0tJxpdBmvPQ2TSmKxKhrrIIb5LOWDH6aVbCK7qzHu8fTNodSJbHz+U6mBIGWyOsE0FO
         l216f4svoJhdStviEPpjKgQJbsScHiJXTljrahFMHQ/CJvEbnyDPcsXn9aLsiV4tatLT
         MtBnRnVkSvqtwK8VLafHNFU5s4Wo3lJnyw66a/1hXQWEtc//lnIdWMBp5un8H2t58QMJ
         2ZnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740653264; x=1741258064;
        h=in-reply-to:references:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hwYrgbQrysBcAd8WRw0jB/UCnkIW4vR+8ZOYC92wVf4=;
        b=dWSje17imXF3H2HGTDcBcmyXB3csCBPYsRddG5tRA/HmxByAXSRjVIEF0ixX/CQe9k
         erXl2VX+InIicWRH4RF1+S+6t2ElxilGGRqY1fx8OcqtLygSzkJkMEyJHf60zBaWDiR8
         nC9ugbLgSy8svp9Bzlee5ZF2IKftJwC1TOx4JUbzhnl0zdnwK6+6r2pZLg3tjX6pD1Ob
         Azpz3AS8soOI8cAgS8SVMaIC+KP9/y03ektF0PRYPjG1VR6uK5NqB546KhDck52vkuVU
         d3CMuZUeghI6J+Ycb/LDMJoqJZqbr7Lr/Rxrzk449MVnenVAsKTtABN+Rvf4w92VpAb6
         hRoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUACFhY1vjq8W4HTbj/30BmCrjGxRjeutzlopnxIsOm0qHw3jGC4RsCNPMQsjGcdRJ1X0BtCLyudh31YWaNrBIlCk7gL7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy957jENUW6U9/4d0ykFnVF+RPyqZBBQGwXMZflQ207xj95i4ZO
	tMHlPnofcZAwI3u/VYb5zsgGaLcdCW0sGJrptCJChon8ijEMckhUv7XVm3/35HR6h3Hq6UImo2L
	dUIs=
X-Gm-Gg: ASbGncuL8W4RP2f29UzfLaxZAW+QvO7/q1rTMdwkYom83PBlnzHKj+oAyfap7qbMN3H
	kMAseYhZC7TUZb9uBzNo1eDyKRT2OLaL2rxb4X3O+FZ769si9HPrrfdtm5cLgf75YeesNOvwewN
	sL6BEI/9qH/lnVUcVyFBTYb8lOrrkLsCirSwJ6QNMM6R+dnJekIkTXSaPFcqRJyMiriG27j0LIq
	gi17NVF8S5MO/RsZO7bAabR1fdMximgF7vtS7/Nat4W03CBMw/3rRA7hWvbXFKPS9+MD7fqByOK
	MQ1xJPL7/qNWTdI=
X-Google-Smtp-Source: AGHT+IH/QdSWLijhlmKS6cpPQOvDmaBBqLi3TtTAJFjDo0/KOlaCmiQJXCXK3w63xzxEUvqFh2dyGw==
X-Received: by 2002:a17:907:770f:b0:abe:e91e:b7d9 with SMTP id a640c23a62f3a-abeeed10d3bmr882696466b.1.1740653262374;
        Thu, 27 Feb 2025 02:47:42 -0800 (PST)
Received: from localhost ([179.228.215.131])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-734a00400absm1199194b3a.151.2025.02.27.02.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 02:47:41 -0800 (PST)
From: =?utf-8?B?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 27 Feb 2025 07:47:38 -0300
Message-Id: <D8362ZV7Y4YI.PJTF4OC88RQK@suse.com>
Subject: Re: [PATCH] security: keys: Make sysctl table const
Cc: "James Morris" <jmorris@namei.org>, "Serge E. Hallyn"
 <serge@hallyn.com>, <keyrings@vger.kernel.org>,
 <linux-security-module@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: "Paul Moore" <paul@paul-moore.com>, "Ricardo B. Marliere"
 <ricardo@marliere.net>, "David Howells" <dhowells@redhat.com>, "Jarkko
 Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.20.1
References: <20250123-sysctl_const-pcmoore-v1-1-d9f918dbb0be@suse.com>
 <CAHC9VhQpkyqaJsxj9_d4d6Vpc+FVbSnH_HeAFAVEdj0trGCh1g@mail.gmail.com>
In-Reply-To: <CAHC9VhQpkyqaJsxj9_d4d6Vpc+FVbSnH_HeAFAVEdj0trGCh1g@mail.gmail.com>

Hi Paul,

On Wed Feb 26, 2025 at 9:21 PM -03, Paul Moore wrote:
> On Thu, Jan 23, 2025 at 2:50=E2=80=AFPM Ricardo B. Marliere
> <ricardo@marliere.net> wrote:
>>
>> Since commit 7abc9b53bd51 ("sysctl: allow registration of const struct
>> ctl_table"), the sysctl registration API allows for struct ctl_table to =
be
>> in read-only memory. Move key_sysctls to be declared at build time, inst=
ead
>> of having to be dynamically allocated at boot time.
>>
>> Cc: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
>> Suggested-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
>> Signed-off-by: Ricardo B. Marliere <rbm@suse.com>
>> ---
>>  security/keys/sysctl.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Looks fine to me.  David or Jarkko, this looks like something for the
> keys tree, yes?
>
> Reviewed-by: Paul Moore <paul@paul-moore.com>

Thank you for the review, but I believe this has been done here:

https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3D1751f872cc97f992ed5c4c72c55588db1f0021e1

>
>> diff --git a/security/keys/sysctl.c b/security/keys/sysctl.c
>> index 91f000eef3ad82370250e5238d9c9c80757aab61..cde08c478f3272081304e6db=
34e36b64ce0d321a 100644
>> --- a/security/keys/sysctl.c
>> +++ b/security/keys/sysctl.c
>> @@ -9,7 +9,7 @@
>>  #include <linux/sysctl.h>
>>  #include "internal.h"
>>
>> -static struct ctl_table key_sysctls[] =3D {
>> +static const struct ctl_table key_sysctls[] =3D {
>>         {
>>                 .procname =3D "maxkeys",
>>                 .data =3D &key_quota_maxkeys,
>>
>> ---
>> base-commit: 714d87c90a766e6917f7d69f618b864d350f09d3
>> change-id: 20250123-sysctl_const-pcmoore-fa14389b8329
>>
>> Best regards,
>> --
>> Ricardo B. Marliere <rbm@suse.com>

