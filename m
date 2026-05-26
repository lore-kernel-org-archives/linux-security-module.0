Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E0E3CEBA7
	for <linux-security-module@vger.kernel.org>; Tue, 26 May 2026 23:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779837717; cv=pass; b=MU7FYdxg4KtvLkxYhLvU0D5YUd3r3kQg/gpt4rHqaMV1D6jvFdaQfiZpN1bTGdCjpLpXBksK/tvFCP29uBxfqv9+vdWWbKsXusMbKe7wQnfY/SI94lEdDeFqcVl6BisqzycUzW+k0SGoGACV5RB6G/ALNK0nh9GqmuoH2xqOVsI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779837717; c=relaxed/simple;
	bh=BG52CzZJianw9o9g2uCeIbNA1rTnp9yxhYo1fsob0fo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=nYzH228i+quU/Uzr4Km7jp1cz0NQuSgEmtHNuK26W47RbF8vLcGZ162WrSK9RYbmp8dy8TZ57xYAGg1ubuUXZoIMvVCwm1bpsS0pyNlm/u655LxeZOanpejGue6Hqul1zxefQtHyuk2BhqY4xQy8FfZeSm8hRRk27R//HUBOC24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jzv0KVH5; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jzv0KVH5"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-6587cee8b57so12253138d50.2
        for <linux-security-module@vger.kernel.org>; Tue, 26 May 2026 16:21:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779837715; cv=none;
        d=google.com; s=arc-20240605;
        b=Slp7rOlnWCx9/WJewiko4o1VmcZXyXKqkt4vc/A2t87tkXoN+U6bjqYPnTNmPYvp1Z
         YLtTqKCpX1vmYvA5CKC+EO3bc+bBqk+efETpFQ2yeZDm9JIvP3fiaKaFHZCe5ikqyZeR
         M92NXb1whhRkGl7Vd/VZPZ2asKjLjqqKbWMgAo9nayZ/iRkoOq7Q6E5J8KUtf1YeudyD
         BoMRdoOi66i1fCAuhbuTDJql9VFfEm5NSifY44AJW9yPR8ucQYobFVJYdM39NEzEgmwG
         GjsPXQdGM6h0TFZvkBxzoN8xe+nZ+C4b0i2xpjz3c1FQdCfBD9T41ifhNPOXzfYPAai1
         cq8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IawsDaq+jT4smAWsX5Q60cfohWJ4yueT6RiGk7iaP4U=;
        fh=Ddg/mOQzvbxfJZhF0+o/0WnRP0S89C36YXFk1Cxrflc=;
        b=aS/brvUg+eilA6wDg8Jq8Cxg4SBNY9P42eoM/7Ilx7r7jIPvqbyPhCK+uNXwJvY0de
         cbM0czwHIHf71fEp6K6HtFwe/K62zTGWV8Iac0PlLUlsy0RGPhjkWmIQGzk08NlwLYir
         kvckhsV8fGFXgxhzmFxd9VHGP+WPk16wBamuiNXuS67ErNDuHOe73aFyi227FOj1+oo1
         gk3lUhAHpuIHGiHdogEslPL1epXhXmAfUGTNc4EDCuj6+1xu21VPcqsKcnRFmc1qxlJy
         BO0rcMdrv2HwjPHWOAjgdCftVzyeUX/VHpNBDNH9DN8VqQGISUj2tuRKPsyY2ZunaQXx
         5Nng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779837715; x=1780442515; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IawsDaq+jT4smAWsX5Q60cfohWJ4yueT6RiGk7iaP4U=;
        b=Jzv0KVH5eKwV18JpLE5WXz89uxLXuX91c1AlqI0vVVaB8DRiC79GO4oR0+fn7uCfNf
         na5Ksqm2EpPAlKZOeuv4i9qUe6jPZREW/x6cK76zkEPqfMPBmgSgAstLxwdPvnPM4Awu
         JT3DSjcyhZHRrEKA1nekX2YH6ll9r/kCuh1eHFeq/7JRSVRw9DEtIVm3aFSrBffKOn9w
         mFmimsKrROcbCr5lXPThSny1DjOeNE+tRWzUxkkCGEN+OIu83w2Gu7Qcv1FfoBrOmE9J
         Fo8CZVGZTDuaos+mRgDLw2387Q8pawKvL0XWfXTic7CMAn3TXvD4n+KnYp8HThK6xH+N
         ti4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779837715; x=1780442515;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IawsDaq+jT4smAWsX5Q60cfohWJ4yueT6RiGk7iaP4U=;
        b=g4CfPV+etYgZTaGukwSAanrnP4VINThCbetm7kmZAiKMYy/tECRkBFqgC82q369fIb
         akJe5FSMS6O2vdQV3WtdWWbvX6EneMlayab1bqN+KacDENw4miHU99iz5p3Elr4bgsIl
         J4LcowXw3IKu5SFX/9ClsURjBF47BZQKQoJMnN7uss9r7AjiSpBWAALEBQS1HvL1/jS6
         lPuad3Sd6VFzY9395d30v06AU53tVGTXz7uCqmXeAgh5ihRTCYw0V7BrSqw/B+3c34ph
         qyW5GKGOOWzJm2N3knakbL8orNO/Gc4MKrFVELgdAiarpWNRLwXUj2AZAuNQwYlWE5wR
         ANXA==
