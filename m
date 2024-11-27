Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FCA1805A
	for <linux-security-module@vger.kernel.org>; Wed, 27 Nov 2024 04:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732680141; cv=none; b=LYQs0qKPSyAUwrigF2e7nvI0zwtWaXosO+E7CwR8d8YAWpobLC3eNU/yyc0l3m5TIgqw0yC7KjATEYw4kC1m+OAdRiwT9wzQkKQOzTzr1I5RcB7ifPTk53pisu7Yw9ItlqbJNbMH35BLJjAF4PTNthQPqxMBa69F25gpu7jcO+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732680141; c=relaxed/simple;
	bh=rgGUtTi6cgHbXeEIBneesc4o26QfRW4kSE8z1VlqAaE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bh9LFGcmF7l0FaLGyhzv3PWgq42cG0sBA7ypyQMnSZza4DG8kIis+O2QqH1enSyJCBKxGdgheKRBon5Wb4Zu9P+KLqnRg+lRc82BxToyrhJY7/FWMhsLGo1i8811e27Pf4stp0uPwRUL9BLk1jZQNyNemSTTA8+JGidXzr7FRPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=MJu6yPxR; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="MJu6yPxR"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e3839177651so5044236276.3
        for <linux-security-module@vger.kernel.org>; Tue, 26 Nov 2024 20:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1732680137; x=1733284937; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uYdPHxRKENTOkIj1dnE8bjE/PoWNE+0I9VP8yD2g53Q=;
        b=MJu6yPxR0bpmYq3MPhwFovVdnvbGor5GSl5VunSGA/TQ9H6oUmNCy3zKyuOdm3/uua
         4nt0op4cvi9S6y/9i9SPy6M0hfmfN/4dnmhcUiIH+xtcPQrwtX2xhwJxGw3VC0ArCkb5
         4eXN0C9+fG90aUgoZCOrKwCd1VexkFviOyhospxgnqEAxINSKDngtrqcPttS+HYR5IZA
         orSirMqUpzgeXGQVMTUWDfD4Pu1bBDyFV01Gr2OXcyWAFfGfVSQHPn077LRaGQOl60GW
         oagCpzIJSOy3ScIBM66K6DUmFFnZMwP4o0VSBvzLIzV+p51/VgXhlRg/w6LOaKk5Amq6
         IQnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732680137; x=1733284937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uYdPHxRKENTOkIj1dnE8bjE/PoWNE+0I9VP8yD2g53Q=;
        b=RwlMy5qsJmfFyrMhbjCnnA1w0om+ZSgpYKkFa0agfL27pzzyE33TyOPn1HsSI21J8y
         iXQON5cdA8LEEm/DlIFxlx1OUuWH+lpfX189JPpYoq7dcKoI5/dH6Irdo2F+Vn90kebn
         xH+p4tkKHtftWS58KTV4fr7XIKUPk5D4xoYHlKZFUZ9L7iAcWMv23Gp+LLhC2jCYH/ZX
         EUbhIHQYbNYy4jSt7W6mInAhukLPoJnkY8eh0zQv5qxgfPleM0qoDhMGfARLXfdGS/Va
         VxbtwS0X+xzZcUDQtiEeB+Ire235dJmllT7jhBRGZy6NuWHzqtXrj/fJh6yF+YYV92gK
         2Dpg==
X-Forwarded-Encrypted: i=1; AJvYcCXX1fAo/z2femh4q2qPIm9bTEYq1Yc3WtB657VZJhnYX+BTi89TBST35D9p8a4Obv715wbfiij356d6A4KnDybrsne3JNk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKZU5yyOWmixtvj1TmvInGpLBVW8sYdMCpr0aFTm1F+O3TxKyQ
	atowZOLieY5PZHPcrzzCxcFCzdrlx5N9OqT1n4McB9OENKr0GdDJYnneA03dKq+wc9nosTtKIHi
	/bNF9rdpnU+aIf2tHZccdvxibh6aBrE5eFH0o
X-Gm-Gg: ASbGncsugREVFYOu156UW4eW4QBH/D4RH2XbDMc/07dmP1CxfzZvqvQqSH8lRKTpNsV
	fbq1mqM6fcWj02dH3vBwbfdcTHrkkwQ==
X-Google-Smtp-Source: AGHT+IFIhoHV1KZILzwwjbRHgH3oq5xxKI/6tI2yJz7Higi7u+bkhBhq9AhbFSn85Rm7+o3h+w2rhHHyh73JVHZ2jOM=
X-Received: by 2002:a05:6902:114b:b0:e38:b868:cfea with SMTP id
 3f1490d57ef6-e395b891d60mr1535472276.16.1732680137568; Tue, 26 Nov 2024
 20:02:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJ2a_DeUX9UdAYOo9OwG-yXSH1etKQZortPcyxfzG70K3N+g7g@mail.gmail.com>
 <77003d04-f3a4-46b1-9368-510b529fda44@schaufler-ca.com>
In-Reply-To: <77003d04-f3a4-46b1-9368-510b529fda44@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 26 Nov 2024 23:02:06 -0500
Message-ID: <CAHC9VhTmyHr1U97mE0YwueJ_-8p_sBK-CB6O8rWMUz1Gr70iKw@mail.gmail.com>
Subject: Re: [PATCH] IMA,LSM: Uncover hidden variable in ima_match_rules()
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, 
	linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>, 
	"M: Roberto Sassu" <roberto.sassu@huawei.com>, "M: Dmitry Kasatkin" <dmitry.kasatkin@gmail.com>, 
	"R: Eric Snowberg" <eric.snowberg@oracle.com>, LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2024 at 1:21=E2=80=AFPM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
>
> The variable name "prop" is inadvertently used twice in
> ima_match_rules(), resulting in incorrect use of the local
> variable when the function parameter should have been.
> Rename the local variable and correct the use if the parameter.

/if/of/

> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> Suggested-by: Roberto Sassu <roberto.sassu@huawei.com>
> Reviewed-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  security/integrity/ima/ima_policy.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

Aside from the typo above (which can be fixed during the merge) this
looks good to me.  Based on the discussion in the previous revision it
looks like Roberto would prefer this go via the LSM tree, so I'm going
to merge this into lsm/stable-6.13 and send this up to Linus later
this week (or early next depending on how my holiday travels go);
additional testing is always welcome :)

I'm also going to swap Roberto's reviewed-by tag for his ack which he
gave on the previous revision as this is touching IMA code.

--=20
paul-moore.com
