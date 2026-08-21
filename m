Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6013B14D9
	for <linux-security-module@vger.kernel.org>; Fri, 21 Aug 2026 15:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787324909; cv=pass; b=KvvLwB8jH84R3eFsOBSWpdELvjnflJsQHPFa+rmS9i13oXTccrwvkLBSX/VkfSd2DUaPRtP8O9dzLINrCqL32pbWH4/gHr+5Gc53otaPf4GPiK486AtbzWm7aUstJWXLkGwZpBxVAFd5ruXIIRyDDHz/9noosBa7r0240u0j0UE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787324909; c=relaxed/simple;
	bh=xsvH04/zWmLu6VaMQp0d91tlrFx34Z/3JARQ444mLbg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XgART1/AVsw10MxgHRD7rs8ei7L/o17Baj669UYA5p2viBQg5WdYbJJqouJynW2bFUjbS2f6dU/jXb211HDjC1cL1r0c5UQ0Ug34oyt/7tomVeEGT3W7TXXXg/2tjrD1JgR6GoU3tKLslreq+A/uYJQhX55nM5bch3I+8L502DM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jn3llhVh; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jn3llhVh"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cede6375caso104125ad.0
        for <linux-security-module@vger.kernel.org>; Fri, 21 Aug 2026 08:08:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787324908; cv=none;
        d=google.com; s=arc-20260327;
        b=QJMyhcVYr3ddkfwXxS7g7WarNukSXPOV1ghWDapNVl7N4x2nFGx6uJaVZ3eVcp5D1M
         SMJK2Hyg+rupxBDVExbbVR6YdRj7IaTuh+A+kqaJYyMt3XoXexMfuumiikTMKr99LQrW
         6Nc9+MgOoHFpX/UnbGPqst5daCXB0e0lAtSOODf58gOFFpiLtDhUHPSIEBhNIbWmsvUp
         F0vI2SzH3dV2ELm310fbVDtpVtpz2PpinqbKYBF05QgVlK86QW1N5N7C45QEvfMNNWAC
         hSFl9ULji2AqtAKh/tnwOIZVstDkuuXd/I8UUzYNyGAgikKLVzmkVSDw6sFxOC/QsKlu
         7Tow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8B6gWPpC8JGpYPIfuo07l/hitWijKoYP3mF4ztxgwcE=;
        fh=c5u0chAGykvRLWoVBfgnfMnGgsBr9+eWKfzIUSlWf3o=;
        b=c3kXyb4CV+9RqxFw5QR4KFztPjmQW3FOOj8/hn8Y5KPukykaiApCQAKVJxE7LTxFK6
         sE7/NqjL3BhCyLcBNvYrCP2j6SjgxXEIHBBguCksPOotcPulPQy7Nmby/hDOk9Jvs/OO
         4A4sGB73FyAx+YSnsNReOBhOAqm2RdmEau+0toOv3OlXKGbnOGTQdYbURFp6AJq1yF47
         9Ref5ku6fKYQtgEP2V1G3yiTxwWBKr0+6jHbTFXldCKf68WXGBm/vVlpUkce4Mxd6BxY
         mu2JZOxlwWOiBZ7N6ThNXzGBourYiKzDpt1oOnAaZE3AxeCumU61yv5SjwTgMnA0kZUs
         Ar+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787324908; x=1787929708; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8B6gWPpC8JGpYPIfuo07l/hitWijKoYP3mF4ztxgwcE=;
        b=jn3llhVh7gBIXYmlyYrL8WSFwdMj2FeaOqUzMm20N/uwus8nxn2nTiYrr6Spo3Ic/r
         yzdUP0CyskkQJFgBlJqkaeF1d01HU4FExNId432GoipNMKJNfFOEUYefVGSR/Arz7L2F
         /xUoyd7soP5MoKCvjKTAR/giwPjkduRJ/9eFnMdyAd/kqf12n7J3VybR8YidXE2HSCsL
         vGMS4sZfe/9FAI2ndBJGlu/2U9EJxDFF7tuqyHEB0M1EWRgDIg9OYneCHklHZeX2zyCT
         91PVWLA3W5cMBuaIKZc3siKwJJySuVjtrdDJ9VfQkJJQIqwEFDyU10WXNwEdFfg0TS0G
         PSJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787324908; x=1787929708;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8B6gWPpC8JGpYPIfuo07l/hitWijKoYP3mF4ztxgwcE=;
        b=BeY+bmnhj1K9UMAZ9+ZtYx95a8mOd+moupFQBNSFpDfwdWaVL5gGsoAfn7MJ+kZArx
         YzhfcjoctHJyfC8/JjLMfLCbyoWMcMRq3YIYUnHvBmssz38RTAOEg66GqxZNWxadOJwe
         QJGqzYYCC5Ffp7d6EMJJItxX3fJ0plUTjeuWw4gzGJiz9MbcRArEUe5AGAiSvifgNBIg
         7Dpva2oeUIvu8e7q2nitz8wbUt7QmMMMx29Mnzw1xEKI7PHbDG5xLI7PHobkgknkq7Aj
         TjXOv8+n7RXmiW4vst+WYRzr+2hT9GkMNCW0wcwKGYdFgjtYV5KXzKw3VeQBeqmECPHY
         8w5Q==
