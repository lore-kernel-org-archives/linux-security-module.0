Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4C235DA78
	for <linux-security-module@vger.kernel.org>; Thu,  2 Jul 2026 16:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783011033; cv=pass; b=QZW/HB9YxKO7cOuWZXvWKCa03yjNBhfywVrMT77Y+HzsjC2b5RFES+4lBX9N1/Pyx6s/Mk0nvbD3t2fTRqnlAYOzXluU7CHspQ7Gs3hfgbyKky4Eg0DZeA2jUQc9UsOE3GibgRPb4Xt8xtFHs1bj0+hY3oj25qnHhFcYU82aGQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783011033; c=relaxed/simple;
	bh=MYmrI09amhjLqSAbahgTEWur6GL/kjiiPuUFpLejiQA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k31MaDDzogd+cx4enG4DwspHWLHjrPStDSRjXz0OLg0aarf8l2am9HMHJGL300k1/tOkzu11yivCFvHFf4Av/PViLtzkEmYAMaYuzQXhUuVrXkYbDoDQx98BdOlActZ8SVJ3H0unYckJNO9uoRWVwrdk7YqZXa2cQ+nupxbfbtw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ZCGlSf70; arc=pass smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ZCGlSf70"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-845b6d9bf39so866730b3a.1
        for <linux-security-module@vger.kernel.org>; Thu, 02 Jul 2026 09:50:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783011030; cv=none;
        d=google.com; s=arc-20260327;
        b=Ie8te2U3DXdgkhO6wWq3qfpFiAvvZ0XKfVtrcdyA7MrLrFJE2hAVt9OnqinKnwckS/
         70UKzBBZ5pNI2dJZQdMGBMCuL1do5np1btdwUmNatn/x2s8kcBs+ne28epZpMtOL6aly
         BST3FnF6r2oVVROr8F6vQzZdcRxAIDsYSbBXf3P1Bducjawz4kX9+TqJVb61sQ9THJMb
         h0Hyh/P+E7nTyNLwFFHvmiToglCnZmE+UNdGnk64GcJrEuuN0PVlxpLMaU2ODHYgA/JF
         LUlnBTv1O9/+h21Fw7gui7T/RzBvywrVQdynjz/q37awA1hu7b2KSdmlvNw3xtFoqyj5
         7myA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MYmrI09amhjLqSAbahgTEWur6GL/kjiiPuUFpLejiQA=;
        fh=A8m2RFp0N0/ZBkuq7bOuqdleilnh+XhR903PEzKsJsE=;
        b=jF+GVbls5r0HqIAW8d3gO3xaX/dLHN1R3pAj37kGEo5/yc7ao/QW+8k+KBUCSI1ZmK
         3r2Fy6skICPKAC4AMSQLeUom70FIabFtaDO59Mdm6bZb8efrDnkrG7Xe/OYNA6SohpOY
         sYNpL4MpCNtSWEgZ2Vg6U3PGRYaRUS+HG10Cz9Y0/IR9DluQR/XZGLpzYZMO1fg19i6e
         NAcWg5TVMvhP+tvh7JlJ9UCL4D2Z0GcDzUTcgoKLdtt4nDxlKszMz7aISrN9dyGWf0aP
         6/RCMDeHem7qTnKju4inRUAbfSHa/v+oktRipGE3E7tUi0MqgVo6Y6LbxLTMf2Jj3nwX
         Lx5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1783011030; x=1783615830; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MYmrI09amhjLqSAbahgTEWur6GL/kjiiPuUFpLejiQA=;
        b=ZCGlSf70DkuO/WgiLI7FItnXRcJCm75jGa9kUuhvnIfZvledcpXwFBScOWz7QsKgg2
         REFmG7oqOEBHOqEEZjmeuQ1+mNVdlRCxd2vcES6akNaspsoaSfcpDgBVcLuHwR1y0njB
         kilhG/OkcAQRxAS9qzmIEcEm1i3ORwmW4tqxSaWFlu9HxyDDKEldvfw+9y1VncC5vkQ8
         LZwxkdft8tEWaInyfzsjS55eNMiCXUW9kVxcMb6215HZczgMnnl3/yDizZcuCiedMDiC
         fTFx9N8kSgn67m7YIhlFOmqKlvIvVKbxUu+5Y+r6AYcUIbtVeEKr7caDDB1MU+RiNKD4
         nWRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783011030; x=1783615830;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MYmrI09amhjLqSAbahgTEWur6GL/kjiiPuUFpLejiQA=;
        b=L0Lz2eTqdLBfNUb/uiagQHjf4ocvtCWtc/eSY/apEJH4loKofOE65JNdL1K7t73x6a
         AekRB+Hh9yB5qU15Xq/84CzyQAMVHYUrtJLUtKeAmA30//iv9+WVkveASpWQdjsXL5mn
         I37diAaC67oXfAUUP1S9zJxC/HqzCoT6PSLejSRBN5XysEtAiHBjhFUNDhzkff75IWif
         BMO4KC188+TAX8zl9Jm+y+s2RKcuwZ+2o0BpwNgtK4B5zhzWaMiIOqz5ZTlEIZMVrtCJ
         5M5W7sh68nWTmtWDbJNlcUC8NTrJ1IAc0+xETPDoDGcZ8nPb3HaeLr4LJn+u227I4S9b
         SLNQ==
