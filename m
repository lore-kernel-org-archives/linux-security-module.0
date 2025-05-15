Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F72B1E1DE2
	for <linux-security-module@vger.kernel.org>; Thu, 15 May 2025 14:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747319769; cv=none; b=TMgAguMLU4l7xV1eKfczUmtSjWZtwWbCxwwcdrmpx2NTbfHG9Erooo2jlKrxzWu/nDLVNYMDHxzW0eJB51DRujSZsBMgMeMztT0u7+5XV6/SkmFUOkKfAI5qLvZ0n7mVBIynnw+qYEGw5i8NhkeVznfX8X3+H2y6tpojM6a2VFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747319769; c=relaxed/simple;
	bh=LkwzEhK4YQ+y4ydj2RJEeVreHzqorQrGCeShw3Gkmrs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kyPI75D90nJNZYbuByAW6ji32qZZaQqQeybC4AOntcelZm+C9uLo8VKwNJvtJxDrpjZKVVeBPORRfbqOE1dVEOswnjHKpoYg8BrQIuE6lFL3REk+eE03xFFkdSxVX3MB4CA3pBeXgXGCu38CqqXG6OwYxqJCDlwFuuntRp3lA+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=QBA7431C; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="QBA7431C"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-54fcd7186dfso1179260e87.0
        for <linux-security-module@vger.kernel.org>; Thu, 15 May 2025 07:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1747319765; x=1747924565; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jfHo/+rR2MB5NBA0pbyumj+N88FH0xRlivNxbjV7rwA=;
        b=QBA7431CGUeD+fibjQBsXkMd6BNNd+HNMBFqif3znoO59QdgwmWwotzF2kQaSxR97u
         RFURYC+rE5GKIykbTifdwIAv8+ZDl1aCbupp9fP1AznMFXulUn0WgN8MNhaZ9/sD9IeD
         3EBcLEZ0rrq4wE8rzKENlf1b30zs1gIO413BE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747319765; x=1747924565;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jfHo/+rR2MB5NBA0pbyumj+N88FH0xRlivNxbjV7rwA=;
        b=acmS6M2NWOqtJ1wBKqUlRxgZ6PuSHMoIl/zxh+jSGFO/cvUKkS67vuLkgKkDrccchy
         roGJbNhtc0NxisPEt+A+xO9nyDSy7/Q8J6HaBFKMPJsv5p0w7V+GQxjchZk/XPGaexMB
         hjfbx+Tmg8jyLVxwcYeOKOTl0uoxNE+WmeginZBJGvBrSlhQ+4NCRyRj/E/qJD6UbTTG
         BkqCU5GgMe5oZR5u3d/etcANVnYsM0D8vcn6KIATNBL11NLtYVAIYkQ9sJhyMYoyBJ08
         aDdpLYtOphQQEYggEf8tmI6gHbqowXlac+Y82H8yy5XaaUMognSJZ5JI7vHM5/r5W3LL
         Qs/A==
X-Forwarded-Encrypted: i=1; AJvYcCXZcUQW8ZO4MqWKbry5PHqTH0I/OLQCtTD6RkRou+gBujCCr04hLBO6RSOcUeYmWYguqhNhFeLAGuGXRHPVMR3UN/NEerU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw/awdOeB1YuQ1ShW+XOM40/Eu9TvpNNxF2iTsuYmKkH1GyR5c
	DC2Yhz+u5N/if+mIt8QevnBemZSDC0AAWoUYumxRB+kYPdgAQOBflbp09NkH9ph7ZgoFCDDNAp/
	db1p50T4pJIhLpohb/HOvINYzhptlXPXQEdxRiQ==
X-Gm-Gg: ASbGncuVZoru92BlNoqHYrsRdW6DZOfi2n0V9sZo62chWaortBnSuejMWIPGqYjKMIT
	6NlIjYOXztt+CXdyGgYAapK+/+xA6a8lN7qUSbuNDSW/FGtloLpjzRkgkAV5loRHrPucjoJZqbk
	eZxH1r50YLnvvJg4sNv3d75x32bS1P6edP+/l0Mu9jqOzm
