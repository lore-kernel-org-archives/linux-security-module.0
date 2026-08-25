Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7867B33ADB9
	for <linux-security-module@vger.kernel.org>; Tue, 25 Aug 2026 19:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787686263; cv=pass; b=LMyfHjdPHIt/sBv/qDpx/wFOiE95CdJ2QzdnBBUImNZNXCa9zDbTEcVi28aj0f3JlXHV9CaphW4z+BpCnvZpD36ORnFofzYlAXJAeVZN1WU2Qf4TwQmJT7QSBMFSg3nLTqRJjQxVGF0oGr/vz4avQydLED2gv2nXltXu21XBTsk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787686263; c=relaxed/simple;
	bh=dNgSdype1mNwitZBXug95FkyN38/VTRy2nwLEQed+5U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E2Cm5C+TAoEtqdEmZOHORsvjyb5fW1ngjz4XpVCXVgfo8h1ajSZvp0mU94x24VJ+N5LO9Z1/CX6h4X02d9/8mWdevnZphPngfu/vXUQJ48SP0ojr6rgir4wE1dpIUdP6BMv28QeNkm/LHZ1TMSvO8jT3vDbWfZ2dVmXSrVYAMME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JlJWNiwJ; arc=pass smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JlJWNiwJ"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-45171f2f608so254739fac.1
        for <linux-security-module@vger.kernel.org>; Tue, 25 Aug 2026 12:31:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787686261; cv=none;
        d=google.com; s=arc-20260327;
        b=C8QPu99amLZvBt+qC1bUnHiDbzkW5PfAPs4cWblD2tjdg5ytnw/qjDd7+VDz5UUiAo
         P4LXoWVlLCxscZgXryszJzWju1BT9IjsexML8dbrRHmimqjtkLbSjcRCwF6ni2tqqnTB
         PfM/0JEUrybxSc1yjXtpSrsC2zKhFJSKQfSou0Cdx0VQivOc12ulTfO/qq9BAFEyB9S/
         m3eIjb20KdfegQmyo/Pg48Z7CnPVMICkHRx/4nR1MRcVcqtyur36cCjU6XsL6Ydvmpmb
         R6qUV3XKkiAp/9COfqr2punaEOcsh70UPdRiA7GZ1EgY6YjTpjf3xeuxqC01hZSfwn7h
         EsfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dNgSdype1mNwitZBXug95FkyN38/VTRy2nwLEQed+5U=;
        fh=SHknThEiWvB7hYKM0kg6ZA3v39UIpsvBlOX6iFo//gc=;
        b=ZrAC/8jfiWSciVTzsbTaHMVWfVkHM4vxuQAsXkxJBe1GsQfbQWt/CeeBnO88PqrYym
         MwAm776qda14+jyNhkN3XOjUnyvLOA9w+F4YVYW4UlilqhtXYUyBwu30XGxR6CUG2ko2
         bar9mP9XvwT4Cq+9nKWjiB5TByGMkIrcBJT5LDz65kYZlN7WYJqFsz9/g7/2pmDmC1ET
         BJmTVQ9mWyQqKyuB32whYdHB575EzeWZmhYcZws8fs9wAZDsnkgrDKP3bJN3ORTf+8O+
         WPFA7uk5DeTjo/MstXNeEaGW0G3AEjyQrxOhTidjaUs9w8bD2rBO0my/zi63Oe2x2591
         i+Cg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787686261; x=1788291061; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dNgSdype1mNwitZBXug95FkyN38/VTRy2nwLEQed+5U=;
        b=JlJWNiwJGmpgyOEEilZgSritspdSWgKvEFEr1+tlWxGqv6bEGpsH27bcJ8FE9c3TYV
         gf5VeM5PbL8ez76NaCY5Fc2aYLjBTkS7rLfSVsFIZ0Odz/WT4aNILtXw5LXHqFZzcVk/
         CCDl7vfjAMnstulRBv2P0nBlv6socQxo1WpXTP52d/10YlZGNKGbt5gK9VFyROn7qxgZ
         Vdl4hEgmH9VuU66iMeq/Bq3TuOtKVlDQY5Mk2aeseGtKrMzsBBDJhokpe32jqg+W688c
         88KyrgJvdzRUG8d7Ra0e89jWN80mE+twx76kFYoZItZ9NEVEvEoQ4w0N6LTBQR2srX2L
         QAXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787686261; x=1788291061;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dNgSdype1mNwitZBXug95FkyN38/VTRy2nwLEQed+5U=;
        b=GG8UG+rw6FatoGN5VkZf+BGjUH/5xJyUg5PqkyqMOkP3cfuERH7L3lfXXenXT1zrs1
         teQUNEntFGx/JiQ91L24n5dA5Yn2+mRaeRLp3ddzfwK7yA7A920nmb0fqs+FW/InCwM0
         tqndBnJfh9XTSy17RSmVBiL81ewkDmRpXM6KB9XzjDFFg51aIygBPb7mPtkWp1Dcy+uI
         kCdbHShikRElRHqEEdPi/UAQCWbReKJv3Iem1n2Ev39szHpa2/JknzcmQ7q0n9U4uYFE
         YpLZBppAYsGxGQxhXiHKehfCvoTTDegsS3NLStc2syo+bzb4hkiSS7vRPMk5YNNRbJIf
         1RAA==
