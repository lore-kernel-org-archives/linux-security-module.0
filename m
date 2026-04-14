Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02AF1D5ABA
	for <linux-security-module@vger.kernel.org>; Tue, 14 Apr 2026 14:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776175679; cv=pass; b=GLy3bQHxd1jbKClRB4+bCPNRU5MTh85okwVXcFHyeHqq+lN5bXto3x8ycoZSpux/Zk35kQ3fhuMlH715xSAbHb/eBiDA3FV4VEXl84exVVOxN95HOrakOzQY+VGBoPDx72zsMoMow+LSj/jUbAXOPrBnNcVo9dMqXFPGxzYDH90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776175679; c=relaxed/simple;
	bh=I1GcbUi7sTA77PozVWhGavR9RxloPt5QVse6L8r06E0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ulEeQrZJYxC0xUARfy/S1BEvTGG/OllSBzp3GWXqAeZHe9dklQqr2BlbmF6U79nWRJFPTRjU8kOdeRrRQfdfu1EvQCItVCISQzmvb7qf+nMooSFKPIChniH0BBlNAdYrngo4AxFtx6E8UDEBwY102A6txLxbSOPxG7x9h/XoRG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=hCky8I65; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="hCky8I65"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-50d2945e6adso75814391cf.3
        for <linux-security-module@vger.kernel.org>; Tue, 14 Apr 2026 07:07:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776175678; cv=none;
        d=google.com; s=arc-20240605;
        b=Z0TG0Id50IbBaVrWvtJu9MqFoL2xUmf60kPZR7WTzjSxxvDdWEKukvQ/2Kpy3V6e77
         yZrxu22N1OHEH7JXl6dHGOz01lSn+OlLqvhy5Gri9c7OvePfAcK4nVoqY96LLGP/56iy
         4lcIz976PYkilPisMxG2GBZLDUYjTWijvzQgeS/ULOt3SUXEb9ZBz4kNN60eaQ5b3Wt4
         rNRqyOKEorkc1JkVKuDVrCsOX0m9SnZSMH88hq0+VAc/QY6e9NJXtcWrHHvlqjcfp8PV
         ZtgkU+nT0iQnfxP1fftCG0dCAKghX+dKsTtApoMNYx9CU7jCckPn0PASc1os3JbfHc+G
         dpkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GpkpOFIsqQQ7tnZ4HHfIPfIZu7HMPv0h6n3vSGgysP0=;
        fh=P4FQ78vDip1ZP/vHJ5B1x6KEr/kfTqqVZLWNzqIoTPg=;
        b=AfwQL77AYXYI0nX05VTf8Vpxy8X0wlsSNmPoH74KgJ+jWLc7RR12NeayrAaxUdDX6z
         otcsyaexZDKROf95BM0oad4ZGkO7BYJFd5/AoBfYuET2Z7OJEyadepSb8ZHMnpW1x1wm
         DU9MMs4/VpSVIgYXYvWF6O1rd0/IJiIFu+Vk5W1NCpaW2K/U/RYdxohpIUrzeiZWMYij
         hu/2KnKIfYVW9Ge97sRzAO4MeNsc+ntVHz7wvamPYmvBYnFK6vwL0LVb7suxGqEwNA6Y
         6pvlI9Xw8wZY5f57jtnjhUCsb9J78ODxmrXBOXIk7uK9GV88VRmTqX1HMLk3Qx/5xDQC
         U8RQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1776175678; x=1776780478; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GpkpOFIsqQQ7tnZ4HHfIPfIZu7HMPv0h6n3vSGgysP0=;
        b=hCky8I65ACA4WN5vqi0xpzsaHGKbjB0qJ4jJMmfWkTvUKSipFgh4ERBdgdXt5NLt3j
         4gXJ9XJcQetSfoQEbUdiTIJctiTh7YKNNkCN6uvTGEbmeuFcojFQStgrSd/7u3imfc0R
         vu9aoz94fGzGxHADMcnrkPCwnJIn91HcbHP58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776175678; x=1776780478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GpkpOFIsqQQ7tnZ4HHfIPfIZu7HMPv0h6n3vSGgysP0=;
        b=WZS2PLOcNtdl3km7Fpg5aX4g48Jpc1gwI0PRNTGBmiihYcGzMmU0robWkNvZxIpTL7
         9/szhbYp7eSChxtL0lKknRKyd5kEoEifcNnV7FG11iao9KRCiDwaWiJird1ygPKELXDO
         geZdOeq4uZHsiRq16PYGFg5OUNSCUbxUVEikUBn3IKq1dGTktsz8AIntQUWLa6SObla8
         3MiPgjbwbdLvXkdSznRAcZw1ufO8SMgi4ejo/31KZKmmLvk8rIyW81R2lFZ4IcXRXwIq
         8poCGVvnSwBBs/Ii5ncn73yo0OcvvtjD2wzp+mACibr8fXBSgoVknTIqQQdPoy6miVVb
         KMYQ==
