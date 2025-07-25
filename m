Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E9E230BD2
	for <linux-security-module@vger.kernel.org>; Fri, 25 Jul 2025 02:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753411438; cv=none; b=u/KHx4zlnSGlknYjEq48pzI5gHUCgw8Z93LyBJbDCFTpbWcs4ger9A1B44uTMA0TKB5AQBJuWzEnFboLRv+DUvTrdiTKxZUMKjXAS/rmwQV+vFRzEITa1cW/wuTR89V+u3x9ztS4rGhJQjMHWUygA/cf/3UhlCInYiYqrf8Cd/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753411438; c=relaxed/simple;
	bh=7hlZomtnwSEYXgOyb5FEyanHu7jwB5H+48d2zwgeTUg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JF7GKiHnLcWH6Wu9GATtNkMZ8C3DWwDabAa1RYOsQepJ401MNogb5itDiagEbzGXm5ykSRtUq/4+ax0FDWdGVGNaE/myXvFO8LHonSpxZMv07WYbmjHjPLGBqTBZT11RSawdFhnlZ4+9NqMIyEyzKHeiPZcLK8hyDcZ8eLMkhPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=NnZNDbMp; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="NnZNDbMp"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e7311e66a8eso1515729276.2
        for <linux-security-module@vger.kernel.org>; Thu, 24 Jul 2025 19:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1753411436; x=1754016236; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FySz+cRu8BfNFHOSnCCE2y4s68tkhJQYIqvY80ZJOyg=;
        b=NnZNDbMp6cO1yeqOxSzJnQHbtkt8YjbLFdeK2oiZJOaqEDKfGwtANFCOytqsmHBnpX
         g07As2ZGtKdnx632yB3Fo9nZEHYkmlOZHr9gFo4Gv0zp4ApBc/Qw54MEV+efM0iYV+KP
         IEIcpQ4n72+XHkp9T3xNcDnZPqnTvL1EMN65rZ87N8iTXGgt44UuNPtTt3pTIptjd37W
         pddb1v+TIbQR7xW5DgCVpRkCSqmnWMmn7KUz/I+wews+3ls06v544i3VBezGGny3IT6u
         P3hkZfT7U9DezUjN59PpiI/S/tyuzjwSkZgO9ok+oht6MEh3NAkQvLz9Q0YaWb/0xwvK
         XhpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753411436; x=1754016236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FySz+cRu8BfNFHOSnCCE2y4s68tkhJQYIqvY80ZJOyg=;
        b=IYk3gxhDVVC4Q20NL4XxMhCTVgS0ankA/5lPeh63qxa7wJVU4mCrh8V8ISuEWOt4U9
         xAFew++ktaOwjDchCstuy4e8dhbIZ3AhyhqIqkcZiDXUjMqAuN72OsStmqO8avGNRFqa
         +ifKzqgm4lU+F5RDkmXCa9/A2zX4PttmO0ukjaESLq/o1nM6Gf0GpLZ+cXruEhYsAccT
         DRSG5VLpwlI+OiJYU5fX8iw3WIBJpfcq5aXgcGciCOIGZUPLSViiL231Av+lggEXAcQU
         FoLp//CgG+ZnWTqjE3+drtokeJmqmkSeV1+lwpltGBpqQ5oOc3E+63ugycNDyQk1oLAj
         176w==
X-Forwarded-Encrypted: i=1; AJvYcCXUxAKaaiiyCffV2k/XG4aXenSHRSHjEPL7QVujDHMjF3Enqof6IB41qUvdpSGbPrCWSOy7CVBmG1bmuv7LX5UpYyBIx8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN796XDzLKrpdFrjwyGkPskKBWH1JkEorAUgE2q5P0GtGvPUp1
	7qbNVMLiLAlfIe+AB99JHi+Ao/XEfpVopzIsGloZbRJ2UnbRN1yxns7om6Yt38LNIBh/jW3Xe/a
	Bi6Fb3KzbdZGBWH+R5Ym0VllhES8Wgqwq3x5ctP1n
