Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9768A4C91
	for <linux-security-module@vger.kernel.org>; Fri, 24 Jan 2025 01:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737680563; cv=none; b=L7hfM1NK3rglEEwGyQlBdqIrsyhvz15ux0o6U0KOI7Q/2FIsItkfdTHgoW65WOoBluMmlIyXO60JShbZ+ZS0JUtH2h1fnM8Bwp+xVFD4ThJ6kI0nf6QEDNllUHu/OXfkZ/djSJ7pmwYG8kbrjTySUKBkrQ6R3fiIzbwgSz96bZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737680563; c=relaxed/simple;
	bh=rWo4Nb9mYvI0PiMIQ2wnnmSMguUdWNj5SKVmlpgERa4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fQV8QV2JZh22tNbcf2qNMc/w3aq8xsah0ev8+fBU87iFDFlJpTGYpnTqjSnUu82aTy3Te/8L1wceHmgQYPqTM/Ls58/fNvt6qXH0X8/LSHtXtJbypK6OgfUrxFWPhwIIMJWf5/Y+fOYQwtbOdE0VyQN5eqN0fF6Jr92BJfV9n8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=V+maciEu; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="V+maciEu"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e53a91756e5so2859163276.1
        for <linux-security-module@vger.kernel.org>; Thu, 23 Jan 2025 17:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1737680559; x=1738285359; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AHr9mD9A58MKwLx0E6DiQmvmvw3cmv2wbrUh7jTBVtY=;
        b=V+maciEu+c2YgKWxY8wVvr37FIgZJuaWmtHgd7YWVM4+wyKIgpbshVn7F7FCPwBVSJ
         ZVnsC+YM3eO2DKe2uRB/Hb2/amS3kfcLKbUCt2imLEsdSfYqxHCm3v1o5bNZY/aMh555
         jupgqOVdTcy74D5TdtOKH16TzUr9/OTIdnvUq6MwV/sLUYT5cLxctoaqs3anxTTEiKJa
         CCbFHMNROWSD9mDVFzTI11mq2/6+cUcnxjZldxPVbMR0SdQMvo9hsLwNnz+PARKIwNap
         7Xh6emdvAACAu7fzF1fMmvXsLc6VMjIFchOeTkiity2KmAZ4IlHbyIKKrkQbzxHjxwOf
         JD8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737680559; x=1738285359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AHr9mD9A58MKwLx0E6DiQmvmvw3cmv2wbrUh7jTBVtY=;
        b=XUx2qWHz98NvEvnRUijp6gVaSVFNcmW84ATVZ/DKBH6xE5zN3SiK0lOcekzE8xCCA+
         tBMqOIdMztU3/CrIBIDyJmhcCpLwqiKdPhk57Tneje6Iv6TeA5wdXMbe0imtVinp95cZ
         Z+e8gwsgdt4LR4s4bJpKc4azKTqHZDBSn/NZtIc7A40HrNAlcw5TZYvozm4l/WFRU/Ol
         ritW694TbI4XP3YJKyv0b3exGUK5N31ovEwM+uGiBR27WmL/1V4oepWSp72uiWK/b7G2
         l1zvIn76jm7ttQKVY5wlWx2u8CEm1gymZXrUyM5kED0CH+7BjgfK/MbozXVpkT2Q2qp5
         OgXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNAHGE22a9aTf6GDhHZ5AIBuZoUtH1olL9jSttwITyNuERG2usNzcx1RFBlUELrqMNTFc9QRfYls/VNm4d7hORB4m0BZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS5r12XAB5FUvSQ0xtISkre3OJ6Ba2AvExcoH4OpFWDvChbHaS
	zD/krRjYTl/93+U4ARioi/KUbuI3FzZZQiK146efXd7TZkYYf8evJ+LiQW2b0J4r88d6nCEQFrr
	Z3trHVC6dnh0QIsxWQqBSSjWpxKtpvrjtWujd4grTanQzf6s=
X-Gm-Gg: ASbGncu045k3Ef3zw83ypf2DQ6+ru7YIzdXTnnnHCvOK3bzHJuJbg1EhujO1bFpOr+S
	3GvCjGOQUPXTcpeyOnUDSSdJ/EbitFKP4DB72xpeWd3fFJLsxF2Yw7pAW9ufj
X-Google-Smtp-Source: AGHT+IElp6TBEcc84dL7qmH9z3gGe/bK7LKNsZXLq++G7Vn4tEsmoTZ3xVmsWhnzvir0ZRpTUNnQVXOTWirLrtcXPik=
X-Received: by 2002:a05:690c:6a04:b0:6ef:48ac:9d0c with SMTP id
 00721157ae682-6f6eb90d52fmr226383637b3.25.1737680559461; Thu, 23 Jan 2025
 17:02:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250123-sysctl-kees-v1-0-533359e74d66@suse.com> <202501231521.A114C18BE@keescook>
In-Reply-To: <202501231521.A114C18BE@keescook>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 23 Jan 2025 20:02:28 -0500
X-Gm-Features: AWEUYZlvqupEnE3nswlAITAU0hFnRLfZwPmbchWJyo7ZrVU4xcLOuYvltZht8fg
Message-ID: <CAHC9VhQz-uOsKTynZk-vcGxLgSTJPaT-6QkfkT+poDSu=XV8dA@mail.gmail.com>
Subject: Re: [PATCH 0/2] security: Constify sysctl tables
To: Kees Cook <kees@kernel.org>
Cc: "Ricardo B. Marliere" <ricardo@marliere.net>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, "Ricardo B. Marliere" <rbm@suse.com>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 23, 2025 at 6:21=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
> On Thu, Jan 23, 2025 at 04:33:33PM -0300, Ricardo B. Marliere wrote:
> > Please consider pulling these small cleanup patches. They simply add
> > "const" to a couple of ctl_table structs within your subsystem.
>
> Paul, do you want to take these, or should I put them in my tree?

Since you maintain both Yama and LoadPin and these patches are fully
contained within those LSMs I kinda figured you would grab them for
their respective trees.  However, if you would prefer for me to take
them via the LSM tree I can do that, just let me know.

You can also feel free to add my review tag to both patches if you want.

Reviewed-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
