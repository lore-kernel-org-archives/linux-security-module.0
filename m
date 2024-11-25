Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E831B983E
	for <linux-security-module@vger.kernel.org>; Mon, 25 Nov 2024 18:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732560793; cv=none; b=Y2BOooHduu6pmVjaWJWdvMPWGiiY0Or8UsYNtsM8Gt3donlmjjhSFuKxo6rHpAUGIrc/DZRa6TTrK/jWdJ3ljAUFzJy4XXFOelb912Gi6UEsKlweOvjPokV0ROoSLEQTestVkIfErk0UYtiCwdUDPihV/8/qYI9ZNbOOrPwat58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732560793; c=relaxed/simple;
	bh=DgyXtub/mrosQT7xRYvugi2qsZ0dWJBpLmbcBYjlDpI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NtttDr+j7VOcQ8fQBpBusnwwfklj55gSrNVcQ+xEJ2M/ZJ/Bxj5ya5sHxmnXF+HoLq1c0ROrxXtaqnYLlePDL0RpTVPtUA9sySKlZVeDW2tsKYYivrgYTMgzwyWKa8pfRXnJFcFIU09cEK5E9OIDOFObyN04ssKD+cyJQVbXdSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Oa5aCEJj; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Oa5aCEJj"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6ef0c64d75cso12955137b3.2
        for <linux-security-module@vger.kernel.org>; Mon, 25 Nov 2024 10:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1732560790; x=1733165590; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DgyXtub/mrosQT7xRYvugi2qsZ0dWJBpLmbcBYjlDpI=;
        b=Oa5aCEJjXEX7OG+KET1dsdzjJrt74joABXQZbZIR9N+0lsKrcpInSztcpiRf0CWAOd
         MGVjr3lJJfKWMPAJhwM/PIzrdY9JYTDvA/eDTyt8zu5tupKZPXFCdiPvnRgkyWvkIFTO
         mpUFmNnnIWHSGHLtwj4P8ku0+pLqTRDEamAeMjC+rYMI0xoZTZ/fLwNXLxJ3tQ25Gp5B
         WB3iAUKbUzm3U772kOqvZd7C4nGiI0ARECRCAqa+bzJ4JF1/IPQLdJmcitFaAN8J+TXY
         MmBEepf0ilKnyzib1YZsoDVJlaFfxO5VcZuvaUxSfXwCs7irvKtrTuN0qxBnCHoxlvmU
         m9QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732560790; x=1733165590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DgyXtub/mrosQT7xRYvugi2qsZ0dWJBpLmbcBYjlDpI=;
        b=UcjFFOF/SDd5WIMz8RaykzKQPO0grx4rqLdSr2ODuugKh5ZMS8LH77yDoNZNiEoi8R
         CHugj00NoO+kZ6uS38o1mSgzPbuE6MGlrPkUzf8nG1CjYRTIXyTMBPbNSL/b029cCyCI
         eXoaJDLk0e0f3E3A5kRuO5GgIMqx7uQbsqdKPoXhVsGx4hPfYEGdrXUg2/8rGhSeVS0X
         xd6M8ifgeCxyv8ZvznOqHsEliqNRDaBEP94Awev8QAbFoQlIWoIW25q42YdbnGRa5eSM
         oeaxXxCUhgdB6bdtoFZ7XeB4QFu8pVP7JakrTGUliLA1W+yX+Vw7itTtmPmKXV20eR93
         bAKA==
X-Forwarded-Encrypted: i=1; AJvYcCW/VvI6oq2CQTOKn2LZBKC3XZCEJh/o/BhQLSbYgWFPr64oADPHCINybaP2qU6yujp0LDLHWGRSqSltyIJmV6pDamlFnso=@vger.kernel.org
X-Gm-Message-State: AOJu0Yydw49oLqyl5Z7ofWmdeX60gdtWtBBrg+0OKFRNcwWJ5nyE3B3X
	DQA3yyQEkPL0XBE0xm+GQRCmPNKOXQUjOhuzH2rwf78RJJr91ZTti2sEbPb8TVz++YrmlMikFAk
	ngK8gYUYVp6vXL+OieyKkC66/YdxkZihp1tE0
X-Gm-Gg: ASbGnct/XEh66PETFB90AOYxf8RYfb5wiiQoSz11A7MSPYJdYIAZYpcd8RmQoauSME1
	DxDV096kLhBamDkchzB/huVLG4J/FMg==
X-Google-Smtp-Source: AGHT+IH4DDz+VxDlpzwy5Tehg7j+Pz6+AoiLkVQmZ6sHppSS7SAzMQPpgzbmFRcFkdDNu1kI1gZ8fYkhnFxzn5B1PPQ=
X-Received: by 2002:a05:690c:670f:b0:6ee:b30b:f124 with SMTP id
 00721157ae682-6eee089f8f6mr138230747b3.16.1732560790126; Mon, 25 Nov 2024
 10:53:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zztcp-fm9Ln57c-t@lei> <20241122173418.GA518018@mail.hallyn.com>
In-Reply-To: <20241122173418.GA518018@mail.hallyn.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 25 Nov 2024 13:52:59 -0500
Message-ID: <CAHC9VhRtuDmRX37asbFTFnwnoGTAidS1PArwZ9EfY4992fXQXg@mail.gmail.com>
Subject: Re: [GIT PULL] capabilities
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: sergeh@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, 
	Jordan Rome <linux@jordanrome.com>, linux-security-module@vger.kernel.org, 
	lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 22, 2024 at 12:34=E2=80=AFPM Serge E. Hallyn <serge@hallyn.com>=
 wrote:
>
> On Mon, Nov 18, 2024 at 03:26:31PM +0000, sergeh@kernel.org wrote:
> > Hi Linus,
>
> Hi,
>
> before the merge window closes, I just wanted to make sure this didn't ge=
t
> lost.

... and while Serge may not have sent a pull request for the
capability code in a while, I just want to vouch that Serge is a real
person and this is a legit pull request :)

--=20
paul-moore.com
