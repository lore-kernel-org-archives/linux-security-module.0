Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7596E1B87F0
	for <linux-security-module@vger.kernel.org>; Fri, 18 Jul 2025 14:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752850412; cv=none; b=L8RHeQ6TcRshvCKMypwJ66vBi6cfsLbnAVPRV306CaBeNhePRoDXX1zxI/EILW/5CLpzT/O9wDFJ3vUqexGTwBJ9Av6pmthisVYng2hg1SJMd0E7IFYa81IpP4iR3CGpMN6Ps/eWp8OfDNVS9QlQO1vnrNsudyfaN3XOYrrtGF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752850412; c=relaxed/simple;
	bh=+cz4HCPr5tjchC6wb2VLVqvPWbpYeCdVtpSnQppLTSI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hY7/1TtoU2YC6on5xaFJj5j9tEcZpxjBTl9DbPhQTj9QRSF/o3C3jciz2uFfEQc/qh05vsLqqHdMZHgXuQ7VsgDrKt1EqSiKQ11kvbN4nfS29aeCe4CCMwakZIS5SB1bHYfPKUIA6cIIjJofomOrB9q3uBuN8uD3b2Y2oOJ9Qzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3J6d9SCj; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3J6d9SCj"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-611d32903d5so12132a12.0
        for <linux-security-module@vger.kernel.org>; Fri, 18 Jul 2025 07:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752850409; x=1753455209; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/hzBLC06b+5l1Jibi7tNWcnqjU2kBOrH0ilPtK5Nqww=;
        b=3J6d9SCjRHdZJtVgVlLOflA9rtmh8HrYLIyP2MO4YmnSiqCAwIkfJR13ADdLXt324y
         zRqiVa8o9ULQX3LMUVvGdIrU7wufoJUHLrgjtBCLFV7+MzFxvxJB4ym/dh33Am6fhKzi
         6yoxoN+tZE31hBU4f+X1hvJUXbpvWiDgV5CXYrNiXSfJNs4FbGS65KYImpP+U6dbA7yG
         +7n6GPljBmNgRUja+n+Qgbw6iSnBVQTdV1gqB+D+h35h5YsdA6NQIaDumIgpldhUp1Z0
         zEnjuT5I1M97ka8yaixU+xjPvQ3CN9QFMQSZT+s0VBnZuWCtcNo9g8jOvDZgkr9Ym7lA
         n1pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752850409; x=1753455209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/hzBLC06b+5l1Jibi7tNWcnqjU2kBOrH0ilPtK5Nqww=;
        b=bqdQZS+PvsOKzIUP+MzUzHjxfqFPw7C7vC+JrSdMfC0SAEawLngUwV6huH+RXF1qSG
         EbfPhx0oreOVfghbT8Le1dzy9qXHcwgckw26+wFkNfVTosJQCW3HPIzPeRY5f107wSCQ
         yUEhK7nnCjqkhy/85+FCDwRz0QPOR50k3WOYyokmEvpOX9XZ3llvZiCp3Kg3VtC9tdO9
         xPlsJepkmotf6PDpEbiBPIyRceoXA8eee2HAKiB/qo3d+0KgSAmQzKSqRS7KojWF1G9D
         aiU98GAp2lScGpoHV6XzikVSCNf3ouheaVUTqj9PvpkbQMLbvi80671IfEUg8apk4Yez
         tRCA==
X-Forwarded-Encrypted: i=1; AJvYcCVco/YtpE3Vr1BvPc4lLDGRDeHy+1wiKL6ldVnJZS6yMMi371V8flb7/AjsWn4+UablKxk1lbY1hGjjUbDz7k87V2xlNjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPKma97YJw35MgiPbCuxrcnzNUyij+iTuYj4aNlO2oAkS0gfSD
	XV9GLOG0ycLhoRUdaYcAxkwsBVI3OGla6MIjDdcXKxtXjsYipqUZ9GEen7rUfkAx8k25XICdTpl
	dpkylwxEl5chUqxbu3mgqSXOuUPWthxOViFWqL/ym
X-Gm-Gg: ASbGnctcj7YY2siCLQYxlziu0MjGBqJvQj2VyRn0wKne7m5nzk5GUt4aHVLIfIFtr0G
	FXwkLJNL6yIZZAE+F/XwcXQq5wDKM/St91AmuGUk++txIkkeRH693WT1D1GDbLK7wiMalqpotHt
	P77GFK7GfYDBfqEcF7hVo8CHeWaaalcATDNOJl3qOlqqrCphOYAnpqeX3CtYQ8cTGf94VqAqNud
	u/Qd0KjFMYz/xTFMKsLQsOE11mWnE9ecbd+AbqtmrvsWQ==
