Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D73B324B33
	for <linux-security-module@vger.kernel.org>; Fri, 21 Aug 2026 13:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787320343; cv=pass; b=Zb1gwE+IPKRulwL/KtplHWyv95HQNNiQHY25u4LUJBLTfl5nIMqGMLvzWJPYNGtyrrWcT5lZssTzucWK9YXEQ4fwU+NK0bu4W9t+V/7rCGJGkZFkVidBf2rOH7i0joYK23YkCedQYitqGQqIM/5xn1fe+e/JiKRtGTWe1xN26qQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787320343; c=relaxed/simple;
	bh=sMCXD58Ck7XMjqxi99CPuHjkI5MeTfpATIu7xweU010=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pFRi4LS/1z9pBquhv6JHsqjrTva9NBmjXjBFBu04LSAh2Uf0C6zcYdBGUHgdie+c53SgHAg7BAOjGyqYqrgtPoSXeZ6P724u9qw0UEkaqiTp4Wef3MrEWs+gk6mC1MEEOBiuNnGqgjVSSrTAWS2jB1rC7xwO3dE3dH14MMQ1n3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AOkW+V22; arc=pass smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AOkW+V22"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7e9f69ee6f4so1246146a34.2
        for <linux-security-module@vger.kernel.org>; Fri, 21 Aug 2026 06:52:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787320340; cv=none;
        d=google.com; s=arc-20260327;
        b=adBwC7M3LBZ87V64KjwwgTjkjydobVUWSAQMqn/cvzkwi8GSK0CVa5zZ/9hyhQB1B3
         nqiFrUnER3I2J+NQWzgHAld4N9nrmhqG1VANgELmjA0Wm0Gq5XtDJF8IuMneyukECSaF
         HyZaa08u+zOmVmdo9AZzzhPwGzvTBhRz75I+75tcMgYONfdPsX1hAbE8GeEw3aeW4bAh
         ncru1aJOBPhxumGgIdo/xov/ujGcImY3R6NNhX5NdO3Mi+K/ZdBjN6UDrarqFFv1jgt5
         WiXRzNIeippieIvisHgO4v3o9wGm9Z+t6anHHpzy4j3GROWzOaZmFvdKtGsncfGaMBtK
         6mIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0MQng+9xXyTKknMt+t9Rj4wyf14y6xu9aKeDOtOOdJk=;
        fh=OsjRmjeYdmzLFRYEk2hJDdSJ/Wv8kCU4pNFxCjBQD/E=;
        b=nqYxOctRQ3Fqi9MgL4cuuSlRHS/Dl8+Q7SQ7SNb859th86RYNYiBlrcUUUOlV1JBkS
         MUzcuAFy1awEhETcunhEJ8d2H9OQMF7qUmc1ryM3bIt17Z4px3EHYvZDEqnztOQIQamN
         96GNTHE3AtMZcJc2f0dHgFQ/pGg5gPqDIIEdEYtoYiJ+a6Btk8EZnm+gFaUmiORBBUqY
         GQtyvHvQjJ13u8skt9yHnmoAHENTImsLdUMTY86e4AlpM4nUxTaygMlJ3O1E+mgUeW3F
         cpztaNAiFXPGYLY/VoMZItOIZEsr/yRfYlg1JcbZt9oyDtGiwmRMzVob+c0W/Drdtl8H
         LFSQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787320340; x=1787925140; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0MQng+9xXyTKknMt+t9Rj4wyf14y6xu9aKeDOtOOdJk=;
        b=AOkW+V22rhrAxcDrepdr3WEBsSoDX46UNW13oEtBAtR86Zl+J5D9pmddAY7Bk0995M
         QuotVn4oehPG+vCPdruMMX5U4gu8EZ+yy2gw7vaEU7vUfqAs7W4uvZAshk9+a24YGt1V
         hE0y9L7jgoUSzx6YXi9cqEVIleBrHRIctPZ70NwPdGmB36PovDhg/W1EwlBaMinmXMVv
         E7Bvs3AtK2x6BJeUad3NremEA8nwU3nHssME2Xb5WOKNMZyRHRlhluK3JZwXDkD2/oSL
         BxNctSj79dDb32MfOHET0LHHkDLRVhjufn6uuN60QOwQNIrvxdZPfzC/N7NGwXuZjD5i
         ukyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787320340; x=1787925140;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0MQng+9xXyTKknMt+t9Rj4wyf14y6xu9aKeDOtOOdJk=;
        b=QLv+jkEdLsKrC9pRM6q7XzU7055X/qgJQfNchFh3ll47CcaC8qILI/zwowwD7e5BT4
         /n+5wHKhNZA039gpoLDanjI9cXASB3d6JxSM6PkAmygXhWukExRqvnfe/e2dYGTgbyJ4
         fcPkpyHdv/YyqIK5m6FiiTCqVkR0l4XkHD0iJbAV0M+zU5g7yUvFht6VMHVKxAK5ljXj
         jCJDRTZBfJjFanynNyP4zjmWANRS0elVl7J06+FSZv/bnGHpouUhHD3J2qo5HINSRCl3
         3c++SwdeFfkfpjzM+0VhwmqnAtA39bHI6FQ/DgrD9xYGSAIkat1I9ZNcyJDhfRBs189T
         1HJw==
