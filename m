Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4307A1B29DA
	for <linux-security-module@vger.kernel.org>; Thu, 20 Jun 2024 16:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718902480; cv=none; b=kgiSl+fb5iH+Mq223tfobbsqgpANZRzDgQWcssGngLYPt0Mf8HLsly6ZG5JoCllyn3LH9QI/2FWcHDbidpZChDVXd/2j4TWbePd6lOBo5PWLggrRBpuLw1HRY80mGarnUNa4YX9edJGL79icOUEXutQYBmxyxodLLCJsLgT/Ejc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718902480; c=relaxed/simple;
	bh=Wqp9vZOjGXxNeztCTRhZXaV/kM8U5SAYlJJa2Su7aFY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bd/8VYpvByWTcSrTLwyqhSbvTpWvauKJAMQ5V5jbjAJlRe0jUC+eYQHZUQU4iDw1hbcbEWjM57Zk3Ss94OGtslBtYTEwUBhyGOY1i4PwbYrHO1JgDxj6ftllW1SxcHmouUUYwqb8ji7D1gFezIhYEFS00IZycSzAJR0P88JWoYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ODwvZO3o; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ODwvZO3o"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dff06b3f413so1056443276.3
        for <linux-security-module@vger.kernel.org>; Thu, 20 Jun 2024 09:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1718902478; x=1719507278; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nU32yJqLVWlauO1MOjGbdfeZvhkP3RdEVxn5gIXcZPk=;
        b=ODwvZO3ogo2UMLwhPrtupguu3JIurgoLDcMxA3oKU5Abw+okdMRfgtCpGq/ZXLgioB
         uOrWl3X5Nx/efGnBlUSulgfd1mMyhre+nyHhLGGWqQZLYDcjzsR/P3Z9/JlNPEDopCSt
         clKO17sS7CI7lKviTQzMbOF+eQyR9ZsZVz1fwZsszoAdTpRvKmPWLrNWge3HgVIYGrVi
         W1tHg6pRNkmKQtgr2XBVMJZNBjbHi1iFyaoG0dIGmdc9ydgy3CC+Qw0F+/sYAuIfd1pM
         UyY2j6tb97KGh8EWdo7ooBHSuX5ETEyz8HAdf4dsJMQPIGQjW8wcIGZg4qOuQctnNEi/
         TB5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718902478; x=1719507278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nU32yJqLVWlauO1MOjGbdfeZvhkP3RdEVxn5gIXcZPk=;
        b=Eeb2/0LLjjB5JrXOf3cA4I+ac0rYdlZnkIOJtAM3xbmpKGwyAGlpTwUn+6BOwkffiI
         w6UxL3F4IYg04oosG+9xe1Oc2kig1mvPhrewQ4iVDYPw3c8lnZmVnajK1raF9/x+SjSW
         2mEfq8nmHmy6SaaS/FlKrn2az+HF7g63KN3Px8J2YwTq7x68coNJ33Dk3Lps2onhSYI8
         KzYlkmD+/+/qbYr62DTYbKdE1umtq2380gPLYLs55UBFIu32XKVHhOek3xGnTAGihqbl
         z9I0oEQMymrs2YS49paF1QM/zi3ON5NWhPQbv40p2fyxB1+/jW3UDlHshoopdmMw9nbp
         sDPA==
X-Forwarded-Encrypted: i=1; AJvYcCUP9kh5TmNJP204Z7jbDNG734dbX/fgqAlV2NNr2LVzn7l8mb59nfntqLmQPIIWg0UfR18oHYRwjND8M8Sqh6sNhaXQY2cXo9u3m21+oJ2zsCf5AeDM
X-Gm-Message-State: AOJu0YxseW0y7CaLcpd8VEqJU8+vXLUKKA4hrujJcmDsktI7DFxypmIU
	VtE+1kauiUUyThBd0n8zPfM7Sr+1Fj62zYUECYmrmVICzBP2Jtzu6Wa4RAG7sweys9I9QbtPnR7
	5XgRRuFrWPJck5Cy86Pxmer5hh5aTnCFjfavQ
X-Google-Smtp-Source: AGHT+IF13BHpoNYPwS4PQPx7j7170Xyxvk6ucDaOXGDhfaS1JKo7NId9A6sAy7bCJmw3neQ25h0P/Cwv0uX6xpzNWNQ=
X-Received: by 2002:a25:7442:0:b0:dfe:3e88:3649 with SMTP id
 3f1490d57ef6-e02be13b1e3mr6638405276.20.1718902478328; Thu, 20 Jun 2024
 09:54:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606-md-trusted-v3-0-42716f15e66e@quicinc.com>
 <20240606-md-trusted-v3-1-42716f15e66e@quicinc.com> <D24EWHXV14EM.S0NQ3H51R892@kernel.org>
In-Reply-To: <D24EWHXV14EM.S0NQ3H51R892@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 20 Jun 2024 12:54:26 -0400
Message-ID: <CAHC9VhSVSS46oCAz_NrUUGstmG3j0NVk70-SwwtCTVJ-R1Z+OA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] KEYS: trusted: add missing MODULE_DESCRIPTION()
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	David Howells <dhowells@redhat.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, linux-integrity@vger.kernel.org, 
	keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 8:19=E2=80=AFPM Jarkko Sakkinen <jarkko@kernel.org>=
 wrote:
> On Fri Jun 7, 2024 at 4:47 AM EEST, Jeff Johnson wrote:
> > kbuild reports:
> >
> > WARNING: modpost: missing MODULE_DESCRIPTION() in security/keys/trusted=
-keys/trusted.o
> >
> > Add the missing MODULE_DESCRIPTION() macro invocation.
> >
> > Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> > ---
> >  security/keys/trusted-keys/trusted_core.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/security/keys/trusted-keys/trusted_core.c b/security/keys/=
trusted-keys/trusted_core.c
> > index 5113aeae5628..e2d9644efde1 100644
> > --- a/security/keys/trusted-keys/trusted_core.c
> > +++ b/security/keys/trusted-keys/trusted_core.c
> > @@ -395,4 +395,5 @@ static void __exit cleanup_trusted(void)
> >  late_initcall(init_trusted);
> >  module_exit(cleanup_trusted);
> >
> > +MODULE_DESCRIPTION("Trusted Key type");
> >  MODULE_LICENSE("GPL");
>
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Are you planning on taking these patches Jarkko?

--=20
paul-moore.com
