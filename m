Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBE4348465
	for <linux-security-module@vger.kernel.org>; Wed, 18 Mar 2026 23:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773877624; cv=pass; b=gkiWsnWzSrJRSSheqG+KVGcNk1RjBE9/ysy8UQv7eo4Ma2uTkVYiReIf7VJFra5OBZTQcZ5AtYSUGgsqrhFfOoXYLWZSyuXdeOTkgRlw1MYGrLC2/x4narXg5CMBAjbTJiHJV4MrACZVu6vnvbofYvkWkOCAZyNo259Yls9rLNo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773877624; c=relaxed/simple;
	bh=goPdRYRb1QYfjLs/QmPDwV3Kh5LoPgcZM/xi+f3fGd0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pIQW1vd1JpISY0/46IXDHjFOQrnDJGQite0/srlBBR18V+nK8QoBgHMiOyjG4EuKqsTjvjAo8/Tjf/LOqQoNgD1Sh0wADKd4AK6775qrbq8OZorz1tASOCxFkrQiViQkVWeh2dwJnyLBEsYu/SB6+c5gg3i1kpIPezBpFPXMG3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=AKLsHbzP; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="AKLsHbzP"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ad9f316d68so1667655ad.2
        for <linux-security-module@vger.kernel.org>; Wed, 18 Mar 2026 16:47:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773877622; cv=none;
        d=google.com; s=arc-20240605;
        b=TzN3SOI1ZgBG2ftjH7TmqM9S6GuRlIpOYedeiHfo2Zui2Ni94M223DI5Y7t+MXiMnf
         hX6vrm4cN0w9SOxJkTZPuGGWN7FowouWvC/jtQWpxjHB3wsPcmMcCJxBkGhW2E/vHZO1
         2G30R4RDb0RFOPL5ihZRRseX7N7DGq2i/UsntfnjLPj01Yly2uLkNl147HroqPWCDUPA
         PhF+NZbFZcgeulKEY5p2bz9479gitVIB6KHgQu9lllfrw1MnWOpfJRoLJbWygH2wxjUf
         4hj3DIZffhdhHQY9X89sRtkhwcYkBeTMH7pG9bJeuXluTs6LmoNUJDOmHFKr6m/Gb8Nr
         eAtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SKdeu+6dCkvAUwBQTZO2KRv3z1lv0eoszoXVMxx1Rl8=;
        fh=pNcvBJd37bvygHORLJNXBHdoZJ+lTM8mqnTRQiEzzzY=;
        b=fX6EwNGRXyquZFqQ4CCMnviKlZKX+DyTSVZZPZKpIdinO9NdDJRXobkahTtbz/6bMe
         F5zAtUkjK/rjiakQRXDTbl+WuGNYYzcyei64iVNv1P8d/DqhbSt227QOqYWeXYSp1+Du
         tpbPqLUs3Jiwsm/hjIpEcVnozKdXvxfpBnJpsQyuy/f9tJqYiGYPg3Lz855Tf/6/MCxK
         wa5lb8lgMUTZkkx8DZ8Xg3+TnpYw731la8xpZmv478LSyIkt0z2v+dLfzkqzRz1pQzVf
         05AkShmY0p2GooI0FN4bvNv8P0AvwwkWNL3qMYDkawJ7zb4bmDvhpCjP+GA00py7ahAV
         J1ug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1773877622; x=1774482422; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SKdeu+6dCkvAUwBQTZO2KRv3z1lv0eoszoXVMxx1Rl8=;
        b=AKLsHbzPe/UFGdaly4ZmKWfwEwmrHjd1DkZL4IVkQuzIErZyEfHo63QiPdDZocQ1er
         TDQuBHxvJGfj7ByZiLM4PkfV8rNk5V/3NumordXmOjXxnaeC+X32rN8w4u++FYqMJ922
         qiHl419cOnkMprBN228Xaq+2531KkoPltl6Xoo3Vp6WW2pPtOlttG1dg8+rgq8J+7Dml
         4EjE2vHGePmPhTt2w4gTd6ctMcC6LeWCMahkdppjXGiyBMeMN+uX9UjHwZhkMaO5oXpt
         utlaZH6uQCma0rd7bqSMOrjCIguHzeb4LLkVoaJxpS4oP3XYJDepNYXITJJxfvyktN/S
         yLig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773877622; x=1774482422;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SKdeu+6dCkvAUwBQTZO2KRv3z1lv0eoszoXVMxx1Rl8=;
        b=Vl029ae/1UD/JgBFmXSce+jGZ+fvMdB3ZnG5b/SfNlVtx7O6F/BSJfFM+BXk58DvYS
         V4pjAY7bMdQq/WQCHNet/L23F+QOCjroKSocZWQooh/yuVEFtQnga59ziBjegGCQR8hg
         kJNZdkR/2cL1K2oML4LEeCiXDbYQIdhk0Hzjpe3LK6TXLszM9EVGt8a14KisNUeQw1j/
         5Ed8JbXGoE9zt1zlm8tdn1EpfJF2JGocTGShYS8bLHTzGwWDToCeF8L/nRYEijJAoyAT
         3g8YE1JeYG/GcCfGZj7laXqvLYFeLapdz5ul83wkp5RS8hsfCYorfWZcJlYRjRZC+uId
         xszg==
