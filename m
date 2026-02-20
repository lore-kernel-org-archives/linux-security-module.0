Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2DF3128CF
	for <linux-security-module@vger.kernel.org>; Fri, 20 Feb 2026 22:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771627678; cv=pass; b=BbJ/iVtL1v3p6AMcrKTSo5jEA8Cgl2g/xSaLbz1cAtdq1+RVKrIdzpnEGmGYtDYqQ/l+sb/Zc5+BNRbmj2u2o/NEgk52OY3l4KpydfdmFaHR/gl5rzyvVVKhArzpNpc7cw1vX4+U4QCulwjbQ/ivnTWsJcJLe0YmaQw1LwTAVkE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771627678; c=relaxed/simple;
	bh=cSO5ddvam+3etx0tA+nKexvNvZkPWOiJ4oLj72nGz0o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KUyzvmEDfuRaSKeLV7viQo0a6pKY0HSLeidcYusycNP0ymVuM+N24Gz3MnZIOfhotUVS2IoDPAEpdkUTnbl3C2m8k5nLtFrhemt/GdnVxLZjgB2L8UWuk2qGkAYKuOUDANuObYZ/E5FfOhWcw5+ao/6pWcFhlI+IGZmzZJIsW+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=YdaW2WuQ; arc=pass smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="YdaW2WuQ"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c6dd5b01e14so920620a12.0
        for <linux-security-module@vger.kernel.org>; Fri, 20 Feb 2026 14:47:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771627676; cv=none;
        d=google.com; s=arc-20240605;
        b=bbTTJCTGNemUzZL+/Mb969cOUL7+2XcBqEOKUOWZHmTd9UPsOJQ0Y11zTqHpiyUhW4
         QUnaxEcXUWDqDv1joIC+FPrCJdtEbWkHI6nl2cgf+xQEy49Fvz935PCkYi6vgQ3nTOLJ
         rKTxjzxLZx28lUXqmrQnIzFQEM26xUBuseTwL01DmsTjDtNQvhD21J3k9BqdqIoysjVG
         bGEBbHDlRaJcjcN8+Xz8OXWcjyokwb1ZjGZwnyRMFEk4xWQ3mQ22k6q8/AF/EygVAmMH
         qhyN8djW+Lg1YP1FeZX1NVxMCedclxQpezHvA8BessxAT04iFPhayn8DRSqtHOnZsB29
         4CAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DDXd3tXPluWk2oCytZ/1RJVm/UKOezpDOPY6avX6ips=;
        fh=xgC5Ut1f99zBNJr1FcncXESAmdew7tV+XApE3UG2uZw=;
        b=XjVwUCNVin1gTaD37LqKyKnnnPB6uiloaahMhv25ly+SgXrU2TlbbvgA1Og8ve+jev
         AQ3Kd5Bx9X4hwz9LXIDJFeYStkhFyN1sEDSNRNkzElA7wFgvhQMXdmclH4TcWCdtSa1Z
         oQtR7kGIfjCoFwooNt0bobfdrcQiV7RyUMEtFTqXMABIJQA6s3jjhKa+noxpDb/ANtqh
         dCnvUmad1oN5k/SxQ/lhlykmf6UC9FQ+rYhhb9B3LU6YoIA+Zr6ocGg7I4l1we7QQ2ff
         axZo9ygUVRS53c2hkRxZmhXIDok1GXTD2yalPRB7Sj6ZkxMIBwEaOG6c2AUovmZBDzDs
         8LhA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1771627676; x=1772232476; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DDXd3tXPluWk2oCytZ/1RJVm/UKOezpDOPY6avX6ips=;
        b=YdaW2WuQ41wM5N1ATcsiXfFOfi8o+6IN5OMQAoEAgbdAjJkGfZ63rBEdcJ8rnXF3yy
         zZPc6a4bONe+ldk+YsvYsyF2kj29Z3wp3gNZOieGr1bx02kYKEQmVczXkyhrdPBmsOu+
         02nizDc9/b0WQGtrOR1H3GqDf0CUX/xKMH2X8B4mZpv+1BEK8dbBgL7id+rR5kElX7Bx
         n0PhraKR1StZolJE3zbIKZZSH2znoCletYgDWkfimFsMFY3R/x3k3KRCEkMEvmLYEC89
         hBRTOgyFJXJMoXD0XtDvmQ6JKkjmqmwBDtqojqDUbUMVLPW7sn6eTqD1FLjRPj4//pn+
         8/jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771627676; x=1772232476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DDXd3tXPluWk2oCytZ/1RJVm/UKOezpDOPY6avX6ips=;
        b=gyiXujzFqjaDzu0kPOJyPkIOYQlwGpr/7H7NDiGGs7q1xy7oXq8riOABXk5w8zybTt
         p1VjGYMBcfAGrZ62icDtxbM8UNKM+Z3OU6ShZz2zHEUwL87hxnlODCiBihS3h4E4oISk
         hBYWWG/OUG1P2LvjjnZYSCUPn2oyTbDCcdlwdPrWQaGoyc8nSZLuHXHrVRlU1Mg/t4Kz
         1FPo07ICiiVeRmvvvtvC/dtT3ML4GxZIqcBheD0EVg6Xmc1hiyN9ZQr8v98o7xf6BwgX
         G7ExeOLc9Q3ChqwmzTvPMxFaoIWxwF36ymNqOCbUSyQ+ZCQ7p58Tp2fQATIkY/7NVELz
         1Veg==
