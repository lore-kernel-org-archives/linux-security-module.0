Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E312222CA
	for <linux-security-module@vger.kernel.org>; Mon,  5 Jan 2026 07:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767599220; cv=none; b=d7ri+lfHvAoSeIXYokkamttuiUDk6BnZzBjkBiAWu2XNFIWIQZs+oHO7LTuoDs34ET66Ex0yiE5yPRT6iUJkYzcnSn/XN78IJqHj/0owg19haimCE8dCHn1y5UfCeJ+s6troF1up2jABxJnniVX/XwVdey4bmvbBGiY2yheToWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767599220; c=relaxed/simple;
	bh=3XiCPihyU+BrHOwDidi8R6JTp4P32E8+y+fnt6YdF7I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k0wefUNLg8KPCpPp1J4nstSUN7d4f9xiK/3fAqSSHwnnxhs3eS7kAILkAI6F0kdhJZIfPnRCTvsjSgo2QcN/8IQPhBiDSslu9KVr16viaq293I9F1yth5yf8lN0fSd9wv0WfgLJj7/sfTjDtFFBg3o7l/8YaxKRwdOWasVDDwK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0a9JbC/0; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0a9JbC/0"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-34c708702dfso14568677a91.1
        for <linux-security-module@vger.kernel.org>; Sun, 04 Jan 2026 23:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767599219; x=1768204019; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0hl/znACV5IliyiNlDparHEHtCKNFypJX8ag2u4d1hU=;
        b=0a9JbC/0BW2at7gPpJHhyjQp+uXmZ80Lz2+OslH97517U6vIbmTFJ5DMOpJixpSlAW
         rVXEwU8WATs7p5iqd9rooS3BqCTxw8PUYIN7h3JU4bqXUKrWUI6IPJsRscHDejuhRXLy
         2MIXvcGh+LcKUh1+17pMAY1gHM2YhsDa2SbvSZ7kAQDQvwutp7V96tMzJiiHDbUwJeyc
         XVRf7inuBpfWsqqe0AnNnkMTIxSgSqpcVuzseG04wnauLDXWdr37OeJhO7xnkYabGMx8
         5b1Ogq0mABL4AEo4WnwETdwgLv8my27z+cBjfEaPzToKbqenNjD9uNj4yHxfEu/bbaI/
         t6DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767599219; x=1768204019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0hl/znACV5IliyiNlDparHEHtCKNFypJX8ag2u4d1hU=;
        b=vKMybk/DlLpsKUL74XH7ojS4z/mUvptgU+t+LsRo88Fo8TIUPfNucgK0pfSUFADRbR
         4dUSOZJ6PtkfekT4pcgoW3s21Xnm8CEmB37I66HLvsOhTNEkIwxNTW9vAujwShqwbgTa
         nsdIK35ybPoaBzON5qMTs/FmATCdmluknU49mr7gcntR2KvjqPzPhiYNNJyzxGXAj5aR
         7ZCSnwVpSo2tyigYcd9FTE6gNtxajZaeeydfOiNPZQOuQjZ/UWwXxnBIbU+i3mCZCVg+
         w5UL/phW5nIMIp4nvRmKyit8zYH5FBRyFBnbMVpqUAahID5wvM12heWfPxXdlA0MCfEm
         MnSA==
X-Forwarded-Encrypted: i=1; AJvYcCXgFvkN3F8SrUOJcR0jNWhYNscliY7t5FIrB0161m2kmO0SdDAJDt8JkbezbSYx6RgHeg7/EGvQ+xpOPOvBqnpqQBpqYtI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4j7wllX7auVnuvJXFB63tna/6SU55f0uNtRWnXQu+qjUXpDHe
	ZdYjxQrGkRYmtkecmYp8XQeekAZZpW/hOJl2sDjmZ7K8Gr9um6PVOrf5pS7o43GuB3DiELaVMmy
	S8BMda3Fdg7j3vIoIVOeyMz3pn+dq3+uMlsjSmTYx
