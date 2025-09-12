Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22552E401
	for <linux-security-module@vger.kernel.org>; Fri, 12 Sep 2025 01:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757641735; cv=none; b=VpR+Vklwg0fhtD5i371USRAwIjx6Pd0ev06mJ8RbwezL0bX9+5Pu+5WUSJqjgAljooyhZ+niftEBGLxq2ey+Cir4v2qMVPx6+H6chVJvIbeSsFobgMunR5zi4Zh/0yYKf3JS9X/6rLfOA9X45qgrRu2miOjmZeaP8btoeRKlk6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757641735; c=relaxed/simple;
	bh=Zga3GNusDfSgVUj052y05xC1n7khhCDCOun+kMC4wAM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LCZERw/8vjahTPJLRl1udTQrUbfk9ElwQ58K+q7jUcd7Dkx6cB26kSmS2G2OXRaaoU7jjOxQHrnhl4ddMohqEbV2Xvto5GB2aajE+yoKPGFNzkh2FV8HhtkN2QSTcRg0csjNvi2JVuhn9F1BXw5csexs61gV/AIczSG9Jpkn2DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=AQ5pdCaI; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="AQ5pdCaI"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7741991159bso2085827b3a.0
        for <linux-security-module@vger.kernel.org>; Thu, 11 Sep 2025 18:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1757641733; x=1758246533; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kwZ+efw570OZx4YJ4/j4PWOdvYDNSjRQjeqYpWheFvI=;
        b=AQ5pdCaIeyVAXT5K0h0cZt+naDyhkgw0cp1RWM9QeJZyxqYyA+4mKWKbtnRllowQLi
         e623bHYj7BubYyltm3SuOfK4n3kwXALVopz9jzHGd7sSrsaKVQHkQ7AH1Q444I56oxZ8
         mvlUDjWL240u/2XEgY4mGFq2rVUqdEiw0/gTt+4+yLc/T/zF+pXjtaHnJWCGRg8mvUcf
         t6iS/Io4K2dxJ0gEbT3jcB7pADbKsCBchwbyWjZNGK8qDelC33kUYPY0JMo6eAGaTOaP
         UWus4dGfpMDrW4a/BAwEEp3XSG1aALeVrZEjKKCcLTBiyU+hkyWWdwsoR31frBSW50jf
         P1rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757641733; x=1758246533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kwZ+efw570OZx4YJ4/j4PWOdvYDNSjRQjeqYpWheFvI=;
        b=RYzDurWNXh2MyDQx4HkjH5pwhAnw239EvPIfUIFHpTU+ZUrUVUzLD+vmlZljBdykps
         Buz+/sAn03fd7iq9d8aOlRVf1Ro/62pAC9A1fM6UE6Ed7toQS0C/AmJ2np67L/mv9QkA
         9rAkHztTf7HoQtMjrjDTJHzq39ZMrJ7nSKFoy3BsYl6XNRBRGay5KNiSC5bbE0gKKn8A
         MWCXBSot799FAnsO5cdanLd+sDjaJQlSdBULTjAMBoENqbTV3CPBvCg0wQhewCFq80iw
         Fnr9YZYvwRU3mj/4rTyoskV4/amXQzmOQHmjEcJzkrjqL9DId0Z5KFMuaFCSxKWiCCpB
         B9Jw==
X-Forwarded-Encrypted: i=1; AJvYcCVDOxr3QLxDEejKU9kADr6+xpQu/Tn+ctGYkS356CW/W50G94zzmyt0jjnV891LVtnHcSbZgNw28FeZwM0PIni1dB6WWDk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVKZNQN4mObHRsnfvUedR93vFaOdrGpDu5BPR2+LM3AjU+/21x
	rnglnpY51fbObnnD/h2EM9Cn1zny/8UC2b28eNflyjW3j2ejIZvTp5s+U685KQDrczRnDkYP8Am
	m4+pP6CFqrhgcwpKjH1wAmPssPhKlfFMk1VZWcaEM97DAMRpFagmfsQ==
X-Gm-Gg: ASbGnctP68WGGQSXxjyCnqH4TQtddCneaM0KXFxlptWLLCvckjrgP2Xh7WjRKIDeKfX
	Jc7HYGfRLHNA16mwfieqZRfOoOaxp42q0ocGpK/Mft0sf6zxVNIqPKPE5kEACKoKwUnPjfzKXng
	x+wsIqlZGY+vXZpjTV4diBVmOHfbOhMbkuUsy/JeOzUAxVrhVkcFGjUddDeqXPgnK6eTf3u/W2u
	MU482Y=
X-Google-Smtp-Source: AGHT+IFcmKzAXmvR3kg0PSIDLyLXxlf/usnpeiCPFujxVN4S0OObwqltQTuSb24BYjTIZ7ku3FiMsnAVEhIfTSZTKnU=
X-Received: by 2002:a05:6a20:158a:b0:245:fb85:ef69 with SMTP id
 adf61e73a8af0-2602c04eaf7mr1616418637.40.1757641733012; Thu, 11 Sep 2025
 18:48:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903192426.215857-2-stephen.smalley.work@gmail.com> <aMNVDOCjCBZZE8Kb@mail.hallyn.com>
In-Reply-To: <aMNVDOCjCBZZE8Kb@mail.hallyn.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 11 Sep 2025 21:48:41 -0400
X-Gm-Features: Ac12FXwv-pJpiAmW9-PshxFm06tfN1NilplttFrornlIK7ric0mSfbZU5-JB9Tg
Message-ID: <CAHC9VhQYr_3WzG__RYs_mPtMqFCQz4wbrUnyGZeyKjCuEO93_Q@mail.gmail.com>
Subject: Re: [RFC PATCH] lsm,selinux: introduce LSM_ATTR_UNSHARE and wire it
 up for SELinux
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org, 
	linux-security-module@vger.kernel.org, omosnace@redhat.com, 
	john.johansen@canonical.com, casey@schaufler-ca.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 7:02=E2=80=AFPM Serge E. Hallyn <serge@hallyn.com> =
wrote:
> On Wed, Sep 03, 2025 at 03:24:26PM -0400, Stephen Smalley wrote:
> > In the hopes of nudging the conversation in [1] in a more focused
>
> Hi Stephen,
>
> what was [1] supposed to be here?  I can think of two possibilities,
> but I'm not seeing it inline...

I'm guessing Stephen was talking about the "LSM namespacing API" thread:

https://lore.kernel.org/linux-security-module/CAHC9VhRGMmhxbajwQNfGFy+ZFF1u=
N=3DUEBjqQZQ4UBy7yds3eVQ@mail.gmail.com/

--=20
paul-moore.com
