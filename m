Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A83B57333
	for <linux-security-module@vger.kernel.org>; Mon,  3 Jun 2024 22:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717454172; cv=none; b=HplZtpj8/eeYDBijVMlX5DhxtHS/tsNUUierEUQye0FecTds5Afm/3Hlh+2haBnwkr+YCb0tnmhn3EUCAQWbKgA722jDQdv7yZYlGDc2aT+vmn4X/PtxCdWsak2xymAdmzhntN2EgGYSMCN5fDaIPiTMTpfg7A+0x3tRDZYOhC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717454172; c=relaxed/simple;
	bh=eLQTm5bdwsIaGMdIKYVz+iwaKfPty9F535UJJa1XdvU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hlFKOBdCyvCOymCRciR1eH+iER/NFKVxiofNPSygXa+TjPUqJdHhftHseNlte5TfY7J30d9+vWA5x5uNg1pIpzREwx+a1lCcbZCItZVonterSW9goG56P5bEJSfnoluIL7k7oUwftX8rJM9tuQBIUusqo/TVWBL4mu4foUKP1MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=JUnqFBuI; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="JUnqFBuI"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-62a2a6a5ccfso50351797b3.3
        for <linux-security-module@vger.kernel.org>; Mon, 03 Jun 2024 15:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1717454169; x=1718058969; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eLQTm5bdwsIaGMdIKYVz+iwaKfPty9F535UJJa1XdvU=;
        b=JUnqFBuImCJDxqUT1ykjHVXh/ujwI5KrsEYcF8hSJ8DtqDHHcqkSEg4FZru1kvyFte
         MA6rVBesYqx4Sz2p+AoXgo/mo9uUMZbr/e4goohb9qLEes8CSzML0Deb7qgRFWxjxV6v
         AFRu2UJmCkmC1nuAaut6YXv58I5Hoi3HrFx1/LNpcTDRPWnWvMUAifAzPtoeGycycNPD
         jI/eY72Vv5CG1w6dv5hVKYCeWcAgtVpEK/FPbys7BikwBpQ01eSo16084nMqZ3deecjJ
         g0QbKCAQS+rXzf7ol53epun0N9ZChMnP92nPOKHolmGxzNCU2mimAGRwrNdoqWemv6vi
         1Sow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717454169; x=1718058969;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eLQTm5bdwsIaGMdIKYVz+iwaKfPty9F535UJJa1XdvU=;
        b=S8VPrY+tTk2mw3jPAv9g9G8FxsTXgrMmc3MHtxph5BNzQT5koK+wnKUHX7l3mQm2ES
         xT5w7NFX2v9iVoEbO40dZFDZ5uUAfJnCi5NypjsjDiAUPQK9bs6gtMzaAiM5FDoXLou1
         nfB56vRHh9dL97+p3EGpjb3bKL3O9/7pw+v1roLf8JTu/K8b6D40IhJplQkdG2FKwM0c
         qpJ6y75Psqb5nGPL9Ri5TRKESm7SxlWpoqxnZQLLndt1t2I92NRah60gCHMev+BYwFNw
         a3+0NADChNC8OG9/rZ1XJk14txjl8IB/t5sKb1hnNbhPGTzqdaj5nV/9RthwnjFoJh4p
         QcAA==
X-Forwarded-Encrypted: i=1; AJvYcCWbr7416BZRb/MJjGtDSOPxu6SJxjxZ5MCaV10qsghILi7PkXa/+Hl5Kvl2THezSD4vECmZroTJP2XQHq4+sWbx4VvYdHY/o3LJyf6bkWWXryZzlO+O
X-Gm-Message-State: AOJu0Yz1jN5ewIAZ4ugEqdD8EzDgryz7UDQtXQoHFKZnVtiOohyOu2cv
	l9PQYRNeOeVqDbIIjlWRS3k59urpFaEsJMyai2pdTe3/hqwzcEZaUvb4/6XmCt2tcWIt/NnVeJr
	mJavv8MFisM39wfqLAzme/1kVVaXSgQlv2j9m
X-Google-Smtp-Source: AGHT+IEnEj0HaAe2XXJ+P58B/3DENp7qDyeNgjkaCnTRpS2uJyaK4IE7boqra/mRVtjfChhSz9siZckxkdCbwRz+WVk=
X-Received: by 2002:a81:ee03:0:b0:610:e9b2:f84a with SMTP id
 00721157ae682-62c79720b48mr101000677b3.26.1717454169627; Mon, 03 Jun 2024
 15:36:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240315125418.273104-1-cgzones@googlemail.com>
 <20240315125418.273104-2-cgzones@googlemail.com> <202403281506.46D9C5BEEA@keescook>
In-Reply-To: <202403281506.46D9C5BEEA@keescook>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 3 Jun 2024 18:35:59 -0400
Message-ID: <CAHC9VhTWoehrxwPe3_Xf0Jud-ouc8Cfwp0hwcE3+JekWQ2nJXA@mail.gmail.com>
Subject: Re: [PATCH 1/2] yama: document function parameter
To: Kees Cook <keescook@chromium.org>
Cc: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, 
	linux-security-module@vger.kernel.org, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 6:06=E2=80=AFPM Kees Cook <keescook@chromium.org> w=
rote:
> On Fri, Mar 15, 2024 at 01:54:10PM +0100, Christian G=C3=B6ttsche wrote:
> > Document the unused function parameter of yama_relation_cleanup() to
> > please kernel doc warnings.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Reviewed-by: Kees Cook <keescook@chromium.org>

I ran across this in patchwork just now and don't see it upstream yet,
you're picking this up right Kees?

--=20
paul-moore.com
