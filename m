Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F03226D12
	for <linux-security-module@vger.kernel.org>; Fri, 25 Apr 2025 22:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745618807; cv=none; b=Z4FOzRMEDWw3NcXdUFvIivWYPBBg2V5DLK1hjS5MDjrr673vQ1IkD3ll85/nCJe1chCVlTA7aa2HuQt7kA2DbCw1/OYM/gcqrt3v+aiTkNVlhxB9uq/xbYt4C65TnP/9N7O2gTKTYXz/v/50p4K7RXzCmaUWyGcd3ju0EkY4MfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745618807; c=relaxed/simple;
	bh=0h/2i4OzM19JYCfbYUcC9+9+VlKqvq7nRs+TkBqKhNk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rLqmTsJwjLWQmX8OK2smK4StydveQ0kkiWPY758PAm2KLGV4178cgvHOVXUqVmwBoYIjeWGjDQlVWns8Ki4L0FT/3JeV054pesQMxkYuiAVu76g4kb/+XPZUmf8VCNaZA8XwOpiqyyAR51y4o59gnIZiilr6DY98zAmkjylBIAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ai5HHIQL; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ai5HHIQL"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e6e1cd3f451so2288522276.2
        for <linux-security-module@vger.kernel.org>; Fri, 25 Apr 2025 15:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1745618803; x=1746223603; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S3484a7HUy8+Qi6eFFzszN0/To9Anoe0IsOVqEqn88k=;
        b=ai5HHIQLLNJe7fChb+a4DJ1Qfnd3ABjMD6bLwvwIJsC1C2ibpFmK1BFK8utZpBhdiR
         w3nFU/rkJV8lbAHYVp0f8bBEW+QPUnG26pWbDSwbuaZTsT2MZv/93cfezemMwDJ4AyyW
         YAdKNhXlq6KBQm6dWzULiBm+XUr4LYZOKifTI4I27KvU/8hzfH32suAVeLc50AOQmNfJ
         XBSmbckeI/57FIwqE+o+CCDjUvGK4CyTYQxayG5Ccg0HsYMn1Jxfro+50PttG8CNcJQm
         H4Jex1d19YnpMvJo5odNAZBP9DjAnQezr3xgz8tX7SoyTwr3iyjD4lX73IF/WeV6H094
         +CCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745618803; x=1746223603;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S3484a7HUy8+Qi6eFFzszN0/To9Anoe0IsOVqEqn88k=;
        b=OoyAniLlhxwoWcwNjN9exzGyU79812Dbzt1MbvdB+uDPZilSfEg+baONHB2iEFyXBG
         +uMp+TfcNWFBE9L6wt7rZTcmc+DjbKySrssTgZkqRwYP9Ci0HPfWBKWekZNVgvqYZWDQ
         /tUu+1VQTu/OdXZHWy8TIW00o1roUdqOvdv3emaFuRAD9R6qY3IaWnw89KI+HM8xWo2T
         IAzDIO73KWD6CLjEIu8/drUh/6Ji7LrUTn+uMHVFQkYzZQpQtYhtBiqQMoUrcDP2kmQi
         FIasif6v1ONuDup1mpNInlRgiXnUkF/5+Kup5cKMyKTMzw8zOaOw3QieE+LeSKfI7foP
         BOrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZfws1rJvw2tO9WAnh625/83bIVD/TNs39gWLfkGC8mXXax1FjXAy9T3bW2YtKPkHiYT49KtIOJKrcarCbdj006JXT1yk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyE4YwaC9Nx5PJzm/tAcOjC3TGEtaZnYLm7YDCLjX40c/3Pg4j
	a6gnPN9Z/fVhD8cjXEqkKqml15DuMvQNoe3zpjIagR6UuPOEzjxgKnrnLnHNYeTvnEPaWE8wwcI
	+SUvC8KcAnaqaJCMpCd2rVTbqc1rJxw6N51fO
X-Gm-Gg: ASbGncscKhAkO4k9TJX4JqZdybD4H440SBhYPb/ES0OFqJccoKJI+IPqZtM4/BFb0jA
	hrLHLkQgCPJUVQaHqpTq1DyxudPqSq6XOlLx4GOdEK9udG1q2WmUFFyTu6NG6SvhdUTWZQreSMm
	U8CBYki5Yo8ZTWLrUVcWGDnSuGgkXf6I4v
X-Google-Smtp-Source: AGHT+IH4mlwNihe4zO4T0ISKnFerJ+kqwwxfHtAwiiRO+VtTs4cZFAE2OA4qlsnuSB1fNAjF5bE4+/7auYaqQWC6UHA=
X-Received: by 2002:a05:6902:1b0c:b0:e5b:4482:a4f7 with SMTP id
 3f1490d57ef6-e73165c3ea0mr5639493276.12.1745618803254; Fri, 25 Apr 2025
 15:06:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250425092548.6828-1-alexjlzheng@tencent.com>
In-Reply-To: <20250425092548.6828-1-alexjlzheng@tencent.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 25 Apr 2025 18:06:32 -0400
X-Gm-Features: ATxdqUHy0h51ahu4iy47IiYhlwJHLNTHB1P-CJEUi3_yYn351KlJrCu1jR5Arcc
Message-ID: <CAHC9VhROjCvwaEJ1-Vc9SQU-x3wmZjeFknxkFGJcpPL28fGm1w@mail.gmail.com>
Subject: Re: [PATCH] securityfs: fix missing of d_delete() in securityfs_remove()
To: alexjlzheng@gmail.com
Cc: jmorris@namei.org, serge@hallyn.com, greg@kroah.com, chrisw@osdl.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jinliang Zheng <alexjlzheng@tencent.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 25, 2025 at 5:25=E2=80=AFAM <alexjlzheng@gmail.com> wrote:
>
> From: Jinliang Zheng <alexjlzheng@tencent.com>
>
> Consider the following module code:
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

A quick procedural note, and you may have gotten an email about this
from the stable kernel folks already, you generally shouldn't add the
stable alias to your emails directly.  You may want to look at the
kernel docs on the stable kernel if you haven't already:

* https://docs.kernel.org/process/stable-kernel-rules.html

Beyond that, we don't currently support dynamically loading or
unloading LSMs so the immediate response to the reproducer above is
"don't do that, we don't support it" :)  However, if you see a similar
problem with a LSM properly registered with the running kernel please
let us know.

> Fix this by adding d_delete() in securityfs_remove().
>
> Fixes: b67dbf9d4c198 ("[PATCH] add securityfs for all LSMs to use")
> Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>
> Cc: <stable@vger.kernel.org>
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
