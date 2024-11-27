Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBEE819
	for <linux-security-module@vger.kernel.org>; Wed, 27 Nov 2024 17:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732729762; cv=none; b=lEpCR3rcXBB3HInNuQd9bsGYix+USxtlyazBzhKGEGq+J8ch2bfLqA9Q92Gaw9c9KihLapSmts7jr4TQ1Eeguiwy9GzoWptBX2fRJ4esYN6xKFWzse+2srDRASiS3PF340ouepJZYZRZsXiPoOJaNJRYQPHt/vT6oY1TlEG1LZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732729762; c=relaxed/simple;
	bh=K+0Y7jRYQnRZmvU6gRHmIW+RWE5eVgCtby5qNC29T98=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GPqjRExQsSX1wpdfexTmcRrJuqi0l6nQA5wKKHsIz6PrEEV08/07MvE7WeucxVQwke5MoEtk23BLhToMHlybY+dB05Ui7vP+hPirZgUe14hnZagw2U1la9kXKkzYT2dh8KeJezEJ3lOSC48wtQim2jqXM/CFhQ0Nd0dbr7pl0Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=LYdeYICj; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LYdeYICj"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aa51bf95ce1so875451766b.3
        for <linux-security-module@vger.kernel.org>; Wed, 27 Nov 2024 09:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732729758; x=1733334558; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=E9qBplinmT7Akijm8NuRYfzUMUhxIfhfIn+o97yyJts=;
        b=LYdeYICjPcXwy7hoNNapFZHGeoBrrTKcCF5/sSoLeFblgpfTAhOFzKyLQAf4f/oSxa
         ai2ZP26BfyqT6qnIf24NZYaJiWit1EIcI4RlueN9Fq7DqF+23lobsmPZ/P+s/ZTYLRRE
         bcAOIO2gTqBHQI24wQX10Z1I79Hh2o6Kta6oI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732729758; x=1733334558;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E9qBplinmT7Akijm8NuRYfzUMUhxIfhfIn+o97yyJts=;
        b=M2fnksRyXAD6yKDo36m7e8Sg3pJS0YayABANRFk5IQvBf5E/MZbPGrvlRGW0HVeg7f
         r3Pt4FnFlV6RYHatRPZ9nMO/O0O/jkTISPELfNUY0aEDwqwN9uF6wUv59mAOSUC8BOLe
         3xP/zmNTMN+BN0vLnyJLGuaa3WOxr37FimmL4z368v8JCsZPyfauQi8jBHEBxqV9WhvR
         YXixvbu3G1Wyu8BqEIqkCcfF1g4SlQRhI8/pRZXkBJwxJwIxLdEgRr4ZAWtbuBeKB7g/
         sptY0ffI300JudCO1mVFxIB0wXAeOWFHEy9QfSIol/KX8QIhF8N0vNPrHiGt9QMc1jfJ
         aPrg==
X-Forwarded-Encrypted: i=1; AJvYcCVgjCI/X/iwaRc8toT72RbEu4gBj/Lvvkm+xgfcm341g8d5SqUW1ZL6oolsy796Ndl78QocJq2VJdSKWfQMk2GisHyx8ds=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZcFcy67KO233oEXXKjY5Zb9uiS1Mw0Ak07TjfXnLhD55kcWWh
	NKk6qcypdcvKb0uN0mCb7a/u7cvOX8SB1WJITumtpeAFTne6X23RfaTPQU6XpO99nQsmY0ujVil
	RgVuGCQ==
X-Gm-Gg: ASbGncvb6ImqcJtPcchPKOCsUVDUtIJLrIwXtsIjfSRD3A9LIt9pInOz3gyYE2xGuuV
	IMrZiJh5wFKKqfHhfNvN6wMAto+jxfqUUTqytQIFKikqpZUXSgXdhrt2LzM1eW2lN/AShHCRN0v
	AqEZdKwYRzdTybvTftig99nDYd8EmipuHGPP+k7Qv4RADtgdbndfUTckjqXEPopq5Vpq6RvuatD
	wRkgFuKeH5mVUFn5EumIaSyCxy2AAjIeyZyUvizKzLxa+lfV+9x8VV8//0Rr09LVHwshuHqPMzb
	CE0SrSVlGkUNVVukbaH8Vt2B
X-Google-Smtp-Source: AGHT+IFOx6SENUHKCBwpqbMO3S38+iM2Rb+l2YiurOR97JQZP76EzI0N6SfKCbJ+zYg1xxNrQF9fBw==
X-Received: by 2002:a17:906:9c1:b0:a9e:c446:c284 with SMTP id a640c23a62f3a-aa581076ae5mr392754766b.55.1732729758051;
        Wed, 27 Nov 2024 09:49:18 -0800 (PST)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa547ffb152sm462537766b.62.2024.11.27.09.49.17
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Nov 2024 09:49:17 -0800 (PST)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aa578d10d50so297169866b.1
        for <linux-security-module@vger.kernel.org>; Wed, 27 Nov 2024 09:49:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCViY2NJsDVQUaQvzCV3cpYkD3hmnbYt3T3U7d+WQjof/PAwLhzEHBH+5P/ObLBbJUQjzR9YtRDaeOkaYWulv7ihBVgJBMc=@vger.kernel.org
X-Received: by 2002:a17:907:2cc5:b0:aa5:317b:39a with SMTP id
 a640c23a62f3a-aa580f57953mr365939766b.34.1732729757073; Wed, 27 Nov 2024
 09:49:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zztcp-fm9Ln57c-t@lei> <CAHk-=wiotQ0isGLKp3EUOdq6sSEb=G=WbnxCfcsDnbszHGXNtw@mail.gmail.com>
 <CAHk-=whArvb=wUqw7eYko_MkBuvFBiiV_0xzqHDJa-J_Qacf2Q@mail.gmail.com>
In-Reply-To: <CAHk-=whArvb=wUqw7eYko_MkBuvFBiiV_0xzqHDJa-J_Qacf2Q@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 27 Nov 2024 09:49:00 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgNuhWGsXqTHiZ8_OiYDL_jr-zUWFuwuRornXvt+LMxzg@mail.gmail.com>
Message-ID: <CAHk-=wgNuhWGsXqTHiZ8_OiYDL_jr-zUWFuwuRornXvt+LMxzg@mail.gmail.com>
Subject: Re: [GIT PULL] capabilities
To: Serge Hallyn <sergeh@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, Jordan Rome <linux@jordanrome.com>, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 27 Nov 2024 at 09:31, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Again: very much untested. But at least the code makes a bit of sense,
> and code generation is actually improved by this.

Oh, and the 'cap_capable_helper()' function should be marked inline.
Gcc does do it automatically for this kind of static functions only
used once, but just for clarity it's best to mark it explicitly.

            Linus