X-Forwarded-Encrypted: i=1; AJvYcCVlf7HyMjBYLIIhdPiTjFKjcky6TaG2q0kAtO2V6F5yzSjK8Mn2gEMRRrZqY54F9lF49smY1jjgr/5iKezErqjBMG+V9IM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBKJIU/UQ4Lo3IMJzEyQOC9nEnnyfgMmkHHbxzhgxbsqUo5FAX
	u9NUL5g7kIYPvFuAFjf9mss5Ynh4GlBLXkTZlJXckKmhe+gvR8/hCxuAMXWoOl5m2s6GvPKwCDl
	UacZExwWUtDkE5Bn6MS9EOLSgwp+eOS0Ul2B+BCXj
X-Gm-Gg: AZuq6aLuhcVSkaGyLhYZPV3Oop0JjdH9LJxSCTpXaUPJOT2/cHtYbHfQM9l4WgxMxHR
	ElvA2wHUVGcunONCxUV1cIns59CEq0EyvCK6HdQCXMMbAqs9E2+Iy19/0XHZ923wWLBrBqStaPm
	aKH6O1YoMJ1/9P0RKBRjRt6BODCkc7I7OE52qtD5G+5UCaKxiLoEbNvNnCN/JslmBoDnwyTBc3y
	zsztbN8ZepuMf2er2ikftujMNhAUbpLn0worvHoJrSt33fwR+hAWXzGQkvUGUC8wcsP7XoqpOnN
	YpE/szs=
X-Received: by 2002:a17:90b:3a08:b0:34c:fe7e:84fe with SMTP id
 98e67ed59e1d1-358ae8c0983mr894544a91.28.1771627675691; Fri, 20 Feb 2026
 14:47:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260204050726.177283-1-neilb@ownmail.net> <20260204050726.177283-6-neilb@ownmail.net>
In-Reply-To: <20260204050726.177283-6-neilb@ownmail.net>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 20 Feb 2026 17:47:42 -0500
X-Gm-Features: AaiRm531rz23NInLiaMybHfJxR35OGBc7KTvM6WC-U0WofFc5pma3F6ygsFUv1A
Message-ID: <CAHC9VhThChVk1Dk+f-KANGj7Tu7zzHCiA==taeQ+=nQaH6a7sg@mail.gmail.com>
Subject: Re: [PATCH 05/13] selinux: Use simple_start_creating() / simple_done_creating()
To: NeilBrown <neil@brown.name>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	David Howells <dhowells@redhat.com>, Jan Kara <jack@suse.cz>, Chuck Lever <chuck.lever@oracle.com>, 
	Jeff Layton <jlayton@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, 
	Amir Goldstein <amir73il@gmail.com>, John Johansen <john.johansen@canonical.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, linux-kernel@vger.kernel.org, 
	netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 4, 2026 at 12:08=E2=80=AFAM NeilBrown <neilb@ownmail.net> wrote=
:
>
> From: NeilBrown <neil@brown.name>
>
> Instead of explicitly locking the parent and performing a lookup in
> selinux, use simple_start_creating(), and then use
> simple_done_creating() to unlock.
>
> This extends the region that the directory is locked for, and also
> performs a lookup.
> The lock extension is of no real consequence.
> The lookup uses simple_lookup() and so always succeeds.  Thus when
> d_make_persistent() is called the dentry will already be hashed.
> d_make_persistent() handles this case.
>
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  security/selinux/selinuxfs.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)

Unless I'm missing something, there is no reason why I couldn't take
just this patch into the SELinux tree once the merge window closes,
yes?

--=20
paul-moore.com
