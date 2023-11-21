Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="TQUbB6ek"
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD8FED1
	for <linux-security-module@vger.kernel.org>; Tue, 21 Nov 2023 15:52:17 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-da41acaea52so5791663276.3
        for <linux-security-module@vger.kernel.org>; Tue, 21 Nov 2023 15:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1700610737; x=1701215537; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=erXjJV6zalLjMGClDTXisX88n6EbGy4UAR+wJMjOZdE=;
        b=TQUbB6ekq5x49Ic4SKrKmp+79a8bFYG1TSlNgK7lTfe7AqpIbuXbXQFK4ty1a0JHMq
         mQVQn5lw093OZSd8eXS8WuDKwrzxkLTctzxcmz8mcnIDHUZMw/Y3c/3VrZSoDq81SbUG
         zAWg/9hC78WJlLZxZzxobLSXrJpBTXTarXTATMXGyedeBqQTh+EIdc9IE3KQJf50ZCJ4
         mVoN0Mw9sfAIwRQ1zXIaMGcRGQglo0mgqVZuEG4mQ7HERK/rd8aRfSVnAi/O6I2CtxyF
         1bq6CLYwJJgO8ZsBZSfOJAg6XQ2BleR9++FhSNIUWDYltbmpPwC4FY59pXFtXH8d9as9
         E6TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700610737; x=1701215537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=erXjJV6zalLjMGClDTXisX88n6EbGy4UAR+wJMjOZdE=;
        b=VosymBYOO1kT9tqAmgHNQP4OgNuobHooqT43aQBIZxFWd5Wicim/GZRxYVrqsxSDb8
         zdOsQrSpwOaCYknWRPtneLlqxHppC0sbpjyyjiPIpdcbRDCJ7PSOlWEi1vOY9HFG/X7i
         IQidskvbLIwJ+CEmyPdOfaQqUmjIMJVUCG7YYt302G8uZhKpjLSUWIhj0P0b8fkbBvt7
         pDSbmk/JwdS0jEzEc4bATJ0oxCP2yyrmlP5pkykiGSWMLcWuDt9B1FbmcdHzkzP5ASoU
         MJuo9dAa5lj6H+Es8DkbbpLI9IWRmSYe1Nr6aL5ccsKbVgrz1gUmUeSTSm3hKQ9RAyan
         s4jQ==
X-Gm-Message-State: AOJu0YzGUUiH1w1aUDqvHxS6SCbDmUPm3U8kgkjCLRz8wZ793ID/N+ZN
	LhAxn4ULQHngzsmYoRTH9GJSM5S1/yIFvdEtaoG6AxjW8+wjjdE=
X-Google-Smtp-Source: AGHT+IFefvbfl7VtV+3wG5n3/9jAN38sXGW+jfAA+aGBZWbqCT8ZlIIsMjq/LUJv0L1htEpeLmLNi+BNckudVJLXbxw=
X-Received: by 2002:a25:848b:0:b0:d9a:6b48:db71 with SMTP id
 v11-20020a25848b000000b00d9a6b48db71mr542373ybk.62.1700610736932; Tue, 21 Nov
 2023 15:52:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231120215917.287595-2-paul@paul-moore.com> <ZVyAOvBQJKTkFB53@srcf.ucam.org>
In-Reply-To: <ZVyAOvBQJKTkFB53@srcf.ucam.org>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 21 Nov 2023 18:52:06 -0500
Message-ID: <CAHC9VhRvK4QmgCQqtPJJ0uKdRMNg8Hanm9WowMrYDTPvi6G-OA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: add an entry for the lockdown LSM
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 21, 2023 at 5:02=E2=80=AFAM Matthew Garrett <mjg59@srcf.ucam.or=
g> wrote:
> On Mon, Nov 20, 2023 at 04:59:18PM -0500, Paul Moore wrote:
> > While lockdown has been present in the kernel for a while, it is
> > missing a MAINTAINERS entry for some reason.
> >
> > Cc: Matthew Garrett <mjg59@srcf.ucam.org>
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
>
> Signed-off-by: Matthew Garrett <mjg59@srcf.ucam.org>

Merged into lsm/dev, thanks.

--=20
paul-moore.com
