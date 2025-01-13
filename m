Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9CD1FBBC9
	for <linux-security-module@vger.kernel.org>; Mon, 13 Jan 2025 14:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736780183; cv=none; b=qEwK9iFxghtvgemBiOZy2gVHyQLvWz6g/knHKwOQX3lLJLtOX6Ll3lh2ffa2MEas0V92vhJcdlnRfGP5vJxj9uBfTStmSx/vL8/JVWNedFd2u9LQ29mY5JIIJBiIU7/dXCudY/JSLKkfR1QQ982TnO2byMIoZd4kKHAoXQXCTDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736780183; c=relaxed/simple;
	bh=TK7Qvhmlj7NhEvh41RPsmn4JZi3Ks3R0ITd41jPHuBk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HQKnj9LabEu+rMXFsRAqDFMO0u1dMZbX9KwIsfSXHMOYT+Tfu5EKEF937CCl8YdD3+omIOpReSToMXyIYwcvW2O7vGGNTyMc5BLDsyWvGX0RjloPLqLhGv5iepAeUP0jl97I829yhwNs2WlZRZZtbNsZpUSsfxZLZP+KVFQcjjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pSeqzIP9; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pSeqzIP9"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5d0c939ab78so10655a12.0
        for <linux-security-module@vger.kernel.org>; Mon, 13 Jan 2025 06:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736780179; x=1737384979; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3bU31rzvdnNyKMbDykjZh8Ruhqgs15OKqVWKy0rLwlk=;
        b=pSeqzIP9E5TQa21nOXQW00jLyELXYdkh/zFrZJgUZRbYvc70KeQXWyV+s9fMkhkLPR
         0JW8BgDF2coVf3kopxhcVjkTEj8m3EaJlBcp8r3QybwWdEp0j0n+quZME9Ag3oj79kNp
         N+8uRHxAkZrYPitsf1pvoSVFP4v6ewdRBxfV3IEySoy3xV+rh/0AQYl1A/Mb/ISBxsoP
         qnFLFKwFOMLrD53yiT+Fx4swX5dxDh44qcuUJAcNqlzK1lADX9tS9wLlcKt9tSjqrJQW
         m08nSAUUM9sEZ8HEAQVnvLB086xH+f1DMhbCAPsUFo0e3yXN0+5A+AJIbvIDdFZUlyI5
         PYrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736780179; x=1737384979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3bU31rzvdnNyKMbDykjZh8Ruhqgs15OKqVWKy0rLwlk=;
        b=WWXV/NV/0e1QamJXphhdfFeBkTvCKyU7i54rbiwTgZlPR3wWG2XJHIVpGbPEoybzGT
         Mq3oNPmp8EaPc162ayd9wC+MKrtpwzyYG3E/9y/0I4QDv7gFuYvDXUp0jM8E/9mB2E63
         L014ht3j+82Xi1HPX3JBWDC8kzvCpx6EnOLA10mXLNWVocwpY8Tg5fsFmWLzEkI4wRa/
         RI70zN5+/WPgpiayj6zAnc74mmmyFWhHPd4uk95JiSfrU4hZTaa8UI8hXx1AiaNjKIEL
         PUmcDd2CWwLqY7xtv4qtunTel882HjNz7JdmywnG8ipY5gLSw3rMQBWJZToVJ+xTv21b
         l2lQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUt3Y4HPGtxE168Q83cfsb1euLx2ZZX9iRPgf62XSllxI9pMbg4BKiv4dvCWepYrduj3aMoj5tygpp/W0lpx6sJEXJFIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyydLKSLhEqLB5AzvFZLLzQGdKOECyvteRkjRy3TDQxYGkJfLD1
	UTo1V8ahAmy4ny8Zij7VPhVzNQNUUmhIoneP0AKOA8BNwdh0abjtUOGfop2/bCcudoop9KmIeHP
	Yylo8PZ0JHfOOF2UXxDEcZhQxH5mw1K7GhmBM
