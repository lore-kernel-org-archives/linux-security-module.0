Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9087917E8FD
	for <linux-security-module@vger.kernel.org>; Wed, 17 Jul 2024 11:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721214243; cv=none; b=KWZqz5i3BftSOV8+Hau9WbdpTEaNWniavHQFSW9zhtH/S0sbpHFVGJZNas/4yAlEfxh7zj/4t3KRCOcmRwUP8l7xaaXZB+mok36iYZMM96uq6FkuACJaNxFn+Cvqkzv5OrY2JSeKdF5iBPcfexGdJgGBNJOOOIG73WPFy+EaVuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721214243; c=relaxed/simple;
	bh=BISw6QaYo5XGw4g9kcYQi/vCvP2PYYCiF3MeCq2fVFI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=pkckSo4KPU8W56mvyyNj9ejv8VoEshXJXtEErzhx0GVYYnx/pkDOZTxkOjkkEeAELyZiuuM8fvXlDtwa0NPXbChwHbk086+iiQab0ll3X+UBwS5P7vfdwDuVIKRXz1cTYMtRzZSiJ0+nMXcRN7jvrXonmr4JTEstqV/KZs+flUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=vutvKP5m; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="vutvKP5m"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4266182a9d7so43375445e9.0
        for <linux-security-module@vger.kernel.org>; Wed, 17 Jul 2024 04:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1721214239; x=1721819039; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BISw6QaYo5XGw4g9kcYQi/vCvP2PYYCiF3MeCq2fVFI=;
        b=vutvKP5mO5yJZfgL6NY0i5pe/9u1TdeOWI4SnjXNCpFyX3FGaZnZ6wtRslmBeXODYu
         2CIY+fs2XJMbPPlIe9nAimchkDJIz5uf8DNirxMtxVGzB9+YaHjXWEwxG8VHrXH3m97u
         kkAD0/SCz0afSe8iaYVdfd+UDFx0938xefudscIsQTfb6hFiXkHGiUN6YPCtoanqICbp
         FytCooA4kVIy10XrywJ8kdMoyTp20tlUWXXZlqpWGjWscwyzCFu2UtZzp2hixFrCRc8l
         Sb+SfZqsDEN3LeQs0GEjo/MDL6GBus6Om+JWAAtuaO33Io3ZexA4w4NLDolcnNE3gZtG
         StRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721214239; x=1721819039;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BISw6QaYo5XGw4g9kcYQi/vCvP2PYYCiF3MeCq2fVFI=;
        b=vAdB6G7QodgODZ160OVy3+/n0DGIYRJnLxnL7YbT6QQMBSBBI5GYJg5Ysj78B/6ekL
         vpP4/FQphSZJZYr7ZpI6RGVFldlhTGiTXcW9A3x/9bShsmnLuxvgtY3/6D/Q4GI97/xi
         6jSxSYCi2nrNKkmaiLhoH3OCsGgvkCsnGReHM64h9X+/BA8nzIPxnKjTZo4O8Caqyi0s
         9ZKLeucoerfZcxe9AtDNQzbA6/kBYBFNjB0GGwM80FlwUMMIsele03tgMtMmb9IuzlPb
         /ZQTn6l4lcZM+OOyGBGfYKiKKR7fBWjgTrEfn5F9jXO8HvwsAILwCKRrR1Ra5VSGmphJ
         hUwg==
X-Forwarded-Encrypted: i=1; AJvYcCVYznw++xSIAga8y9DaFMxuFBX+/F+FHOEM76dPChuq2os1LYOlwW+hum6uP+M+IFiMS4nHHJ/OJj4syxpuK8uKUQkON9uYeQ9emMJnCsnOzBtp3Eos
X-Gm-Message-State: AOJu0Yz9mmt8jyzh1n/sxOxlDVAvROO6qMQKCFVDfHaWGZcBpxedNytG
	8TVudRt4FNBECIb5v3KImYp0KcBWnFr0ZfyGT2X5W3IqRh+sBgbrNzoTEiBvIEc=
X-Google-Smtp-Source: AGHT+IEDplGH0IVfvijmWw8u0JGSe1acucXgpm0GKMtZZyBCxjNkFTfli8WiN3/+52j395E7jXaZoA==
X-Received: by 2002:a05:600c:4510:b0:426:6f31:5f5c with SMTP id 5b1f17b1804b1-427c2cbcbffmr9472755e9.17.1721214238878;
        Wed, 17 Jul 2024 04:03:58 -0700 (PDT)
Received: from smtpclient.apple ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427a5edb525sm164901895e9.34.2024.07.17.04.03.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Jul 2024 04:03:58 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH 1/2] KEYS: trusted: fix DCP blob payload length assignment
From: David Gstir <david@sigma-star.at>
In-Reply-To: <D2RQC1H7N1JI.1W4JT8FI0R8L4@kernel.org>
Date: Wed, 17 Jul 2024 13:03:47 +0200
Cc: sigma star Kernel Team <upstream+dcp@sigma-star.at>,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 Mimi Zohar <zohar@linux.ibm.com>,
 David Howells <dhowells@redhat.com>,
 Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>,
 David Oberhollenzer <david.oberhollenzer@sigma-star.at>,
 Richard Weinberger <richard@nod.at>,
 "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
 "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
 "linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 kernel test robot <lkp@intel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <CE5319C4-F81F-4C70-AF74-B0B32DC60CCE@sigma-star.at>
References: <20240703125353.46115-1-david@sigma-star.at>
 <D2RQC1H7N1JI.1W4JT8FI0R8L4@kernel.org>
To: Jarkko Sakkinen <jarkko@kernel.org>
X-Mailer: Apple Mail (2.3774.600.62)

Jarkko,

> On 17.07.2024, at 12:07, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>=20
> On Wed Jul 3, 2024 at 3:53 PM EEST, David Gstir wrote:
>> The DCP trusted key type uses the wrong helper function to store
>> the blob's payload length which can lead to the wrong byte order
>> being used in case this would ever run on big endian architectures.
>>=20
>> Fix by using correct helper function.
>>=20
>> Signed-off-by: David Gstir <david@sigma-star.at>
>> Suggested-by: Richard Weinberger <richard@nod.at>
>=20
> You cannot suggest a change that you author yourself.
>=20
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: =
https://lore.kernel.org/oe-kbuild-all/202405240610.fj53EK0q-lkp@intel.com/=

>> Fixes: 2e8a0f40a39c ("KEYS: trusted: Introduce NXP DCP-backed trusted =
keys")
>=20
> Tags are in wrong order. For next round:

here=E2=80=99s me relying on checkpatch.pl to tell me this, but it did =
not. :-/
Anyways, thanks for reviewing! I=E2=80=99ll fix the tags and send v2.

BR, David