X-Gm-Gg: ASbGncvr6bO7qRBTWRYR/bxENjvEuxxgw19J29hbeZEbCyhKk4CIHD9Ny14+sfetq5/
	2fCq6N1zOCyJPa+wusIAvwY1Zr4/HQ/2gixHvsevOOWKzCB5RcyjSQwF26rHzYFyDy1Gr+Rvsjq
	X5kgmHCN4RO+RUoDLZgTaXlf6iP88qmqXOcWMFihAm/046L0q4Oe3azyDgMYk/bluFreVWbTZh/
	nZhzPk=
X-Google-Smtp-Source: AGHT+IGy0kReF31F1j3wAaPhrwrQg7J25T0JtgcUwvIMbS5nqsDq9A60L8ppu0vixFFhHxaUG+UyC2kOcMggzd4esWk=
X-Received: by 2002:a05:6902:1747:b0:e8d:9f9a:79bd with SMTP id
 3f1490d57ef6-e8df1134dbemr143078276.17.1753411435973; Thu, 24 Jul 2025
 19:43:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1750975839-32463-1-git-send-email-hamzamahfooz@linux.microsoft.com>
 <20250716212925.GA14322@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <CAHC9VhS3qY=+DVYqzkgbHLETUo4KgQ17qr_BC3pn9TeG+cr8Mg@mail.gmail.com> <xfabe3wvdsfkch3yhxmswhootf5vj6suyow5s3ffumcnjkojjz@e7ojgu3s7ion>
In-Reply-To: <xfabe3wvdsfkch3yhxmswhootf5vj6suyow5s3ffumcnjkojjz@e7ojgu3s7ion>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 24 Jul 2025 22:43:44 -0400
X-Gm-Features: Ac12FXx7R_BHZgXqsCbTxD-hHKdNeH-KBiya6C276YAbabcH3l3gvX9QAvZbV9M
Message-ID: <CAHC9VhQ+4=J=nf2Yeb_QACVD4-d3_aUScpBAZhGyj7_+z+mBEw@mail.gmail.com>
Subject: Re: [PATCH 0/2] Secure Boot lock down
To: Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>
Cc: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>, Xiu Jianfeng <xiujianfeng@huawei.com>, 
	linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Yue Haibing <yuehaibing@huawei.com>, Tanya Agarwal <tanyaagarwal25699@gmail.com>, 
	Kees Cook <kees@kernel.org>, linux-efi@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 24, 2025 at 8:59=E2=80=AFAM Nicolas Bouchinet
<nicolas.bouchinet@oss.cyber.gouv.fr> wrote:
>
> Hi Hamza, thanks for your patch.
>
> Thanks, Paul, for the forward.
>
> Sorry for the delay, we took a bit of time to do some lore archaeology
> and discuss it with Xiu.
>
> As you might know, this has already been through debates in 2017 [1]. At
> that time, the decision was not to merge this behavior.
>
> Distros have indeed carried downstream patches reflecting this behavior
> for a long time and have been affected by vulnerabilities like
> CVE-2025-1272 [2], which is caused by the magic sprinkled in
> setup_arch().
>
> While your implementation looks cleaner to me. One of the points in
> previous debates was to have a Lockdown side Kconfig knob to enable or
> not this behavior. It would gate the registration of the Lockdown LSM to
> the security_lock_kernel_down() hook.
>
> However, what bothers me is that with this patch, if UEFI Secure Boot is
> activated and a user wants to disable Lockdown, they need to go through
> disabling Secure Boot. I'm really not fond of that. A user shouldn't
> have to be forced to disable security firmware settings because of a
> kernel feature.
>
> We thus might want to add a way to disable Lockdown through kernel
> cmdline.

One can enable/disable "normal" LSMs via the "lsm=3D" kernel command
line option, however, as Lockdown is an "early" LSM, it is enabled
prior to the command line option parsing in the kernel so that isn't
really an option unless we add some mechanism to later disable
Lockdown during the "normal" LSM initialization phase when the command
line options are available.  This would result in a window of time
during very early boot where Lockdown would be enabled, before being
disabled, but I have no idea how problematic that might be for users.

--=20
paul-moore.com
