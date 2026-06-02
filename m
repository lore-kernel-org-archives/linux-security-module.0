Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 496D03630B9
	for <linux-security-module@vger.kernel.org>; Tue,  2 Jun 2026 16:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780419471; cv=none; b=rZwJFTD9vy4ctqTTHd59Hd4gY9zhKnThh3EZEZVQ8I6Ua+R3gh/lb7E5q63pa/PN5IVtpRL2rlh0uHeSymvL/hZzphqaCP6bgCQsnUFjt9IAx+KTvoj1O6nyNj7zotJ1QGWLVv74ARhfxlLWlkTAhcoWXW6e9jMUCkSwAg/P+To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780419471; c=relaxed/simple;
	bh=6b4nAaQxphKIEBnQj1A2hRi1RU8/Z36cXPPJ/HHyDxM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aCDv3NhRj4hIpsXL7tfirdldtUhk2B9FSe/grfWBXk+CpFyHEut8S59Z4KOInkvYrd5F12sjkkg3sMG0XFNkEvNxIabtkl4ECu4MaEqiaYX3r7GzcX8rSo4ojkXp6WsjUHQ4YtdCVszmR/LH7+luRKqAMHP2jbSiQ4jdxNvBTUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=hxygyWJq; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="hxygyWJq"
Received: from narnia (unknown [35.132.143.199])
	by linux.microsoft.com (Postfix) with ESMTPSA id 9ECBA20B7167;
	Tue,  2 Jun 2026 09:57:29 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9ECBA20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1780419449;
	bh=ChU+UZA2V2CG8/mx9yKG2UQc+COHM2k0Y60siUpVQkE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=hxygyWJq152MkbmY5U3g1z2GPz2Y/uyU5VNfiMcHH1lbfQWIklHTVDSxHKOF0y0RG
	 kkvY8yOgTD1Kj5VJIOERFMbr0VIdAIcf+V/yLimnKe6eth9m74dXYAGrIjmfwvd8VL
	 meeI/Zu0oGrBujL+hYdMEtFfeqJy1PaMquuevT+Q=
From: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
To: Paul Moore <paul@paul-moore.com>, Fan Wu <wufan@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, James Morris <jmorris@namei.org>, "Serge E.
 Hallyn" <serge@hallyn.com>, Eric Biggers <ebiggers@kernel.org>,
 James.Bottomley@hansenpartnership.com,
 linux-security-module@vger.kernel.org
Subject: Re: [PATCH 02/11] hornet: invert map set check logic
In-Reply-To: <CAHC9VhQ_c9BOLXbYRk3+9_TPHbFW93-NeTe3fypxnkQOif69TQ@mail.gmail.com>
References: <20260528030915.2654994-1-bboscaccy@linux.microsoft.com>
 <20260528030915.2654994-3-bboscaccy@linux.microsoft.com>
 <CAKtyLkHtjzP3YsDr5-Gw0GRFB7Ch2h1amZzxy5taTt_+3gSzwQ@mail.gmail.com>
 <CAHC9VhQ_c9BOLXbYRk3+9_TPHbFW93-NeTe3fypxnkQOif69TQ@mail.gmail.com>
Date: Tue, 02 Jun 2026 09:57:42 -0700
Message-ID: <87o6hsyj5l.fsf@microsoft.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Paul Moore <paul@paul-moore.com> writes:

> On Fri, May 29, 2026 at 8:57=E2=80=AFPM Fan Wu <wufan@kernel.org> wrote:
>>
>> On Wed, May 27, 2026 at 8:09=E2=80=AFPM Blaise Boscaccy
>> <bboscaccy@linux.microsoft.com> wrote:
>> >
>> > In a multi-map hash verification scenario, a logic bug may have
>> > allowed an attacker to provide duplicate maps to satisfy the hash
>> > check count. Instead, invert the logic to verify each map discretely
>> >
>> > Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
>> > ---
>>
>> I just realized there is no audit event if hornet_check_prog_maps()
>> fails, probably should add one.
>
> Maybe, but I think it is important to remember that not all LSMs use
> audit for reporting, and Hornet is doing some new things from an LSM
> perspective.  I think for right now it would be sufficient to use a
> pr_notice() or a pr_notice_ratelimited() (if we are worried about
> unpriv log spam) message in hornet_check_prog_maps().  Hornet can
> always add proper audit support at a later date if deemed necessary.
>
> Blaise, do you want to submit a patch to add pr_notice{_ratelimited}()
> in the case of denial in hornet_check_prog_maps()?
>

Yeah, that works.

-blaise

> --=20
> paul-moore.com
