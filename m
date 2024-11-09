Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D434086A
	for <linux-security-module@vger.kernel.org>; Sat,  9 Nov 2024 18:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731177387; cv=none; b=qilYx6Hz2sO/YWlHc0BikyYyeUmtRSn0Isho7yCq9YbPVetoivz/Kennkyv4AXSjps7wW1qD61OnEP7qwY0KkrNKAgqZYp+D0ue9q51lbl4MRIozyudGnU5qTW0FsHvVGom9Tq52Rlx/e7DrmvP+dkdUDFDTCxoxn4j9xCbrBX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731177387; c=relaxed/simple;
	bh=UeuRoLIoFZl+e2wEIDEgVc4qMkCvGPRDAibgJq60uZw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kAUlgQOlKX8D1ptQjH3gLxp1txhYPulynKsvBI3+ZWuHXNUYonILCFhii3ZB0e/kNnSpEUvsRzrbY6TKOLv+V/qtyS04rCfjy4CQ8WiTPumGojIXxuM6QwS9A/TU290NCsIgcRpl9cJIp0C6WGJWtP6c2sDjQJpo/0JjdpB+vJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uKngsZY3; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uKngsZY3"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6ea82a5480fso61788077b3.0
        for <linux-security-module@vger.kernel.org>; Sat, 09 Nov 2024 10:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731177385; x=1731782185; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IC0td1EB33f7rDp53a5h8SQVwqUp/0C6lqTv8T24vkU=;
        b=uKngsZY3/j3zfZEintXnRY2BhUbY7cXqBiFOB1Dx0g1ROAkrEG4pI2e+1O946dToyt
         DV4pKLJT3KzcDagmP3zELxVIilZOnftLR806VVjQYWv6btAcgmFBKMmJgOTYZffYhV8M
         r3BJHwUwEbtjL/dfrmWSC6pOBRUJd1PFZWVaFU2CYJQZj9+mRuO4IrYff4YcITm48C2/
         WAfnlI7zFJFOFw8dxhW067wmO9YARcxAViwVBlQSENh3LyIp7v1LEJRvViqvsMh3uOs6
         ER8dMVnm1VdO9//FFfznHUShkm33fmmyvCVYPb+WQbQS3NE6Rpf3L79Spl01MP2tWKY6
         JXQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731177385; x=1731782185;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IC0td1EB33f7rDp53a5h8SQVwqUp/0C6lqTv8T24vkU=;
        b=S9ZuobyVy2vCfBZmhzzgeggeAwqXXFkynwf660usyTFIIf9jAupwsXjLYPIzrMtx41
         Kf2zGNTMYmAxndps+yn2hCQBFO1G6HUKek0wvaVP4dJ0BEsHsZmU2R8KPk3ZstXC3nqu
         wU8zyhVDMLGjYPEFind4AK1+CACB6grjH2BK++gA5LMjHkYVn0YSZaQCLVYr8WBJjEvU
         pWP0Fcj4eB+vNkwAYP6KLxntVuHKAIzbaezZxbRWaW0j+fJG3auXnG9SGfaTW6JeBf8/
         1KUhoS/W+Tv3+84PwvRUMbo46rg154b0CVcMo5U7icYmEVEdoqYkE8QsHLjdcZHwegYs
         NomQ==
X-Forwarded-Encrypted: i=1; AJvYcCUV5gbHWetMyNM+tgOaiUZCOaHi30RIymfP1TvQZ8O8uEEYpDqcxRbJrU5XsEZL+9ejvDim6nN3fH5CUvA7wYMpgyx8X/M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9PcMHA+5v6D/A/OiKymAz2SzMQxlUwidRcL8U5fQ/dnUF32jm
	0E7qG2EDEKvao2hnmJlNCwzhHJsxhUYbCLj3Vkh15X0B9Ajj8GnOG9hgkKvRm5wKzVxk5zsFyl7
	jHw==
X-Google-Smtp-Source: AGHT+IEb4fEPLeJ7n98PcRJUUQ/Ryt+KSVEtHCIMAt5JF3ABfkoP4DvEHRPRh2r9ehSppb5iSvQtA/w7EaU=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a05:690c:3409:b0:6e3:19d7:382a with SMTP id
 00721157ae682-6eaddd71c24mr310157b3.1.1731177385230; Sat, 09 Nov 2024
 10:36:25 -0800 (PST)
Date: Sat, 9 Nov 2024 19:36:23 +0100
In-Reply-To: <20241109.xie6Quae9chi@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241109110856.222842-1-mic@digikod.net> <20241109110856.222842-2-mic@digikod.net>
 <20241109.xie6Quae9chi@digikod.net>
Message-ID: <Zy-rpxay3VmM7QuG@google.com>
Subject: Re: [PATCH v4 1/3] landlock: Refactor filesystem access mask management
From: "=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack@google.com>
To: "=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?=" <mic@digikod.net>
Cc: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Paul Moore <paul@paul-moore.com>, 
	Tahera Fahimi <fahimitahera@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 09, 2024 at 12:14:49PM +0100, Micka=C3=ABl Sala=C3=BCn wrote:
> On Sat, Nov 09, 2024 at 12:08:54PM +0100, Micka=C3=ABl Sala=C3=BCn wrote:
> > Replace get_raw_handled_fs_accesses() with a generic
> > landlock_merge_access_masks(), and replace get_fs_domain() with a
> > generic landlock_match_ruleset().  These helpers will also be useful fo=
r
> > other types of access.
>=20
> Of course I need to update the commit messages with the new names...

Yes, those are still using the old function names.

At this point my other two remaining remarks are so minor,
I think we can skip another version of this patch set. =F0=9F=91=8D

Thanks for simplifying the code!

=E2=80=94G=C3=BCnther