X-Gm-Gg: ASbGncvPMhxEm/nK33fTOwnh+5a6/9WaxjM0iQWjf+nzHpieO+VoNhivvo72yfa1CHx
	9TgiNS24oTZXrKoZj5VmOXHoEMB5jBI8WMR4cOlnCxvGcOWR+IqZulAqSka//mMEwcA==
X-Google-Smtp-Source: AGHT+IF/PaA6R1kIgG/h6ahe9DWLpPUJbhhw8Pyr/9w2G+GnL8ggX08blaDoQKySlhB39ot8IkKydU588T57noh/Ia8=
X-Received: by 2002:aa7:c850:0:b0:5d0:dfe4:488a with SMTP id
 4fb4d7f45d1cf-5d99fb471c5mr228899a12.2.1736780178703; Mon, 13 Jan 2025
 06:56:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250108154338.1129069-1-mic@digikod.net> <20250108154338.1129069-29-mic@digikod.net>
In-Reply-To: <20250108154338.1129069-29-mic@digikod.net>
From: Jann Horn <jannh@google.com>
Date: Mon, 13 Jan 2025 15:55:42 +0100
X-Gm-Features: AbW1kvbvOyaaV64nNP2wfgNQ0OfxJtIm4xrtJNJoqWzzmKYPFqd07bKL-_XqlV0
Message-ID: <CAG48ez3oTpoVH=en8yAwS2u=kuyh8rKqPQFjDCe_Muh7N9E_Tg@mail.gmail.com>
Subject: Re: [PATCH v4 28/30] audit,landlock: Add AUDIT_EXE_LANDLOCK_DENY rule type
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
Cc: Eric Paris <eparis@redhat.com>, Paul Moore <paul@paul-moore.com>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Ben Scarlato <akhna@google.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, Charles Zaffery <czaffery@roblox.com>, 
	Daniel Burgener <dburgener@linux.microsoft.com>, 
	Francis Laniel <flaniel@linux.microsoft.com>, James Morris <jmorris@namei.org>, 
	Jeff Xu <jeffxu@google.com>, Jorge Lucangeli Obes <jorgelo@google.com>, Kees Cook <kees@kernel.org>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, Phil Sutter <phil@nwl.cc>, 
	Praveen K Paladugu <prapal@linux.microsoft.com>, Robert Salvet <robert.salvet@roblox.com>, 
	Shervin Oloumi <enlightened@google.com>, Song Liu <song@kernel.org>, 
	Tahera Fahimi <fahimitahera@gmail.com>, Tyler Hicks <code@tyhicks.com>, audit@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+Christian and Al Viro to double-check what I'm saying

On Wed, Jan 8, 2025 at 4:44=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@digiko=
d.net> wrote:
> -static const void *get_current_exe(const char **path_str, size_t *path_s=
ize)
> +static const void *get_current_exe(const char **path_str, size_t *path_s=
ize,
> +                                  struct inode **inode)
>  {
>         struct mm_struct *mm =3D current->mm;
>         struct file *file __free(fput) =3D NULL;
> @@ -93,6 +96,8 @@ static const void *get_current_exe(const char **path_st=
r, size_t *path_size)
>
>         *path_size =3D size;
>         *path_str =3D path;
> +       ihold(file_inode(file));
> +       *inode =3D file_inode(file);
>         return no_free_ptr(buffer);
>  }

This looks unsafe: Once the reference to the file has been dropped
(which happens implicitly on return from get_current_exe()), nothing
holds a reference on the mount point or superblock anymore (the file
was previously holding a reference to the mount point through
->f_path.mnt), and so the superblock can be torn down and freed. But
the reference to the inode lives longer and is only cleaned up on
return from the caller get_current_details().

So I think this code can hit the error check for "Busy inodes after
unmount" in generic_shutdown_super(), which indicates that in theory,
use-after-free can occur.

For context, here are two older kernel security issues that also
involved superblock UAF due to assuming that it's possible to just
hold refcounted references to inodes:

https://project-zero.issues.chromium.org/42451116
https://project-zero.issues.chromium.org/379667898

For fixing this, one option would be to copy the entire "struct path"
(which holds references on both the mount point and the inode) instead
of just copying the inode pointer.
