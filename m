Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0732550D7
	for <linux-security-module@vger.kernel.org>; Wed,  7 Jan 2026 21:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767822230; cv=none; b=Onv533XiJg1fEIdVa7Q9nyHoZAv85OimO87fuv6a+aUmUm8FAN9WdOSVyyNxHu0PtlKVtmo58WMEZpDB7SsGzu1tTFLkp9D5JeWd87KHClLwKh4IQPmhm7IrIj86fK/nATLb+pizqoK++5/3UyvhY2ueX1L9YJJAlafxjE6hYWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767822230; c=relaxed/simple;
	bh=oPX8WC0khXlRSxRk6co6iZtm9CKQ99X3PYw+4T/T8zo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HlYv8tzAX7vyFtkPTUMxSSVXLxUI1TpnSa4s52YNuVcFbENy6S/CCmhvj9klV56bzbvePld+NbQxJ8Os8n1JTmGwRh7ejlsh/3QyxJDmUjMyN+G0m7LYN0PrgnTFbF/S23uCpbF7idQeIiDNlRkD7VLjSp6Id6IMpRvf0y7/sMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=PvGxBpIx; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="PvGxBpIx"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-34c93e0269cso748644a91.1
        for <linux-security-module@vger.kernel.org>; Wed, 07 Jan 2026 13:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1767822225; x=1768427025; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e77yQyAw1MVVvjefm5EFz/r+8dtWPsocGN7afrJ3Dyc=;
        b=PvGxBpIxA6h2fvVVXXqqKYhrsH+3ANdtHgERUvozVjOuCx7Rg/qQohluW+++GqpwbP
         jWxKLMpjFvziu1EwbjYh418dk5XUl+duRyrlyyRKoSZUVcRnXwUU62p/e3bt5VFSRcBr
         r5LtVR+8w3qf8SxW1NKOeqMvJbp0bMGQmPiooBlYJHUblFnMVaS+FKD6EaTp0KmfDrqa
         q8Ff6g4LtHKg47XGVY64FCxlAwdt85H0IMxWQ/AY0oS2qfDnqBE7BtQN7St662nhw2GL
         hCaQBsMEs6dJyr4AGpFf98TUGU32B4QdHgk3v8p+qEHaFZokWFLFq5zHFO4vCmWWor0Q
         2SbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767822225; x=1768427025;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e77yQyAw1MVVvjefm5EFz/r+8dtWPsocGN7afrJ3Dyc=;
        b=sW6VUsIkWZeH9Y2djJ8645leQUfGbE3A8pXMKJrSb3ggBtJNbSmE16VjHKnuf2dlya
         GuANLUmam+ttJGGNidGn3FHC2U6g/xA9WZkXOT0OnBB7jpSBjQmYugL1lPmVxsAZjiX2
         wgvz7kArkncFX3L3XRivH64o3KKlvTDGsjYLzfUZT8P+w4YnA8svsO+jE66eKsUI514W
         ceJo9CUNqD8IZw2b8l1exy2/UGsD9xUkv46i1MtxGDGr6V1kwOegeAH1eHPIC5LaR3Z1
         ApJzCjeUqQjGYfTRBCZ0ODuqK1eU0NrHH5eyR0AzCza+JJhWctnm2XLbKXtrkmFI9MqT
         7vTA==
X-Forwarded-Encrypted: i=1; AJvYcCViXWRdPWJ106dHjx1JtGdT76IvGZ7FSQkSHROZIHjeZIEtUIvi+hoE3UriYjhcsmBoCZUNFfrBDcYECp18Y+UuVfqTc5w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwI5NGxX9c4iwl8G4rLrDyrSh08ArqNA3zg3mzkHnPWsFBjmVtg
	h2MFhQnePV6vrmVsG/hKZoHWH0hMY4N5OA3OGyCsPR9FBMWf7gYSOLg7PjOsP9pX5oXRqoxxDWo
	OAQcCuzetlCsfVQmzHjn7WJOCeke+cth+4OfPTQ+2
X-Gm-Gg: AY/fxX7TfWpXI8+AwSlxshyA47CAvpept26JfeO8tWWGYPTxCjWauRXSrZiJcwmqMtQ
	/h9j9TXgAD035oCuEj5KS7smlfVZBuvqwsCRs9BS5DxV57VnQuB7Y2kvrN+0l5bAWVzD3SUb8x2
	Y06okmY6OUoMJY/Tx2JpVebWSFg9h7eY8lCUhB10k+9s9+DPwneYRtI/w7lb96+eWW1RBSr35oN
	RqjajWBj1H5cj0eebcojg8CXtgb3zgPgTMp/MT/aaUMn0r96s+vrvTIvGnMEzVADx2qkbg=
