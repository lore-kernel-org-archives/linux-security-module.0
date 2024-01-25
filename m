Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2174579C7
	for <linux-security-module@vger.kernel.org>; Thu, 25 Jan 2024 19:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706209397; cv=none; b=IWhzA07E/RRy1xi0GAtoFrf8lD2zJXf0KrLrc8KZriS6yDOz7kw40t++TOmrxtIc82FGdBlGLJT236tJgF3iXdvr3j0wh299xRjPWvK8JnQ9szR+nrKqWy78BklY+N+8oNcYdBHYs6ZM95lcSLjP/qVNiVQCnj6cvFvb5XbYY/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706209397; c=relaxed/simple;
	bh=Pc03gAJWDs1rYqi394fLWKQ1B7j4F1mw0lv6RArD1lI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TJypLm6wr0SAHWdy3VH+cfBWbpyu48utMnu1Gtt8bW8K7fcXFrxFqzrHgv9GhDllm3SApG6VU9rIiuDdiYEZgewhIxalLJun7SHdV3fgxkG3HmqS/rgmtwJdp4+MqBJuHiQ00T4l1s+m6uKncSSu5oRZgTg89uH/Y+qUxINcZMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=FoJwI3/T; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="FoJwI3/T"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dc371b04559so5641276.0
        for <linux-security-module@vger.kernel.org>; Thu, 25 Jan 2024 11:03:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1706209395; x=1706814195; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mlrh79Euh4eW3f/uCnr6fwpn940jDXkmRsbZe1PCVZE=;
        b=FoJwI3/TOX9dk7YP8pyAJeZBTDhKOZfEvqgkxPheY6P7LueCl6GPHTF6+4W0+Tgzqv
         uUzZNSLqilKGaV62CBIT/e9QDGmCw0HWruzKoO6pApjKxPBUBiRvEHJZZEIwUsrXCII2
         Qcyf7J58PZGhOXfNWgTFmzPQTjECluQEMdyUkkGo9qCkbqZdSjIKtIT8kSPy5UEGtx9t
         OjXpQYNpVF5TYFa3L1y5HaWWjBY/zw4KFUQXP1fH3tbs3Y7OB6nX5KRGkLUFRNBovVl9
         EFAoYo3CWp1jOvVebA3xH4nFGlu9ViVseoylwbchksu1b//UYhoIqWaWRuA+WYHptToE
         Llbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706209395; x=1706814195;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mlrh79Euh4eW3f/uCnr6fwpn940jDXkmRsbZe1PCVZE=;
        b=jNlmkgleR8L9j/2SsbMLAeByTeir1Vl6MFYOj4NtBI6rZN57DYlx366LAx3Gm/xM/+
         OkUYNfHs3575Z3wUr9zFj4HzA7eljgfDk/pgz/koD7SkbgJbp2OoWkM0Vxyc5iA97oPD
         PEiVcbCaUqFdxjrfCwlXhcs54x9/HnZvWmD7tBV6RPc0hQ7YBfIv/w7kwgNdpUIxyafr
         Q+NwF8uLXRHDn/B+quDjlsBmne05MOYHUQHGtPqOaiTv23PQioRh/8ZEVQw/9aXUUQMd
         c35TkcLrvWfWCctMhJ5kSgpaZ0CLNor8Pdi25OYOWTU9uN7/MCVPzp49CzSQlCt9qNCr
         9ZQg==
X-Gm-Message-State: AOJu0YwPOM82WFtiHH6bJqNGKEPIHKqOteOYgO3rf7eOPj4prPDlibgK
	3vo+O2VqXB8VWYxVLdkwCBzFBCgjRHvPxXWStUIns0AodvCMBQT/UwH4mX7X6INFxu974RDTBUz
	Cxpvqj7z9yAf+tFwUaiMyZAN+JdCXisp62lD+
X-Google-Smtp-Source: AGHT+IHEq/5SVbrbDkVRZ3ZSdo10k/TvYvxDrSzOgPgIJfxwd4SWWal1/uWo+67pTna4o7tRUao10eQBniEr4CqCrgU=
X-Received: by 2002:a5b:3c2:0:b0:dc2:4d83:2084 with SMTP id
 t2-20020a5b03c2000000b00dc24d832084mr304717ybp.27.1706209394874; Thu, 25 Jan
 2024 11:03:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CF22CFC7-11A8-4BE5-BA61-04A55FDEA1DB@contoso.com>
 <a8868907-91bb-4125-8f7a-79acd9c01f08@I-love.SAKURA.ne.jp> <66582C41-D44E-4270-9091-C153541D7311@crowdstrike.com>
In-Reply-To: <66582C41-D44E-4270-9091-C153541D7311@crowdstrike.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 25 Jan 2024 14:03:32 -0500
Message-ID: <CAHC9VhQo7NLqyPSacjVpwtFaW-_3YaHn=-N4qaik+z+9rY-ejA@mail.gmail.com>
Subject: Re: [External] Re: security_file_free contract/expectations
To: Ben Smith <ben.smith@crowdstrike.com>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 12:19=E2=80=AFPM Ben Smith <ben.smith@crowdstrike.c=
om> wrote:
> =EF=BB=BFOn 1/25/24, 7:19 AM, "Tetsuo Handa" <penguin-kernel@I-love.SAKUR=
A.ne.jp <mailto:penguin-kernel@I-love.SAKURA.ne.jp>> wrote:
> > I guess the out-of-tree filesystems are used by CrowdStrike products an=
d
> > therefore the source code etc. cannot be shared. (It took me 2 years to=
 prove
> > that an out-of-tree filesystem used by TrendMicro products was the culp=
rit.)
> > But are you sure that the location that triggered panic is at reading c=
urrent->fs ?
>
> Yes, unfortunately the source can't be shared. From the stack I can see t=
hat the NULL dereference does
> not happen in crowdstrike code, it happens in mvfs (Clearcase MVFS), whic=
h I do
> not have sources for. From crash analysis I'm pretty confident that mvfs =
accessing
> current->fs led to the crash.
>
> > security_file_free() is not meant for reading files. But if the locatio=
n were
> > really at reading current->fs, whether an LSM shouldn't try to read a f=
ile from
> > security_file_free() is a bogus question.
>
> The underlying filesystem, as part of reading files appears to use curren=
t->fs
> (I assume it's looking up something about the calling process since it's =
a
> versioned file system). So, my question was who is doing something unusua=
l here?
> Is it the LSM in opening a file in the context of a partially freed task =
or the
> filesystem in blindly using a field of the task struct without checking w=
hether it's NULL.
>
> > security_file_release() proposed by Roberto Sassu would be OK. But I gu=
ess that
> > the kernel version you want to load the out-of-tree filesystems is not =
the latest...
>
> > Without more details, we can't give you appropriate suggestions.
>
> My feeling was that reading a file from security_file_free() was not a go=
od idea
> but I wanted to clarify expectations and make sure I wasn't making an inc=
orrect assumption.
> Casey's reply cleared that up for me, so I've got what I need and have a =
path forward.

I also want to make it clear that there are no guarantees that the LSM
hooks you're concerned about won't change tomorrow; the kernel's
stable ABI guarantee does not extend to the LSM hooks.  If you, or
your company, make the decision to support out-of-tree kernel code
that relies on the LSM hooks, the expectation is that you will be
shouldering the support burden yourself.

--=20
paul-moore.com
