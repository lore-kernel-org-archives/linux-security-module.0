Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B601BDC3;
	Sun,  5 Jan 2025 06:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736057289; cv=none; b=CDr7zfqdsfoN8OrP+lygRlpegn6zDEjugTneIzAnKZTUKmPQNmzzlk7aCox9hl4ZBBAzyhedYaXJFZen6lCxgYA41suWXwRRQglQCzTPsC7EpBrXVSf/wti3rJKaoT5giwhdZNba9dx/Kyd8xGrINzHPgYV85q/fLmgj9ZThsT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736057289; c=relaxed/simple;
	bh=YAP80eNIzsVuTJaZhRorLhaQiJ1vzZJrxsGDSWOTtOE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yqf6saeK/I3IB2bxyoPB4NV15E9NLiURvMRkV5cY4HyRUhgenjnRW36wZoDWU6CA2kh9gaNZbc8WPJ1g3EzFfDq+M6d9SFU+x/PX5E2MoAkacIXoA8jvzEnKugRcH4N+ouAFbkG0PzF6YBkd3oHSdNlqqjpniPAI1ZIqaJ0jzac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N7K5lBSB; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N7K5lBSB"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aa6a618981eso116024466b.3;
        Sat, 04 Jan 2025 22:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736057286; x=1736662086; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fVSE4N1RwT5qB8XJOjmBWIN67S8Ite+kAcu3R7AOcM8=;
        b=N7K5lBSBkHbm6oqKGkY2XgeQQpmhDC9zTfNVdoQngERNTQhnJFeZJvI6jNUHIwIJyn
         9g8HJb4erK/9/3lCRn9FX8qXnc/WANitR9Ncjdyu2h0CwNrI3+tFbVq/846Nn9vjismN
         ReqO81HOJ7QKBCqg7A+pn4iWsoqH5e0dmAsSpvUFJjL1DYJB3tmB+NagoMzsM0P0b+1z
         zHqMlogxLlBwkwf46YxYrIgfm++kOSbg1ccwM6tEcTYIEIBojCgn6gcYEUCepwS8HHx9
         7mfDowunga2QnzSBs5mEALB9PH1Ibt2xGtO0vx0HG2PxyRr70YL9ji5RAOrunkcsXX7/
         wCPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736057286; x=1736662086;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fVSE4N1RwT5qB8XJOjmBWIN67S8Ite+kAcu3R7AOcM8=;
        b=OloSOvX7w7gdKxiXmudJFAXHMYrAzmLN1XoEvr4Zbj3BRcLvBX6euKb4004agHVTwN
         EYsjd0k3BCX/sWeGXi6X4G7SU4jaXEVgAkwAgurFVxRbIpv5usoNSuevuNNqWPhUgBmi
         JS2rxXsNQjsQo9lOir2MghuJn9XgRM64aKYe78pgLlm3/g385fieZ4iEA/USpaS1TpM9
         XigpgWF+45V5+iqxCghk5TDNU1Pg8L9QnOnEQB8Vp59tGVLma119oK/fGMfV5IasDALV
         be2jk7jPNbVB8niKkaMSss6oBhsMqLLBE3HanSemNH+V5axRs+iqf3SSipKmdTA66PQZ
         v/lw==
X-Forwarded-Encrypted: i=1; AJvYcCWbjl0+Du260qZEb6S0abCX1QArJZGYJx2SIjPtUVqwlQzdK7FO2nshzbncdymOYM6zUUIsDcjsseumpZWPu4n8X5nTp2/p@vger.kernel.org, AJvYcCWoUYYNZvdeNZTapX/Sy5kGKL0ZHEh+GOrif4kGdb18ShyfiJEC13268d05whFWWCeNOvTaEH1cuMleH00=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlmjXlQfaL6XWHIqgyDI6DqIhA0wPm6nmvpCGBZNwtIQmd3NdD
	sD6MoqQOtXqdMppQTTGUmYafv2fNYH+BA5luVIyUTlLH2Tx2bDOdqzaua91GjHMb76AYo36mmm5
	ZQd4TDPv6Q8jqkeTlzHojnVsHfdM=
X-Gm-Gg: ASbGncs4D4CBaLne2imCdUx4mM4MiKqJkaqw/SXx0VhYaxWnyI9v92tyS5igz1wkvE7
	CCorVRVoO0GC6SAPOPPKv5X50JLCaQ3u8iZwZ+Th4dqawsJZlKZqFuCBPnKZXSuqOTtlNEwsy
X-Google-Smtp-Source: AGHT+IFs7H83zXOps/STjbxVwwtqo46ZyZZfwjOuimQtPkof2otQSHLh6BtwpkMXd3UN08eNaiBnhniWfcntKZ37+TQ=
X-Received: by 2002:a17:907:d08f:b0:aae:9cfe:4448 with SMTP id
 a640c23a62f3a-aae9cfe46a7mr4206579666b.29.1736057285500; Sat, 04 Jan 2025
 22:08:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250104191006.3807-1-tanyaagarwal25699@gmail.com> <018b4316dc1089799101308931a47fdc@paul-moore.com>
In-Reply-To: <018b4316dc1089799101308931a47fdc@paul-moore.com>
From: Tanya Agarwal <tanyaagarwal25699@gmail.com>
Date: Sun, 5 Jan 2025 11:37:56 +0530
Message-ID: <CAPdGtUzwUdahFMmmjsjw_Gf9gsNvfB1Qj6aMh0eW7y0oDvNeDg@mail.gmail.com>
Subject: Re: [PATCH v2] lockdown: Initialize array before use
To: Paul Moore <paul@paul-moore.com>
Cc: jmorris@namei.org, serge@hallyn.com, kees@kernel.org, 
	yuehaibing@huawei.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, matthewgarrett@google.com, 
	skhan@linuxfoundation.org, anupnewsmail@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 5, 2025 at 9:45=E2=80=AFAM Paul Moore <paul@paul-moore.com> wro=
te:
>
> On Jan  4, 2025 Tanya Agarwal <tanyaagarwal25699@gmail.com> wrote:
> >

> > -     char temp[80];
> > +     char temp[80] =3D {0};
> >       int i, offset =3D 0;
>
> Since @temp is a string, it reads a bit better if we initialize it with
> double quotes, e.g. 'char temp[80] =3D ""'.

Hi Paul,

Thanks for the review.
I agree to change it to double quotes and will send it in a revision patch.

>
> This is also a case where the static analysis is a bit misleading.  The
> @temp variable is uninitialized only if the @lockdown_levels array is
> empty and seeing as the @lockdown_levels array is a constant array
> defined in the source, this isn't a real issue we need to worry about.
> However, if you wanted to fix this simply to quiet Coverity, I think
> that would be okay, especially since this isn't a hot code path.

I understand that is likely a false positive. However, as you
mentioned this is not a hot path, making initialization explicit could
help silence the static analyzer without any real downside.

Thanks,
Tanya

>
> >       for (i =3D 0; i < ARRAY_SIZE(lockdown_levels); i++) {
> > --
> > 2.39.5
>
> --
> paul-moore.com
