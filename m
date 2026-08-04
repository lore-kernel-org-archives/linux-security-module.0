Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8D445D1B1
	for <linux-security-module@vger.kernel.org>; Tue,  4 Aug 2026 17:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785862872; cv=pass; b=q6Hn9PrL0vxFzFeZf/dKgQRljVJZ1kIFM7UW0VYO9eOoJE650MQId+ohbcer/qnlLvwjjQ6/a4/Z2VxniEDFUhEGuetwhlEs+UH0alcl8Vlbp4Mx3gsCo09NayZKeH3gsdaVDWF7C/5T3Lp79TOOsDk1Ex/QjA1sjCfCE4BNFfo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785862872; c=relaxed/simple;
	bh=NN7RQwZEWIcd3u0Kef8iTQYndBZrEjQokV6obVKC/Dc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bZ55wDpsftrBJZFEkXnrxakdBUSQwzlVLPRhSlAEHyM5fvdCdAkQx0/VxLQ/BBmxZbikZxfdwh5zNnDSWY/dpbF0ZXvFGcNV+YR7iJn6Z+1p+zT/e2vlmP205wC8eeiSC4qdWcNrTPYIb7tf7JrEu3IdsSoMxD8KlfBnW8zHFLE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=SZHhjSu+; arc=pass smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="SZHhjSu+"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38511175ad3so19534a91.2
        for <linux-security-module@vger.kernel.org>; Tue, 04 Aug 2026 10:00:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785862855; cv=none;
        d=google.com; s=arc-20260327;
        b=CIGh0EEpKa+CNcg9Uz3uptLJFRY2wEJNPQadvOubWEe/RECtj+OZD/JXoaS2DcBj+P
         ZioK+I5lXVh9Q1BHX1T11K/v9r9ia1KUbWTdrmw0BUOVS8FFnI0M/uk01U5BmLxCN6Kx
         M1t8bkgtWMfneSwowi63/dsAELXElcxIMml6reWqvUtLzu+sRvh7i2aXBNuiaF4Ippzc
         6YfAnHVGAKnLUMYHQyxriTkI0DC22iwfUJ+mdweYL2m/Drx2EikjognS8byKvx57r49Q
         FUH6t6SHKIWtJWrRcq0lo1tkbGSFOIp8gLpHhfPpnfEak5r8KHZbQTdOorP2oPxJqnt7
         kMyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=d0whWseHxQspZUWpMNteiPZ9cq9DmnQxMjSfFcf9OVs=;
        fh=86FK5bpTIFB+/QJr3YXjlbAl7o9+HXr8bngF4zTEPoY=;
        b=InVWpNty4Uw7nBv3Mm+VK3hxzqLnZisMrH6I5OXtPgpE14udjOCiqxFhG1Z2V7mT0Q
         TUl5yUcPwVaxJpP6vohSOjJvl9Ns2ANBVLKbgeeExJhYMhmdi3bp8qPT9HL0IkSHTbVq
         5TUhYV60UrrZXFKRkP0Il8ucs1EVTl9S/wAhqfn/HpXok/HNnw2MWY0lU0RrzCKYpze0
         tHOJ3J5/UeO56RyVaeEvI+exOChREr7AUVjDikCrbGF3PJr/J36XXsJNqTo7Vhi7s8lE
         SpbNDiw0f95AHumBzgIOLnXjXfNV8ouBjgsmdUcJZkIQOY+pabXmljmwPG71dJhsGLaV
         nsSg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1785862855; x=1786467655; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=d0whWseHxQspZUWpMNteiPZ9cq9DmnQxMjSfFcf9OVs=;
        b=SZHhjSu+914kO7qex0mPblU4m6opNNQ8SYzai3bSARLJLgxVPtp34YzgW7oNbu+Fuq
         4k48OU3THdvgN3jqv+jM8b9hg4IuP4x5ZijnVcsu409eI/9qvBshVlFF9iR0I16pcYE9
         8EkVEiEQ0LZ4BthS/SlV0K0QhtVk8no3npBUgkYyjDuhrbnahz6Q6mEKaxT+xuEvfw+O
         HGBFPVy/uByJ5rIO9oNE0+N946LUW2e2Kdacwu07ETwulGTTUCTxb1+jZ4znPHIPIpVC
         FB1jraJdPJh9m/LBOHcBHjtCTxZu8G794pvx/MD3enegq88zBZWC0w0rApfKO0ybDjfA
         3Bnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785862855; x=1786467655;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d0whWseHxQspZUWpMNteiPZ9cq9DmnQxMjSfFcf9OVs=;
        b=mqFI93eCI3WUPUr92pQGZ8ell+tdsEZFZGI/wMMXB1zjun+XEA1NMJRMTVKO8SIzKd
         HmVEL1nlniWWjfo3FfJHcjm2PIvsFylyLl+Q6THWGYD8VJzTFCDiqtLtYZ5jDYixdZtx
         3Vkt2khbKLOyHxOt1+IBEGGnpvvYBJrUO9F45Y9r3eNByK3F8hyYHXDlWRxrBhT1kr9U
         Gwe0BS298FhW4zhNfxyupgKiDsUwkLmujIBNCecQhsScZVZxlnsUPyNVfHjCUtIZVsTC
         EewA2L8g5ufukRzeWuNmz0892H1QSC1suUhX+wt6N0gnJkASY4/lCkoriIVqJrUHT8Y6
         eTCw==