X-Google-Smtp-Source: AGHT+IEathxfn7upCeIJMulzVmZ+e1fE6uIUQmRv1edLX1SRNagEQbVFk7h9kV77Y4T/hAnb47hz55ycTT1gohwEaGk=
X-Received: by 2002:a17:90b:2dca:b0:34c:2f01:2262 with SMTP id
 98e67ed59e1d1-34f5f831c80mr6124632a91.3.1767822225568; Wed, 07 Jan 2026
 13:43:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260101.f6d0f71ca9bb@gnoack.org> <20260101194551.4017198-1-utilityemal77@gmail.com>
In-Reply-To: <20260101194551.4017198-1-utilityemal77@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 7 Jan 2026 16:43:33 -0500
X-Gm-Features: AQt7F2o7xku2xhldp3g03NR8PmdBs1HeZm0dsE0__ArgjxjiqElz5mgVs9Jrc3s
Message-ID: <CAHC9VhQ234xihpndTs4e5ToNJ3tGCsP7AVtXuz8GajG-_jn3Ow@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] lsm: Add hook unix_path_connect
To: Justin Suess <utilityemal77@gmail.com>
Cc: gnoack3000@gmail.com, gnoack@google.com, horms@kernel.org, 
	jmorris@namei.org, kuniyu@google.com, linux-security-module@vger.kernel.org, 
	m@maowtm.org, mic@digikod.net, netdev@vger.kernel.org, serge@hallyn.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 1, 2026 at 2:45=E2=80=AFPM Justin Suess <utilityemal77@gmail.co=
m> wrote:
> On 1/1/26 07:13, G=C3=BCnther Noack wrote:
> > On Wed, Dec 31, 2025 at 04:33:14PM -0500, Justin Suess wrote:
> >> Adds an LSM hook unix_path_connect.
> >>
> >> This hook is called to check the path of a named unix socket before a
> >> connection is initiated.
> >>
> >> Signed-off-by: Justin Suess <utilityemal77@gmail.com>
> >> Cc: G=C3=BCnther Noack <gnoack3000@gmail.com>
> >> ---
> >>  include/linux/lsm_hook_defs.h |  1 +
> >>  include/linux/security.h      |  6 ++++++
> >>  net/unix/af_unix.c            |  8 ++++++++
> >>  security/security.c           | 16 ++++++++++++++++
> >>  4 files changed, 31 insertions(+)

...

> >> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> >> index 55cdebfa0da0..af1a6083a69b 100644
> >> --- a/net/unix/af_unix.c
> >> +++ b/net/unix/af_unix.c
> >> @@ -1226,6 +1226,14 @@ static struct sock *unix_find_bsd(struct sockad=
dr_un *sunaddr, int addr_len,
> >>      if (!S_ISSOCK(inode->i_mode))
> >>              goto path_put;
> >>
> >> +    /*
> >> +     * We call the hook because we know that the inode is a socket
> >> +     * and we hold a valid reference to it via the path.
> >> +     */
> >> +    err =3D security_unix_path_connect(&path);
> >> +    if (err)
> >> +            goto path_put;
> >
> > In this place, the hook call is done also for the coredump socket.
> >
> > The coredump socket is a system-wide setting, and it feels weird to me
> > that unprivileged processes should be able to inhibit that connection?
>
> No I don't think they should be able to. Does this look better?

Expect more comments on this patch, but this is important enough that
I wanted to reply separately.

As a reminder, we do have guidance regarding the addition of new LSM
hooks, there is a pointer to the document in MAINTAINERS, but here is
a direct link to the relevant section:

https://github.com/LinuxSecurityModule/kernel/blob/main/README.md#new-lsm-h=
ooks

The guidance has three bullet points, the first, and perhaps most
important, states:

  "Hooks should be designed to be LSM agnostic. While it is possible
   that only one LSM might implement the hook at the time of submission,
   the hook's behavior should be generic enough that other LSMs could
   provide a meaningful implementation."

This is one of the reasons why we generally don't make the LSM hook
calls conditional on kernel state outside of the LSM, e.g.
SOCK_COREDUMP.  While Landlock may not want to implement any access
controls on a SOCK_COREDUMP socket, it's entirely possible that
another LSM which doesn't have untrusted processes defining security
policy may want to use this as a point of access control or
visibility/auditing.  Further, I think it would be a good idea to also
pass the @type and @flags parameter to the hook; at the very least
Landlock would need the flags parameter to check for SOCK_COREDUMP.

--=20
paul-moore.com