X-Google-Smtp-Source: AGHT+IHd1CtZlFuSxAsXnx5Takqv6QZTe2+lhVirdtaDn0cFg77DyP9oBpxqfUMLz0N3QxnnHSEZ6bt+VSdCWoGtElk=
X-Received: by 2002:a05:6512:6d0:b0:549:8b24:9894 with SMTP id
 2adb3069b0e04-550d5fbd6f8mr2818776e87.15.1747319765098; Thu, 15 May 2025
 07:36:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515-work-coredump-socket-v7-0-0a1329496c31@kernel.org> <20250515-work-coredump-socket-v7-8-0a1329496c31@kernel.org>
In-Reply-To: <20250515-work-coredump-socket-v7-8-0a1329496c31@kernel.org>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Thu, 15 May 2025 16:35:53 +0200
X-Gm-Features: AX0GCFvO84s9iCLGUVDHGCypS2YVBJg4ZgjowZGClKY4pjGPNQYODIsSapI_tGs
Message-ID: <CAJqdLrq_MG0z+BMCCxX4EGkSyzz-nOuRc+Z0E+wTHH+98KEs8Q@mail.gmail.com>
Subject: Re: [PATCH v7 8/9] selftests/pidfd: add PIDFD_INFO_COREDUMP infrastructure
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Eric Dumazet <edumazet@google.com>, Oleg Nesterov <oleg@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, David Rheinsberg <david@readahead.eu>, 
	Jakub Kicinski <kuba@kernel.org>, Jan Kara <jack@suse.cz>, 
	Lennart Poettering <lennart@poettering.net>, Luca Boccassi <bluca@debian.org>, Mike Yuan <me@yhndnzj.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	=?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Am Do., 15. Mai 2025 um 00:04 Uhr schrieb Christian Brauner
<brauner@kernel.org>:
>
> Add PIDFD_INFO_COREDUMP infrastructure so we can use it in tests.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>

> ---
>  tools/testing/selftests/pidfd/pidfd.h | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/tools/testing/selftests/pidfd/pidfd.h b/tools/testing/selftests/pidfd/pidfd.h
> index 55bcf81a2b9a..887c74007086 100644
> --- a/tools/testing/selftests/pidfd/pidfd.h
> +++ b/tools/testing/selftests/pidfd/pidfd.h
> @@ -131,6 +131,26 @@
>  #define PIDFD_INFO_EXIT                        (1UL << 3) /* Always returned if available, even if not requested */
>  #endif
>
> +#ifndef PIDFD_INFO_COREDUMP
> +#define PIDFD_INFO_COREDUMP    (1UL << 4)
> +#endif
> +
> +#ifndef PIDFD_COREDUMPED
> +#define PIDFD_COREDUMPED       (1U << 0) /* Did crash and... */
> +#endif
> +
> +#ifndef PIDFD_COREDUMP_SKIP
> +#define PIDFD_COREDUMP_SKIP    (1U << 1) /* coredumping generation was skipped. */
> +#endif
> +
> +#ifndef PIDFD_COREDUMP_USER
> +#define PIDFD_COREDUMP_USER    (1U << 2) /* coredump was done as the user. */
> +#endif
> +
> +#ifndef PIDFD_COREDUMP_ROOT
> +#define PIDFD_COREDUMP_ROOT    (1U << 3) /* coredump was done as root. */
> +#endif
> +
>  #ifndef PIDFD_THREAD
>  #define PIDFD_THREAD O_EXCL
>  #endif
> @@ -150,6 +170,9 @@ struct pidfd_info {
>         __u32 fsuid;
>         __u32 fsgid;
>         __s32 exit_code;
> +       __u32 coredump_mask;
> +       __u32 __spare1;
> +       __u64 coredump_cookie;
>  };
>
>  /*
>
> --
> 2.47.2
>
