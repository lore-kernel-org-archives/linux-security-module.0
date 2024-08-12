Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863E317A5B5
	for <linux-security-module@vger.kernel.org>; Mon, 12 Aug 2024 19:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723491445; cv=none; b=JZQ10Eurfd8jXWCsgC1L1jcweqrJXKTa7Hls9k1fVnXPpx+oXNb48TGanG75uRAEweYz3Niy9iomY6meJnSssRxrzN/peP+CyMhoYRwhrluZViA+Rm/M7T6HPwE4C0XOSA5+od742EN0KsoCeWzG66jA/mAu+LS8LQ2nKTorRBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723491445; c=relaxed/simple;
	bh=Ee/lx/KaJjg9FUXRFp5zcIm6ZhPGSG4qyOR3WLor29s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Jg6//PNUjaSFy9WMj4nb/dysHLgUihb7Lumvs0R2ltsY7CwgiuhiifUq671lzbZsxRfxdYTz687o/npmDuCxdZBtq3Tr/ItAgpCxKNTRWFsyy0bdtLfoalWXqE1WtP4g6yC3dgMo9+z784D8gCjjZt6j0n6kQBbnNeDinkh+N6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=eGFG1cR7; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="eGFG1cR7"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e0ec934a1fdso2167062276.0
        for <linux-security-module@vger.kernel.org>; Mon, 12 Aug 2024 12:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1723491442; x=1724096242; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PRXchTvscnk8lG+agBroPlH7oOuOBH7zuKSQ1dSsRZg=;
        b=eGFG1cR7QbR/vFUmF/oU91n+2obiTNCUYBd81/1I7UpHfuiXfrPv2iYPmfoCskGLYN
         dS67pAB1SK6xcMiGex/p0F6DWZsNM/3re5sgT9skCQRPm40lGcc0bFHQb7sIQyF1DN5U
         MUSARF9HxMX1pUFmbeb32k6S+o5SlDveo+klo+L105HbQQj0EhjEb/KZqnQS7PjhVjE1
         LPbj7M//qHd9jkyoc8kJ36Yl5c7MPaDqeNZ0brenPfGP5pcyGktFXMXSqnBcyPg+H7a6
         CJxyAFUhC0Helt2qF7adaXX7bGMZOHyoVi8WZtrOBQueIPMrR6m50fX/ncdVqxNDsNoc
         FYGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723491442; x=1724096242;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PRXchTvscnk8lG+agBroPlH7oOuOBH7zuKSQ1dSsRZg=;
        b=WR5EgpqrjFVP+drT7vI/D7D9TNXB8D7aSrLRmkwoNkr43x+QylpUrdKq3xUCzCWt5y
         GXGbvu1Sl7KuWCZ1BadgipjjeXMbZj677Tsn4YOCRxlEX4U6HroaXneYCKNXeARvtfS7
         m8DYV9jeXRIm+GFC83engrExSVbAltpMvBf0Bl0wUZ6/62P/iYYGTd8qcb3rYhbexW3G
         F96Sel7Jpbel9DnJdIMhOqJVihWJc5tNn4qU+ZL2fj81OirgH9lSjL3sIUWlC7r7CkyC
         uJXxi0wE+fRL9lr85pOyP9AI2Svjf0RbPeu+0gpj+jWyT+VneFbJ1YpoeYHlAesyl9/w
         YLzw==
X-Gm-Message-State: AOJu0YwhumLYJMkP6peIcmcDYWu8vF+jYaHZf9zXm5/3/p2EY8vkXmVb
	xL2OxGKFYQXLZAhoKJkzEsJ78gTsRpujHVAm0lvsqhSvcBEGVva+CLZ0dvDEj1X2Gc0LtqgshCv
	m39NdlJrC7CGpSEkJKLJz83j++UvZMxVBreuJhCP3qfHD4ps=
X-Google-Smtp-Source: AGHT+IHyvaH1YUBlfM5JdT1PeUi/jaJoQUERpm0wHuNiYQylnouO6V4zFj7lwJhYb7t8c6Bug7vrq5/xBkfd9ajaT58=
X-Received: by 2002:a05:6902:18d0:b0:e03:5bca:aee6 with SMTP id
 3f1490d57ef6-e113d2bdac8mr2370289276.54.1723491442315; Mon, 12 Aug 2024
 12:37:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240729215840.319398-2-paul@paul-moore.com>
In-Reply-To: <20240729215840.319398-2-paul@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 12 Aug 2024 15:37:11 -0400
Message-ID: <CAHC9VhTSsNkm2ULcW9Yo1e0zxHQEF2xcHFb=yiXvc34g8-4rTg@mail.gmail.com>
Subject: Re: [PATCH] lsm: add the inode_free_security_rcu() LSM implementation hook
To: linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 5:58=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> The LSM framework has an existing inode_free_security() hook which
> is used by LSMs that manage state associated with an inode, but
> due to the use of RCU to protect the inode, special care must be
> taken to ensure that the LSMs do not fully release the inode state
> until it is safe from a RCU perspective.
>
> This patch implements a new inode_free_security_rcu() implementation
> hook which is called when it is safe to free the LSM's internal inode
> state.  Unfortunately, this new hook does not have access to the inode
> itself as it may already be released, so the existing
> inode_free_security() hook is retained for those LSMs which require
> access to the inode.
>
> Cc: stable@vger.kernel.org
> Reported-by: syzbot+5446fbf332b0602ede0b@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/r/00000000000076ba3b0617f65cc8@google.com
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  include/linux/lsm_hook_defs.h     |  1 +
>  security/integrity/ima/ima.h      |  2 +-
>  security/integrity/ima/ima_iint.c | 20 ++++++++-----------
>  security/integrity/ima/ima_main.c |  2 +-
>  security/landlock/fs.c            |  9 ++++++---
>  security/security.c               | 32 +++++++++++++++----------------
>  6 files changed, 33 insertions(+), 33 deletions(-)

Merged into lsm/dev.

--=20
paul-moore.com
