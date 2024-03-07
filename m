Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7344912D778
	for <linux-security-module@vger.kernel.org>; Thu,  7 Mar 2024 15:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709824537; cv=none; b=QrltE4SGG0cnekUH9bbZ8jJNpU86YSlCqnrsgOhkrJ6yV7ajQlSFZo620rMTPS8dEcJBqxeeuodZNTkmF1wH2TZNqRpIxPu17NOfAS/J8aZ0vlwic2ZkDmoF/AgVDe3H4YYcAeLHWsr1ZN2nXNsI25n5q1kE3q6SRU6KB+VfDX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709824537; c=relaxed/simple;
	bh=pfY9J0g4xyv2pAK6fRjy7mEhcoycH/GOvGuj7q9mSxY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BHo4/nDLTw8DvcUPo/OSQWfCka3wTbF2fi/0EVAetiEvcPd8bHj/clmLBoU6s7/vVfQKeJ+mLMV8aOmNwwYmTdXgwy8nWsKUp2NiSQntb0fDMDX7ibTosdybsTPKSGVfHRWQJni9tTS8vdD/IHODSKtgi2+LYQck8QofJzcRdY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OiwEUdvM; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OiwEUdvM"
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-567eb02e45dso914702a12.3
        for <linux-security-module@vger.kernel.org>; Thu, 07 Mar 2024 07:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709824533; x=1710429333; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=njnVJ9Lw8AENvPRhnL3cISikH1G4fJntPjeGIXpieAU=;
        b=OiwEUdvM3ahyOhx84v313DFCEYBqLuUncxu+deY9P8iDrRs1cMByJuDK2jXkfMOq9B
         jfuKx51vBPvqAeD+YQH7RNqoaaWuaNVRT4WXVz8skEvbSOQ38H7grggJ1vwMAkWReDB4
         665Z8nFmevKD7B8wexVOS6pOFFeBm1k46AG8YZOuGEB1Scq7rrvLrh15JMJK6KvjvpgX
         EjCDYx+mE43PDmbPyCtAK6MZgVdOaKk2esD8N8XKb6+F14x1h1CkRccodkEfnquBAq7y
         F8kTGmqdyf8hjfb+NoPzyPTiZDDPDe6+Jyz7DeZwsY12y7+DSxxP8Ua3iCGSXXAH1A1U
         I0Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709824533; x=1710429333;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=njnVJ9Lw8AENvPRhnL3cISikH1G4fJntPjeGIXpieAU=;
        b=QXA/+0Ea8KAFVJ8xMH+PFUM2WV+EY1KV1Pv+k/GssXdamSjAF5ouKTNCGMEisDz2zR
         66fPZyP6Zf2LnlRHKrWlS1cXCdWFcfoV20MH7u58CrgvF/qy7uEuHPgeuSeUuQxOgCie
         c37epH5d60O1XAm02xl03XBO3JoTq6XF1kQ3BDtjslVqygDd1HD705QNSRN7TnRTranz
         vpfJ1tCZ+eEQumrp0oEWEhTBR1bCBuduCCIUo/3bLDDUX0HsZ3hM0VLOiqxbA3nGYCzr
         VJvxVCL+TDkGDxzVqE7aqizbPrOz49685AuxMlK/IKMzUMeC7C59EDiTruV3a4WDihFH
         b1EQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+4C6sRrlHSmMfdkQjVE9IQJu55qm+e8eqe0S9btNLZ5cEzi7E5rlWaemmoDjLK6HWl9wHqQjdQV67CK2GALAN1zrBgYcCYrEF1bMuYCPK05NHtYwb
X-Gm-Message-State: AOJu0YxOpT1FRkXbn1W3DpJlHWM66R2dJZ7y1gg0PKEF1T1oOByRUvYM
	S384ZFPZgv3CRfE2/NPQsw9Y433PoDExrrqRCbysnRG6SLDq/+jeX/+MvncgUQkNOReZbWwJScJ
	Dvg==
X-Google-Smtp-Source: AGHT+IF+EDkDfZT2I31rUYUIOorSZU/di3KvNcdUMx15LLKt0pn31IhCWiOJTAlakdL/5OGrZwgQ6TJoCVk=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a05:6402:4490:b0:566:649c:fb44 with SMTP id
 er16-20020a056402449000b00566649cfb44mr82edb.1.1709824533350; Thu, 07 Mar
 2024 07:15:33 -0800 (PST)
