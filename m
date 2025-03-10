Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E597A1DFFD
	for <linux-security-module@vger.kernel.org>; Mon, 10 Mar 2025 21:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741642623; cv=none; b=etLavlg0jn6b+O9CaaDWR23FIW0W1JyczXmh9STLzjZwgabnM0rtZWSSQWP+q60k8XAjQ40qFlUtpqa9QaWvaoSGVft6bRFR9+CVBmuZWCYEyGU3bH4gUdcGwGeBdw5xE2fhqzS98AsuUPK1KJQglBadpAYb0EyeLGXX4ygL8hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741642623; c=relaxed/simple;
	bh=ZffuVoKhYwkGsNLqoMxxm9ynreiXL0B3SKGY2kRVw4g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rdI0Blk0Tu3g4SSeRtmieoOCYeG18KVkOxg/K3KXJcD7lCcZYpqeWkb+8tnBu7bTXsKysWvVDxtChYrq/IQiMmH0NDDqy0pozdo3Wp9p4QQI6oG/QEGKU/0CBdtjCUzGL4cojqCz/MUGljPxhh0jTSxbkGi+apuJMTxvnuwLWKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=VO4vBSUa; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="VO4vBSUa"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e589c258663so4187846276.1
        for <linux-security-module@vger.kernel.org>; Mon, 10 Mar 2025 14:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1741642621; x=1742247421; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gy7RJJZ2+g4pp45KhfK/pE9AJmevdwLrlbqK7A52AiU=;
        b=VO4vBSUa5swLa3Z0+xq/whMa2b/cXq70dG0qRMODBvn16TgYAmCbxzu4g9iz9jEj5B
         o7AQoZQE0IAXn7HPtCy72SxSPwvoIejeMTTGReRYbfywoWL9jvJpcMIwZGx3/5n90agI
         i11OWEacsO5uZOWVXoVsTVN49wFdi5uTGPIr65I2k9accZL0aTxedwAc9vR5naXx5RYB
         qhjZjQqvP00OL34X5WGFdi3A3VH3Usv0qnYhbI4Kdjw3Wnt4fFgxDCtq1v++gkjfrTP4
         7WfBenhlWGJn+vSi8HZGnXwAQIV51c+7TmhERxZPZugjh/c9DKsVXDLNCK/2fFrDel/X
         py8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741642621; x=1742247421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gy7RJJZ2+g4pp45KhfK/pE9AJmevdwLrlbqK7A52AiU=;
        b=aWkzOF4Q52nK2hluKF7H/4Yatkko/hLLmWaYRY+XhLrFRjdJMWLva6wWcXu1nEzTt0
         aBSla0rYuwedXpJhNzNJ41iiSESsrK4qeZyAI1J92Q3BumTdbORdlQSpMDFfSxc5WzWW
         lzuuuh7S56yD6drce+euP3/qyVK4L8CaY69qTYaBbimSeP6qa3tG/GeVpo2tMftWOAd4
         E4+IDgcynurif288IIVhb6nGhs2lZIgikYFkcj8435jqE3s/ECQqAf6+146XoTkX1oeh
         4IrjJxQ8P9KyX0dxfiXHkuL7mssjr3d93pesl9tTHRLFOd79if/bM1O9uR/0ZgSBOXYn
         SDGA==
X-Forwarded-Encrypted: i=1; AJvYcCU+/MEAqDB8nmi3nzTDuLm3fHmGeX2/2JwlMC6xnqiJ4Il3g08j/x7p3VsxahNxPA7ReXMmyexCuxi3Bpv4jeF249IvdFo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE+taUw5Dty8XqYMclmhdxpMNjTmwVlFalOJTPNoZVUu6Ye3x7
	Li9J+tYPt+nlzKl6M/5dfuA7te3Y5a6OUTNzhfHF+MYOcI+v0Ygh1rhTKIvJt2r4gPTtRD9B6XJ
	Rzu+FYIFeT1JSg1pwxFgd5Nh1eGPQ31iwUzIn09uUMnWt8Sw=
X-Gm-Gg: ASbGncu8iEKRAJsfS6P+ZUfbX5NfGSHWuYTYzo02+M7xSaPYzOCkjnvhKYGUN9GzoU8
	2VO+9g6irIcTJdFy82KkUht19KU5iOHV+Q56rh8bCWHuT6Gy+p+u4YghhgWFAicf7XrFa315L82
	xFYmrggyznpfXzRoAXNikEeCAe7g==
X-Google-Smtp-Source: AGHT+IEABKnfIsajujJa9LtUyHzaHv1YlxNSFKNY9reAZnJdFRjFzK8//H8LPSIFRZ3SJpDoJEMId/3T2DG4O3sxnsE=
X-Received: by 2002:a05:6902:220d:b0:e5b:43e1:2e84 with SMTP id
 3f1490d57ef6-e635c121f9emr22237146276.5.1741642620692; Mon, 10 Mar 2025
 14:37:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z82Sug-XLC1r5wKE@lei> <f44bad6065bbf45c02dc7caf90ed0e7e@paul-moore.com>
 <20250310213237.GA195898@mail.hallyn.com>
In-Reply-To: <20250310213237.GA195898@mail.hallyn.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 10 Mar 2025 17:36:54 -0400
X-Gm-Features: AQ5f1JoA1yAFuUk_pWTCCQXK_vbLp2GoCURFNTHFh0-PEifsu_ff6RzwzZJnk80
Message-ID: <CAHC9VhTSdq=zrkmipZJjTMcudbyvHJeq+XR3Td7mr7cEn+GDEA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: add Serge Hallyn as maintainer for creds
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: sergeh@kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 5:32=E2=80=AFPM Serge E. Hallyn <serge@hallyn.com> =
wrote:
> On Mon, Mar 10, 2025 at 03:58:41PM -0400, Paul Moore wrote:
> > On Mar  9, 2025 sergeh@kernel.org wrote:
> > >
> > > Also add the documentation file as suggested by G=C3=BCnther Noack.
> > >
> > > Signed-off-by: Serge Hallyn <sergeh@kernel.org>
> > > ---
> > >  MAINTAINERS | 2 ++
> > >  1 file changed, 2 insertions(+)
> >
> > I adjusted the subject line to reflect that you chose the reviewer role=
,
> > but otherwise this looks good, merged into lsm/dev.  Thanks!
>
> Oh, did I?  I went back and forth, and actually *intended* M, but must
> have left my git index out of sorts :)  No problem - reviewer probably
> makes more sense.

The patch you posted to the mailing list had "R:" before your name :)

I'm happy either way, if you would prefer a "M:" just let me know and
I can update the commit.

--=20
paul-moore.com