X-Forwarded-Encrypted: i=1; AFNElJ9yNZ9FnkWoGRsMC8wJE70MKWDry1N4OfFdrIINjGg/Z/T6WlkxCaBbQk7GmRM9fROem6VgfBZ9fpFASg124UCYjCvdsqc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi/vX6hqUk9zxh6ll1vBL171dNacOWfoRUFPtqO1H74Ht0wQBw
	6jSgR7mXQ58UDQjN4K1LNjTDleT/dKsi4Wl75TUCZ3Fj/QXWOOlPz7tH1agvZqszvL3Xl7YD94h
	uXKfQACsxd5gpHb/ScBKh6egsUlgzVbx2YZaNwSmLXQ==
X-Gm-Gg: AeBDiesvbDJRcTMfY8Ej12cu0R20EIhUACzUiaY3t6f4ZjzGQHiEgp33HT7u3BSTomt
	TrqGrXz9zpa4DvWP3lIAV1ilBv8pmKaWtg+UkU3NIEGrHQu4Iaz177DMgf0mGatU+eiHIutwh27
	EknMPMYYUwHxP9miImPmX8IV+rYnc4SMjjgV8O8S+ZHuWiuD/w7Pg4OC/Z6FinPWFVTQeCTcsXZ
	/UUT96EZTm1+whoe4/4nx2Iaao+e8r+ZHDl3/py+kBH4tYsZ8tFgAwwq6k2Wdp59ZOg1UWqDzPQ
	Gq4nG5Qj3cd1Mn72vcNO9DvmwpL7TllXgaB6
X-Received: by 2002:ac8:5855:0:b0:50b:a9d3:2e20 with SMTP id
 d75a77b69052e-50dd5c5de8fmr270610931cf.49.1776175677602; Tue, 14 Apr 2026
 07:07:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <adUBCQXrt7kmgqJT@google.com> <06337e89-349a-4334-a735-b8dc9b566cdd@hallyn.com>
 <20260409-entbrennen-turnschuh-54af9b45610e@brauner> <adoIGHwgMJSuRfE5@google.com>
 <CAJfpegv6GDFZjdGrQ=0Jahvz5mSgfJr+GvjVwws=SFX-yirpSg@mail.gmail.com>
 <adzgKVIhRj5t3GqM@google.com> <20260414.gailoogieGh0@digikod.net>
In-Reply-To: <20260414.gailoogieGh0@digikod.net>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 14 Apr 2026 16:07:46 +0200
X-Gm-Features: AQROBzAlDgij0NJu_SEQXonuAppoeFCheLDZhgFXV-UIY4VjnaeiJpf0WQLibPQ
Message-ID: <CAJfpegvXmnQZea0zVC+hB8h360FSbBV-tYyTjHtfTDwauuYNVw@mail.gmail.com>
Subject: Re: LSM: Whiteout chardev creation sidesteps mknod hook
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Christian Brauner <brauner@kernel.org>, Serge Hallyn <serge@hallyn.com>, 
	Amir Goldstein <amir73il@gmail.com>, Paul Moore <paul@paul-moore.com>, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 14 Apr 2026 at 15:42, Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> wr=
ote:

> BTW, I don't understand why only the renameat2(2) syscall can
> (indirectly) create this file type; why not also unlink(2) or rmdir(2)?

The reason is that the same effect is possible with first creating the
whiteout in the work directory with mknod, then renaming it over the
target.  Since the work directory is needed anyway, this spares
filesystems from having to implement yet another overlayfs specific
operation.

Thanks,
Miklos
