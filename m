Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F6122338
	for <linux-security-module@vger.kernel.org>; Thu, 10 Jul 2025 21:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752183635; cv=none; b=ryV46lUS9YxEdT456NJxX8azkE/C467HqHj1MJzs/mq99PQsB5QWyc7nnB8IxPjH97meQLwQsvSptVCzcftZ+nU3g6ohnwQzyBpC+QLSdB5fsDA6tbytRR9lqHoMhTrtI8ImsC3UG6xxi8WTgLoOusH7ftOsFYnmYRkcOpVPmow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752183635; c=relaxed/simple;
	bh=6wG3MiVJh0RcPO7dGyjbbquYVHNZCnHmFZCdF5hrjIg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q8FrAOJLB0RN27V42Ip2JdU9MC7ip8FYtJDToZuics/XRkupIqeL6bizSQScXwSFFbPdFKN2ExLYp2f7rzeCZd2FPEF9KGi7FIR5XofxdIMN4AOENegOEAlOJw2dSgqj62PwXdnp8/OcTAqJi1cMWbJ/WbPDCCD2zvAT58lansQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=VSUdY6rQ; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="VSUdY6rQ"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-714066c7bbbso16093727b3.3
        for <linux-security-module@vger.kernel.org>; Thu, 10 Jul 2025 14:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1752183633; x=1752788433; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6wG3MiVJh0RcPO7dGyjbbquYVHNZCnHmFZCdF5hrjIg=;
        b=VSUdY6rQrvB5SnmTJeTDDxuv1MqFK95JFGnvSKjfpNAQrAu9SV3ve1+dbTaNn2+/Im
         xMDQugq4NaD2p1uRKuYNYDjEGj4Sp/Sk3PAujTvvQv8dNjst/5BjrocZMQ0rf7/cXW2P
         P9yGYdNlEI7jv9027boah+y0CwtsmSnn5Be7mEPTA583IY2VCTnsjehv4VruZOMD56i6
         FK5vj/ehnLxd+aSfsPsLdC01WNHW2UVwUhXX74t8EdMug+Y8pN6c/mRgXo1X0z8BcpU9
         OTwuqBYZ32Sm9xwD8LXghM1RbJ3Yvq3Iqt3lQvV4tr8KjCK3tDB3M6Oy/tD68YZp/ikX
         +s9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752183633; x=1752788433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6wG3MiVJh0RcPO7dGyjbbquYVHNZCnHmFZCdF5hrjIg=;
        b=oHRxArEAaGT92y/Blefe0BQsq//MP8HF1hICZnOc7R3TznyDt+tFf37TCoEHDHdPI+
         kRpv58x2yr7aOfP0X6LmbX+4bnberYW4ZOv8+2zIAwjR+IEfm+kD0BgW5RDv45hkFnw1
         /O4M5fS+Ry2cqh3NIoCyO9QKy1wAljWQtR4d+p8u3t8H7O2KIAvA6O3lQ0nlHcAI+4DZ
         9lxrdJv1Qa1fUVDpiYhC67/LtEqKhJY9GH1hBzUN/ZSz+ayPwUGOF4zIbUmB0eh/+TwR
         AP68Rz1N7BmbYi9V+godtM66a/6k/jR8OwERHfY1vqQFV04qulelNgTdr/Z9m+Pi+mbk
         P/Mg==
X-Forwarded-Encrypted: i=1; AJvYcCVc6dxnQdyJ9nf/rqtdg8Z7hdUxgIhgPWXkM6m6oRyg5/fW8l49SmnSmOfuI0j3j/pG8vBlI7e1WwwADikon+VwJ38fUyM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmsToXxYA367Hesorqaz16MoN1U8iY+bTpemUYmKNWLJwcJLo8
	girksSODuaZu+IrXGqBl9XZGWmWMdJz9RSfhMywn0EwnQo0PIEZzUsopBuJ9dXv5ZCstAh6KOkQ
	8/IdKcRsKWPq9irShPuBWhnAuJBdbRUt5z8+foclt
