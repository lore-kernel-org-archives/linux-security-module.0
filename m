Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6752522F17A
	for <linux-security-module@vger.kernel.org>; Wed,  7 May 2025 22:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746655991; cv=none; b=Pa2S4vi2ArVHAJGVwtamih7vzuC/mi8CTateh+SI2d13oW/zD9W5V74WIeDkEatSXpl5bMl3yDwfun3kmCyhSdnPjwajGlJ21orj892a+UbcGhLLjuKUF4ow2gYwuDeg3KWJRfjcI3ifXSHRjWfBxTBh/rFGsk0HDTxC+yobook=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746655991; c=relaxed/simple;
	bh=YdWrWz3ZtdDCuUNMSZehjP/jint9xFF3sKvvIvZSRDo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jBx1K10XNoXQ3GQ7mb1Nm8wZkMbOQiDqs2JnJ2MA0zhEscn1cgGEd1P9ajQbiMIb4vxGi0DeQ6eNzfJfo4xQAO/7gctBrB7zGNy6ENE2abpyIRhmdiOlj16S1LwMRv85IigGWdrFKV7cag1KSqNn3vBM7mkXtywEhMMhDiJMpg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=GAkKNHv6; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="GAkKNHv6"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-70842dc27easo4000577b3.1
        for <linux-security-module@vger.kernel.org>; Wed, 07 May 2025 15:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1746655989; x=1747260789; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S8icWB/oIrX/HgcLARDHS+J6ctl2NAQ5/4rcyDqZz2U=;
        b=GAkKNHv6BvXVXyNgRgMDZq2sKPDLmdaTABIBlcDhF4jlFN+ARQ6EvA5MUnOqHzMkwF
         G2s2gLuA5gbcG3GSQweaxllwxyw6bysGVyo7GwCB5QeHjVLIKZg3aW9zgSGd3vOXOZ0Z
         3othp9xVTS/gm1GU4IPZPz/t1nju8YpIVRMhufUl7BnO4FFd6blItWIJNUm4tJbGOuHV
         wsTkcJZe72orsO6nPQmtM0hRiCXMPzQuMo0hYt/FzzDGNJIG2uwcCj80O3VMd7MIWpW4
         NHzaw19nr7/Q8jkLyTkKPut8ZwJmVkp3N4yb17E3nivUNjaQXuffr+FPVHW97V01Hb12
         1pjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746655989; x=1747260789;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S8icWB/oIrX/HgcLARDHS+J6ctl2NAQ5/4rcyDqZz2U=;
        b=Ac42afXDShPJmTALxfa3Z13ABj8KRzQ8fKbsaKJ22OPGXoVp1VoActtbNDijQdW6zM
         Qo4HkJ4f+H2opSLCVXLGlw0iMQ/PAzPP+nBcOEIxTlbBjmdatIbqk8QLuk5GaXfkcFoX
         yx9XQiObVnF1B30mn3cIY8tL94imMtM3B0YvTCOb5My+Qq+5PPyZKUrUYt31ytwtGDtf
         YQ+gnHQkkGEIeq6SEqJyyAdkdVVXe8Y0Hrl4G9WvLfBmUDEkzAtKZQKqK6vlyxkph+gy
         Ip21537vrKc/uIIlo4W3eDaZxaDbOQADsE7iIEvyIAOvJ14tAl+BNPicNRQQE6YCPntW
         b83A==
X-Forwarded-Encrypted: i=1; AJvYcCVqcUkDn5fqmViISxVHl66YBGwgtW2CdEc6HdGzCvbsVYxebBEEwviPu0tt5YtTLNqSSbhEG1ipgIbE9xNoFHR4p86rhrg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwORlQYzu/oYeaeRiPnAncTrZEc8muSaINM4OFoBfxAcmcuxBb
	D/63kC8lMqxYHBeW9FwPUKm9Ak20CTw76OpYWqxQ4NmGhZh/fxEFgkA8GLYFZ+kLcAG6ceLOC8H
	LcahRd6V2R0m3pQzb4NcMSTCtawYadk3gQUi/5jAlwX8HroKMUg==
X-Gm-Gg: ASbGncv8xr2E4T30cXVzYMa8cAXRByfhwQ3/4So0y/yfaEIATWlv+tiZJ8xd845+XP9
	m5RikYXG/XqYG8apHRUb6/ZK6pcIej/scPIGTthmn3IqXKOM+bpbxyTVdpqn25owKCkyBxfk5eA
	I+UvJffFznQO4XNNmQ0GnTsA==
X-Google-Smtp-Source: AGHT+IHTCvYdc4odka87i+iikS8LAezFf+6/A6Tt3o8F08N9z96rpAljDv13alcoYAwKbSxuL/6ejDA67pfnCk+qTL4=
X-Received: by 2002:a05:690c:6012:b0:708:2604:4a10 with SMTP id
 00721157ae682-70a1da383f9mr73554767b3.18.1746655989211; Wed, 07 May 2025
 15:13:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250507111204.2585739-1-alexjlzheng@tencent.com>
 <CAHC9VhRx6SUqYHm7Nv6JKVzpANsnt-qPONcVqZh=hXOsWMqDBA@mail.gmail.com> <20250507212329.GY2023217@ZenIV>
In-Reply-To: <20250507212329.GY2023217@ZenIV>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 7 May 2025 18:12:58 -0400
X-Gm-Features: ATxdqUHJQjdJboeHkSfNksr62Yf4EKEM9bAdRYV7SYcjIV4GMSrXhAmnRg3v_RI
Message-ID: <CAHC9VhScmdZLz7W=FN+mfWjf5LB7jbTJm5g-iy35hvvMgbKRfQ@mail.gmail.com>
Subject: Re: [PATCH v2] securityfs: fix missing of d_delete() in securityfs_remove()
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: alexjlzheng@gmail.com, Fan Wu <wufan@linux.microsoft.com>, jmorris@namei.org, 
	serge@hallyn.com, greg@kroah.com, chrisw@osdl.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jinliang Zheng <alexjlzheng@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 7, 2025 at 5:23=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> wr=
ote:
> On Wed, May 07, 2025 at 04:10:11PM -0400, Paul Moore wrote:
> > > In addition, securityfs_recursive_remove() avoids this problem by cal=
ling
> > > __d_drop() directly. As a non-recursive version, it is somewhat stran=
ge
> > > that securityfs_remove() does not clean up the deleted dentry.
> > >
> > > Fix this by adding d_delete() in securityfs_remove().
> >
> > I wondering why we don't simply replace all instances of
> > securityfs_remove() with securityfs_recursive_remove(), or more likely
> > just remove the existing securityfs_remove() and rename the
> > securityfs_recursive_remove() to securityfs_remove().  Do any existing
> > LSMs rely on securityfs_remove() *not* acting recursively?
>
> It's a bit trickier than that (there are interesting issues around
> efi_secret_unlink() nonsense, as well as insane refcounting grabbing
> two references where only one is needed to pin the damn thing)...

Fun :/

In that case, what do you think of the change suggested here by
Jinliang Zheng where we add a d_delete() to the existing
securityfs_remove() implementation?

--=20
paul-moore.com
