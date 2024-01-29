Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188821586D9
	for <linux-security-module@vger.kernel.org>; Mon, 29 Jan 2024 21:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706565363; cv=none; b=FpPNWFm8MhHX76rC++ekww4UR1ETM2/hOb87xi6Yl9maEhQazKtKZcSAa8osoqcnaha6kPkZdPY7wpFlga9NOlyRdImidcyeNF4OnbZkcfsCJ9sdWbjkUvEvnJO73jM1t0WijFhNuBrHm1I/kqDwGarhQhG6N4MZxfL8odePzl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706565363; c=relaxed/simple;
	bh=ZSZJK35l8EgwFmVZ8i8owr3cheq755BtsNinccw6QN4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ArbwDV3ZBXnvm44GEvxPcF3/l6bnBbggNX3NqFqyBnnu8p9CxxFa/mWpPCiiLDvxJ7/4ny6YBS0PmdJcxQtxj9EIN3goqxRqT2IMm3GExd7Z6fsJiVeHvN7185gTldcWhvFKCU05YGuIG83mswRoGbSZaDjq4GDmI+WBz2lbiw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=DpwbYrKn; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="DpwbYrKn"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dc221f01302so3084822276.2
        for <linux-security-module@vger.kernel.org>; Mon, 29 Jan 2024 13:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1706565360; x=1707170160; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UV/iIRO0zfu5R/kLa/LTz7qDudbKFOHxBhGDjxapsKo=;
        b=DpwbYrKnewJVloDgLdCCgId9G6zHLCpjrwt4IDRcETSqnrn8hfHc7rGGtTIalcgblx
         EFKhYuDy8J6dekShhRyQqE2U/HfL1BTAbokQp2i+r4DyMEHy6fiQLTgum5WL0XIwGh2e
         oHwXaFvwb76clXcz3MsAuPvprmKu4Hlx+Dab5khy2pAuTVtuXG0HXtMLr7hh8J9ngkCQ
         B2AQhFdHeL9Je7o71+4oI4ku815/HneT0GLVt+XUmep+rRm/c/drA/xwFMjDCIiwCfq5
         p4i4YV7E41Ixp2DMbfJdsb7B8rU5yJvHIiYuv7kSV7QtpW72tUqWVHLEH6HNJ/wTd9ve
         1VTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706565360; x=1707170160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UV/iIRO0zfu5R/kLa/LTz7qDudbKFOHxBhGDjxapsKo=;
        b=ia719HHWFncOCclw1EzPKH7+Sl+HD89mOfWThbtylq+GI4lEdyFfehE2Y4dGE+j444
         3EkHT94cDXQNQ9QqrCSfXkRPfWxnC70j1sD4nxZistFrjF3kSMtq1lQYrKrnLXtvpwo4
         4b53t3vrJEuofYok8BPsPr3nP9uGkuoJmFD8fAyn0uoN2N2oQXfc7sll/cYZ0yTRqlMw
         HCk4O8PUgI5Od+hecepwAKyM4Ey2388364nCjZPNOZttPqvYvt6vuimQw2bFtIr/Qzw4
         X4n1pPUvbQzgNAeE1jDE3pw2IIhe83P9lKnJeB1lDberFmsVXCI9qTDvpA7T+zE6EnLD
         tS2g==
X-Gm-Message-State: AOJu0YwF7zSMe07eL9VDVl4oO1XUxqFNHrQfF8mY18HlfAyUPLVRCpE1
	e53A7xjCx+QuNM6rAahZuu9PzqdzYlGnP+Yx4+z3VG8Ur4i7jTmHYOBtrIfTTYf+r6AeuSHU52b
	DhgnDqnlPD/Je094Cj2Q+RRkw2MwZDJJ/LpCr
X-Google-Smtp-Source: AGHT+IELjEtx1N3ZgC2LPqFWtfYXYDiqNnPtrpXq39glkGRg2Im482C6q3xB9Js6LaNJcY1os+w4qyb3C+vPGPfqqyE=
X-Received: by 2002:a5b:251:0:b0:dc3:6b86:f41 with SMTP id g17-20020a5b0251000000b00dc36b860f41mr4521462ybp.35.1706565360082;
 Mon, 29 Jan 2024 13:56:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126104403.1040692-1-omosnace@redhat.com> <CAEjxPJ7Sya+__8z5TQ78C_crqZoHuTrnqjaCzCtz9YVR24KNtw@mail.gmail.com>
 <CAEjxPJ6Y4RazpOHabcv12HgMRHCqVe+k8v7f5tQ8fVT9f4QqnQ@mail.gmail.com>
 <CAFqZXNvbm9OHvaY5rmO8fxxHCT5T+ne1kj1XiT3yTRMiff5d2A@mail.gmail.com> <CAEjxPJ7NeopFG+mgBfxNa0bBxgrEB7DzfG_NFdLDicS++fGe1A@mail.gmail.com>
In-Reply-To: <CAEjxPJ7NeopFG+mgBfxNa0bBxgrEB7DzfG_NFdLDicS++fGe1A@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 29 Jan 2024 16:55:49 -0500
Message-ID: <CAHC9VhSG14u5UUYiU6kUDt8jGMPkHAs67F_kc5Xt+w_P_zEovw@mail.gmail.com>
Subject: Re: [PATCH] security: fix the logic in security_inode_getsecctx()
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Ondrej Mosnacek <omosnace@redhat.com>, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 2:49=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> unix_socket test is failing because type_transition rule is not being
> applied to newly created server socket, leading to a denial when the
> client tries to connect. I believe that once worked; will see if I can
> find the last working kernel.

If we had a socket type transition on new connections I think it would
have been a *long* time ago.  I don't recall us supporting that, but
it's possible I've simply forgotten.

That isn't to say I wouldn't support something like that, it could be
interesting, but we would want to make sure it applies to all
connection based sockets and not just AF_UNIX.  Although for the vast
majority of users it would probably only be useful for AF_UNIX as you
would need a valid peer label to do a meaningful transition.

I would need to chase down the code paths for AF_UNIX, but for
AF_INET/AF_INET6 I expect you would need to augment
selinux_inet_conn_request() with the security_transition_sid() call.
Possibly something like this (completely untested, likely broken,
etc.) ...

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index a6bf90ace84c..1c6a92173596 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -5524,7 +5524,10 @@ static int selinux_inet_conn_request(const struct so=
ck *s
k, struct sk_buff *skb,
       err =3D selinux_conn_sid(sksec->sid, peersid, &connsid);
       if (err)
               return err;
-       req->secid =3D connsid;
+       err =3D security_transition_sid(sksec->sid, connsid, sksec->sclass,=
 NULL,
+                                     &req->secid);
+       if (err)
+               return err;
       req->peer_secid =3D peersid;

       return selinux_netlbl_inet_conn_request(req, family);

--=20
paul-moore.com
