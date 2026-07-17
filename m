Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B153B8D4F
	for <linux-security-module@vger.kernel.org>; Fri, 17 Jul 2026 21:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784325478; cv=pass; b=QS75A0wjvZqsTzSqUK4NrZwseSSay3dQj9tGNWXhAMzilnWMrPlxYnCn3a2n2X3ky8oSjLH6RzdxWVR6ePP2SC7KQnTzVp/KwviYfpyKPZfyDphLrwXKNf1ZfIrCdQb+aTtiOnXsuE/oCcDsR6MlRCmb2i72tq1KqwIvKkzimRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784325478; c=relaxed/simple;
	bh=lS/4o44r61OudiDVKzEsBpT8GbjtJ66jdZgTqhTHQ30=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NPuVbjHqC9zv7hoJxgkZF9hxc+XrOgDO85IVufD1kowpjQF4lB3iGgI2/tg/zwnT9Xi/w1SNW0kaTJCImviR7z3ekEq0J1WiORPO1I5O/jt9muoTqU+mcvpFc79N8p6G9wc3a7sGpg1oOWJPNN6ddzaz8mq2eheld9+UXk2l2HA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=UdMcCuN6; arc=pass smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="UdMcCuN6"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38dd55ad76cso1635425a91.1
        for <linux-security-module@vger.kernel.org>; Fri, 17 Jul 2026 14:57:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784325474; cv=none;
        d=google.com; s=arc-20260327;
        b=FVbIDzWSz98lwZeq6Rw44BisyjYMgnIFmH/svjNK82IFQnG+uVe41aRMbIRaxpiciV
         abSm1EEEn4kYWAn7g0tKBGGFLumhRGvTuIiJ6qlgiSpSO+UIvcgEBwAHOhccavzhzdC6
         SSIfVzVCl0q0ZbXydEXKiGqS/jY5LL7kAKytNSdYjPgwi65PdT8Y/w/Znj6eZ6q8903z
         rgsVOsyFyNKALdpvKmZVGJGjomnXpuTiR0JegDI5+ng46mFHigypnViAbu82huMIw+6E
         KV2saXsXa9HBgFsWMHOi4Ky9q6mNT3YT5JGfvGzfgGHL/DrXj17OjYSK5dRTp3Lu67Sy
         l0iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bgbDhwhzJZUNbhJaBRFSWHTDEuqLeTObKnABflwdiWk=;
        fh=aa3vc3abKVWvRoXdVEdlEDeIDbsKHlCRdWMICIPeRws=;
        b=VOxug9Uccl28psXD3xzIKyj1HvlRqTF9WiELE1IdLWUdX4BymVfDDRLRP1MTiyBQOI
         D2yDqvGP8bf9HDIAIxM9ovF5kO3V0Quwaa6hbeYZSMJHTTII/mZyPTvCyny4R3yNVLJ3
         wKg/wvD/BvsWHL4o0lLsaBZTbHLQ7GsvQ4QrbazCVs4CB3r7PSet71pQSNWPMNaEfMhc
         FwAmYba/axyrpkcrAsPepMIWY6K5MtVJRjERxWMrUipt+s7n+ElLh9YdPqksjUom/zuY
         TstibPeF3EgzagCK68+p25yte3T6qML02VJPd3ExjiSXTt286DobZ+OiH2sC8geCYTnK
         GObQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1784325474; x=1784930274; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bgbDhwhzJZUNbhJaBRFSWHTDEuqLeTObKnABflwdiWk=;
        b=UdMcCuN6pmIb1qDSopK5+cWc5KmK2+puk0+V8MRKmxD6RnmVT9E6htlTIeviyla7iH
         7htMRxE1UCOetVqupCn9ha8KGD7cTnoelISO6cG8tJTO45jDOHc4JmOwx337G9ZQZC6C
         PsALt/xv0qrlzf7DlVEtThu4ETxN7Tb5TJDYbgLBrObp0SwiHHrqobl86Nq/nqqt5Gr7
         paAn4YPQCSwRNcmapvi1IA60ItD4KtN032WEeFQZiKb4tNW00+N/WHzKf790B6I1fYt/
         VlAS8f3k6HRP9nUvywV4QQgnShMNUcXq50A9s+lDU7JLVb78LokJv6QbWT+Lz7MJm/Id
         UC4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784325474; x=1784930274;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bgbDhwhzJZUNbhJaBRFSWHTDEuqLeTObKnABflwdiWk=;
        b=mTO743ACa+Ompd2J4ePEjMKX8y20O3SjHM6VE/865hne5OpozbiwuVK+ttzCYaU5xb
         9E3LZqHVZQsWA4Xiu1MJzY9//qhto0e2oj3fcEjyngK7ECNYlPLvWTo5gXxGZ2Skf3fS
         CYOc7Vc4jh+UDgAlWjW8SkrXeTkEVdW6uscg+AXNEkZeaMiRODMugbFTxuGZ5Y7Yh7vU
         kTEU7h5kAIGWl58t/zXtZCxRyZZ6gXMdmaq5a71oGQ5PJNLWZCACyTA9Z0BUZuDhX8xm
         GmpKdXC5RP/H71zEjSSQkAqWKXCaE0UFQc3FtSIq4zZWGAtO+Ps+TdLIe7qR4x6hK/yG
         N3uA==
