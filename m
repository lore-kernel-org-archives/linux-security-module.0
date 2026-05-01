Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F163D523C
	for <linux-security-module@vger.kernel.org>; Fri,  1 May 2026 16:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777651270; cv=pass; b=aybKIVnDgbOOx8m2mtl5dAIADXiOvlOzyzLI+vT+f2QKiL9RItJu6WSVL5sdSPc4HiabvoiGRerA5O3fZRKT6DHz/NOWYa8ElyAhCAxfxfviXNv1OCXn3aWELKAo1hWVI/H7fzmPpktQHGmW8jtIvqoDrLak3DoQS1ZsHv8vscA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777651270; c=relaxed/simple;
	bh=i7dJg+Ad/jLF4unFEZVC9YnfPvnVtLzsZxdPQEi9eo4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YRphWMZgfdDfw0I4BGnQ0X8eEDaxKWTXEEjRein7s3awSsxRB/kOqtLBBflqJKo5iKOAJOg8uKo2J9ECQyamxuSgZxXXLmg4PPbdC2DAzp/hZ1xYj9kxQUrgvsRO0ZTBzGbNoXjf+kRZXT+rvgZRHQmaWNrJUdlrFFiHW7XZuaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=CBpXWxAg; arc=pass smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="CBpXWxAg"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c796163fac5so1222306a12.1
        for <linux-security-module@vger.kernel.org>; Fri, 01 May 2026 09:01:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777651268; cv=none;
        d=google.com; s=arc-20240605;
        b=IxDC7R6b34+rr/kTuw2CbtYfCMa6eFuM2mMyKAXnHm137KxvrycpQ2LC4A7Edeqala
         wL8clyKJOwWO2vVJPYprDucG0s4Kx5MEckxpDrgCmKxCfVUWavq0ctfjE+MAH1u5jYNn
         C6OuculrrUUCYoTHgdIhyMB0Mw+GMYOhGDX7DvIY23hXMQ15gD9bT5NKSaaq2viYvVqZ
         dBSjiHdHDVRQ3j8wDMMj7NArFaMfIzOx5Ds6ZGUMYdG6MU+IDxPT1Iw3FMkBYYLoSNhE
         fE14iXki1c/0Om5/VvHJDWNhUOTWKTq/6JlUGQOetpeqbhET1RgBvM555UTte8n/F/cW
         4fsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aWEjhQ0FAeyXxMzwj0dAwfsic/KJmsxnSKQcD3Tkenc=;
        fh=RI/mk+6kgmfR5NmlH+yY3kA4U6lAKbkle4kHapFba9g=;
        b=XqfqU71HyNhBwNKu5qCqpMMQ72hEFp9KphASLYJ1cIpsZ3xbPXdAK5g4kTHxOzIbDG
         acbHt43w5+OZ4uaIIdV3kf7m7w6zAYSvAQoc28JVfpUkZ/lP+wjpydX2f7NnVnO8gYVG
         XlGU2y9163BZEl32Kt6ILKv7VZWvKUlZPKz2XQn6KCPH8UEhwbP+OYutr1HujqKVkh9g
         zn4T3lM0zhFNNNULLzPDFbfZMIlCtYVU6iXWDboTTsZhovbiwvU+Dazt+17dk+Dm6JU6
         ymYCo3WmtMjJbjv7haw8vpDr4Tp7q9Z0cUvFIVsMVaB0ucGCY6Mmag6kKHcrGCkCIfaL
         wGvA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1777651268; x=1778256068; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aWEjhQ0FAeyXxMzwj0dAwfsic/KJmsxnSKQcD3Tkenc=;
        b=CBpXWxAgBMkmjB8Xok4tXdUjTk929M0ao0dwZZEZEC6mdNe9MdvnjuOqpXVhH0NVP8
         MVcuN+TdNx4bHaIVDMKE2NTrh4B1QxcsMAFFACegusAQ4fwaFQEcNIXEDftiBSX7jwq3
         q/SmkzexRfa9nDb7/V4yLE9wStgCCclIsEHddAwRHNbOp2cwwrEp7vkLqK0InWac4bAq
         2zD4RQ/eFr/aWwBqnBxLLMBZP5q+wUfXpFJuQ84EA6yXWZPOJkY5TovrNl3CV30ma2gw
         0uvlQevr2alGJ+x1/OliNj9p21ToXn3hJrZVf5RvBTDJg7JZDaYqlcRLmqbLNnzpO6yp
         EHVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777651268; x=1778256068;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aWEjhQ0FAeyXxMzwj0dAwfsic/KJmsxnSKQcD3Tkenc=;
        b=XQ+0t4ubuZvqACQXbHfjwaSPlOISAYa76jp/D17Yh4OAAnsv0XfgXdGJFtbbGev6ST
         IBdEifxdhyuwep7B98O2zT/XU79uWuBHF9KJzhCMGLEeIayteZxB58ODLA1tLnxNs2ac
         q+TsL0LmmRO2CF6Wh+d7zjErkl4NfU0pR6xJs5txhwhCHy75pZp9IfF4tGGOpYGG/Vkb
         bwAt5tLHhtVp8r3pVjlslWpLT3Xsi9K3jq4oFV4i/Qgq2BmyuhzTSOZWie0vZNRb3tPl
         PR4Bq6fYy9zoajaDKKusLec/8KL7GUrSp+ADbJRkW/uaXnyN2cSKEESWk6zCagHL1QyL
         2veQ==
