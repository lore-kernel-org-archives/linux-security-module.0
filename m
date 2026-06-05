Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3182EC0A4
	for <linux-security-module@vger.kernel.org>; Fri,  5 Jun 2026 18:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780682895; cv=pass; b=e+R7injYnRV+tbon137Pc55DG7knfNlstuGB2mxbu3FPO0V3WF/hkBTN42NxU5ZZRgxW8sIykl2iteD/4K9FH5YeJmfkwUUHar8UE7TuqWUPrAikLK/Ovr6oDbhaiHEKr98zX2PCARrUG8u/Fwx/BpWs/AjzaAluv1aDu7DJ8dw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780682895; c=relaxed/simple;
	bh=8ilDxhAiB32IqOC3th8HmSfbryjwzjesS/MpZwszFms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MDT90smuLfs4bGDD0W6LMOwB6tkdokYEsF1nxKz3xYKEHMHo+kGaVs6YWG9rmHJjYEBaTBPSsiZlWuGOKNcWAMe+xtVd1uPgTQ0WaGhAOOFoVAyCwgBZdslDlDaGc/ZKN0MnDa75cW6WsjTQSDH8+8TfcymXz4uvhrezrD6Nr1Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ag6bubmy; arc=pass smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ag6bubmy"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c8571db044eso1435487a12.2
        for <linux-security-module@vger.kernel.org>; Fri, 05 Jun 2026 11:08:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780682893; cv=none;
        d=google.com; s=arc-20240605;
        b=eyUkwaT4+9np47VcK0BYO3mAjsQVmMayG0Nsw0p0ufnnylqOCPrCWqqm0ZLd3vu02K
         CguuONfPfZ/ptIjXFM6KslVukCp4Pyb+WKnYyTFcroQ7zSauilAP5wcURlm+UtZMY96D
         Z8HpRNVk4x+Bcse8IWmMt3tAb8lAprZH4qeSbEGqK6Y6jwTBWxBecRYxa5+X4LsJxm0E
         4B0a2Z+r0HaZratNCaDZ/lGDA42L4oUoEXR6hLTv8LwrMkRDbJJ/yeTHteqaQ6tPiBpH
         bkGBDJkB2kxreQY4C8XPAxeU+zq/ZIeR14lDu3Me0x0StOjHSD0AAPnucEgSp5lAL/ht
         Nilg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=V1+sYntU5WFVxPkxcqomQF7fzW4LgZDONPtKqmZffiA=;
        fh=c9wLcdqvghJwOfQb9joumefpJSBpSbBF7P7qx8AyaRc=;
        b=Xe3P/GOa50dQiY02NNADfrec4TCtaEDbO1TPQu8lDdfRS7h3zazOG+TDqFOXdXG5nG
         bXQ46g9Xc23g0aFSvEIwk6LCyW3rUrhFlQ/fXBo9oNE3MWXH4G4FFSvNyzXl/7ZJknp7
         xk+gVrHhUceAAY8toJDkgqrPO4+bEaMWcTD3aTrvENlwJ82MioRTBhTdtbEfcp1HtLxb
         9oIQmABznii3FIosY929wiOfeE7Or6RI/qMooZVuLoY/BBTNN8j+AKJk0+5ZIf0+H0xf
         79jRX+DYWxhzcuLmL9TUVWoHnEUP+RkLe0G2XKQpByp3iEfTyIBjpDcS2WvnFqWnGmss
         kwDw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1780682893; x=1781287693; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V1+sYntU5WFVxPkxcqomQF7fzW4LgZDONPtKqmZffiA=;
        b=ag6bubmyV1LSITsOZ18m+UPiFqAyqHSUlSrkViApHk4nrY7QQ4nL/ZA1gxLW8aKFxm
         Pew83nPhwuU2sUvTBYuKuIWanVJp2/Vic8YGdvzdOmVIzddRpAAEW+Nehi3m7SslhxpG
         89EAKVSK3X/QQ8FffyXFtUL9mDF5DozMxgVzBvtu1ZR3bbvV18YPNOKBWlsDRDUgWtek
         vOaL986Iy4It4J8QLbuzaRGjs5M0sa3Zrhh01GYoOparU4uhhuYabStPGD4HhOU1ht5o
         qEx5Z2h9USPgNqLx2XYCbjmqc+whoS0wmeA67NgHvbvAZz/SODOYbYGOhs1BIzHb3WdH
         hPTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780682893; x=1781287693;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V1+sYntU5WFVxPkxcqomQF7fzW4LgZDONPtKqmZffiA=;
        b=qhlAU5MTyc8+LzYhRoJb5YOabqtiJcJ6qvaBFDk2HI/MhjopZB/OrIwupWne9oQsSa
         RvECsw4lfsDzBY6Yi02Trn2MKO1l9+h+G2y2mQbUMNVL4Iwsun6+jCu0MDuoCPmhEr9l
         OEYsjDM8o3MDBw28ymVMK/+2FKwKdLJn21RvsczCBfCzHf893zeTwQSiVGRP1alu5ONu
         9LnVgsosfA3ZebmcdkwOkCXrgbxYdkxlO7rZSQqPeSt6A9N3yb3dadsIQ5J4IJsNBbti
         oJifuCI4yBrcxOyjRjhnzRJ0cLDr/rQsemy5o7hNhLtUcWs36MkzsG5Uqf8wU6YZ1LVp
         dMMA==