X-Gm-Message-State: AOJu0YyqkaANroSlk4qwQ8ouNOjHkN0GsFtW0cnHBBByq+6AJHwEdqkQ
	voIiB2Yy/LbdpMp5r+7bNZZyx59I3soRhWN8ntEnksFfaiH8TfXyUcEzTvp4Ghv0fd8FEnDNn9Y
	a+fXvNydpUjQCIH4GawbOAUbsIqHplZp9ecRM
X-Gm-Gg: Acq92OFs9XaUC7H6lAfRkB1fjGmNxFG7lvHbt9JMBEI+uFVwE1rTFlIW0sZM71viT1E
	+tXqrzE5CuUsH12durGko5etYtfS1RjOgaQHxVNfx9XH3Zx31Y6MAqhVTraB5nlWCOSyP09pjFG
	O1yZGZLk5PgdDB7kVhKKvP/07Dg41z3yA9xksDFq/Y6TKvSqyRFUOZHR2XBqAHam0tQddCiYDOI
	PVE0AyZBaM/7dCSdj6TinMNOEDBW7i+tD7sJV4gSfAIIAqvVr34CwA7EAz26/v5QgzzB34cwL9K
	/SHdBd/i9+AD6sl/1g==
X-Received: by 2002:a05:690e:4090:b0:65d:4429:b6c6 with SMTP id
 956f58d0204a3-65ec98ee2b4mr20064856d50.39.1779837714727; Tue, 26 May 2026
 16:21:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFftDdrzV2xC7HBcgS8EPb-YewJyCK9uos4crXOCh5ONm6SxSg@mail.gmail.com>
In-Reply-To: <CAFftDdrzV2xC7HBcgS8EPb-YewJyCK9uos4crXOCh5ONm6SxSg@mail.gmail.com>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Tue, 26 May 2026 18:21:43 -0500
X-Gm-Features: AVHnY4ItZov3xV5vdDhv9F5waH1j7N9kKMkPY-kOalQ87k149-SYhfMriDG0MVM
Message-ID: <CAFftDdqp8b5n21hdEP6w0-PK+CoG7mmQxgrnhpBLU7-1GZxniw@mail.gmail.com>
Subject: Re: security_task_prctl: why -ENOSYS
To: LSM <linux-security-module@vger.kernel.org>, 
	SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2026 at 5:39=E2=80=AFPM William Roberts
<bill.c.roberts@gmail.com> wrote:
>
> Hello,
>
> I am trying to understand the motivation behind having
> security_task_prctl only continue if the return value is -ENOSYS. This
> seems to be very different from other LSM hooks I have investigated.
> For example, in other hooks, the value from SE Linux avc_has_perms is
> used directly. This essentially means that a 0 will cause the check to
> pass, and anything < 0 usually an error.
>
> In commit:
> ----
> commit d84f4f992cbd76e8f39c488cf0c5d123843923b1 ("CRED: Inaugurate COW
> credentials")
>
> (8) security_task_prctl() and cap_task_prctl().
>
>          security_task_prctl() has been modified to return -ENOSYS if it =
doesn't
>          want to handle a function, or otherwise return the return
> value directly
>          rather than through an argument.
>
>          Additionally, cap_task_prctl() now prepares a new set of
> credentials, even
>          if it doesn't end up using it.
> ----
>
> The check in kernel/sys.c is currently:
>         error =3D security_task_prctl(option, arg2, arg3, arg4, arg5);
>         if (error !=3D -ENOSYS)
>                 return error;
>
> Should this be something like, "error && error !=3D -ENOSYS"?
>
> I ask because I am looking to leverage this hook in SE Linux, and it's
> annoying to have to coerce all 0 returns to -ENOSYS.

Of course after hours of banging my head and one email sent, it's more clea=
r to
me now WHY. This hook isn't meant for making yes or no decisions on an oper=
ation
but rather to also handle special prctl flags for an LSM in question.

I guess with the said, do we want this interface to be used for both
a, let the lsm handle
this prctl flag directed to me, as well as a yes/no security decision
or do we want to split
this out into two hooks?

>
> Thanks,
> Bill
