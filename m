Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B989E19AA56
	for <linux-security-module@vger.kernel.org>; Thu, 27 Jun 2024 19:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719516603; cv=none; b=AbP7WsXepHQaIu6JzsKkImUudYeP8EpnIgZKtabK9XjJMkVhazNpjm9BXpswJ81ObE2P+agyt9At7J08Y/gfGXM0s+EeV6Jt/EBPwh6Okl59z3nrAAzVLOMBv0hM+m0BafAmbO28FLaI9X8cRSdRFt26m24Vhs5+yhMHisY2NRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719516603; c=relaxed/simple;
	bh=iBOh0atC42lqPdrLoVvDYoOS2XF1EIzrwaPW36hsAh0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K7Rg0m+lq5WnAg8QShKr1H5JhuPWwQO1Q0NN14bLXxA92Y02RBtGXnGryWnbome2WValmOtwwAwaZcgZYODnkS0zxhJCdOu4i7M6Y+oLpFAwcxgQJyhIZdWW7jE3Jfokm29drbmdxFLCJPRI9jq2U9+Y2vPtUyD7eHTclepWV3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Rue1XiAg; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Rue1XiAg"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dfa71ded97bso1800098276.1
        for <linux-security-module@vger.kernel.org>; Thu, 27 Jun 2024 12:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1719516600; x=1720121400; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hdz+RrVgteZReZT9YJg/zM1QvaWDeqeNdyJjVUh7iT0=;
        b=Rue1XiAg4ijxWwvKeEg3FpLdHGCKAVV/vkyCNohvDTowHsjjOQ1dVDaL4sk8WP3519
         FekKY8gcpf+IYjXzYlfC5gvOyA1yBCbRuAWAkQ72qY8ECG1ELttEJCqCSBVdOhSFtaMV
         SfgFqZZKfYHP/Pv+LMv3GLp9qPB304cGh0oRlyHAiZBImZDGFp2zsLD7rRdpIjGfZGb0
         ulJRofZmytvWGaSxeuXQu2rqzZMqKzgSqIY3SC6FelvqKQZV7SRe8hWLjP9LKHmvTqkL
         m3CpeqxYpU2Sxkh+kZCrnCXcRJ64hLmWegFGQ4eZrR7on97MCFBPirKzto1hFtnccQ4O
         oGvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719516600; x=1720121400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hdz+RrVgteZReZT9YJg/zM1QvaWDeqeNdyJjVUh7iT0=;
        b=w06NxR5iWTikiOsReLClF1wPxO0bGeuI3OorrjbmKxRWlrDKI8JkPNZZqY01T5FLcr
         RkTOub5QeFXkpjF6lKaSwqyJc+fkDYg8pC+qxyw1OxZ4Lro4KUSvIPiNZXLwn6pjyvlH
         MPTRt0iA5UYpuc8E5dlxzH1Ago8LTxm7TdQsmHYnVhcv0F2kYFzbpPDmMCpIX1fo1j4s
         Wm8O47+yyknoEqWDjqty4xBPDxSBtkeWNWTjAuTjzYFD6dRY1PdqB5+7lwY/vZfqdzc1
         H7B1/xtkAUtPehkU/mfKOm8mzc+JXZdLNjbho/0GXCAgzNRexmSMWeG6vMGfbkdUlN2b
         kYWA==
X-Forwarded-Encrypted: i=1; AJvYcCXXqXUnWugOw4z7OfOoVIrIRDF2FTmmZY1+PcNogCcY6cv8G4Y5MU2qy/fsJRCdjxvIwmv2biRukWNCEW5vmJTwS9Ujw+z0ChGw6aQH8o/opz4RZwno
X-Gm-Message-State: AOJu0Yxx+h++71rsTOiMKADYwKU5dBXBm4n911zMQ7l9IC9B65Tp6EsJ
	2OKEIKbMYR0AAg98frk+5cO9po9uthYcRlxDb21z8oj97T671KQjUg/lDpAHXHilc9Q85Y6wcoD
	Q1EwHN6J0v9j2gvpsa5nshrpTR+WxCLYJp36E
X-Google-Smtp-Source: AGHT+IG5zda6W6h+VyTY+2oP03mzZadPKl6xTjtfOgSRdYt4ZmyFwUOr8h9KN8Rs/nKDGLnHUnBSp9tBCGT9XIo5Y0E=
X-Received: by 2002:a05:6902:525:b0:dfd:a095:f98c with SMTP id
 3f1490d57ef6-e031bea726amr7464296276.21.1719516599651; Thu, 27 Jun 2024
 12:29:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <00000000000076ba3b0617f65cc8@google.com> <CAHC9VhSmbAY8gX=Mh2OT-dkQt+W3xaa9q9LVWkP9q8pnMh+E_w@mail.gmail.com>
 <20240515.Yoo5chaiNai9@digikod.net> <20240516.doyox6Iengou@digikod.net>
 <20240627.Voox5yoogeum@digikod.net> <202406271019.BF8123A5@keescook>
In-Reply-To: <202406271019.BF8123A5@keescook>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 27 Jun 2024 15:29:48 -0400
Message-ID: <CAHC9VhRFP5m9k5JhQr-8QXJ=8JL_OCzDWxcO8dGxuLnk5X6qJA@mail.gmail.com>
Subject: Re: [syzbot] [lsm?] general protection fault in hook_inode_free_security
To: Kees Cook <kees@kernel.org>
Cc: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Christian Brauner <brauner@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Jann Horn <jannh@google.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Casey Schaufler <casey@schaufler-ca.com>, 
	syzbot <syzbot+5446fbf332b0602ede0b@syzkaller.appspotmail.com>, jmorris@namei.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	serge@hallyn.com, syzkaller-bugs@googlegroups.com, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 2:12=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
> diff --git a/security/security.c b/security/security.c
> index 9c3fb2f60e2a..a8658ebcaf0c 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1613,7 +1613,8 @@ static void inode_free_by_rcu(struct rcu_head *head=
)
>   */
>  void security_inode_free(struct inode *inode)
>  {
> -       call_void_hook(inode_free_security, inode);
> +       struct rcu_head *inode_blob =3D inode->i_security;
> +
>         /*
>          * The inode may still be referenced in a path walk and
>          * a call to security_inode_permission() can be made
> @@ -1623,9 +1624,11 @@ void security_inode_free(struct inode *inode)
>          * leave the current inode->i_security pointer intact.
>          * The inode will be freed after the RCU grace period too.
>          */
> -       if (inode->i_security)
> -               call_rcu((struct rcu_head *)inode->i_security,
> -                        inode_free_by_rcu);
> +       if (inode_blob) {
> +               call_void_hook(inode_free_security, inode);
> +               inode->i_security =3D NULL;
> +               call_rcu(inode_blob, inode_free_by_rcu);

See my response to Micka=C3=ABl, unless we can get some guidance from the
VFS folks on the possibility of calling security_inode_free() once
when the inode has already been marked for death and is no longer in
use, I'd rather see us split the LSM implementation into two hooks,
something like this pseudo code (very hand-wavy around the rcu_head
inode container bits):

void inode_free_rcu(rhead)
{
  inode =3D multiple_container_of_magic(rhead);
  /* LSMs can finally free any internal state */
  call_void_hook(inode_free_rcu, inode)
  inode->i_security =3D NULL;
}

void security_inode_free(inode)
{
  /* LSMs can mark their state as "dead", but perm checks may still happen =
*/
  call_void_hook(inode_free, inode);
  if (inode->i_security)
    call_rcu(inode, inode_free_rcu);
}

> +       }
>  }

--
paul-moore.com