X-Google-Smtp-Source: AGHT+IHhIPDeunFBo1vWbIckgOjZNTBX+72Iuj3bDcvIABI3tBDgDiU9nGOHjPKBy83vW/xX7fddjk+XYV/k/HG0dn0=
X-Received: by 2002:a05:6402:31b6:b0:611:ff6c:50de with SMTP id
 4fb4d7f45d1cf-612c234e830mr103625a12.4.1752850408383; Fri, 18 Jul 2025
 07:53:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250718-yama_fix-v1-1-a51455359e67@ssi.gouv.fr>
In-Reply-To: <20250718-yama_fix-v1-1-a51455359e67@ssi.gouv.fr>
From: Jann Horn <jannh@google.com>
Date: Fri, 18 Jul 2025 16:52:51 +0200
X-Gm-Features: Ac12FXwt7R8GLFUkdtizIwT7mYdidtRUy78w_KziKqUlTZowf2o8kv3DmkXhuRM
Message-ID: <CAG48ez23HLtb9GJ-BbSXaWFhdPjXyFNED9fbuyaNP5EXJ_Wv8w@mail.gmail.com>
Subject: Re: [PATCH] lsm: yama: Check for PTRACE_MODE_READ_FSCREDS access
To: nicolas.bouchinet@oss.cyber.gouv.fr
Cc: Kees Cook <kees@kernel.org>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Olivier Bal-Petre <olivier.bal-petre@oss.cyber.gouv.fr>, 
	Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 18, 2025 at 10:47=E2=80=AFAM <nicolas.bouchinet@oss.cyber.gouv.=
fr> wrote:
> From: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
>
> Currently, yama only checks if the `PTRACE_MODE_ATTACH` mode is set
> during the `yama_ptrace_access_check()` LSM hook implementation.
>
> In cases of call with the `PTRACE_MODE_READ_FSCREDS` mode, nothing
> happens. Thus, yama does not interact properly with the
> "hidepid=3Dptraceable" option.
>
> hidepid's "ptraceable" option being documented as follow :
>
> - hidepid=3Dptraceable or hidepid=3D4 means that procfs should only conta=
in
>   `/proc/<pid>/` directories that the caller can ptrace.
>
> This patch simply add yama a `PTRACE_MODE_READ_FSCREDS` mode check to
> enable an interaction with "hidepid=3Dptraceable".

Please note that PTRACE_MODE_READ_FSCREDS is actually a combination of
two flags, and the intention is that the PTRACE_MODE_REALCREDS /
PTRACE_MODE_FSCREDS part of the flags should basically only be used to
determine where to read the caller's credentials from:

/* shorthands for READ/ATTACH and FSCREDS/REALCREDS combinations */
#define PTRACE_MODE_READ_FSCREDS (PTRACE_MODE_READ | PTRACE_MODE_FSCREDS)
#define PTRACE_MODE_READ_REALCREDS (PTRACE_MODE_READ | PTRACE_MODE_REALCRED=
S)
#define PTRACE_MODE_ATTACH_FSCREDS (PTRACE_MODE_ATTACH | PTRACE_MODE_FSCRED=
S)
#define PTRACE_MODE_ATTACH_REALCREDS (PTRACE_MODE_ATTACH |
PTRACE_MODE_REALCREDS)

> Combined with hidepid=3Dptraceable, the following behaviors will then
> happen while reading in `/proc/<pid>`:
>
> - "restricted": A process that has a predefined relationship with the
>   inferior will see the inferior process in `/proc`.
>
> - "admin-only": A process that has the CAP_SYS_PTRACE will be able to
>   see every processes in `/proc`.
>
> - "no attach": A process will not see anything but itself in
>   `/proc/<pid>/`.
>
> It is important to note that the combination of "hidepid=3Dptraceable" an=
d
> yama "no attach" also makes PIDs invisible to root.
>
> No access reports are logged in case of denied access with
> `PTRACE_MODE_READ_FSCREDS` to avoid flooding kernel logs.

This seems like a major semantic change; I believe it essentially
means that commands like "ps" stop working entirely on systems that
enable hidepid. While that might be desirable in some scenarios, I
think changing the semantics like this without making it opt-in
through a new sysctl knob or such would be a bad idea.
