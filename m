Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C345218C34F
	for <linux-security-module@vger.kernel.org>; Tue,  9 Jul 2024 15:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720538343; cv=none; b=cvw+1jSnaeZGdBiKD5l7ohavqHg2cBUZs9kR4Zct9HD/GILMoKIeODHOunaDqpC6wVZG0xzk1TeSPHOlmgDVXqEwpqUaRltpamIOau2+U2avWm+w5VvreMPCkvcUVmMxQ8ZArxNjSjDcFGXDT2ZTnhDtucr7dviLm5hXUbrwg0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720538343; c=relaxed/simple;
	bh=ojN2JmcT7kvuAEXfKcAoFG86zqUA6Rqq1vkhBEhguOg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ry+3agffDy8wQI6ZJQiaqsdr59SLLgOVxdoGZYp4QaM4gzMPA73jAbM5K5NsX0YFQGUwLEBOinWn8+4VXDaBtL0A+TruYVfiwffz09LyTzWB4q3GhYQ5rG157B5O2ozxvPgpELdmPfMPeuiMSiBfRdg92EGRiK4hM3Jt+gTVdwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1RPpgbzI; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1RPpgbzI"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-650fccfd373so82444127b3.3
        for <linux-security-module@vger.kernel.org>; Tue, 09 Jul 2024 08:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720538340; x=1721143140; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WFa9c2fe6FXvwC1bTAk+U1J7rwHtRLarFBf2iyFVXFo=;
        b=1RPpgbzIGzHo3yWZJf4MsJNhfbVGOR5W46lwsH9F7sdjsJc/Q64O2ZOHjRg5AXOjur
         TjOk7MRSlsyr6otXso+gw4UZ4IxGZ7p8XdG0bdRuh/agGo+4nuNkxkz/3jGUxkutCx2P
         EPlgZbQgRmvW1vFhiTocAtPbl3fAiivnzqFDJkp1njpS9tkhLMsBtjCvu8VFdy18ttZo
         W3vkT6Rp+puih+IBWSyrijQ6vyf2+2gitNeYtZUWxptbb5xUnJ6UU9jCzlh3dTllU0xC
         JtQ6UU/Ra3HHthOAtekVePEixR1y9ZrKPzlHTJP0lnlqn9zb8hzgvblHGyEsz2xcBzfH
         F+PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720538340; x=1721143140;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WFa9c2fe6FXvwC1bTAk+U1J7rwHtRLarFBf2iyFVXFo=;
        b=Ue7IDXNy8sIXlC42dINnw6r4ocvd//Ej1pHuOVWq79ArG/nsc4qTi31O44RV+NQE2O
         glObbFTy7cPymr1+7u77yQFE/Q72CwRnwXI0tCrWlezOV2+bEv0/RWGe/KzWPIU6Idsr
         5S/xYgq48uWnXgzbed+IZ5tKOcfiHr737Z93BhjjBd1IFJIB/UuuYV21nR7RbAZspDOV
         92DE3uAcDu45AFCg7gctbSbbArBjoIaW2O8+phoaINbSNXwGHDZR2y7Cw7G4UfKlL/4K
         x5v58d+33ne992vo8tmR6sqNo3ceHvnOKxl+frICJXkY2qWkdVuZwkveO0ZzFlTWlPg8
         ZxxA==
X-Forwarded-Encrypted: i=1; AJvYcCUlNIizQR+aMO2UcluwFbOaWHayG5EEHTXGxhjIDQV1/ithZwZSelIl+zCz6oluS3SjYt44AJLVVXu6ARrN1twlwKSw2lo2G8g+qbt6HCktde/QNW9K
X-Gm-Message-State: AOJu0Yw2bR8+Shy0ISkW6yMclmDd4C2awapphA//ZMU6Q6oJQIgoHngU
	xk7D5AeV1vUmbqyKGaTOxKlZLCdBKByby3x1ye6RcRFkIreg1xNDlxvriT1iIcdfzGFJTzpcBTU
	LuA==
X-Google-Smtp-Source: AGHT+IG6s2DL4z5jJ3caJ1nyKbichgc+9treufuJXMxHE5/JSZIsXGqVg7GvHDIihpvMghDuHrXil7HRN0A=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a05:690c:46c8:b0:62c:de05:5a78 with SMTP id
 00721157ae682-658f01fd061mr279197b3.6.1720538339849; Tue, 09 Jul 2024
 08:18:59 -0700 (PDT)
Date: Tue, 9 Jul 2024 17:18:57 +0200
In-Reply-To: <70756a7b4ed5bd32f2d881aa1a0d1e7760ce4215.1720213293.git.fahimitahera@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <36958dbc486e1f975f4d4ecdfa51ae65c2c4ced0.1720213293.git.fahimitahera@gmail.com>
 <70756a7b4ed5bd32f2d881aa1a0d1e7760ce4215.1720213293.git.fahimitahera@gmail.com>
Message-ID: <Zo1U4dX-kGcm0hHA@google.com>
Subject: Re: [PATCH v1 2/2] Landlock: Signal scoping tests
From: "=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack@google.com>
To: Tahera Fahimi <fahimitahera@gmail.com>
Cc: mic@digikod.net, paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bjorn3_gh@protonmail.com, jannh@google.com, outreachy@lists.linux.dev, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 05, 2024 at 03:21:43PM -0600, Tahera Fahimi wrote:
> Signed-off-by: Tahera Fahimi <fahimitahera@gmail.com>
> ---
>  .../testing/selftests/landlock/ptrace_test.c  | 216 ++++++++++++++++++
>  1 file changed, 216 insertions(+)
>=20
> diff --git a/tools/testing/selftests/landlock/ptrace_test.c b/tools/testi=
ng/selftests/landlock/ptrace_test.c
> index a19db4d0b3bd..e092b67f8b67 100644
> --- a/tools/testing/selftests/landlock/ptrace_test.c
> +++ b/tools/testing/selftests/landlock/ptrace_test.c
> [...]

> +static void scope_signal_handler(int sig, siginfo_t *info, void *ucontex=
t)
> +{
> +	if (sig =3D=3D SIGHUP || sig =3D=3D SIGURG || sig =3D=3D SIGTSTP || sig=
 =3D=3D SIGTRAP)
> +		signaled =3D 1;
> +
> +	// signal process group
> +	//kill(-(t->pid), SIGKILL);

There is commented-out code like this in various places in this patch.

I am pretty sure that scripts/checkpatch.pl should flag that.
See https://docs.kernel.org/dev-tools/checkpatch.html
and https://docs.kernel.org/process/submitting-patches.html#style-check-you=
r-changes

I personally just keep a checklist of things to remember before sending a p=
atch.
(rebase as needed, clang-format -i (for Landlock files), run tests, check c=
ommit
metadata, git format-patch with -v and --cover-letter, scripts/checkpatch.p=
l,
edit cover letter, git send-email)

=E2=80=94G=C3=BCnther
