Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4226E2F7442
	for <linux-security-module@vger.kernel.org>; Fri, 10 Oct 2025 14:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760108275; cv=none; b=AJ+NoTafECab5Ow0FgzcNr4FmwRDMwg33Fbb4ph8x5UonpyrLmS1kC0CaTvZ9F0unPAiFImP0xNedpKAHIFNsaOzZNKKIX5mNXeFDlXkjj9G+89cPZfJTHODLhPEOR3FOWfylR417r6OKzNGxOhoMI7As6tyaX9jwLLCq2J1D4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760108275; c=relaxed/simple;
	bh=QQVYa4ebCX8v8+c+fDYRRGNE0jM/1QXakKg6oLLEBx4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cogFbTRZyR04fVjnE00wmeroQ19Stnwnh5fEAQiTDY/G6megDYnxeKnbI7OuqGzw9uj5oPe6CoYZvPdoY4Yx8dElVhExmMMGx1ayx8gVK1aUHunLiBQ3bqdz9NOEMdDEQu7EG6KNULIxlF1QfS8RxjHAwSxQAwjEi5bhIboncbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=CAxjFQoS; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="CAxjFQoS"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-780fc3b181aso1332009b3a.2
        for <linux-security-module@vger.kernel.org>; Fri, 10 Oct 2025 07:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760108273; x=1760713073; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dhktQ9njw3xUQQNiviiU9j7Lv0g4dtHdRAIlg2dWPdo=;
        b=CAxjFQoS/jb4TMgFpWob4hN+EWlm06MxLcWp3sBs0aS+t66J7GzQ17+8CC5dQwgoOM
         ZUQ8dm/H5l8PXcTNEoESIIFiJZOHdZ/papHwKdTEZULt3l4v4l6vxRzRIZI7gjBbOmvH
         Sdg5M/SwQAnA/0tjDna5p2Ha6K+jSMzyXKknBq6GLTlBwpmmdCNh2HWbT0p5cNFF2Qnu
         angK9QQL0nwYh+COink+kqkvgcNAK+rxsap8OjiiFjFojOAJdUzrMY36sVd3HDGbrU29
         XNdsscGIbv7ujwfp8M6YOntytm4sAPNv236n/3iDtEV0ZPi8qxMYoD6Yz7UnKMv0dMON
         8jWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760108274; x=1760713074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dhktQ9njw3xUQQNiviiU9j7Lv0g4dtHdRAIlg2dWPdo=;
        b=G7g3bOT5cb0z8ngRAqqc8r8e3edAOAp1v7WKskNJg+BtWewlB/ZEO3sxDmKKn9Mivu
         x2mHZnaHbkhT9vgiLFvdXua3Z5ciIzLnI0ghWMYow4fk5sqgRpDL3yBVie5+DlX3ieWG
         9Dk3LgTt/rUZNBGouRVgXnX6dReydDeZGBbWM9wYB4G9nWt6hUn9IUlBImqPTOV4f0q/
         t6Uk+My+/LbnNSlTCgwkyfte3bqDcg4Byg+o5dj1EQWLJPbD6KjimrWRHBejYILvbKD4
         9GFslbGs94msjYUbSRQI1TvNVOyzVekCZMsb+6JJxvZ3JhvZtYcBO5H+N01pjGD8scvo
         BwZw==
X-Forwarded-Encrypted: i=1; AJvYcCXvd29WGh7uYspgbuXzKtlDnTJqPXx8VKGSlPLd+BhWcyAj7JROv4NA/Y03gju43ssX7njWTM1CEAWhqr0lIlxOhfTBOa8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxrq8QCYqcIiZHmi0gHS5F4Q9vArCYqjfmGNetyU6ua60W8eIM/
	jk0zyjGV867fJ+Kqw2HZeNnRbIEavdC04mMXxH/YmDvTrTVOKLIsVRuMibNqYm/v92Q4Zha+qBJ
	2zD5eKH/tOxsGu4aN2rWbNKjPTsNiWQL4rEyvSlbO
X-Gm-Gg: ASbGncvPcMQtI4C64xaSTk12qMr9B9mf30NqSdTIaeCrDRH+946eVpTaO/1bBqVjbAu
	cH5UAZ4Er9XtE2/0RAiT7fGk4Fmy+2qLys0W/SO7qHODfJR0YLyz5kiAeACQyrtJ5VbqmjBQfye
	owRY7VAuLtdA9VxRU9N1xxJ6YYYe1iOfG+1u7HPb7IEpxhkcM14QsHj9j9Y+tznSx2GMhtdcQY+
	BcZinxM2JttwIi2yntydJXAmdpZEHe2rK1K
X-Google-Smtp-Source: AGHT+IHkK8Gm9viP+PnMJqCf6YwcaiPSZAhk2njG3CWT6nK+53DU2FspPpHEd0UmuOb2fdMKjhpGzmFzl8fSVbMyvcI=
X-Received: by 2002:a05:6a20:6a26:b0:2e3:a914:aab1 with SMTP id
 adf61e73a8af0-32da83e3df1mr15879251637.41.1760108273442; Fri, 10 Oct 2025
 07:57:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251010132610.12001-1-maxime.belair@canonical.com>
 <20251010132610.12001-5-maxime.belair@canonical.com> <CAEjxPJ6Xcwsic_zyLTPdHHaY9r7-ZTySzyELQ76aVZCFbh8FMQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ6Xcwsic_zyLTPdHHaY9r7-ZTySzyELQ76aVZCFbh8FMQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 10 Oct 2025 10:57:41 -0400
X-Gm-Features: AS18NWDDlD9d-obeXSKEgVeXrkg3pQGOfVLXHTxpEsZnDxFwMdZ6CYaIkCq_crw
Message-ID: <CAHC9VhTSsUf-XJTNSxs-7DeAdR-0uBfL7reZnjMXhma3ZSOF+Q@mail.gmail.com>
Subject: Re: [PATCH v6 4/5] SELinux: add support for lsm_config_system_policy
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: =?UTF-8?Q?Maxime_B=C3=A9lair?= <maxime.belair@canonical.com>, 
	linux-security-module@vger.kernel.org, john.johansen@canonical.com, 
	jmorris@namei.org, serge@hallyn.com, mic@digikod.net, kees@kernel.org, 
	casey@schaufler-ca.com, takedakn@nttdata.co.jp, 
	penguin-kernel@i-love.sakura.ne.jp, song@kernel.org, rdunlap@infradead.org, 
	linux-api@vger.kernel.org, apparmor@lists.ubuntu.com, 
	linux-kernel@vger.kernel.org, SElinux list <selinux@vger.kernel.org>, 
	Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 9:59=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> 2. The SELinux namespaces support [1], [2] is based on instantiating a
> separate selinuxfs instance for each namespace; you load a policy for
> a namespace by mounting a new selinuxfs instance after unsharing your
> SELinux namespace and then write to its /sys/fs/selinux/load
> interface, only affecting policy for the new namespace. Your interface
> doesn't appear to support such an approach and IIUC will currently
> always load the init SELinux namespace's policy rather than the
> current process' SELinux namespace.

I'm distracted on other things at the moment, but my current thinking
is that while policy loading and namespace management APIs are largely
separate, there is some minor overlap when it comes to loading policy
as others have mentioned.  For that reason, I think we need to resolve
the namespace API first, keeping in mind the potential for a policy
load API, and then implement the policy loading API, if desired.

--=20
paul-moore.com
