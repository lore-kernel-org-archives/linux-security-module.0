Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C2B47DD48
	for <linux-security-module@vger.kernel.org>; Thu,  7 May 2026 19:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778181597; cv=pass; b=MAcM67oYSNaldC5s4x+wxRYDQ51xkhtq11Q7CD3OxhZ/u8rteJyTU1NHNmvyUPNrIfdAcvWTi4JoYry41X0d/YYoiPv4zYnGng0R+PhNpHf366Ej9TZe+N5cvcjBVny9SlNIGvrf8RBBANCYao+P55xn/tDjrazgCcrdjCqT5cY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778181597; c=relaxed/simple;
	bh=I5DZUCNXHDpvnJ8tiHxWBxQrtvvS0aWP/FaWpvJs1Mw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=opzyVkBXIh0hTwy09Se8S2wmERxxNZwofsI6gMGKAfNnpqq2/T7Q05TlE2glGHxqekAIW9f5OFLK4RjMKNFf9WxsXQpAZT1p2GF4ZhLZ8kC6093TgUBX1xF5apO705iLG6QoXn2rQTEAaWznjNVQ9e8kTKxgItMBWOuyZ7J1nTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=GLnNKXiY; arc=pass smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="GLnNKXiY"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-366375c43c2so397073a91.2
        for <linux-security-module@vger.kernel.org>; Thu, 07 May 2026 12:19:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778181595; cv=none;
        d=google.com; s=arc-20240605;
        b=YrL3L6oXCeswXcEeXaCmzw+/ZKHJo8sFq04e/4LG9lHaybT+MGICDoqK3soW3Ce2/n
         g+em97BSmpCSjIBWLkN+LVRdUDmPsQvLYs86GR2RrsfRpR0V7AGAcC7Cp1j3ql8+PD1z
         YkDgTHkB7XAV95rU1/U0sgJJgV/Kl6QZG31xGHaUyR7lLYILMQhgRE45jdy5KWQ7ToP4
         BVnjB3K3MLn03nzbW8oRUnYgRMNZIT2GMe72iaB9HetMm8D6j8tEJGh3gNx1NT1KcDcX
         kVANjkmiR7llOH315rKKX0+pR6cV2nBno6cUf7NbXRfxa2H37bHVBgaVNe3hzvl6Hajz
         zFhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lLAJ2nIgwojcJGz7oCLjCvCHgUm4ZxZWAITSlIqPTzE=;
        fh=1sQw8ORVtXLRwq1dbtZQNzohWT4kRUvNLLy0kRrpOeM=;
        b=T1+9ECzXuo/RPY2m1liDESCtOB5GvXFncJzLc4ta0C+Y9bnkZFoU8wMadkIEH6RFz0
         uUdcRj7ZN4a5KaH2ys0KsosOtVHNl3iWAIePJVrnPlYTyEjEzF75vwiG4fP5zeJfs+u/
         weEQhIzKXvbcnyolpM7+xGX/v5CHGOHiyCtChLtLZOC6vyxue2qG+7AEuTE0DZqhaOG5
         EGjm/4dMwl4/jm5KpgvFq6WEwZWh/qb6vjnabuzxdaOXr3bNevAPRwfXgcXYGkw63Krb
         KZeLzNZhRFR1PQPzq3ROVZ8l+xOZokOLKOOEcBNlScQJHpFsAdaTPMMpfvG9DjWp8uSN
         bUvg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1778181595; x=1778786395; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lLAJ2nIgwojcJGz7oCLjCvCHgUm4ZxZWAITSlIqPTzE=;
        b=GLnNKXiYDLm9X4lYJUk02s0b+xtbyxLM6HP4HQx4rvJuLbAOYJILY1cJpj1vNvYPq7
         IsgG3W/RqKyXG988mhDHnBhJKdvLepgkXwL0CiTNMCHdxOFlJqjE0CUq4yheVcwODhYy
         uN/JtKwkvlrtUbHhiMzDk0LHc94wDdqa1JuReUq3eOpJkysLpIO+F4ANHmloLujAkE8X
         T77szf4tb5LSXgz1RHfFaROnD6uMCDwWsDzAJBEXzhhkrDHauI8M2MxkOpBbou+zAAlv
         fC1A0peVt1fHW63vTiXaWyJh8nJ01Czu7BUWbHZRwpnyYQjWoKepZ3tLXLtcSt4vBAs1
         b1yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778181595; x=1778786395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lLAJ2nIgwojcJGz7oCLjCvCHgUm4ZxZWAITSlIqPTzE=;
        b=Rcj+I9W94sIZg2f2n/wZfx4Nr/YveJzUUa4eoX9zrfMFwmerY4Dm/MNL8BCXXDqdox
         rtGplnuv7pr6Ahk9aNRievpaJVXeLKycxbeAuGQwsdiJRGDC0cuPwOeTnqB6lNuFdWQf
         Ls8RYLxxN4fK4ec0QTWC0qjT9hghWdPyKd8jhZh/Iq9O+z3ZzkaAB6TP69qLFo0kQPr0
         mW9DOzLfcWqb0h8u23piudbSqw+JR3G77w7aXto2ItZFdLmVy4YiGz4HYOM0SH0gQVxe
         ft8EyWcBRfDBwXfqObxmMKH5fO6CBa8OCJSA2X3QbHAjcPYHBkEWGUIIi33hIdyCyddj
         o87A==
