Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D98914EC51
	for <linux-security-module@vger.kernel.org>; Tue,  6 Aug 2024 19:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722973054; cv=none; b=t2Icpth5AwUDBXY0ini44+uNNg+hOrvSksAH2XMgk2a2+/S1oJsrWKglEYcYU3NsFOtb/P4rQIz0wdo6FAnyaFHuEy3l9bSfCAgAjEZMtCxfhtGIpCDBv9v5Mxl4qlHKn0G9GsTqNlaDmHd8YWU58ta36nB2EG0CxCjj+cSYKLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722973054; c=relaxed/simple;
	bh=FY9WL5Ew4UpGjqQRe0kjOd5ck/2a2WaUZo90dYASdOI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pYDA7go4x5LP7z8iwJ34HaHXDcVyFgt/OzW1f/ndeOQwXcR0jbZZeMhT6EgUgRr/l3Mipgdk1A+q8eYfGqPvtWxIPZBSMhya/Wtktt9aQNxwB3jiKs8zPFJqJZYzi7EiI3r1riKKvKw/vNMU66BjyPFGuA9Lty6OeibIG4yIfwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OMzonwQ6; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OMzonwQ6"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5b9fe5ea355so21406a12.0
        for <linux-security-module@vger.kernel.org>; Tue, 06 Aug 2024 12:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722973051; x=1723577851; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f8uEFO9W2+FLhm25gWiA80kftcKB1qkyC9ekZLOIA6A=;
        b=OMzonwQ6TaZPj3Q1ucGu7ke2nD9cx6vQbfrEnilcNylVMvSZDHnCedJlKy+hjalzmb
         Fd5PbI6aKTdynVXKOIyWgVoiFHh+1e95eCz/QHHnKcU9f7ULkx9JNr8nFbmYX0zbyA3K
         KgeEnuDa+t1hI0/yZGc0NjlByhFnIfoSXuiMWP/2A2c6c4BcOmQaMPXagTTRakEdO32s
         7d7vLUKGNniPxzHW8hLYza1aFQHptP8Zxgz4Oa3kYnbcCYwzRD2r4cpNoHTWi69J7h8o
         iU0YG0uKDdAMDYBwEXALrwMhfOaVVyjw/fG6RniAS5KpmuxqGRisAykV6MWH/8IzN+qt
         tT9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722973051; x=1723577851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f8uEFO9W2+FLhm25gWiA80kftcKB1qkyC9ekZLOIA6A=;
        b=Hv1H8zRTwEOmOLPYQgeUYwdt2oaZJhvPhFw2/JiSkRlaMD4+PrOQQGpJ5zUQ4gznAK
         UNgLFxVPxGG5/n9c5YRI5qe3hr8HJueKMQYBFZ2JqaaIaQSdYtCAOXUjcFefEI47Di4b
         zxngdxFWiH5/ylrus+1NY43CAcO15tJs7ujneDkQEg6DQhowNvaw8sjFExNPQyeZDX1Z
         KSfC1aDEGN8rLHKpqe2eFnSrSuSe5ySS9SpiFjRqJaWnqgC/arZiOlAKVF+pn3GEQa2V
         t5vQCX8KGMxHsI/HlouZxOXLopbD/GfDqlQNNkb/hs2VP9rSN9+WD8bNQ6QbtXLK5oGQ
         e2zw==
X-Forwarded-Encrypted: i=1; AJvYcCWeOI/142jhBhkYgqKIO3Z9aJLyNtVRjs8ugdkuYDQFoWA7Etgw0i05lZb7j6zy/PIrBRpCECrFk2S3LkNnbVBl5hnyqHn4N2Uhne/rrnMRM2ddBUOQ
X-Gm-Message-State: AOJu0YyVrRUgrMY1SWVLepMmEgn8LZhequ0Raa0VCaOFSb4TDq6PeUHS
	3Y/x8oO3/xNSwsLZ2/lyE0jjOEXoZkiYfHWcjxsUZ5Yd+Iy8gZabPmykE1AgOzHin57xj8JQK+s
	AP+p2Im2LrUcIx20movUUuDXwcxah6SXVL7oq
X-Google-Smtp-Source: AGHT+IEW1GMKFCD4DKnyeN084/kX07o+WDR9IdrRnzwMCqQYEsxnNt1QCfmcpRWNQ2zFJ7nrXEKfvAxnQsHp0cWnkXQ=
X-Received: by 2002:a05:6402:84c:b0:57c:b712:47b5 with SMTP id
 4fb4d7f45d1cf-5bba28b2757mr28024a12.4.1722973050127; Tue, 06 Aug 2024
 12:37:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1722570749.git.fahimitahera@gmail.com> <e8da4d5311be78806515626a6bd4a16fe17ded04.1722570749.git.fahimitahera@gmail.com>
In-Reply-To: <e8da4d5311be78806515626a6bd4a16fe17ded04.1722570749.git.fahimitahera@gmail.com>
From: Jann Horn <jannh@google.com>
Date: Tue, 6 Aug 2024 21:36:52 +0200
Message-ID: <CAG48ez39+ts9pNVvAxXcbk6X5_+s_yBXPUW-ZUNRxQq3aJAyrQ@mail.gmail.com>
Subject: Re: [PATCH v8 1/4] Landlock: Add abstract unix socket connect restriction
To: Tahera Fahimi <fahimitahera@gmail.com>
Cc: outreachy@lists.linux.dev, mic@digikod.net, gnoack@google.com, 
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bjorn3_gh@protonmail.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 2, 2024 at 6:03=E2=80=AFAM Tahera Fahimi <fahimitahera@gmail.co=
m> wrote:
> This patch introduces a new "scoped" attribute to the landlock_ruleset_at=
tr
> that can specify "LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET" to scope
> abstract Unix sockets from connecting to a process outside of
> the same landlock domain. It implements two hooks, unix_stream_connect
> and unix_may_send to enforce this restriction.
[...]
> +static bool check_unix_address_format(struct sock *const sock)
> +{
> +       struct unix_address *addr =3D unix_sk(sock)->addr;
> +
> +       if (!addr)
> +               return true;
> +
> +       if (addr->len > sizeof(AF_UNIX)) {
> +               /* handling unspec sockets */
> +               if (!addr->name[0].sun_path)
> +                       return true;

addr->name[0] is a "struct sockaddr_un", whose member "sun_path" is an
array member, not a pointer. If "addr" is a valid pointer,
"addr->name[0].sun_path" can't be NULL.


> +               if (addr->name[0].sun_path[0] =3D=3D '\0')
> +                       if (!sock_is_scoped(sock))
> +                               return false;
> +       }
> +
> +       return true;
> +}
