Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3510E25D537
	for <linux-security-module@vger.kernel.org>; Tue, 24 Jun 2025 23:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750807567; cv=none; b=G3UQpDNvWXeUZlrcqAw8k6lC93b3jPHG8WVoGc5JaNBmwYpScJfAtgmIAQf0do6R1sHloTDQTRVRJPhFa4T72JG8DOSREorTkNZl+S96c1mpgA9egW6gCzX9eXF5EVqYdqvfHwOuPIg7gNj+trExUp7YCzGAuZA0LckWGuHgLnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750807567; c=relaxed/simple;
	bh=tlQ5FvOMjbX6Z8YhpXnrzKrOO8FlQxeVzUe9JhzvgiY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F361ztdnlehq6ML2YPX3oBYErkQ4wqKBpjAdCl2pXel8DPJHBqvqb+YtvA9YS32rlOiCYe68CeSqmWkKZn72VnLg4O76EuDLJHApu3voTag6jBiruc/KC54CUKDExjd1YzuMoX6AcxcnW8H/0T5zlR8J0e1E3zrsijTQ9GSZBeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=QJerJa5X; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="QJerJa5X"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-70e23e9aeefso9046667b3.2
        for <linux-security-module@vger.kernel.org>; Tue, 24 Jun 2025 16:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1750807564; x=1751412364; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A5KAAp0hg3rI6FMNaXq3I4//0zQjQR1hKb9wxZe7KLQ=;
        b=QJerJa5XSXpX3z0qka1G2FdLIn5C2XLSIGsFBFpTEPkIlUdx++9GV2e4VuXWCszTJA
         9AGXX4NLoP7/U4t1JjJjVvI/tYOBxNsCWJkebJqYyAaXbCZ7ofjYXhqMJNyVPqs2FHMk
         JWoK18nalzr6WA76/MEaLPvgsfjRhT88cWmLrihb122RGbDk9q+aWzdfETbdXVyM3kky
         wlbGzGa0u2QXWKf8vp1jr7b4MNHZ2Vv06SMDH0t3LprWg66xvmBM9lJK1mLF2EBTT2e/
         4J2lobOmCGiTlaRPgrKstWYWCl3BlIvC9Cqm5bClMPGWUPS1jZ7Rp78WBRTBTHM8Ke0C
         Yk1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750807564; x=1751412364;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A5KAAp0hg3rI6FMNaXq3I4//0zQjQR1hKb9wxZe7KLQ=;
        b=GmXd45aeuDJ1TmURLMLy/rWDUZL/W1DAidCf0NgVVAzKh6yvs9k0zcww8ZByC7qJeg
         P94yLZ7tPWpYXRK8NEp0l2YCtHGNk2mGROT/WTouZ+cYVjp41zE1QHxe3zxscW9Gu0Ji
         SjzflW2TZRiitZ0AnHs+NFFWCiLDaFAGXgnx7iAqe5vc/fozgBbXlVG77uu79k4SuejW
         AMen0yOAPIpmgXHh/V4ISmAEgZV9spCpQoO5jhNrQXBKk6zcUfzMT8s8rhEex265iH5Q
         Uh6R5OWUXns/b2MguwIoocx74cZM0Rxxzl0DtFvRC9HuA1jVe/GHf0YR0eD7yo8uqWmC
         5IUw==
X-Forwarded-Encrypted: i=1; AJvYcCX2zYUDe0j2gm6KLyP2huoUswnHvjbGHE6Po+rRmtvKJHUyleiJLfuSosaHVTIs1ANzzpPggPTlSYwz+7BKDdNek22gvQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnvVUr9vYhhDRkZKWweNse9zh2BKH8tImbX1i27sX5WP8xjo7S
	flFnbb5VX3SaMIe3G0qGRSijRs3q2jYymrkbSM8JnX02U+vPpTiQ1e0vu4tWuJl4nLyfFeiBuUD
	ftcuH2Mm5OvEqdfh5a3oNYmPOnw8yYhQmeETjttJXGVp+9d8e7YA=
X-Gm-Gg: ASbGnctKJz1LnzRKZC9jcqc2M/DYhcZD15GN6Pr2EVDQfjEXpk3G0+X4VUyww8UX1uI
	+y4cm/PRbh5bqaG+OF3GsXC3JACnFzGPvljygGrSDPlna5QYYXVZPZ3c006TPtCWn2ZfzkCuAyA
	yc3h0vRhLNaz48zTOuK2kqt0wpgpb/v3fHKCwjO7DchRc=
X-Google-Smtp-Source: AGHT+IFETM7yorOza0u5Xc4IPvb1Wj6Cy5A1k0l3kUM+G0H9Gtr1V6n15kmn5i3dgL3ZfArcgzsK9tCF6fhB/AUVhNs=
X-Received: by 2002:a05:690c:2505:b0:70e:719e:743 with SMTP id
 00721157ae682-71406df28fcmr14100307b3.26.1750807564156; Tue, 24 Jun 2025
 16:26:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624-add_myself_to_lockdown_maintainers-v1-1-bed2bc934666@ssi.gouv.fr>
In-Reply-To: <20250624-add_myself_to_lockdown_maintainers-v1-1-bed2bc934666@ssi.gouv.fr>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 24 Jun 2025 19:25:53 -0400
X-Gm-Features: Ac12FXxqbHuHNKN2wU9KiVvFlrrwz5yfJ7Mf5VRJd7P5lrOrY1rBggH5fBMw9ks
Message-ID: <CAHC9VhS_QLEJrVVKNNtViFXcnaysseH5mFj9jMq7RK4u3to2yg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add Xiu and myself as Lockdown maintainers
To: nicolas.bouchinet@oss.cyber.gouv.fr
Cc: Xiu Jianfeng <xiujianfeng@huawei.com>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2025 at 10:49=E2=80=AFAM <nicolas.bouchinet@oss.cyber.gouv.=
fr> wrote:
>
> From: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
>
> The Lockdown LSM has been unmaintained for some time now. It requires
> some work to ensure it works as intended.
>
> Xiu Jianfeng and I volunteer to maintain the LSM.
>
> Signed-off-by: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
> ---
>  MAINTAINERS | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Thank you both for volunteering to maintain the Lockdown LSM!

I'll leave this patch on the list for a bit to see if others have any
concerns, reviewed-by tags, etc. that they want to add, but as far as
I'm concerned right now you two have the job :)

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0c1d245bf7b84f8a78b811e0c9c5a3edc09edc22..776c7fffcaec08f71faf27405=
99f0b4570179832 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14060,8 +14060,10 @@ F:     Documentation/admin-guide/LSM/LoadPin.rst
>  F:     security/loadpin/
>
>  LOCKDOWN SECURITY MODULE
> +M:     Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>
> +M:     Xiu Jianfeng <xiujianfeng@huawei.com>
>  L:     linux-security-module@vger.kernel.org
> -S:     Odd Fixes
> +S:     Maintained
>  T:     git https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.g=
it
>  F:     security/lockdown/

--=20
paul-moore.com
