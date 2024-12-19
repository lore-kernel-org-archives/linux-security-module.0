Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5871FA8C2
	for <linux-security-module@vger.kernel.org>; Thu, 19 Dec 2024 14:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734620144; cv=none; b=mu46FeRxUl967qjCaQKY00HzWn2vVXQF9PRGYccfw5lSTIFNd9hhRYuPOEgETPL0nlY6iYVTodBsaIJflAwp2/b+F2NhViVSY8tKlpejlk9DEJsf+prnsoWHkKhpBi0I9sVPb6evRgn7PDHI5n658JZnxtM4ZZT8IXLCbY3Tbrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734620144; c=relaxed/simple;
	bh=nD0RdWI9pH7M+nzees9Jbpi4mb7dX/dkVLsOD5kkdfg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fDzChaoIN9geDBfi+FNP7qY+YEkBYReiUcqoAyYo7DJIx9lLCEk2PObBW6FoeUgEINvNoejjYmmcOYvBzA+T+RwpWXlmsqIlKYyBNz5FWdTzyM3dM1eumZJ+31Grj/KZlUa03ksG00oSpuj46t08VWpldmCilXWhArXzeHRh6s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=BiDhFF4l; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="BiDhFF4l"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6ef4b6719d1so7461737b3.2
        for <linux-security-module@vger.kernel.org>; Thu, 19 Dec 2024 06:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1734620141; x=1735224941; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nD0RdWI9pH7M+nzees9Jbpi4mb7dX/dkVLsOD5kkdfg=;
        b=BiDhFF4lvv9lRtTxTV8XlhYhVX1bAYfrnu50/Vb+b60MDeLvdUo4Mpw2LqS70RtarL
         gqQFrrjjGH9QA0IwGPVm5z0ktYF/83O1LCL0lMj2ejYlSV72PFOOdYCxBgiwPlPohjft
         kb1scc80scFD1l/AGLt5mj82yAdvMyYs000KZrXiT/v4Mo7jg50rwEi4iZ/XyYbvwvdO
         WjylSwoBhYkIfBtOxefazLwHRb1RSBw8LqPJ+z8odEUap+aZhQqEHyWq5Ca606piRN9t
         EgmCTn3RyOV9x4dYl0sRsJNJ9g/tjTzZ5fPx7OJNaF8LPHPrrudAGZacvgKp/L34uj8k
         jGhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734620141; x=1735224941;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nD0RdWI9pH7M+nzees9Jbpi4mb7dX/dkVLsOD5kkdfg=;
        b=cXrBCmTUrKudegyxSasIKpl9JCYhHnK+bGSu8TTy/1cDhl4qDlV5kgpePrhJSDfA2N
         FJwwo6KapDqYpxRHWgdm/dJhxtAkTI+Rn4o6z3c3jzht/9sQ9ilGNogN4UsdKABF4shw
         9Q/2ufl/tswFWAWiAj+/VtLVqRTwF6yLcm4Ds3yjDOcgYcpnwP/ffFxfyD8/Czq9wD/U
         WguglYZn1J1Umx7u453NAyYYpHnuydFtr/igGNhZRejV2kpJ6an0O/jOVEmgCP3b3xf7
         yriY2UUFv4q+jB16h1RPKA0C7O7Zy7qiDAQyujvF4qz6HmO/o2tc/9Tm16gRpiHlmiAF
         RHug==
X-Forwarded-Encrypted: i=1; AJvYcCW7ox/mLZ7JHCSu5LQiNdjcnEDFX53Xky98M0sT+0vAlggl0O8CRkwM58sgk4eJMLGxyJOkhMZrWNYzwjOnvOfcoSDq2Ds=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBqrugSmP990dcau0JPnXlBuqtwkWJMLqgTWPMPVDhyMpeQeJK
	2XfG3NkBHeLqGiWFUUb2PGYzaqJhE8uNXLwJ0yfvClxOzXtqkB1/NGDzepF95jBvDP3kAifOUxM
	bUqknukrqNkoRhqLDDZFL6gi3vBXsFAiy1fUO
X-Gm-Gg: ASbGncvJCGAMJqbKhiQ8tHK/7wkv7V6kIh40SGmskTqZJexoK9vnVl7ffOdAv+ZlnMY
	HeTluRBoE3WqBMss/+EysrTmqGNMhmJTbqbf+
X-Google-Smtp-Source: AGHT+IHLXfk/jcF8KEYS0KdxPX10hu/5HMnoNNvSOItB3ps79bCaRbIBPzFJkvXb0MW43KYXxt91iJFbrvjOBr3FTGc=
X-Received: by 2002:a05:690c:46c3:b0:6ee:7797:672 with SMTP id
 00721157ae682-6f3ccc2a573mr58329947b3.7.1734620141426; Thu, 19 Dec 2024
 06:55:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241215165352.186692-1-linux@treblig.org> <CAHC9VhRyf8Jo54gnz2Nu17eHFOEqeXd3B5_HoXbz9uLYDba=HA@mail.gmail.com>
 <Z2NIpSZ9iY0q1EAl@gallifrey> <CAHC9VhTmqMKkemeyWK3d6tyPGSus9ApMpZzTjtrmgHqbC_au+Q@mail.gmail.com>
 <Z2QrgI0coNmBMonB@gallifrey>
In-Reply-To: <Z2QrgI0coNmBMonB@gallifrey>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 19 Dec 2024 09:55:30 -0500
Message-ID: <CAHC9VhTZ98OwAAtk52MreZaU1OJwKS6PqOU=SCzhfBYNEM8qqw@mail.gmail.com>
Subject: Re: [PATCH] capability: Remove unused has_capability
To: "Dr. David Alan Gilbert" <linux@treblig.org>
Cc: serge@hallyn.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2024 at 9:19=E2=80=AFAM Dr. David Alan Gilbert
<linux@treblig.org> wrote:
>
> OK, maybe:
>
> * NOTE WELL: cap_capable() has reverse semantics to the capable() call
> * and friends. That is cap_capable() returns an int 0 when a task has
> * a capability, while the kernel's capable(), has_ns_capability(),
> * has_ns_capability_noaudit(), and has_capability_noaudit() return a
> * bool true (1) for this case.

Works for me, thanks.

--=20
paul-moore.com
