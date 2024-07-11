Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECCC15F40A
	for <linux-security-module@vger.kernel.org>; Thu, 11 Jul 2024 13:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720706390; cv=none; b=ZguBXZ99tZhMmQL69pP7NBqvz1Zw/OZwSQ8eR1/WqJtscoriaS4lTTif00nlnMk0GVP5BVuvqnL7sbA7k7aZN8u7vQW9y0VbxY4U8Scv1KERqHrYi0ud6fZGqhV+wAopTTKg7GA1QrKT1eUV/SWIGUs9SQB1J7Lp82IHP2V+Ry4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720706390; c=relaxed/simple;
	bh=febJ7xDjZS0C45YP1S6zLfvMmURRqXEwqqNrgSRVceo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d2S5nmZ3GBuxRDl1qXiVQ1MCUK8N/SDpJ1zgxSocG6ytG0mM/7HfPj+wE+jQ0aBl6kPVIrkQxBzvTpNX+dNEa2mPpokU4F5E24+LL7rZVC0+S7eyS8R8wcRseEBNB8ROCaoAEBqYMsCnZ2J1Or68n7KBHT+HX9eMDnvA7s35f5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=NPAq3MgB; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="NPAq3MgB"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-655fa53c64cso9370127b3.3
        for <linux-security-module@vger.kernel.org>; Thu, 11 Jul 2024 06:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1720706387; x=1721311187; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GQY2b8/DRuEUTaxvuIRlplaS5SN88ksoRA5Ll0aBHr4=;
        b=NPAq3MgB70r6Qm3vgI7+RlPeGEFs2iESYk1gr0/CJMqDSX1jT71b2wlIo252YtIsBI
         MxXaH0B8L+asbsFSGRj0KLKxYh3YY+CAHI1Z8ui1fcPD6N0HewX8vwbjXQ3Heraj067T
         Qd8YDHE3QFURqJgrdRxCw0mnkWNclUL/KJte36aHNadW9V6CBJleoI0ozT4gZm6X6DVP
         31TO40Y+nxlQvStvkJZfGf/NvCn52dM3Jm9wJ6pY5i16D9H7qhWeN/1ugzM2lCXjuEfD
         ZMSQ6NYl1JcMXZFm/HaJM7OIFiRpnpA5KxWEOnrKj6ROc2o6BRcqqyB81DehRyN3NSSy
         9nMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720706387; x=1721311187;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GQY2b8/DRuEUTaxvuIRlplaS5SN88ksoRA5Ll0aBHr4=;
        b=TTUqLtxnFlcCyXZH+UtXjyNTlqbO68t67W+XARJAxr+BG0W3hwMXy6tZkU50Og+vX9
         e4G+uI4pHFSdOQMavVbbXIl/J4tJtB0nE7A89tlvxKvpmR95ZIzbcFGAZhpTQk/Pk3cQ
         hvcJrVoFAWaJhLIcJv7SSxX7QCyPTv92NrXKf2GWm1Y+a2qhCm7zObU1YZmxxABxbzYM
         iieVVoh2ByCke5bgKwBIHCLPXUlv9xd5Q3jMTBcd4wYhgP2jqikvKV7gtMedgwsjKn7J
         Row8vdSSZ1XsqOTT0DTZk3Y4ig1PrlqosV/r6ZcSJolHzAI3gRAJuqShxpwTWEbWhEim
         k0ug==
X-Gm-Message-State: AOJu0YzJcIuM/Kf3u5pgcbdvbD5imsvaZX8QWW1UCAhHZHzqLEUrwuha
	znD7MgjS6nRFTZ67yiclht2WNv8qEE/LRnaG5dOStPkUxwVIK+km+RxRoXzmDlMlkueRcdP/8v/
	QwRN7uiPUoaDb+yYDWesEwsM+0zrXFGhQoJwC9YdfYk/UIvg=
X-Google-Smtp-Source: AGHT+IEMt3QtUz/v7j9W8ojXGoKTHXeUWcTEdJBkUtHA2ovG9+altl5kDPZ4Nrp/gUeDTxqi3MpZrTf/e1iIP3EsFB8=
X-Received: by 2002:a81:8d14:0:b0:615:20db:4a4d with SMTP id
 00721157ae682-658f02f55e2mr88805347b3.35.1720706387552; Thu, 11 Jul 2024
 06:59:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710000500.208154-4-kpsingh@kernel.org> <b23e0868802853a9ab17e17fdc35c678@paul-moore.com>
 <CACYkzJ6HGdW1Vqs_KPtGLZEyX4NO8ZpreJfhoCoOwsWDdmAueQ@mail.gmail.com>
In-Reply-To: <CACYkzJ6HGdW1Vqs_KPtGLZEyX4NO8ZpreJfhoCoOwsWDdmAueQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 11 Jul 2024 09:59:36 -0400
Message-ID: <CAHC9VhSKrgzzpxZ4SemHcuSvHMegVzqQRqv1hs=EG1A47MBnyA@mail.gmail.com>
Subject: Re: [PATCH v14 3/3] security: Replace indirect LSM hook calls with
 static calls
To: KP Singh <kpsingh@kernel.org>
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org, ast@kernel.org, 
	casey@schaufler-ca.com, andrii@kernel.org, keescook@chromium.org, 
	daniel@iogearbox.net, renauld@google.com, revest@chromium.org, 
	song@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 7:15=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrote=
:
> On Wed, Jul 10, 2024 at 10:41=E2=80=AFPM Paul Moore <paul@paul-moore.com>=
 wrote:
> > On Jul  9, 2024 KP Singh <kpsingh@kernel.org> wrote:

...

> > > A static key guards whether an LSM static call is enabled or not,
> > > without this static key, for LSM hooks that return an int, the presen=
ce
> > > of the hook that returns a default value can create side-effects whic=
h
> > > has resulted in bugs [1].
> >
> > I don't want to rehash our previous discussions on this topic, but I do
> > think we either need to simply delete the paragraph above or update it
> > to indicate that all known side effects involving LSM callback return
> > values have been addressed.  Removal is likely easier if for no other
> > reason than we don't have to go back and forth with edits, but I can
>
> Agreed, we can just delete this paragraph. Thanks!

Okay, I'll do that.  I'll send another note when it is merged into
lsm/dev, but as I said earlier, that is likely a few weeks out.  This
will likely end up in lsm/dev-staging before that for testing, etc.

--=20
paul-moore.com