X-Forwarded-Encrypted: i=1; AHgh+RpeP+N8E8jGNpAZ6gMwJvs2lB7GPAHsnmAOmGuj0xXM/AemQMmmS3lQTEK7c0ZF1DYXtVnnt7HgRWVWc9g3IhLkvwi9iLY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDfnt/Sxck5lqneWIuP6xjPgE8dRutqwMshQFzawaIt5jzXZ8H
	7C26Qp3rW0cmIE5wm2L5MvQyi2gwxKB9gh0fxtAd2gaxiKGkSR6HWjY8JO5CCrrGYu5wcExn8JK
	NU5WKiwa83v81GL/tNTAh7WQAXPsrT8UR2MJQ8Jiww23uykjBeM8Y2Q==
X-Gm-Gg: AfdE7cl2n8i5Xy9wLP/h2yunWjSgIxu8hjqtjKmZ12zkCI+zANVmgeEeZte20jjmT2B
	3GA0hTAa3JSgF6ckRRsBjfwZSsHtg0BZXAm5F4/2ZU/c4O/v5Rl/lLsAXteYgSItcl7j3SXfef+
	i6xGoDETlYTpEduYdS5qWFImpPziWMAB8LUK9E7MdlBl4Bwm/kpMpVzE0VOZXOcIjWArqCMjdVI
	w0a33xuxOfrATYfCFT3JrztxrQs1XZqxh7RdsYQkrc/sS9yFKIUaYPaEHDynw==
X-Received: by 2002:a17:90b:2fcc:b0:37f:d265:18d2 with SMTP id
 98e67ed59e1d1-38e4b5389ddmr3884045a91.7.1784325473691; Fri, 17 Jul 2026
 14:57:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260717215254.383183-2-paul@paul-moore.com> <CAHC9VhRcJGj3Pnrpmpi0uRi3ndcMVGGQorsU4dJ-vA_uQmRuQA@mail.gmail.com>
In-Reply-To: <CAHC9VhRcJGj3Pnrpmpi0uRi3ndcMVGGQorsU4dJ-vA_uQmRuQA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 17 Jul 2026 17:57:42 -0400
X-Gm-Features: AUfX_myljmg0RCwMRK3xg-pfZk7vFTlSMCGUKx5FE5dyw8lB2GUudLWs2RdN69A
Message-ID: <CAHC9VhQNthghRo8S-w8BQhe46ur8vhUyzW+xkOngAJQUb6O-Ug@mail.gmail.com>
Subject: Re: [PATCH] apparmor: leverage audit_log_n_untrustedstring() when possible
To: Georgia Garcia <georgia.garcia@canonical.com>
Cc: John Johansen <john.johansen@canonical.com>, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 17, 2026 at 5:54=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Fri, Jul 17, 2026 at 5:52=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> >
> > Make use of the audit_log_n_untrustedstring() function to simplify the
> > code in aa_label_xaudit().
> >
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > ---
> >  security/apparmor/label.c | 5 +----
> >  1 file changed, 1 insertion(+), 4 deletions(-)
>
> Untested beyond a basic compile, but I noticed this while looking at
> something else (unrelated) and wanted to send it to the list before I
> forgot about it ...

My apologies Georgia, I thought I had copied your email into the
original posting but it appears I copied John's email twice into my
posting script (which helpfully de-duped it).

Sorry about that.

> > diff --git a/security/apparmor/label.c b/security/apparmor/label.c
> > index 3fd384d8c41a..a165cadf8249 100644
> > --- a/security/apparmor/label.c
> > +++ b/security/apparmor/label.c
> > @@ -1743,10 +1743,7 @@ void aa_label_xaudit(struct audit_buffer *ab, st=
ruct aa_ns *ns,
> >                 str =3D (char *) label->hname;
> >                 len =3D strlen(str);
> >         }
> > -       if (audit_string_contains_control(str, len))
> > -               audit_log_n_hex(ab, str, len);
> > -       else
> > -               audit_log_n_string(ab, str, len);
> > +       audit_log_n_untrustedstring(ab, str, len);
> >
> >         kfree(name);
> >  }
> > --
> > 2.55.0

--=20
paul-moore.com