X-Gm-Gg: ASbGncukL1OvaFXJWia5ZhPH0+5d3/8eiR9vGMApNLLDVYpTVNbbeIg0OIC2Nbk/+uQ
	tchMVvdI6CzBPFbzJ1fPljSJT0G4DF70NzQJ3ak+Ef7wCsMym0ihN7Ubt/tA54NTHFw0qnVEFj3
	GxkJoe4fU5993J/uemmdSdGUarTT6loOm40NsabK9hbjgQWXXMwmdJ+yOArNHiXUwp8QGjwJ7/c
	ImTbcoG8gYZbGqncA==
X-Google-Smtp-Source: AGHT+IEUNp7yAcXsQe/JR+irOSVx8v6wD/QnrcWD8zPh1FLoq9LoOpgHSEVTC/K3sabkCRfbQXhsH559rzftY5+dmIM=
X-Received: by 2002:a05:690c:63c6:b0:712:e516:2a30 with SMTP id
 00721157ae682-717d5e134b4mr20477787b3.28.1752183632871; Thu, 10 Jul 2025
 14:40:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708230504.3994335-1-song@kernel.org> <20250709102410.GU1880847@ZenIV>
 <CAHC9VhSS1O+Cp7UJoJnWNbv-Towia72DitOPH0zmKCa4PBttkw@mail.gmail.com>
 <1959367A-15AB-4332-B1BC-7BBCCA646636@meta.com> <20250710-roden-hosen-ba7f215706bb@brauner>
In-Reply-To: <20250710-roden-hosen-ba7f215706bb@brauner>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 10 Jul 2025 17:40:19 -0400
X-Gm-Features: Ac12FXygeQp3no1_lmAy5tCkImjlkaS0qLNeFNCTV52hKWMKCGltsNt3Gzdmr0Q
Message-ID: <CAHC9VhTinnzXSw1757_yeFdyayXkpTr6jQk8kzETtB5r=WNaxw@mail.gmail.com>
Subject: Re: [RFC] vfs: security: Parse dev_name before calling security_sb_mount
To: Song Liu <songliubraving@meta.com>
Cc: Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Song Liu <song@kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, 
	"apparmor@lists.ubuntu.com" <apparmor@lists.ubuntu.com>, 
	"selinux@vger.kernel.org" <selinux@vger.kernel.org>, 
	"tomoyo-users_en@lists.sourceforge.net" <tomoyo-users_en@lists.sourceforge.net>, 
	"tomoyo-users_ja@lists.sourceforge.net" <tomoyo-users_ja@lists.sourceforge.net>, Kernel Team <kernel-team@meta.com>, 
	"andrii@kernel.org" <andrii@kernel.org>, "eddyz87@gmail.com" <eddyz87@gmail.com>, "ast@kernel.org" <ast@kernel.org>, 
	"daniel@iogearbox.net" <daniel@iogearbox.net>, "martin.lau@linux.dev" <martin.lau@linux.dev>, 
	"jack@suse.cz" <jack@suse.cz>, "kpsingh@kernel.org" <kpsingh@kernel.org>, 
	"mattbobrowski@google.com" <mattbobrowski@google.com>, "amir73il@gmail.com" <amir73il@gmail.com>, 
	"repnop@google.com" <repnop@google.com>, "jlayton@kernel.org" <jlayton@kernel.org>, 
	"josef@toxicpanda.com" <josef@toxicpanda.com>, "mic@digikod.net" <mic@digikod.net>, 
	"gnoack@google.com" <gnoack@google.com>, "m@maowtm.org" <m@maowtm.org>, 
	"john.johansen@canonical.com" <john.johansen@canonical.com>, "john@apparmor.net" <john@apparmor.net>, 
	"stephen.smalley.work@gmail.com" <stephen.smalley.work@gmail.com>, 
	"omosnace@redhat.com" <omosnace@redhat.com>, "takedakn@nttdata.co.jp" <takedakn@nttdata.co.jp>, 
	"penguin-kernel@i-love.sakura.ne.jp" <penguin-kernel@i-love.sakura.ne.jp>, 
	"enlightened@chromium.org" <enlightened@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 10, 2025 at 7:46=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
> On Wed, Jul 09, 2025 at 05:06:36PM +0000, Song Liu wrote:

...

> I'll happily review proposals. Fwiw, I'm pretty sure that this is
> something that Mickael is interested in as well.

As a gentle reminder, please be sure to include the LSM list on these
efforts, at the absolute least I want to review the patches, and I'm
sure the other individual LSM subsystem maintainers will surely want
to take a look too.

--=20
paul-moore.com