X-Forwarded-Encrypted: i=1; AFNElJ/awS0QRY4XxYblVmfadH134DJm4UT73sJE+tJAJQJ4NlTEoT/Rjc4RFbFvXuixpFmLiTFC5TtJylerstU1hy99qsH95V4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwT6eDwsh6g4AMcKoM3MsBsyG+NTC4TsNn4q9areIMJMqv2VI/J
	MIdGIwHwEhUNt+0MQmBoR23+qdPs/2o5N+NhWYpKIOXaeRPz2j88vd2kLkmZEbHm81yTsg9yPif
	dg/J8eQNDYA4FbDk34uu0cxojG9ws2X+ydSySX+x1
X-Gm-Gg: Acq92OFVZ9a/h/Vur8dK9Y60Y67T1N+H06nqR8nNfutuXNdKIXdOVJ3iTyIHKMQbcmQ
	JvNcUzu8SEirO5s7qQgUHej10GuNJiVb2nSaOsCifg0PFQ/HYFDF0wEHg7GuPWEUy+O9b2lq3na
	2qylAdLTQUiE1Quf3ISRGWrZCdMoO/n3cJYbjsO4SC3CghOMtr1HuDEe48JVxpIjVEZwdqSaYjq
	d3nEhKU1yz44o2FAGEADIqZUlFBHskAN4kPQZPf7/V1fVkarJTvQJr1eTeHph5WRupu0/bGNnYr
	3iaZ5F0=
X-Received: by 2002:a17:90b:3c8f:b0:35e:5ae3:299d with SMTP id
 98e67ed59e1d1-365abcddd36mr9275143a91.11.1778181595203; Thu, 07 May 2026
 12:19:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260429191431.2345448-1-bboscaccy@linux.microsoft.com>
In-Reply-To: <20260429191431.2345448-1-bboscaccy@linux.microsoft.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 7 May 2026 15:19:43 -0400
X-Gm-Features: AVHnY4K2gE6-_wPdetwQUwodb--l1vbJFrrIitihnjQHsL-gyI1WmZmW-6cI99I
Message-ID: <CAHC9VhScmOoCtoFtccJ6x_cTdwvKCBfUyg=1p-kuAGmo=FdgwA@mail.gmail.com>
Subject: Re: [v6 00/10] Reintroduce Hornet LSM
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
Cc: Jonathan Corbet <corbet@lwn.net>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Andrew Morton <akpm@linux-foundation.org>, 
	James.Bottomley@hansenpartnership.com, dhowells@redhat.com, 
	Fan Wu <wufan@kernel.org>, Ryan Foster <foster.ryan.r@gmail.com>, 
	Randy Dunlap <rdunlap@infradead.org>, linux-security-module@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 29, 2026 at 3:14=E2=80=AFPM Blaise Boscaccy
<bboscaccy@linux.microsoft.com> wrote:
>
> This patch series introduces the next iteration of the Hornet LSM.
> Hornet=E2=80=99s goal is to provide a secure and extensible in-kernel
> signature verification mechanism for eBPF programs.

I see that Fan identified a few issues that need resolution, but I
just wanted to make sure you've read the expectations for a new LSM.
To be clear, I think you've ticked all the boxes, and there is a
MAINTAINERS entry with your name attached, but I just wanted to make
sure you're okay with maintaining Hornet.  I like Hornet, I think it's
a nice and fairly clever solution, but the last thing I need is a new
LSM to maintain :)

https://github.com/LinuxSecurityModule/kernel#new-lsms

--
paul-moore.com
