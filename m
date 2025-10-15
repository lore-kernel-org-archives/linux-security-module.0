Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C951494DB
	for <linux-security-module@vger.kernel.org>; Wed, 15 Oct 2025 15:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760540488; cv=none; b=MucpEBtp+HX6grvUuz2Jl3dcitSyf21EQ2QTj0eIrpFsUCL2sID0j91w9TH8yedeM/94Sy2608ZgUV6crTQcLO7hd1l+ivE7O3fSlM+wI5CdZbuECX/WgS6ughAf1vZFHbXLm+EAj6j8P5BU9VG5n0I1vHKAh3b2g+dIaFGuz+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760540488; c=relaxed/simple;
	bh=G0birDE2q0Wx2ehWlQiiugDzIYDcXtRCTqJYoPObZ4M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZHlNCodrQBUV+nUe/Jx4gtXWPUDxk+bdBcDcm40VMzVa+PMYxLdcyvdcXnk23CgephkEBonsLM+V4zmtMte+dFsC38Ppcjpo1aWiMQ0bA+7i99Zx8xBsZ6wldYMouqUb6cPHbJJSIeFQuE0OQaRd8izBPESTmM2OQ+PfZVLFrVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=bCf1x0+d; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="bCf1x0+d"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-79ef9d1805fso1924569b3a.1
        for <linux-security-module@vger.kernel.org>; Wed, 15 Oct 2025 08:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760540485; x=1761145285; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1V9E4k77kbYnPONFhSm3hUGtMMxA8VoH3u/N9nnK1kU=;
        b=bCf1x0+dZS1LKiZLKMBTZJHz8U766asMJ4zA+RPmCgYt48vjA84WPlGprazPATQ/1X
         6XP+Uaq99vQCp8g4H6K/15SMCBPO317+WNqopcFA9U1bfWtY/MMFN8wGyfVBYzVTFt0v
         TJdnZdwYtz8lKgm0bqxjwlt4Bv4YaX8jO0YHoXgTJnHOGVDKI+0o5x5k4mQY1VV1TwzP
         1PNudgALqnwX8TfZ85DSqeqRLjov80pnDgDrOwQaPMtmavtDsdBB30c5M9xJ9OOqLxRT
         mHZqnn3R+dNQd7txAH9m0oTA+MIhj62Xju+9fLH/OhtsQa8WB2kYzEarAAt/uwWjdvBe
         zN9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760540485; x=1761145285;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1V9E4k77kbYnPONFhSm3hUGtMMxA8VoH3u/N9nnK1kU=;
        b=GXjqQgeB0P2Kyx/qmsF91p2SK2U4vbIX5+7KUEty8D3+TykMDyhX8GZr7eVcZJRsVc
         AboND3wrJ4Qy1xlNBiBgilgXlEeeald89wxkpIjJsj1b08W7q8DMDBmc8DS6hxmFFr7Q
         6wlqJ6D7FmDpBWNNnI7315DNk68hTiddxqXGPgUve2BTDOomO+a2YE2M7LSZYgEhLa4U
         liFIuLYgVn3brT8dZiEOyjWGverGbRRzk/6y8dJAV0HbHS7Jhv6DX0hMDlyIorNTI8Ou
         7A/0KflT8RmuwZ+ODpCoZ7Iv/h7XbDG42+zH0rxAkHsL3bAfz6asTwgbIR+wZNbPwRAj
         MS/w==
X-Gm-Message-State: AOJu0Yx8BeAa+zd0jkUzhxgefSZ1ji5UBr1B5w0uXa76oW0xdoXA4erT
	sz6T1LEtfhGrOHze6SWlRSKgxbFXEXzSq4bBxv8/SgEQdRqSNrpzU91NahSY5hAI6L6pdhuR4NS
	Ry/8IhUaux9omELAj1IPX973BE0zLF7xWXrS9oPKoT3WPH4Da5O7twg==
X-Gm-Gg: ASbGnctynG28ewV9cM32AAbamfy5mZfnVy0Utz9GZxWDNJ5BK7qguRqZgkYLqybpQXT
	L5Ya//wJ/uX2YmAIkaFM5sHOt/AalcY2WRyGEpF1LCyJoJXnOmhK0lLzz2rdj+cr+rd3EQHBkdg
	ZlPFXWtvCYjxDdkSkX8UuN4c8OO2ieSWdF6wyuljYtIvUqboa4FWGsK5iyQe2KNFuPeIh9p0CZk
	lShStl/LuimBBNkHwNsI4guZg==
X-Google-Smtp-Source: AGHT+IEcSJTT3QGJrSGS2V+oktpVD++CsON/DFilv6mx8tFrdhhoGkkVRu2ouCGSDFmp3R6w8HchOl+Ts/xPSzJgOxw=
X-Received: by 2002:a17:90b:1d87:b0:32e:a54a:be53 with SMTP id
 98e67ed59e1d1-33b51119064mr41098159a91.16.1760540484938; Wed, 15 Oct 2025
 08:01:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250621171851.5869-2-casey@schaufler-ca.com> <846555fc86ec02df31f55935e747a71f@paul-moore.com>
 <1dad4179-d133-41ea-a76c-569a2f92fcbe@schaufler-ca.com>
In-Reply-To: <1dad4179-d133-41ea-a76c-569a2f92fcbe@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 15 Oct 2025 11:01:12 -0400
X-Gm-Features: AS18NWB9Oz_3T_T85artY79FMXfBuxAYWejmklwyW2nIclEFcaeckHr4bHl48PI
Message-ID: <CAHC9VhS1hT0Bvf2qhLxyRGBOrKUfcCZVeWK=eRJWhqaCcX9yMA@mail.gmail.com>
Subject: Re: [PATCH RFC 1/15] Audit: Create audit_stamp structure
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 1:20=E2=80=AFAM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
> On 10/14/2025 4:12 PM, Paul Moore wrote:
> > On Jun 21, 2025 Casey Schaufler <casey@schaufler-ca.com> wrote:
> >> Replace the timestamp and serial number pair used in audit records
> >> with a structure containing the two elements.
> >>
> >> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> >> ---
> >>  kernel/audit.c   | 17 +++++++++--------
> >>  kernel/audit.h   | 13 +++++++++----
> >>  kernel/auditsc.c | 22 +++++++++-------------
> >>  3 files changed, 27 insertions(+), 25 deletions(-)
> >
> > Dropped as this patch was merged into Linus' tree during the v6.18
> > merge window via another patchset.  To be clear, I generally don't have
> > a problem with multiple patchsets including a few common patches, it
> > helps prevent cross-dependencies between patchsets which is a good
> > thing.
>
> I'm off-grid for the rest of the month. Will respond to these many things
> upon my return.

No worries, enjoy your time away and thanks for letting us know.

--=20
paul-moore.com
