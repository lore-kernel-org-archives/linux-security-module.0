Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F4317D368
	for <linux-security-module@vger.kernel.org>; Mon, 12 Aug 2024 15:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723474843; cv=none; b=jzGG/P39QI2duA9OroeBd8lDcgdSVtLFWSX4k+56fOm5S9E5qXpif5LRWL6XR2lv4c4UBGK0nqoBFStQec4CV1/gQgLZUrMJmaRAiiG2gtToR+BTBoUFCya1YLsHBpDLtZd1nFkEL2fD27lfLJpzCiBttOtfGLLLphzBgVB2y98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723474843; c=relaxed/simple;
	bh=BdVvw5wi8ulgbL0r425IYgyBXwtsKVJ08h7eG+xL5q4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hWws33neUC3ImcjupYpU8EIIhtifotKLEQLa6YFtfUtis6I7su2UGjW75ub80e513l4wMu7tIjSNBFaQ8wwezZh1rFz7zaxIR+90yshAvgFeSNojnmrWGEKBahfIqUn2o/6EF0ZN1XBPKKMzdoX6GtsPmi9Ek5czfeNqOj/dYfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=VbEL/7l6; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="VbEL/7l6"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-4f51551695cso1397645e0c.3
        for <linux-security-module@vger.kernel.org>; Mon, 12 Aug 2024 08:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1723474840; x=1724079640; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E1LfnoSFlT+OLyzx/vYttf9gF0d/fk7KCwIj4mtQAzU=;
        b=VbEL/7l6zEzAgEpHngOhJU7+vra/3YzhtTeLqHZgiqMm7QnJkuHKUGKoY+jp79NOhw
         9DMflT36Ig4isIiY0K1UGRZDbT1OzBHxWZlB+sQ/3zBchDoeE+FiK+l3fJ3XAZkhfAlO
         gupl5pIxZnOsqmdRmKsx/RgncbDZMYiSJ3cX/k0CPZAEWFZDocK2XZXv9Ci3kgI3P4Xg
         u0835w2YQ8G2tyEJTlqlD56TYpA5AdvIIh7BVyw42Xb41B6mHkHXW8p+uhXgl7AEl+nR
         D9MPtRn4qWnXN+eHh16gViKwXedb11GXDnMYbrTRRDFhvv2Hr6gJ2+2191WR3P+QYR72
         NWGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723474840; x=1724079640;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E1LfnoSFlT+OLyzx/vYttf9gF0d/fk7KCwIj4mtQAzU=;
        b=Gyxo6cqbyaFBXGp1VPQlmGYCGa4EYq41U2EXGLNm4ed7Jn43aDzhDwU3dKlZXePaey
         I0pBJuNjJ2ETE8vUZ8RRgrkJyf01QgMGPPxzuQE3lVzPIWXeeGojiiABq1gp6PXeeQPI
         29GCqRZI8AdOqIL0Za4Cgc9ZWbThkIkz6P+iPJhJ9kCiS7/zw20Bc3h0Dv8RTKg28Dr/
         IbLFO/fTIsFTx/QB/9jbuHmktQq8AHxYPoN0YCoAkiTQC5Aip9T1p8ZQp1HQZ0eVJ3RD
         q+dcB1qPxr/XureE35hgrGdxcC/sB1TWUbVWvIaWP0x3QvbL2t90DfqgGalxEfTASBzx
         SzAQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9HIC58EQBT3GGgzBJhcmxRSz1aIa8yIl0yKRw3FZCsLNPl8MEe/FCNRQ5OxEL16tmMZVPjYzXvuYQSGbUq4bq5lQafFk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPfra1dv5lOvHMkJpaW+XD3rEdCLH5zf0RXmbew/jeA+GkUaUG
	PY/R7+5f4H0zatu6GESkn6cm2UuHrcely20dgPpdjPVDy+Ec/9rblIV7IUyY9AIBbJWSHVerVb6
	RMMEMsnsE1m+anpkUsvSXyWB3krp5ge+KoVbChWEOFIqe5gg=
X-Google-Smtp-Source: AGHT+IF0QTAbx41bggszGNeJJztfb6bYw1GrU0MEoge0vOkbY0MKZLCZxdKF6yLUy5pNifp1N3/5Fx2G7TY+Nwqu6lI=
X-Received: by 2002:a05:6122:2a07:b0:4f2:f1f1:a9f2 with SMTP id
 71dfb90a1353d-4fabeef04e5mr797889e0c.4.1723474839871; Mon, 12 Aug 2024
 08:00:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHC9VhQsTH4Q8uWfk=SLwQ0LWJDK5od9OdhQ2UBUzxBx+6O8Gg@mail.gmail.com>
 <20240812144936.1616628-1-mic@digikod.net>
In-Reply-To: <20240812144936.1616628-1-mic@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 12 Aug 2024 11:00:28 -0400
Message-ID: <CAHC9VhTVO1-KDBisD9sZjG+5mZUiSy6SOE=6c5_rGp5ApoC77A@mail.gmail.com>
Subject: Re: [PATCH] fs,security: Fix file_set_fowner LSM hook inconsistencies
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>, 
	Casey Schaufler <casey@schaufler-ca.com>, James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, "Serge E . Hallyn" <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 10:49=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digi=
kod.net> wrote:
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.=
h
> index 44488b1ab9a9..974bcc1c8f8f 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -196,7 +196,6 @@ LSM_HOOK(int, 0, file_mprotect, struct vm_area_struct=
 *vma,
>  LSM_HOOK(int, 0, file_lock, struct file *file, unsigned int cmd)
>  LSM_HOOK(int, 0, file_fcntl, struct file *file, unsigned int cmd,
>          unsigned long arg)
> -LSM_HOOK(void, LSM_RET_VOID, file_set_fowner, struct file *file)

As I mentioned in the other thread, I don't want to see the
file_set_owner hook removed at this point in time.  I'm open to the
idea of moving it around, but as of right now I think it is important
to keep it around.

>  LSM_HOOK(int, 0, file_send_sigiotask, struct task_struct *tsk,
>          struct fown_struct *fown, int sig)
>  LSM_HOOK(int, 0, file_receive, struct file *file)

--=20
paul-moore.com