X-Forwarded-Encrypted: i=1; AFNElJ9NxtryTxv2LGrBP7DNf1kEhUWZs8EISiIUN5i/uRdvq6c0jgIBp0yTGg1Taa1bbW0IwuoqxwerPSb5c12wPycs70sYejw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxU//AvNd0lf0rTZCau7HxgLBDz1gIfkRAoe85S6BOphn8UFZN
	s5YpuAZTY8v3iURCw3Zuk40iuX0Rf6G4gc8ijALrRXxZSgoTYN0dTbF7StwoF+OmI17N1UqKSlj
	UyE0S+ik118d+6PUtRR/mivqFLoDCWQ9ROHwtyWPv
X-Gm-Gg: Acq92OEbckNNN9MBbqCv9FXkGGSnfF+renDAIcZYHMQjKZoxc0P5SG6Njpysx+Hb6op
	dZ+hBG/iZ/aiDjc5dP+UMXVk8kVykgz9kh41JZio53WEFIakibnl6/XjT/ZU5d1sDKTBfMDY3Zq
	DMlOnjZhJ9mfLMkN8+w7CnbL59ZYkoePf9022WUzSiOKaB6sE3IqmtJ7sSdmX8cgWJKOHMhkCaj
	lT4/654tsYQHN/pWpuslJa0R9P0wITRPeXYK0wREZo4WruvxbsZZ3uL43mdGvUTTTTA/EL15S7E
	UIacsl4CEOhKPgjrUQ==
X-Received: by 2002:a05:6a20:c70b:b0:3b4:8fb2:a350 with SMTP id
 adf61e73a8af0-3b4cd03dd88mr6135775637.34.1780682893128; Fri, 05 Jun 2026
 11:08:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260527181127.879771-1-mic@digikod.net> <20260527181127.879771-2-mic@digikod.net>
 <20260605.ieZ1hei8Ahna@digikod.net>
In-Reply-To: <20260605.ieZ1hei8Ahna@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 5 Jun 2026 14:08:00 -0400
X-Gm-Features: AVHnY4IwAntIgRXRqihwKQ6FMjOdPIE04f8IHhmR8rRKjjx-CP4eO6M-6Q_FY58
Message-ID: <CAHC9VhQdT7Jh_dXPk4PMSomZ1JPPsm6ouE7cHQb_3=BdY37j6w@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] security: add LSM blob and hooks for namespaces
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Christian Brauner <brauner@kernel.org>, =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Daniel Durning <danieldurning.work@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Justin Suess <utilityemal77@gmail.com>, 
	Lennart Poettering <lennart@poettering.net>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, 
	Shervin Oloumi <enlightened@google.com>, Tingmao Wang <m@maowtm.org>, kernel-team@cloudflare.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 5, 2026 at 11:07=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
>
> Paul, could you please take a look at this patch and the next one? I'd
> like to push it to linux-next to get more feedback.

I saw the patches Micka=C3=ABl, they are in the queue and will be reviewed
in due time.  Considering the delay in getting this revision out after
my last review, another week or two shouldn't pose a problem.

--=20
paul-moore.com