X-Forwarded-Encrypted: i=1; AHgh+RpcmMiBak0KPyM4MmJ2yYSjAWfhsISSPpviT2HubvfR80soVoPih9jbZkyMnc6TUZxSPPfDxHG62it7v1l5WsGrUgiEJe0=@vger.kernel.org
X-Gm-Message-State: AFuF++k+gZpPyc2YPLSR01BSyUm9Y3woEsF/laaxTFZy6xfY5M3Asms4
	VAL0xgoCKxTDtosLdFiMRqelQpUjvwYcdsVQ/qTVTbHoqMmdCX4nKUi34JRIh+s6B+tOubsNRSO
	AnF9VXhPoDgPhgMRgB8HDgnUheGJ2Udq5D6vqXw4X
X-Gm-Gg: AR+sD12amm9HE4nDjNYXkZSVYXZwx1vDwdL3ceZ5kSta/RIk9D4lMET1CojXLgJ26eg
	EmiS1t7grZtbfwggg0wrOcYcGPWRB02PlqCKhuzyWOmw8Q2jlve6i2Y27ndAZ8hL15306MazT6y
	4W3VyfqmhxIhnZpN0iH6AIN6oSRh1MQDqY+vVrEqZTz9WU16BRFAb6Q/GBVgcMV8bgovVlnP4LS
	WYfGk5/LJwZIhrH/dVCDEo4KIkby3tDOurI2R/f5AEPbUYTRkDrocjzA1iUsTKvCEsqbYSql2aN
	rbGtR5AMxr0DlG8tVXw99s8XTstvzTFEJUVx5jZJWOiBFphlQekDb7ll6NZKgGRDp4Wm65BEYvm
	cVawPvuOPbFygiEtTXbkIRNsYr6GC
X-Received: by 2002:a17:903:94d:b0:2d6:3c22:994e with SMTP id
 d9443c01a7336-2d650da6ed0mr6702055ad.11.1787324907361; Fri, 21 Aug 2026
 08:08:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818-selinux-pokemem-v1-0-90cd2357ee05@google.com>
 <20260818-selinux-pokemem-v1-3-90cd2357ee05@google.com> <CAEjxPJ714iCMiQRVAN6MQoOyNx998MS5Xfhbhmugcwz+gWYAuQ@mail.gmail.com>
 <CAG48ez3h2Gft4onQ8AgBmf8gHrF26YqTinajuBysNPkUKaTBoA@mail.gmail.com> <CAEjxPJ5cUDBekWe7fC1JYnw6CfT8GVa9fqrFwLPPAOqSP6jn3g@mail.gmail.com>
In-Reply-To: <CAEjxPJ5cUDBekWe7fC1JYnw6CfT8GVa9fqrFwLPPAOqSP6jn3g@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Fri, 21 Aug 2026 17:07:49 +0200
X-Gm-Features: AcwNN1UOD9xZwijeRgcDq5q20lqu4OjcbnnkogdrF0uco3EOG75h8KaWFgvrdww
Message-ID: <CAG48ez2q6rCbVVWxE55RpuTotmMrNGYfj6+56EXWhXFSrgJXQQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] selinux: require EXECMEM or PTRACE for FOLL_FORCE introspection
To: Stephen Smalley <stephen.smalley.work@gmail.com>
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

On Fri, Aug 21, 2026 at 3:52=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Thu, Aug 20, 2026 at 11:23=E2=80=AFAM Jann Horn <jannh@google.com> wro=
te:
> > On Wed, Aug 19, 2026 at 4:54=E2=80=AFPM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > > On Tue, Aug 18, 2026 at 3:51=E2=80=AFPM Jann Horn <jannh@google.com> =
wrote:
> > > >
> > > > On systems configured with PROC_MEM_FORCE_ALWAYS, ensure that a pro=
cess can
> > > > only create anonymous executable memory via /proc/self/mem if it ha=
s one
> > > > of:
> > > >
> > > >  - EXECMEM (like for other methods of creating anonymous executable=
 pages)
> > > >  - PTRACE (like when using /proc/$pid/mem of another process)
> > >
> > > Allowing it if _either_ permission is allowed is unusual in SELinux
> > > and seems prone to errors.
> > > Is there a reason to not just require PTRACE always?
> >
> > Hmm, that might work.
> >
> > My two concerns about that approach are:
> >
> > 1. This is an operation where a process acts on itself, while PTRACE
> > is normally for acting on another process. It feels to me like those
> > are different types of privilege.
> > 2. I feel like blocking this operation even for a process with EXECMEM
> > privilege increases the risk of breaking existing configurations.
> >
> > I think if we want to gate it on PTRACE, we might need to put this
> > behind a policy capability and let policy authors figure this out?
> > But I'm no expert on how new security hooks are normally added, or
> > what SELinux policies outside Android look like, so if you think it
> > would be fine to just check for PTRACE, I'd be happy to go with that.
>
> I don't think a new policy capability is necessary here. Is there any leg=
itimate
> user of this capability that wouldn't already have ptrace permission?

I do not know of one.
I was thinking that it is theoretically possible that some program out
there uses /proc/self/mem to patch its own code (similarly to how the
Linux kernel has Static Keys) or to inspect its own execute-only,
non-readable code (which I think would also require FOLL_FORCE); but
I'm not aware of any concrete cases that do that.

So I guess if nobody else has an opinion on this, I'll change this to
only check for PTRACE as you suggested.
