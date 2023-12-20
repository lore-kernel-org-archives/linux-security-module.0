Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AA5495C1
	for <linux-security-module@vger.kernel.org>; Wed, 20 Dec 2023 21:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="YCWS/2/c"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dbd99c08cd6so145337276.0
        for <linux-security-module@vger.kernel.org>; Wed, 20 Dec 2023 13:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1703107353; x=1703712153; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gTTb74YZRwuPY0HwKU3wIMO0x9pEEF2I6OsPvxwt2rg=;
        b=YCWS/2/cOlOIeYRpZqMz4wsPg0J+7OKKBnQXxyEA7M4avApYQfqgrcesL985sIq2HL
         Ny+znct3K0292dpWr4bQcmIOUnOtA1ESUGtL11TW3RswWH2bH+lx5eJYcoYU2tyYZ+iB
         w10/p0bqYDNmSxUmeVzeeROSbzB9n4nt5bulF8NuJWbbeIRMQpV7i3g/GuMAK455f9JM
         fpTihHyaMPcY45y9UQG5/72hHmWV7pjpzwKQP6XuC9+WrGznNIhyElATct6I4XrmQEa/
         7sgoeEc2kONQFYgWE3DnqPpV2h44L2rMRyEJ44JhFuOtWeHHrq6PFaK5YhYGVV62Wkyi
         kf/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703107353; x=1703712153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gTTb74YZRwuPY0HwKU3wIMO0x9pEEF2I6OsPvxwt2rg=;
        b=oFXOlCZPjFWOAlCsSGwjfwbatj3j/+67Rd2Zhh1jHvJbqR07tvee20zJq9cns0MJDV
         jNgAhEd8cXr3EAAKdoCZSmGxKSm2THIYi1WjLS0sO8X5+h1r/WKqAJNwxdq3esyfegeF
         Yk04RxfMiJF8LgtGWr9/+xWCbGmlqhfkUzTo2PhLlLzwN8/05BNcQiAdhjgx1GaxOYXa
         fXHjf0bMmtsjw5A+cBherA0UUPTX4PNRjgrnb9indlhZi1p/Yt/qluytt3zuPGyYpj95
         MSeQrQWS018VQuCIF284nQqCqcoWcvaQazscwSqVJRvfePdc/ObQb4EtMY/KXKFxn93c
         IjAg==
X-Gm-Message-State: AOJu0YxLUpe2CCuiqefsP0h7Q4rWSN1t0sjrj7t5Kze/Yk+7tpRguqVZ
	LsIOCvXfnJYRB18t+sC/Be0Qc3S4fLwaPjoFdzey
X-Google-Smtp-Source: AGHT+IGUodO1dp8c+X1v5LwjGVxOv1DeKm4h4wu3cAF4FJiHH6LRI8lz6KVFuJNQoFojDAmv7+HaRyI4mEnxnAYR91c=
X-Received: by 2002:a25:ad4a:0:b0:dbd:7383:d155 with SMTP id
 l10-20020a25ad4a000000b00dbd7383d155mr461235ybe.0.1703107352983; Wed, 20 Dec
 2023 13:22:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230921061641.273654-1-mic@digikod.net> <20230921061641.273654-5-mic@digikod.net>
In-Reply-To: <20230921061641.273654-5-mic@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 20 Dec 2023 16:22:22 -0500
Message-ID: <CAHC9VhQ3fqq6bP=eco1hk=AoMa=5QNyXHCzNw5RZt92y9Z7T2g@mail.gmail.com>
Subject: Re: [RFC PATCH v1 4/7] landlock: Log domain creation and enforcement
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Eric Paris <eparis@redhat.com>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Ben Scarlato <akhna@google.com>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Jeff Xu <jeffxu@google.com>, Jorge Lucangeli Obes <jorgelo@google.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Shervin Oloumi <enlightened@google.com>, 
	audit@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 21, 2023 at 2:17=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
>
> Add audit support for domain creation, i.e. task self-restriction.
>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> ---
>  security/landlock/audit.c    | 24 ++++++++++++++++++++++++
>  security/landlock/audit.h    |  8 ++++++++
>  security/landlock/syscalls.c |  4 ++++
>  3 files changed, 36 insertions(+)
>
> diff --git a/security/landlock/audit.c b/security/landlock/audit.c
> index f58bd529784a..d9589d07e126 100644
> --- a/security/landlock/audit.c
> +++ b/security/landlock/audit.c
> @@ -84,6 +84,30 @@ void landlock_log_create_ruleset(struct landlock_rules=
et *const ruleset)
>         audit_log_end(ab);
>  }
>
> +void landlock_log_restrict_self(struct landlock_ruleset *const domain,
> +                               struct landlock_ruleset *const ruleset)
> +{
> +       struct audit_buffer *ab;
> +
> +       WARN_ON_ONCE(domain->id);
> +       WARN_ON_ONCE(!ruleset->id);
> +
> +       ab =3D audit_log_start(audit_context(), GFP_ATOMIC, AUDIT_LANDLOC=
K);
> +       if (!ab)
> +               /* audit_log_lost() call */
> +               return;
> +
> +       domain->hierarchy->id =3D
> +               atomic64_inc_return(&ruleset_and_domain_counter);
> +       log_task(ab);
> +       audit_log_format(ab, " op=3Drestrict-self domain=3D%llu ruleset=
=3D%llu",
> +                        domain->hierarchy->id, ruleset->id);

If domain creation and self restriction are the same, I would suggest
going with "op=3Dcreate-domain" so it better matches "op=3Drelease-domain"
in patch 3/7.

Also see my previous comment about consistency between AUDIT_LANDLOCK recor=
ds.

> +       audit_log_format(
> +               ab, " parent=3D%llu",
> +               domain->hierarchy->parent ? domain->hierarchy->parent->id=
 : 0);
> +       audit_log_end(ab);
> +}

--
paul-moore.com
