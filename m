Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BE61E00BD
	for <linux-security-module@vger.kernel.org>; Wed,  9 Oct 2024 15:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728488480; cv=none; b=I2g5WyxsNEIDFbfR1jVAj3gx7xLySKBlmxXi3AwN/Sv17q/q/59aYkXnraxBnx3bAeFbOWYpDHjNpW33yQzr4+CLr0N9yhVezoKdKyD/vRcJlwnTkZlPprFYRfo5TWUflh3RSLKSgAXI1r+3+iHqy41m643Vof/Hq/dLg74Cahc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728488480; c=relaxed/simple;
	bh=5zXsacpLbkKdd7Owf7i8fcqhHBq0BjhPegtdXbXq2/A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eAlbZXtIg28FgpRbLc9PLGEcaVDQnprvCcAuHz7qmg7vOCNXUYru1iB96TOIUWJTsNDf+F8axtWRvutBX/0wUGLuydvJzPA4CsXp/T3Ob25Caugmh3xe+8PK9nyZlvy+UVAvnbtFBSvfsEDqvkXAWEqsikL5MdAeWsuB56DLWqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=U1ulGRA9; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="U1ulGRA9"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-50ab5e0c482so1913357e0c.1
        for <linux-security-module@vger.kernel.org>; Wed, 09 Oct 2024 08:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1728488477; x=1729093277; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5SH4+TCbdv6Z9/qxMkcCTLdN6YQ+M14kI3Ja3qoYGGs=;
        b=U1ulGRA9ab7wfwthSbrrhyatrOJ5w4qQDvaStUQP9s1M6piT4MuQDBHZpR5E6kPL4t
         r7U+Hs1ugw/PRf0WxYxQOYY1QFT2V7Kz1dV4x1rYtaQ87VjetSf+euTDX+kx6ydK2ZQT
         /rlDRYIsZAtlLfGLANf9RQPJ6/K3i68JXl8iCpzGoxUD9wE39QHcm/rjRfP2c6Nn8RK+
         eC/Edv4f+tGwqykQJ/kYXvwmG4KBxvgoREHu8p6qUTfAFKsDdkn6JZubvVpCSLtkED3n
         aJZk6VPDo9uLTMTWGqEhpWOJPwRxNuBbyGhFbzKgjAeLkgflduUOqCYSX7CmJROx+zFt
         6ynw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728488477; x=1729093277;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5SH4+TCbdv6Z9/qxMkcCTLdN6YQ+M14kI3Ja3qoYGGs=;
        b=BxVr3DUXsu6LGPgDpF5iO14S6TOoEsK0EgD+6WdzpYgXHWONaVUDKMzC1kjxyFmffj
         LVox/hFStG+85g57+ogDottsMEEKtmkzRhBBFiHXvmmEynpB+rU5mHLWYh5UV654PCoB
         Bz1yZ4mAADtB/h5Jb3DEiN7H1th/8QxO0p4XmeafJ3AS288gzscG45pc98x3lPeHy27d
         VLJrp2BCwPdXzbLHQY02+5tbXgJbZRZsMdUSMvH4V5H7mNmSXmZ7hAmFBz90xmqFaAyX
         fVp1ikkTrMQkaUGCpEYMbFKnnHZg8tmvsRbfvIMDND757NskGN/spEiwvncPLasR1WQf
         1HrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKqyVmRpAtdS7863ujD1YpbvrxDYTjlmMmDmk50SVszKaHU4khK7NQ5wv+1ykTBvGsIMYef+Zv/g9KZ3wdOElW3wfUSGk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb1qTCk5/4cUZWY4IUVf2G9S+Gh9MC4eu+LS66obvdo2Uq1niM
	gDIUpcXP1UEzM9OGKK0cT01qw+TIKFfpPBqgnS00MwenFTDW0ty7Xwz8ueze17OYMThQyTnNpjg
	Dh/Xd/sOJZGEh7fSczvopF47cDMLvykbc5h62
X-Google-Smtp-Source: AGHT+IElqeKjByMnp05SB4b4le58PTvRrx7/UaJf46X+cJIeHFizxq02zRji491nEB6lNk7V9WlBohLTdJPiWskBcvE=
X-Received: by 2002:a05:6122:45a6:b0:50c:eb10:9799 with SMTP id
 71dfb90a1353d-50cf089c7fbmr1989108e0c.1.1728488477479; Wed, 09 Oct 2024
 08:41:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008165732.2603647-1-roberto.sassu@huaweicloud.com> <20241008165732.2603647-2-roberto.sassu@huaweicloud.com>
In-Reply-To: <20241008165732.2603647-2-roberto.sassu@huaweicloud.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 9 Oct 2024 11:41:06 -0400
Message-ID: <CAHC9VhRkMwLqVFfWMvMOJ6x4UNUK=C_cMVW7Op9icz28MMDYdQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] ima: Ensure lock is held when setting iint pointer in
 inode security blob
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, 
	jmorris@namei.org, serge@hallyn.com, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, ebpqwerty472123@gmail.com, 
	Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 12:57=E2=80=AFPM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> IMA stores a pointer of the ima_iint_cache structure, containing integrit=
y
> metadata, in the inode security blob. However, check and assignment of th=
is
> pointer is not atomic, and it might happen that two tasks both see that t=
he
> iint pointer is NULL and try to set it, causing a memory leak.
>
> Ensure that the iint check and assignment is guarded, by adding a lockdep
> assertion in ima_inode_get().
>
> Consequently, guard the remaining ima_inode_get() calls, in
> ima_post_create_tmpfile() and ima_post_path_mknod(), to avoid the lockdep
> warnings.
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  security/integrity/ima/ima_iint.c |  5 +++++
>  security/integrity/ima/ima_main.c | 14 ++++++++++++--
>  2 files changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/security/integrity/ima/ima_iint.c b/security/integrity/ima/i=
ma_iint.c
> index c176fd0faae7..fe676ccec32f 100644
> --- a/security/integrity/ima/ima_iint.c
> +++ b/security/integrity/ima/ima_iint.c
> @@ -87,8 +87,13 @@ static void ima_iint_free(struct ima_iint_cache *iint)
>   */
>  struct ima_iint_cache *ima_inode_get(struct inode *inode)
>  {
> +       struct ima_iint_cache_lock *iint_lock;
>         struct ima_iint_cache *iint;
>
> +       iint_lock =3D ima_inode_security(inode->i_security);
> +       if (iint_lock)
> +               lockdep_assert_held(&iint_lock->mutex);
> +
>         iint =3D ima_iint_find(inode);
>         if (iint)
>                 return iint;

Can you avoid the ima_iint_find() call here and just do the following?

  /* not sure if you need to check !iint_lock or not? */
  if (!iint_lock)
    return NULL;
  iint =3D iint_lock->iint;
  if (!iint)
    return NULL;

--=20
paul-moore.com