X-Forwarded-Encrypted: i=1; AHgh+RqYCf8uTKY70M90FJ4xUyYYcTlm6MGQfAv+DyOLEZYIMP2l/ee7Uty/28pXpNCnsuZ+au+POyL5687sTxI4DUgNtNqXMHo=@vger.kernel.org
X-Gm-Message-State: AFuF++l63Fa+UlouSARhdKZKKGH/H+Gzj8rkMpjaDITyRdix/P5faC4j
	Aoly3Duly9EmLSjrmwdd0rpFxZ16/f8gla4n7kg105HEqqr2TjpVqyV1HWl/eoOFA6fUs4qXZpZ
	/sQ4lJd6MZpW+iSpTtkhT3lBW5Oc5VNE=
X-Gm-Gg: AR+sD111gN9gVWcuh3YoHxJHm3hwoRlq4cCVzajehvWY2Iq+6IKMgGBx8rh65QRqOer
	TEYOyk9L97Y/p+iNJlDl5INlrBjVKClOEjajawnAfuiN1ieZJ7oRK95MGX0CPrC2kCMmCXo1+1x
	NUTRESnAUuYXjp3gLAAj3utwzMJaTYJdfDAMFMMMQQzeBgLB1yCbkMpbOnDDlqgpkJnasoD6ofM
	vQqbD909bW9edo5f6Wam+ek56t0K5uazAr9rHOVpP1nowFIvm4ZbUwtU5yNN1S4alCN/5470BNY
	HkcqsJD8LFbErxmYQr8oU34cypqFeTQT4rAeHCGq+x5TH/Fin268Hq4=
X-Received: by 2002:a05:6870:6110:b0:455:9a0a:f40f with SMTP id
 586e51a60fabf-4659af5add6mr1857019fac.12.1787686261101; Tue, 25 Aug 2026
 12:31:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825-selinux-pokemem-v2-0-b46bc64916d8@google.com> <20260825-selinux-pokemem-v2-3-b46bc64916d8@google.com>
In-Reply-To: <20260825-selinux-pokemem-v2-3-b46bc64916d8@google.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 25 Aug 2026 15:30:49 -0400
X-Gm-Features: AcwNN1W7w3jv19S12dsWPPPWvBnTdscjqtDJ6w6TlqCes7086WzzU9lKHcWHgo0
Message-ID: <CAEjxPJ7ecY4msx_tGxW1bO9ywDpB0wRv3GtQyu2SnsGV9May_g@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] selinux: require PROCESS__PTRACE for FOLL_FORCE introspection
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

On Tue, Aug 25, 2026 at 2:39=E2=80=AFPM Jann Horn <jannh@google.com> wrote:
>
> On systems configured with PROC_MEM_FORCE_ALWAYS, ensure that a process c=
an
> only create anonymous executable memory via /proc/self/mem if it has
> PROCESS__PTRACE (like when using /proc/$pid/mem of another process).
>
> This closes a hole in code integrity enforcement that Project Zero has us=
ed
> in a remote Android exploit chain:
> It was possible to use a memory corruption bug in a service without
> EXECMEM/EXECMOD/PTRACE permission to overwrite executable code via
> /proc/self/mem, which made it possible to load and run shellcode containi=
ng
> a kernel exploit.
>
> Signed-off-by: Jann Horn <jannh@google.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