Date: Thu, 7 Mar 2024 16:15:31 +0100
In-Reply-To: <20240307143849.1517218-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240307143849.1517218-1-mic@digikod.net>
Message-ID: <ZenaEzgGLkmwILUO@google.com>
Subject: Re: [PATCH] samples/landlock: Don't error out if a file path cannot
 be opened
From: "=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack@google.com>
To: "=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?=" <mic@digikod.net>
Cc: Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, "Serge E . Hallyn" <serge@hallyn.com>, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 07, 2024 at 03:38:49PM +0100, Micka=C3=ABl Sala=C3=BCn wrote:
> Instead of creating a hard error and aborting the sandbox creation,
> accept file path not usable in the LL_FS_RO and LL_FS_RW environment
> variables but only print a warning.  This makes it easier to test, for
> instance with LL_FS_RO=3D"${PATH}:/usr/lib:/lib"
>=20
> Print that we are going to execute the command in the sandbox before
> doing so.
>=20
> Rename "launch" to "execute".
>=20
> Cc: G=C3=BCnther Noack <gnoack@google.com>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> ---
>  samples/landlock/sandboxer.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>=20
> diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
> index d7323e5526be..22e8c35103ce 100644
> --- a/samples/landlock/sandboxer.c
> +++ b/samples/landlock/sandboxer.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: BSD-3-Clause
>  /*
> - * Simple Landlock sandbox manager able to launch a process restricted b=
y a
> + * Simple Landlock sandbox manager able to execute a process restricted =
by a
>   * user-defined filesystem access control policy.

Slightly out of scope, but I think it should be "...restricted by user-defi=
ned
file system and network access control policies."

>   *
>   * Copyright =C2=A9 2017-2020 Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> @@ -121,9 +121,11 @@ static int populate_ruleset_fs(const char *const env=
_var, const int ruleset_fd,
>  		if (path_beneath.parent_fd < 0) {
>  			fprintf(stderr, "Failed to open \"%s\": %s\n",
>  				path_list[i], strerror(errno));
> -			goto out_free_name;
> +			continue;
>  		}
>  		if (fstat(path_beneath.parent_fd, &statbuf)) {
> +			fprintf(stderr, "Failed to stat \"%s\": %s\n",
> +				path_list[i], strerror(errno));
>  			close(path_beneath.parent_fd);
>  			goto out_free_name;
>  		}
> @@ -229,7 +231,7 @@ int main(const int argc, char *const argv[], char *co=
nst *const envp)
>  			ENV_FS_RO_NAME, ENV_FS_RW_NAME, ENV_TCP_BIND_NAME,
>  			ENV_TCP_CONNECT_NAME, argv[0]);
>  		fprintf(stderr,
> -			"Launch a command in a restricted environment.\n\n");
> +			"Execute a command in a restricted environment.\n\n");
>  		fprintf(stderr,
>  			"Environment variables containing paths and ports "
>  			"each separated by a colon:\n");
> @@ -250,7 +252,7 @@ int main(const int argc, char *const argv[], char *co=
nst *const envp)
>  			ENV_TCP_CONNECT_NAME);
>  		fprintf(stderr,
>  			"\nexample:\n"
> -			"%s=3D\"/bin:/lib:/usr:/proc:/etc:/dev/urandom\" "
> +			"%s=3D\"${PATH}:/lib:/usr:/proc:/etc:/dev/urandom\" "
>  			"%s=3D\"/dev/null:/dev/full:/dev/zero:/dev/pts:/tmp\" "
>  			"%s=3D\"9418\" "
>  			"%s=3D\"80:443\" "
> @@ -390,6 +392,7 @@ int main(const int argc, char *const argv[], char *co=
nst *const envp)
> =20
>  	cmd_path =3D argv[1];
>  	cmd_argv =3D argv + 1;
> +	fprintf(stderr, "Executing the sandboxed command...\n");
>  	execvpe(cmd_path, cmd_argv, envp);
>  	fprintf(stderr, "Failed to execute \"%s\": %s\n", cmd_path,
>  		strerror(errno));
> --=20
> 2.44.0
>=20

Reviewed-by: G=C3=BCnther Noack <gnoack@google.com>
