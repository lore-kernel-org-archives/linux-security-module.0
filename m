Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8820224D2
	for <linux-security-module@vger.kernel.org>; Sun,  4 Feb 2024 15:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707058841; cv=none; b=KZ9W/ufVaFysUSSQjw5AlmVuav+qjMK4aM0a6PRs0Fh92VU6QltZ6CqlPkL9Xi6dD4E/oQwr8o7fiUhTH7SMduj8cYgPFXoGl0fUk+UU5H5w0j+5eCZOH0gtRx3EIQ6gVNOFvdeBS+0wYQRZdkzvxf2HneOr8mappIMOIGSggdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707058841; c=relaxed/simple;
	bh=xdSeQvV05nn5L8vGt2d4VTs22D9fCwHOm1ANUT2yxn0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B1BDI1QaeMYQVLCoRnXiovygHCxO8p7XH35Cj2W1Ff5EJUIOqp0epDiBsnEV1WpL5BCDhMWousoMgrnmPJzcrRMW/YCMM+LDv3w72g2iRNJMDv7oT6Jm7XfdnbAATD5r9vx2Zt6krxLSTzIgcpADxDpDFYCmNk/08EKQ6CcdyHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=dUGOJxVv; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="dUGOJxVv"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dc6da01f092so3001456276.0
        for <linux-security-module@vger.kernel.org>; Sun, 04 Feb 2024 07:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1707058839; x=1707663639; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d3lqw9guILXTXW+HHup3WqoC7VU2sfl3wXM0hqsaEkk=;
        b=dUGOJxVvIFyaOE/esF1lx2c/aJ8UIlpFFzw9Bugjv00/V4xjDrVUKwCxRoEKGliqvy
         qpAKBABK/CzRE9rMS2V62znJ9uL8vD5BpUOL11NkesMvPY5+PJDCiVSw1ui0Y0Ivr2N1
         EiMTZzUMUiREpK7xPsbXBuseqsRNybWg9Ch9XbKZjdlNQAvIxV4qITYgjrHBwn49B9rw
         F7GoWMm+Vb3IQrzVrhcRwxgim35KIPEsS4WybNbSaNitkU/Qd01OV1Q9V1fy0iWx7kJo
         JIhDGqOuoz3urEvcR7m68E8b0wfCOE8DkIA6tD4fzelxHvF9QSy8tIvM+ZKy34RPHZJQ
         T6wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707058839; x=1707663639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d3lqw9guILXTXW+HHup3WqoC7VU2sfl3wXM0hqsaEkk=;
        b=jUEKQbVAxcQRTrS/aZvGJW/8S40MjSs65Lcp8aTiyeX3kdupHWOVQwpqjBY6xB6NnS
         CYvtke9uWv51RBdURIcjmvyp3sDryj6SwOrl3qzIA/ReFhslR+7O8TNGHhbfh2OL3JQq
         J50BSOL/TPVPkDVu/vkMaOpiIGoPfVhgZ2lkEkX0zotpCcLeVcwG5sLoqBTKBU/lwNnU
         nX8gGMHb52OaxgJp53489upMKBgeJeYH+WgyxvccZUaTWQmA0zdJ1N1GVZehpt5FLouX
         tZV5eeWXrCd7nKW2XQdbd1FbyedbczPrHTWhouM1uUuZmtxmNqpwquMENHJCVIJu4GSt
         110A==
X-Gm-Message-State: AOJu0YyxUwKtWGPD/Cv1lVaeS9o443O2UJ8M2KbP4iU63MV43am0wJ7A
	tKt7reWao5BasSYcBzb5TnYWVNSdJ2n0CdTvrALLzU9dXMQ8KnrU2jE0/mLnKstfXadE3rmoZ25
	YaWI5wl0l/jcXTuhai9sNOSwmHg8Dg8PhwIk7
X-Google-Smtp-Source: AGHT+IHg+0gPpQzlZZ3TALwjYC82frTLQELFYbkrSVOd3QmDViI01eEHMCvlkaUcUAORp4NaJVjUuqgO9iSCHdLFGqw=
X-Received: by 2002:a25:e08c:0:b0:dc2:46ca:e968 with SMTP id
 x134-20020a25e08c000000b00dc246cae968mr6398171ybg.4.1707058838640; Sun, 04
 Feb 2024 07:00:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240204023531.2225264-1-dongtai.guo@linux.dev>
In-Reply-To: <20240204023531.2225264-1-dongtai.guo@linux.dev>
From: Paul Moore <paul@paul-moore.com>
Date: Sun, 4 Feb 2024 10:00:27 -0500
Message-ID: <CAHC9VhQUkUvpj+c0r3vZvfn7djQ5kuBej9RE2L7TZwfxg-L7UQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] netlabel: cleanup struct netlbl_lsm_catmap
To: George Guo <dongtai.guo@linux.dev>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	George Guo <guodongtai@kylinos.cn>, netdev@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 3, 2024 at 9:35=E2=80=AFPM George Guo <dongtai.guo@linux.dev> w=
rote:
>
> From: George Guo <guodongtai@kylinos.cn>
>
> Simplify the code from macro NETLBL_CATMAP_MAPTYPE to u64, and fix
> warning "Macros with complex values should be enclosed in parentheses"
> on "#define NETLBL_CATMAP_BIT (NETLBL_CATMAP_MAPTYPE)0x01", which is
> modified to "#define NETLBL_CATMAP_BIT ((u64)0x01)".
>
> Signed-off-by: George Guo <guodongtai@kylinos.cn>
> ---
> V2:
> Yes, I understand what you are saying.
> Actually, there is a compile warnings on "#define NETLBL_CATMAP_BIT (NETL=
BL_CATMAP_MAPTYPE)0x01"
> which is missing parentheses.
> ---
>  include/net/netlabel.h       | 7 +++----
>  net/netlabel/netlabel_kapi.c | 8 ++++----
>  2 files changed, 7 insertions(+), 8 deletions(-)

This is a much better approach, thank you.

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
