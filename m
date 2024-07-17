Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19263BBC5
	for <linux-security-module@vger.kernel.org>; Wed, 17 Jul 2024 10:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721211586; cv=none; b=JLDUC7jHHpCieZNfXCFHZ4/m1cdx6MTVWKU3yXt/oEQ1S+OoN+1Vw0l1HfJfi/PgEkujCxEWIvMq0C9+Sds/KgCgOEP6fWBNaCxH1ZUuwhaVAsTyhdHDgGN8Jju80LwoVHypLyD7HAQL4psLyBGkTXdvL5Tsi76MwtOocJgTo78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721211586; c=relaxed/simple;
	bh=dmPrErveI9QrEh/ALH738QNw0Bhaor1QfQBU+noYS6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CkB0gWdwXDRMEX5corYIBzpjFu4HKFHQd1olkqgprZ32HbTkP1qlRj33LfMvVMz2oZGz8+FuRi+stXq01GEz8afI65RefNOgLXC4PHl2Psr1VzofhL59y+wTm2NAdkkbaxKfbGCrBbyJ463mcfTO4KUe4l/Qgfktq50QjN9APJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=HY4PEGoc; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="HY4PEGoc"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52ea1a69624so7046152e87.1
        for <linux-security-module@vger.kernel.org>; Wed, 17 Jul 2024 03:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1721211582; x=1721816382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dmPrErveI9QrEh/ALH738QNw0Bhaor1QfQBU+noYS6o=;
        b=HY4PEGocempt1P+ryYqkk1AM94AKzkbBNlvkmAgPPxSq/ij3kfJi7J3Av0koHdXFhN
         w7uWUY6P2bEVeF0C83d6uAbHwfzjtT8N5wZI9RffbRinSidZnyMU5g5kvYXRNDeJ0MUX
         BHr3axV37gQ+cGC5uBiIhHTgMprM3GUXbg+jYyQCaK/49YWI2M6m0QFy0mat/yrqk9js
         AZZBjvShvCOcL+oBImJW+he3oXWZbkQ/i6+1m0izB6RPQJ7TFbWLhAL9ajTyV1MrT/9h
         jFGVkEZKsr0CD4t6e/tNwHwSO0JQ7Ckv4vy4+ep+JBzOTeCHyVVDEDElaZtLG1AYij0t
         r1nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721211582; x=1721816382;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dmPrErveI9QrEh/ALH738QNw0Bhaor1QfQBU+noYS6o=;
        b=hIaPBVrsN+3KFl0wf2cq5tgq7XTPHaPyzf/EnuMQJSTWTvRz9S+gbKTKkpJ1tcKM6C
         cYxXpqOhBks82aYNcPg2YWGw09Zrfi+iu5D+vtj56QRu/xk8GXsCSe5NlZDx1akOdr03
         PJx4IDnLC3x7VKL3PhV37pAMj5zrMtG9AW7qvwoVRZ+K25ztg/hVwHa6Hyc88Hk6yyhH
         qRPRNTh3iUQU9sXeNIYk9XH9fHPbX7f52D6TUMnt3w4xgTDhbWlUSidWoZmm2cBZh8fA
         wE5mjjU+f+t4FLrR+RmJBuGDqcYv1DbG8Z4LIJHlbziC/lsOyT6orRtnX+Nxtu7yRlyC
         wPJw==
X-Forwarded-Encrypted: i=1; AJvYcCVzlQiu3suB0OupXfucKKC33YscxAthqRUhFlCTIsZYapxkP4pdRYitaBzqhSQV47RchZRJciFRBPuwqENwYrdDfYHXgji3Sgn4y2m/YvkFef9vE+q0
X-Gm-Message-State: AOJu0Yw4y3zovmKVHN6J9OwFzvIUiUQchfMXxKBbAwbVL6C1oIqdIkf8
	lLTGvpbBEk1nwFtT7CmViSzkmdUhj8dqaF/W4dEyZg63TI5Wtng7eWGQkAZ/27Q=
X-Google-Smtp-Source: AGHT+IEag26CiKDtnt6JUIWKttV5gz23VEY2V5rBdKxFWabZZE7cd1oBzs2oKhgA0HlG8qxYhwdSaA==
X-Received: by 2002:ac2:4e10:0:b0:52c:d834:4f2d with SMTP id 2adb3069b0e04-52ee53bbf6amr986059e87.18.1721211581711;
        Wed, 17 Jul 2024 03:19:41 -0700 (PDT)
Received: from blindfold.localnet (84-115-238-31.cable.dynamic.surfer.at. [84.115.238.31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427a5e81f0dsm164072005e9.12.2024.07.17.03.19.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 03:19:41 -0700 (PDT)
From: Richard Weinberger <richard@sigma-star.at>
To: David Gstir <david@sigma-star.at>, sigma star Kernel Team <upstream+dcp@sigma-star.at>, James Bottomley <James.Bottomley@hansenpartnership.com>, Mimi Zohar <zohar@linux.ibm.com>, David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, David Oberhollenzer <david.oberhollenzer@sigma-star.at>, Richard Weinberger <richard@nod.at>, upstream@sigma-star.at
Cc: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>, Jarkko Sakkinen <jarkko@kernel.org>
Subject: Re: [PATCH 1/2] KEYS: trusted: fix DCP blob payload length assignment
Date: Wed, 17 Jul 2024 12:19:39 +0200
Message-ID: <2351895.22IY78Rhhi@somecomputer>
In-Reply-To: <D2RQC1H7N1JI.1W4JT8FI0R8L4@kernel.org>
References: <20240703125353.46115-1-david@sigma-star.at> <D2RQC1H7N1JI.1W4JT8FI0R8L4@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Am Mittwoch, 17. Juli 2024, 12:07:58 CEST schrieb Jarkko Sakkinen:
> On Wed Jul 3, 2024 at 3:53 PM EEST, David Gstir wrote:
> > The DCP trusted key type uses the wrong helper function to store
> > the blob's payload length which can lead to the wrong byte order
> > being used in case this would ever run on big endian architectures.
> >
> > Fix by using correct helper function.
> >
> > Signed-off-by: David Gstir <david@sigma-star.at>
> > Suggested-by: Richard Weinberger <richard@nod.at>
>=20
> You cannot suggest a change that you author yourself.

Well, I suggested the change, not David.
So, I think you're implying that David's s-o-b cannot be before
the Suggested-by tag but after?
=20
Thanks,
//richard

=2D-=20
=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8Bsigma star gmbh | Eduard-Bodem=
=2DGasse 6, 6020 Innsbruck, AUT
UID/VAT Nr: ATU 66964118 | FN: 374287y