X-Forwarded-Encrypted: i=1; AFNElJ8MVg2nFXfxhN5A/aFGhzVCv+6NrKnzVVZt603LyiWMl/JSyaBf1H4ohkE2SowX3DrEGkFr7Vj8C6n1N+WxFaVOTE0ESTc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFcV5LLPJ8U1tHBHycxZh+3KdlshULWsIAqA0Er9wd2IBZfKC9
	/y66StCDjuHR+dQ8wKsipbCckio1N5ykdvNRxor7nux4NLv0Ke0I6VOmiLaGJ4a7kCGTKogmROc
	TvR3i260SxUV8zrXxHOrYCd+m7LzN9ldIQFsi7Btq
X-Gm-Gg: AeBDieu5HQGZNDflIp+DxoDNaqNGh8YSbPcasDDxKifHn2g6m01hsRIRt01KlOw5DK6
	S/tODNxA81KfMyPt32WPG+pJlByf+F4CgcmB19dFFaTzfpZ4cuCFWccSZn4Yr2b/C6VUJfrbrnM
	9LsCx6a0cgBdudwO2RYFegqnrcxy+YlvMH5A5zY2zEJOjos/ENML7riFm7wr7YUXz72o2O8XU8a
	yHVDbpZZg/msN5Evr6go0KLfGk5O89mFrq+887sW31KKOuf7ghK+LWG7HXep2QrCez3tiCY0/tO
	FES2fkc1nYRrrDqYyA==
X-Received: by 2002:a05:6a20:6a0a:b0:3a2:d838:bfda with SMTP id
 adf61e73a8af0-3a45fe26b94mr4353703637.46.1777651267760; Fri, 01 May 2026
 09:01:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250428195022.24587-2-stephen.smalley.work@gmail.com>
 <20260428192119.226244-2-paul@paul-moore.com> <CAHC9VhSDPg2U9UYZ7Na_A8RA-KN8OsNj5S+QwscW6X20tojhjA@mail.gmail.com>
In-Reply-To: <CAHC9VhSDPg2U9UYZ7Na_A8RA-KN8OsNj5S+QwscW6X20tojhjA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 1 May 2026 12:00:55 -0400
X-Gm-Features: AVHnY4L3FM6UrambQrN7cixYHO4W-gQ46kIRQQMq31UfNN7fq0b5uZg5p-YAHAw
Message-ID: <CAHC9VhSyDVLOQ2vr0YL1PUCdS-jh0gvwcDruW1f6t9g1WTDS7Q@mail.gmail.com>
Subject: Re: [PATCH ported/repost v2] security,fs,nfs,net: update
 security_inode_listsecurity() interface
To: selinux@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Cc: stephen.smalley.work@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 28, 2026 at 3:26=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Tue, Apr 28, 2026 at 3:21=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> >
> > From: Stephen Smalley <stephen.smalley.work@gmail.com>
> >
> > Update the security_inode_listsecurity() interface to allow
> > use of the xattr_list_one() helper and update the hook
> > implementations.
> >
> > Link: https://lore.kernel.org/selinux/20250424152822.2719-1-stephen.sma=
lley.work@gmail.com
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > [PM: forward porting to bring this patch up to v7.1-rc1+]
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > ---
> >  fs/nfs/nfs4proc.c             |  7 ++-----
> >  fs/xattr.c                    | 11 +++++++----
> >  include/linux/lsm_hook_defs.h |  4 ++--
> >  include/linux/security.h      |  5 +++--
> >  security/security.c           | 16 ++++++++--------
> >  security/selinux/hooks.c      | 10 +++-------
> >  security/smack/smack_lsm.c    | 13 ++++---------
> >  7 files changed, 29 insertions(+), 37 deletions(-)
>
> With the security_inode_listsecurity() cleanup shipping in Linux v7.0,
> I wanted to get this patch ready for the next merge window.  As
> expected, some borderline non-trivial porting was needed, so I'm
> posting the ported version in case anyone wants to review the patch
> again.  If I don't hear anything over the next few days, I'll plan to
> merge this into lsm/dev later this week.

This has now been merged into lsm/dev, thanks all.

> The SELinux test suite runs clean for both local and NFS test runs.

--=20
paul-moore.com