X-Forwarded-Encrypted: i=1; AHgh+RoJ5aGRo0sToQjVfyVIP6jXDcJhXmX2lpI6fx9PDG9wAJCsL4hhs3LJfOetRH+CpfiwaOLbmouRFgdG7cbVoV8cMU/2mAE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKaNKEEfh2I90vHfgd7b/GWv1Cm/M31kaeAS+n9A+C7sl76aLu
	nXz1B2fFHsxOk5fo/uPWYVG2f2jtnZPibT3bWRXjU2hCFye0hLM/o6NNxF4HOCRex2Qq2E4MCcZ
	1xT6OsKGLd47RlcCz55/+YNjM1tuJ0ss=
X-Gm-Gg: AR+sD13r3bCS4Kq4VXbxYrPuUOPpe5tQX4Rx8Bq2Qb5xrYi6glbhdwfkDY0lZMNc/XO
	RI9eob71hn5d5flhZBdQ4ZxcWu2x5wciWE6V8auDUx9iRF2ROcRgGNBcswvTsZXQSDkoS0Evl1b
	1L5+uVZSE4MMkwl9O8h3dW3iAWJaRmJjfGVtD1S3wdtQzbp08sX/2HBBlSS8or6Nab+Dyov9PL0
	Js/gfIbTFQIJqda+cPkzjO2fZCtR9AB1B1nquveyn6THuNtLsBy2A+PMMqky1WEkfGVEKXszfSl
	7TM//7uIiOZP171giEGdNYMKxAJJWWjZaUjI6mrg3/MI
X-Received: by 2002:a05:6820:341a:20b0:6aa:e176:bcb5 with SMTP id
 006d021491bc7-6b15925da2fmr5108790eaf.14.1787320340365; Fri, 21 Aug 2026
 06:52:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818-selinux-pokemem-v1-0-90cd2357ee05@google.com>
 <20260818-selinux-pokemem-v1-3-90cd2357ee05@google.com> <CAEjxPJ714iCMiQRVAN6MQoOyNx998MS5Xfhbhmugcwz+gWYAuQ@mail.gmail.com>
 <CAG48ez3h2Gft4onQ8AgBmf8gHrF26YqTinajuBysNPkUKaTBoA@mail.gmail.com>
In-Reply-To: <CAG48ez3h2Gft4onQ8AgBmf8gHrF26YqTinajuBysNPkUKaTBoA@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 21 Aug 2026 09:52:09 -0400
X-Gm-Features: AcwNN1XIMQRcAUBNk7fjxozSpQ8JckvqGIQ5KHe6kYNDH33rw4pKhCm-h8pgeiw
Message-ID: <CAEjxPJ5cUDBekWe7fC1JYnw6CfT8GVa9fqrFwLPPAOqSP6jn3g@mail.gmail.com>
Subject: Re: [PATCH 3/3] selinux: require EXECMEM or PTRACE for FOLL_FORCE introspection
To: Jann Horn <jannh@google.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Jeff Xu <jeffxu@google.com>, 
	=?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, Pedro Falcato <pfalcato@suse.de>, 
	David Hildenbrand <david@kernel.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2026 at 11:23=E2=80=AFAM Jann Horn <jannh@google.com> wrote=
:
>
> On Wed, Aug 19, 2026 at 4:54=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > On Tue, Aug 18, 2026 at 3:51=E2=80=AFPM Jann Horn <jannh@google.com> wr=
ote:
> > >
> > > On systems configured with PROC_MEM_FORCE_ALWAYS, ensure that a proce=
ss can
> > > only create anonymous executable memory via /proc/self/mem if it has =
one
> > > of:
> > >
> > >  - EXECMEM (like for other methods of creating anonymous executable p=
ages)
> > >  - PTRACE (like when using /proc/$pid/mem of another process)
> >
> > Allowing it if _either_ permission is allowed is unusual in SELinux
> > and seems prone to errors.
> > Is there a reason to not just require PTRACE always?
>
> Hmm, that might work.
>
> My two concerns about that approach are:
>
> 1. This is an operation where a process acts on itself, while PTRACE
> is normally for acting on another process. It feels to me like those
> are different types of privilege.
> 2. I feel like blocking this operation even for a process with EXECMEM
> privilege increases the risk of breaking existing configurations.
>
> I think if we want to gate it on PTRACE, we might need to put this
> behind a policy capability and let policy authors figure this out?
> But I'm no expert on how new security hooks are normally added, or
> what SELinux policies outside Android look like, so if you think it
> would be fine to just check for PTRACE, I'd be happy to go with that.

I don't think a new policy capability is necessary here. Is there any legit=
imate
user of this capability that wouldn't already have ptrace permission?
The other alternative is to introduce a new permission for this, but that w=
ill
deny-by-default on existing Android and allow-by-default on Fedora based
on handle-unknown until it is defined in the policy. In the case of Android=
, my
understanding was that kernel updates can always be coordinated with policy
updates so there is no need to worry about a new kernel breaking userspace
with old policies i.e. if and when Android ships a kernel that
includes these patches
they can also ship an updated policy that allows the new permission
where necessary
but I could be wrong.

> (I've caused stable regressions several times at this point and am
> trying to avoid causing more...)
