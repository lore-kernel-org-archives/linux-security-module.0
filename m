Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275CF1F9A89
	for <linux-security-module@vger.kernel.org>; Wed,  7 May 2025 20:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746648625; cv=none; b=i73JivK5R4ineJNnSm7z6+fIcYRSTUq8uICOgMNr3rKmL5MErXdvsV8tz5Wol04/hfMcPoWm1dFo5zmHn9NSZIEJFHm/7lIVcX6ysk9MlH3nw5lFO8rCQBpkwTZ3qIGGuAlKXH2+r9pCCXSNkStt3wPb7+v7ksEBSOgA3zi0z5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746648625; c=relaxed/simple;
	bh=fCVjwCn4xZyEXegMjpL82M9OYf/7NCLuKcF2+VPwsN4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m3y2+cAONVdf/BbSlS95f9vgbLl7FD9yJaF6XwrwlRfycYHioxIl8ANn8kY+/+zOI/MxTtfguhbM63Qesg2vwN5TutS9l8cq2cclfENNhqWb2FN50MlRsj7MhYTGqT8RNgLi51mj7itcNuOrCDeWRPG+QLCMyMBm5S8PLOeqcLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=OFe5KjdK; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="OFe5KjdK"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-707d3c12574so2863477b3.1
        for <linux-security-module@vger.kernel.org>; Wed, 07 May 2025 13:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1746648622; x=1747253422; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ekY7BJ7WiYIDpzZxnM9t3PLUraHpkr8ihNGY2FZPIE=;
        b=OFe5KjdKWI5HNCWZeXGR0NeIIA5DhfySOJg0/UHdr60h2SaFVPpPp27q/RKdzqcYYa
         0+fehHp+tpiDRthd+h7beAt3lT4ZNjcEWBSF3AZbrPyiHaTPCCBKIJIZHn/PkWrHfQuR
         niJ3JLSyIeO/K/H3RCwLgYI7jLS5Vwf2ljyb8+lrl6srsqnEY1xCtV9kg+iBX/PJfUM5
         9LUsH2woJli9ls+pjQpLvomhvRS8ix1j5oEyCQ/fN1DNrsZTWWwDkSnFL1XhPvnrhDRH
         VAAgQJctkli5C9IsZyeP5MCk0X36r2eGmWSnMlBNGcPGrMgMKQlfYN6v5JXrOPoQ9gIl
         +aCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746648622; x=1747253422;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ekY7BJ7WiYIDpzZxnM9t3PLUraHpkr8ihNGY2FZPIE=;
        b=lcwFyGEr+3pH2sHxna5vnWKkihp8WtyBsIj2RXPvjMZK6+4lu81+A1oMXzmknysjAV
         dEWCfT19W9Gfhvab2fbhCLvQlZql0cn5YJiDv7StDv9OGjditjFu/x5qTzuXZ+Ts+eUY
         Wkd0TBx8A1a7Eh8QsAtEcrbDYGKAOfYAYLa+SZiO9HmnOkEurAqorAtO4hYPy7lD8GOW
         2RETyQCQ+LrC1kIpoY0CwoPHoM/S/nmDcHlY2JEiqS49s4MZOz8vQCamahtbY6jXa25X
         LmcYaGF/kv9JtFPg6qO14V2/tcRFXdHwBj+rE9egyuOG6AqPdQ70yB3L0J82KOIn0jl8
         2NdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyPDAxh86JPfOpy/Dmrs5z2eC43O/zuqV2pcG1ufW9Un7PhF2LgKhy/VO4XPool+VVH+ghni/+K7hqp1PzrwuxDW4xpGc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhnkHnyfJEL/bm7m/gsJSqXeiywY3PNn4bdfyy+TNhj/ktqlFe
	lkd/vekptxg67ueZjya0wbnrXiMBapBP9QDCcrVr3u3t8To71wUa+ADlAarjVPUEWonBAqSt2IK
	ZG+RAT6O2Cvaesqa4PGNZj86EDUwe3vWnUJHM
X-Gm-Gg: ASbGncv7WD+3PtwojjXfOS39qAnmG/l6WeexPE5GH2SDRgbB7Wok5eNvbbaeH9b2CHL
	xFFhmspch+nKDcnZWwrfWOY92TMEIyNDQvgtlVfAF3crtEoWjoW6/YBbFNHaPwBdMSlePo+Y5nJ
	7e0J/zEj7HWx1a1Bp2nV3yrg==