X-Forwarded-Encrypted: i=1; AHgh+RoaD0MVYuz71UGHcjuFyhuaXgZcOA9JcvZnwhGFELZg+QfRuQk4qPq5zRJDQnaKjaI+QvB8lySk1myNQjBjr+GIf6ljVNk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLgBAtngRRinK//OO7RXWjsP9dhzJC5xFZ37EGEGVnbtLlKhtB
	k89na8OImUgIUg7cVdVk2J8ewci4bEIk4OlQqA00eNFrPn7vFtVYr7/93LZLbZ2nP8YFtnV5MXJ
	bGKadYxpPWYCYX7h1ed0zXNUzidjBwAOnUkzi7xAI
X-Gm-Gg: AfdE7clyY6BnRG/MlJHrrXARJtBGZiQFOHoNtSGNnmoRZUEMtQ5UuFKDB3BTjFUrR1/
	Y/hfd/vEMielE5mgdsFOnrpFgWzBTQtlT58YJRDwgAN1LcvWJewEnZtyfPf1KyeRqZ4uFobT0We
	m58O2yBQWoZGCP8vm8oW27Svxv+s/ublMwBUVWAkGfbh4lezlc8uo1SkTcseYKMQKOHl2lh2rTw
	WFLZOmZH1xmhKPH6yV7ShL2PgY8hTOGRAQr/hFc2sTleIna+TXWHq+w43htOUxs3ntMBeSd
X-Received: by 2002:a05:6a00:b52:b0:847:84c9:8ff8 with SMTP id
 d2e1a72fcca58-847e18f8fccmr507308b3a.28.1783011029998; Thu, 02 Jul 2026
 09:50:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119091226.3195309-1-caixinchen1@huawei.com>
 <b12a0d60-da15-4ba7-a526-247b5a7d97ad@huawei.com> <CAHC9VhRokERQGaB-1Xf0AoAzmT5tys4d+e4pmVY-W-88GQ8Jpg@mail.gmail.com>
In-Reply-To: <CAHC9VhRokERQGaB-1Xf0AoAzmT5tys4d+e4pmVY-W-88GQ8Jpg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 2 Jul 2026 12:50:18 -0400
X-Gm-Features: AVVi8Ce78ge1QaGCAaHJ8L5bCQ7K5IBd7RNyQ9tApHcRA7928CwqRwIQ4pkgzBo
Message-ID: <CAHC9VhTQT05+1qYM-8_YTc84Rx2SdZV1iRixeqAywCXf1mMddQ@mail.gmail.com>
Subject: Re: [PATCH -next] lockdown: Add break in lockdown_write
To: Xiu Jianfeng <xiujianfeng@huawei.com>, nicolas.bouchinet@oss.cyber.gouv.fr
Cc: Cai Xinchen <caixinchen1@huawei.com>, jmorris@namei.org, serge@hallyn.com, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 22, 2026 at 12:41=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
>
> On Thu, Jan 22, 2026 at 4:31=E2=80=AFAM Xiu Jianfeng <xiujianfeng@huawei.=
com> wrote:
> > On 1/19/2026 5:12 PM, Cai Xinchen wrote:
> > > After the label is matched successful, any other levels judgements
> > > are meaningless. Therefore, add break to return early
> > >
> > > Signed-off-by: Cai Xinchen <caixinchen1@huawei.com>
> >
> > Looks good to me, thanks.
> >
> > Acked-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> >
> > Paul,
> >
> > Would you mind if this patch went through the LSM tree? :)
>
> Assuming Nicolas is okay with that, I can take this through the LSM tree.

Following up on this as I never saw a response on-list and the patch
doesn't appear to be in Linus' tree.

--=20
paul-moore.com