X-Forwarded-Encrypted: i=1; AJvYcCWtzLIAcSDY4We8qAjVlxC4vGsxu37lXxt3C5JtYrSnCAIWFJjYBxDORS4Nyb/REHQKDIIu3r/kKZ+MJRmI/743IJLPxBw=@vger.kernel.org
X-Gm-Message-State: AOJu0YymWZMkTwlHhlJ2vh36R7P2MhlvUpXMo2mE6uAgFUG9v71nYCwh
	1o466cpSyExIdRwqpJOXo1MII/yd9FX6GTwS9ugFM/IXps1UvJy3oqnw5za+7KwJtIoHmrw+WRz
	6PDHy1+HoYGYI2mnPXZU/a34nNuxXTyYhFqWilECU
X-Gm-Gg: ATEYQzx+lvy+Gg5rsAgTTdeMPVQhlpYWZPYldM7BqOGG7Mj3UjIMk1y7xA9ybmc5Ua/
	vXEuQX8GDlx9wmsopVo4IpZrrqit1M4d4jZWUkq2TIaNjC+mXT5FMFr3iDGUtQPIHMlfbof3DPS
	Wl3ma4X7eLJ0zsgP65oilHveuxvwBvV71p9hiTgEI9Wz+GwyL4SWRYjrBxwHdo4R/fPStcckhtm
	sPDLWzscQi9yh1cp2m12AkcE33efzwyfC+I/EJvXCJ4FCAKPXZgH8fAYbSe+PFyh68kpFG0yJrq
	JzsqZqQ=
X-Received: by 2002:a17:902:f547:b0:2b0:7177:d5e5 with SMTP id
 d9443c01a7336-2b07177dc04mr35425715ad.43.1773877622532; Wed, 18 Mar 2026
 16:47:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318131258.1457101-1-amir73il@gmail.com>
In-Reply-To: <20260318131258.1457101-1-amir73il@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 18 Mar 2026 19:46:51 -0400
X-Gm-Features: AaiRm50UCF1CurPQjVXbzqdFj4rL7YmqoTti-AfxH9o9diMwAaN1iIjAFrpAzkY
Message-ID: <CAHC9VhTKvOzMS2ZyawE=qBN-EpyucfxvwcHZYjXF5zugRhE2rw@mail.gmail.com>
Subject: Re: [PATCH v6] backing_file: store user_path_file
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, Gao Xiang <xiang@kernel.org>, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 18, 2026 at 9:13=E2=80=AFAM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> Instead of storing the user_path, store an O_PATH file for the
> user_path with the original user file creds and a security context.
>
> The user_path_file is only exported as a const pointer and its refcnt
> is initialized to FILE_REF_DEAD, because it is not a refcounted object.
>
> The file_ref_init() helper was changed to accept the FILE_REF_ constant
> instead of the fake +1 integer count.
>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>
> Christian,
>
> My v5 patch was sent by Paul along with his LSM/selinux pataches [1].
> Here are the changes you requested.
>
> I removed the ACKs and Tested-by because of the changes.
>
> Thanks,
> Amir.
>
> Changes since v5:
> - Restore file_ref_init() helper without refcnt -1 offset
> - Future proofing errors from backing_file_open_user_path()
>
> [1] https://lore.kernel.org/r/20260316213606.374109-6-paul@paul-moore.com=
/
>
>  fs/backing-file.c            | 26 ++++++++++--------
>  fs/erofs/ishare.c            | 13 +++++++--
>  fs/file_table.c              | 53 ++++++++++++++++++++++++++++--------
>  fs/fuse/passthrough.c        |  3 +-
>  fs/internal.h                |  5 ++--
>  fs/overlayfs/dir.c           |  3 +-
>  fs/overlayfs/file.c          |  1 +
>  include/linux/backing-file.h | 29 ++++++++++++++++++--
>  include/linux/file_ref.h     |  4 +--
>  9 files changed, 103 insertions(+), 34 deletions(-)

Still works for me.  I'm going to update lsm/stable-7.0 with this
patch so we can get some more linux-next testing.

Tested-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