X-Forwarded-Encrypted: i=1; AHgh+Ro2v0zzZFzJhjW9OCoafCmb/oqlQNzVxuSEPv/v5/8+KHnOMzyvy5EUaKd+P2cBy1UBOtISiuaP0b6dE9n/QFp5uivwtWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJU2r0wmD+cNMwxl50WwfFPh60b/PAZu9ZcI7G+czBq3EwVnHl
	bWFZ1tpY38ptaWLJ8b7bKeSGS97tnUBPgSoeDdxmrFyRl/0dZG2g78mEVrQ2TdnUZwpuL3C72de
	T0C1b69SjKKrfCidr4JydXutdlDoB5cXz2/FG6Gib
X-Gm-Gg: AR+sD12ToXvA5lQXByWVdpiQQ7EckdzX5ZLcqqn7w9DqvuYjQyteGb5nF5Q/ZHe3VRL
	72kY2eOkiU97vj4Gy5rR5svBWKYPUoNgXr+OX0A6yhSrcb0XJzchd1y0MYn5rktH+/m//tjc9Op
	7Rkmf9bCgHzX1uuanIGMagHxBAB9kqyTpjbza2z5ocCR6hEtLFQbL7Yd3AXFaM/2W7viFuKukSr
	p7Q32jG8AEp2peR9th2aHsJwq7Y/0dPFisko+Ivll2Qcb935LCOnoFbdrOzOnPxPNj2ajXdkA71
	qWpf9WH4ieyp+ckcUR8WsVlr8UnDEX4vb6kg9Hut7rHs
X-Received: by 2002:a05:6a21:3204:b0:3c3:834e:89b9 with SMTP id
 adf61e73a8af0-3cb85e7370emr306570637.17.1785862855065; Tue, 04 Aug 2026
 10:00:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804034204.3487077-1-libaokun@linux.alibaba.com>
In-Reply-To: <20260804034204.3487077-1-libaokun@linux.alibaba.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 4 Aug 2026 13:00:43 -0400
X-Gm-Features: AUfX_my2GHODSgWpz7u9PLF5sftBX1mO9fjStT4uqGF3r0dq7sFB5ilyjzEJ3cE
Message-ID: <CAHC9VhTWuX6D0yeBKr0bPbJ_mKUdiLYRtQpcwq-jJgovY_akDA@mail.gmail.com>
Subject: Re: [PATCH] fs: fix user path of nested backing files
To: Baokun Li <libaokun@linux.alibaba.com>
Cc: linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, amir73il@gmail.com, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, serge@hallyn.com, 
	linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 3, 2026 at 11:42=E2=80=AFPM Baokun Li <libaokun@linux.alibaba.c=
om> wrote:
>
> backing_file_open() derives the path to be stored in the new backing
> file from user_file->f_path.  This is incorrect when user_file itself
> is a backing file, which is the case for nested stacking filesystems,
> e.g. overlayfs mounts where the lowerdir of one overlayfs is the merged
> directory of another.  Since commit def3ae83da02 ("fs: store real path
> instead of fake path in backing file f_path") the f_path of a backing
> file holds the real path of the intermediate layer, not the path that
> the user opened.
>
> Commit 924577e4f6ca ("ovl: Fix nested backing file paths") fixed this
> for such configurations by passing file_user_path() from
> ovl_open_realfile().  However, commit 6af36aeb147a ("lsm: add
> backing_file LSM hooks") changed the first argument of
> backing_file_open() from the user path back to the user file and
> derived the path from user_file->f_path again, silently re-introducing
> the problem.
>
> As a result, files mapped through a nested overlayfs show the wrong
> path in /proc/<pid>/maps and in perf/ftrace mmap records.  For example,
> with two nested overlayfs mounts:
>
>   mkdir -p /ovl/{lower,upper,work,merged} /ovl/nested
>   echo hello > /ovl/lower/foo
>   mount -t overlay overlay \
>         -o lowerdir=3D/ovl/lower,upperdir=3D/ovl/upper,workdir=3D/ovl/wor=
k \
>         /ovl/merged
>   # at least two lowerdirs are needed when upperdir is nonexistent
>   mount -t overlay overlay \
>         -o lowerdir=3D/ovl/merged:/ovl/lower /ovl/nested
>
> mapping /ovl/nested/foo shows a disconnected path instead of the user
> path:
>
>   # readlink /proc/self/fd/3
>   /ovl/nested/foo
>   # grep foo /proc/self/maps
>   7f6e2c100000-7f6e2c101000 r--s 00000000 00:24 15813027 /foo
>
> The bogus path is derived from the f_path of the intermediate backing
> file, whose mount is a private clone that d_path() cannot resolve.
>
> Fix this by using file_user_path(), which returns the outermost
> user-visible path for backing files and falls back to
> &user_file->f_path for regular files.  This restores the behavior of
> commit 924577e4f6ca ("ovl: Fix nested backing file paths") for
> overlayfs and also fixes the same problem for the other
> backing_file_open() callers, fuse passthrough and erofs ishare, when
> their user file is itself a backing file.
>
> backing_tmpfile_open() has the same pattern but is not affected: it is
> only called by ovl_create_tmpfile() for the upper layer, and another
> overlayfs is rejected as upperdir by the DCACHE_OP_REAL check in
> ovl_mount_dir_check(), so its user_file can never be a backing file.
>
> Fixes: 6af36aeb147a ("lsm: add backing_file LSM hooks")
> Cc: stable@vger.kernel.org
> Signed-off-by: Baokun Li <libaokun@linux.alibaba.com>
> ---
>  fs/backing-file.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

The selinux-testsuite runs clean with this patch applied.

Tested-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