X-Google-Smtp-Source: AGHT+IE9eGdn2q9nrMivy1PDTWnn2AtAdrp67H8VrWzKCbbvNLD/0n7maPe9v5pI2/6b0zqxBN0BiDP6g0jnNg6Dzfw=
X-Received: by 2002:a05:690c:9c07:b0:706:aacc:d551 with SMTP id
 00721157ae682-70a2cad406amr14338047b3.7.1746648622007; Wed, 07 May 2025
 13:10:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250507111204.2585739-1-alexjlzheng@tencent.com>
In-Reply-To: <20250507111204.2585739-1-alexjlzheng@tencent.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 7 May 2025 16:10:11 -0400
X-Gm-Features: ATxdqUFSGHLB_3GwIuKxTFWUJweW90nEeRxEVCljRPRLt5iua4c8odgJMYbAlnU
Message-ID: <CAHC9VhRx6SUqYHm7Nv6JKVzpANsnt-qPONcVqZh=hXOsWMqDBA@mail.gmail.com>
Subject: Re: [PATCH v2] securityfs: fix missing of d_delete() in securityfs_remove()
To: alexjlzheng@gmail.com, Fan Wu <wufan@linux.microsoft.com>
Cc: jmorris@namei.org, serge@hallyn.com, greg@kroah.com, chrisw@osdl.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jinliang Zheng <alexjlzheng@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 7, 2025 at 7:12=E2=80=AFAM <alexjlzheng@gmail.com> wrote:
> From: Jinliang Zheng <alexjlzheng@tencent.com>
>
> Consider the following module code (just an example to make it easier to
> illustrate the problem, in fact the LSM module will not be dynamically
> unloaded):
>
>   static struct dentry *dentry;
>
>   static int __init securityfs_test_init(void)
>   {
>           dentry =3D securityfs_create_dir("standon", NULL);
>           return PTR_ERR(dentry);
>   }
>
>   static void __exit securityfs_test_exit(void)
>   {
>           securityfs_remove(dentry);
>   }
>
>   module_init(securityfs_test_init);
>   module_exit(securityfs_test_exit);
>
> and then:
>
>   insmod /path/to/thismodule
>   cd /sys/kernel/security/standon     <- we hold 'standon'
>   rmmod thismodule                    <- 'standon' don't go away
>   insmod /path/to/thismodule          <- Failed: File exists!

I mentioned this on your original patch, but I'll mention it again
with a bit more of an explanation behind it.  As you know, we don't
currently support dynamically loaded LSMs, which means the reproducer
above isn't really valid from a supported configuration perspective,
even if it does happen to trigger the behavior you are describing.
This may seem silly to you, but you really should stick with valid
configurations when trying to reproduce things as sometimes when
developers see an invalid/unsupported config they may stop reading and
dismiss your concern with a "don't do that!", which is surely not what
you want.

At the very least, I'm personally not sure we would want an
invalid/unsupported reproducer in the git log for the LSM subsystem.

> Although the LSM module will not be dynamically added or deleted after
> the kernel is started, it may dynamically add or delete pseudo files
> for status export or function configuration in userspace according to
> different status, which we are not prohibited from doing so.
>
> In addition, securityfs_recursive_remove() avoids this problem by calling
> __d_drop() directly. As a non-recursive version, it is somewhat strange
> that securityfs_remove() does not clean up the deleted dentry.
>
> Fix this by adding d_delete() in securityfs_remove().

I wondering why we don't simply replace all instances of
securityfs_remove() with securityfs_recursive_remove(), or more likely
just remove the existing securityfs_remove() and rename the
securityfs_recursive_remove() to securityfs_remove().  Do any existing
LSMs rely on securityfs_remove() *not* acting recursively?

> Fixes: b67dbf9d4c198 ("[PATCH] add securityfs for all LSMs to use")
> Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>
> ---
> changelog:
> v2: Modify the commit message to make it clearer
> v1: https://lore.kernel.org/all/20250426150931.2840-1-alexjlzheng@tencent=
.com/
> ---
>  security/inode.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/security/inode.c b/security/inode.c
> index da3ab44c8e57..d99baf26350a 100644
> --- a/security/inode.c
> +++ b/security/inode.c
> @@ -306,6 +306,7 @@ void securityfs_remove(struct dentry *dentry)
>                         simple_rmdir(dir, dentry);
>                 else
>                         simple_unlink(dir, dentry);
> +               d_delete(dentry);
>                 dput(dentry);
>         }
>         inode_unlock(dir);
> --
> 2.49.0

--=20
paul-moore.com