X-Gm-Gg: AY/fxX4eSCHSR6weLH+xXMPiZ6KlQGUmBNhGNf4hAVQHn2jWLZFczfqWLH5Ip/eGf18
	BdkZJ4ZB7cdyhJubkCDan77dgoemZJHjKOUpD0KFsE91sKygzjkEUsi4nUcxIaUv5IviCjUaxTf
	XcZwxv8WuWqfQJ5RwLz6Hei2WFuqtne7ownTnbdxoMGml1N4W+CMo0wEgT5xu0w2epRmbN/j3W+
	BCToSnKR/mn01A0TIagQkH4wmaNO45hoP5c2vyjATo8tBXvcRXD3rcMj7LT6MFPl4KeRLyZ41qZ
	a10gWNvGHoUX+9BKAiQIIfoOFMA=
X-Google-Smtp-Source: AGHT+IHxteqHEVR6ADiPEOJqOaSNR6YKK2EGsZu1qZi7806i1GlWLIGb3zdwJ5ibA+pr3tr52Iqt+hLN3UxY0p3HaZQ=
X-Received: by 2002:a05:7023:a84:b0:11b:9386:8262 with SMTP id
 a92af1059eb24-12172314a24mr41233873c88.47.1767599218282; Sun, 04 Jan 2026
 23:46:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251231213314.2979118-1-utilityemal77@gmail.com>
In-Reply-To: <20251231213314.2979118-1-utilityemal77@gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sun, 4 Jan 2026 23:46:46 -0800
X-Gm-Features: AQt7F2pSIYBhYKUUMLWFXkv6Xu3AJ783nK6ntuzPyxaCJG9HeDmOp4yEEmYENqQ
Message-ID: <CAAVpQUCF3uES6j22P1TYzgKByw+E4EqpM=+OFyqtRGStGWxH+Q@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] lsm: Add hook unix_path_connect
To: Justin Suess <utilityemal77@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Simon Horman <horms@kernel.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	linux-security-module@vger.kernel.org, Tingmao Wang <m@maowtm.org>, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 31, 2025 at 1:33=E2=80=AFPM Justin Suess <utilityemal77@gmail.c=
om> wrote:
>
> Hi,
>
> This patch introduces a new LSM hook unix_path_connect.
>
> The idea for this patch and the hook came from G=C3=BCnther Noack, who
> is cc'd. Much credit to him for the idea and discussion.
>
> This patch is based on the lsm next branch.
>
> Motivation
> ---
>
> For AF_UNIX sockets bound to a filesystem path (aka named sockets), one
> identifying object from a policy perspective is the path passed to
> connect(2). However, this operation currently restricts LSMs that rely
> on VFS-based mediation, because the pathname resolved during connect()
> is not preserved in a form visible to existing hooks before connection
> establishment.

Why can't LSM use unix_sk(other)->path in security_unix_stream_connect()
and security_unix_may_send() ?


> As a result, LSMs such as Landlock cannot currently
> restrict connections to named UNIX domain sockets by their VFS path.
>
> This gap has been discussed previously (e.g. in the context of Landlock's
> path-based access controls). [1] [2]
>
> I've cc'd the netdev folks as well on this, as the placement of this hook=
 is
> important and in a core unix socket function.
>
> Design Choices
> ---
>
> The hook is called in net/unix/af_unix.c in the function unix_find_bsd().
>
> The hook takes a single parameter, a const struct path* to the named unix
> socket to which the connection is being established.
>
> The hook takes place after normal permissions checks, and after the
> inode is determined to be a socket. It however, takes place before
> the socket is actually connected to.
>
> If the hook returns non-zero it will do a put on the path, and return.
>
> References
> ---
>
> [1]: https://github.com/landlock-lsm/linux/issues/36#issue-2354007438
> [2]: https://lore.kernel.org/linux-security-module/cover.1767115163.git.m=
@maowtm.org/
>
> Kind Regards,
> Justin Suess
>
> Justin Suess (1):
>   lsm: Add hook unix_path_connect
>
>  include/linux/lsm_hook_defs.h |  1 +
>  include/linux/security.h      |  6 ++++++
>  net/unix/af_unix.c            |  8 ++++++++
>  security/security.c           | 16 ++++++++++++++++
>  4 files changed, 31 insertions(+)
>
>
> base-commit: 1c0860d4415d52f3ad1c8e0a15c1272869278a06
> --
> 2.51.0
>
