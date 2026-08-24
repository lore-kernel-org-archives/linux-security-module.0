Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA01A4334D8
	for <linux-security-module@vger.kernel.org>; Mon, 24 Aug 2026 17:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787591204; cv=pass; b=lK0lBwoaeOZ3rX3o8XC/wvK2RSrWoJlTdYRB2siV3JwXYRkpKF/OufgKLeohs4+CO3w2gpU5LDwt4ym0kvI+oQ/LnnOCU38E+Ik6wJeZwoVue3BAnJha0ILgsTasLpzEwnLsAI8QCv1hzU5QtfSYG+/z7SIlf8r0DtCmGgGwACg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787591204; c=relaxed/simple;
	bh=RetglhChGs54xh+G4sIllqLQaZbHa84fR8ti4Eb52Y8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AKb6+N4RRda/+xVrCC3HnEB7TNwPcaItDVWz4lSNbXZYdZT/5LDzIqt8Ccg2vLwOBWvp7/RrwBGBwopqbGtkw82hftBKlQYUhBb6dZEkQ6hos/uhKb9FN0JRsNQkM2A5nPZ31lGPMvxaD7Sk4goCtcMrMQIgxge0VE4pkPKigIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vo7CX6da; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vo7CX6da"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2d3b445a84fso2495ad.1
        for <linux-security-module@vger.kernel.org>; Mon, 24 Aug 2026 10:06:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787591202; cv=none;
        d=google.com; s=arc-20260327;
        b=Sd0KQtdKW5OzA5OdvJq/c00XgqNqh3I7oilwDdsp1qRKRVbgKw5Hoz/JQngGDI5Idb
         Kl80O5zYp/QOD2aT1Y7F+IaldWogvoWg0Btrqi0+4yHsofebYyrfHxLB+R0il2el9R/D
         W00FjuOm8A3U9dKdXVNJRsmIhmkXWkaOnubLjK9GaqzKaDb7VG/Z/9aE9n0leLU1JL+Y
         36yyJkZpJ+zdbkDeUaF70oRMoeJG8VKCYK6SAQe82Cnga7REJXr6x9mBGW6D3O4g7oVH
         YZm1hMPUxrMi5T4Ik9wcEBb3UPRR7Iiebqty9sCacYR0pYfFAR4M8qONnEXJLNh6P2uD
         5hWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wBrui9oca87xmLJo5FCru/sywwEnBCWCZyUpBYfq9bA=;
        fh=kpxmF2EwRm7GV6ycfygogkkJBu0bXN8RnxdQ9mQNZTs=;
        b=l3jQTKBK8JQ9eJaOApIrHeWuGHU3VGa6yosNIdHEGR5fVFxD/K037ZdjUjLhuXevje
         4qUcMcuCXCTau7zWJcGAt1jm+17dreq6JHSHrarrQCk1RgTLK0RlAdxUL7w9DafZEqTi
         lTDI6ppfEahWvlEMAWzFprWjPIzx7vp+KFZst3zEbnCwoYB0HjLHKDJDdk5fJyvMSnlJ
         qZCTasM57sVyJfO5U+Tws2NKRe0N3XDGySuoNg8zQui4GWW05BBFK9syj4MhX+mbWtRm
         8iJKndpQYBIWWqYQEMy3z5STjnrxgF8o/oFpQ8aEDKNERH77exCipqYeWD6ORakm3MHU
         2uBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787591202; x=1788196002; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wBrui9oca87xmLJo5FCru/sywwEnBCWCZyUpBYfq9bA=;
        b=vo7CX6dacDq3q2MBn4zKHTMEovNhzBuyfUC2ySAhPRikC6MgthlA3DcavDh0Du4RKb
         vNhH+ry6oUFWzx5kDriVlQlsFp2awFoahbHruVN4841x5DU670ckNINOGk7vv2AsPCeh
         alykxwXEN/RfBuR1EjJ6cz+3lYDIyIE9QC4z6QOM2AGpwXiHZt40a3Z3m4/E1sDcRDW0
         15M55ELxms/ZwscMIDMmVi6vHmZfTtzu8VsHF1QzFn8lzT+6XO+FTdxpmK+6Lb2MuFEp
         RqqBhFwJ42yPIJgd023xLdyyb0vD/PeLT90/WT+PajJWfDK9UmFvIP6UHkzqWPhMinlB
         0sGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787591202; x=1788196002;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wBrui9oca87xmLJo5FCru/sywwEnBCWCZyUpBYfq9bA=;
        b=ncrtpv67qoIYqIiLHkymziA+rmPhyChGHHeP08QmD9BIJMaDXHj9vIlBFGHPcxhIDd
         2TxnZJEU9YfWH+blNBR2RLwf/jy0pJwpZlfqaTg6D8oD/G6YzM5j72h9TXuTXNxbTMHd
         GZC3IMMXWLKjmW0OPQOx56TC5DB0Vu+Gg0eKTBjcGnl4x8t0jx5fZH8MInAgXpjLNajC
         FPOFbo1sanaOWLHqV89ycMoEPgxBYMKSa8hZHcp00wUQCuCJki/fvTe6z6suk2VeWqcT
         D9zX1IR0Bs5mi5gc+/KiSaSkx7l6Y5yhMeGgcBmh7DyNuyzErtaXA/Z/vv0/6sxp710L
         Yblw==
X-Forwarded-Encrypted: i=1; AHgh+Rp0/e5246cNrLWKLzB1TBSDXWunWcFRNG0S1Rb1xAsDrKiMY2JvDidrIZMSHTKDoPmb89nwy20j60C/0+ltM6TRz0hTaRc=@vger.kernel.org
X-Gm-Message-State: AFuF++kHgci9bsaIIAbN3mAUB4hFNoXlDToZR9xvVjbyLC5hLBoIK52y
	od9o4fqrIgiLQNEFJtfNtVRRUiejsYuTBQ9aoWf5XxvkTucBqbwzZydFGitACLY4f+4NMQ135cN
	/ffkkpJ6bvLusCI4x1/s4qNklxmRKYX4HMYghKShA
X-Gm-Gg: AR+sD13w5ZKFMomLpW1Mndw3PEO9lsZeMJ0dHIFzeqC/R/VN/uQ8Vce8sbqkM5qYqyS
	nU5UEBWDUokinFxzxmKWO5ClYgbr1fLmM3i0RNmsxUKwtvjw5Hm4IoyAAes2FEgsd50jozr7ir0
	iQ4aLbwKWVcDPoLmEpLHtjI/jU4IUkY5zm/xPb41NATL50BpCZ4XanvGY8ZvdRKxniXXPoNiqLU
	vXcmRnNgAGLp2doIsb5AL/dySGOF+hNnkNvJ52L0ThhPVBpv7M4/R1bLSv8ZVnD2CI7BtkCx/9k
	ZWA0UYf5MXyHwTZOhuNvA1Kv0BXP3l19Ngkz1V7NCoMYjoEBHhUsJN9lPgNFPgObKS3XSkpsvHC
	nYrZaEz01/b+uPINnhI4THb4LxREUr7Y=
X-Received: by 2002:a17:902:ced1:b0:2d0:1aaf:daec with SMTP id
 d9443c01a7336-2d673b9afe4mr10236935ad.9.1787591201205; Mon, 24 Aug 2026
 10:06:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818-selinux-pokemem-v1-0-90cd2357ee05@google.com>
 <20260818-selinux-pokemem-v1-2-90cd2357ee05@google.com> <741a833d-6889-4ee6-9322-d6a3a8b95893@kernel.org>
 <CAG48ez2Ngo3=VtyykXY6ynVzGwA8px-p4zV3V6U=YfgV-Hy4BA@mail.gmail.com>
 <dd8c34a9-0e09-453b-88e1-0a5511816627@kernel.org> <CAG48ez2bZEV+3ww2x9XV_5vRPZ_3jU_zg6+h=BDKQ94Xrd3Tqg@mail.gmail.com>
 <aoibvf6CY99IXynk@gremlin>
In-Reply-To: <aoibvf6CY99IXynk@gremlin>
From: Jann Horn <jannh@google.com>
Date: Mon, 24 Aug 2026 19:06:04 +0200
X-Gm-Features: AcwNN1XN1HjALO-7sEAr3yIwV5QVslvlMZpManf5842ZQgDGGQ6V_1u_W3SFNwE
Message-ID: <CAG48ez0CX-PT5Yk5gYJuB6wPe26j0gHHXQqYoNtTA=iHe_5Wdw@mail.gmail.com>
Subject: Re: [PATCH 2/3] proc: query LSMs for introspective mem access (if PROC_MEM_FORCE_ALWAYS)
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Jeff Xu <jeffxu@google.com>, 
	=?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Pedro Falcato <pfalcato@suse.de>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 21, 2026 at 8:52=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kernel.o=
rg> wrote:
> OK so the whole thing is:
>
> mem_open()
>   -> __mem_open()
>     -> proc_mem_open()
>       -> mm_access()
>         -> may_access_mm()
>
> And:
>
> static bool may_access_mm(struct mm_struct *mm, struct task_struct *task,=
 unsigned int mode)
> {
>         if (mm =3D=3D current->mm)
>                 return true;
>         ...
> }
>
> And what this flag is carrying is 'hey the reason we allowed the _open_ i=
s
> because it's looking at its own address space'.

Yes.

> I did wonder if what you're protecting against is even a process updating
> execmem _it_ owns, no fd shared anywhere, as something LSM might want to
> prevent even so?

Sorry, can you rephrase that? My goal with this series is to let LSMs
block a process that tries to modify its own non-writable executable
memory using /proc/self/mem; I'm not sure if that answers your
question.

For context: In this series, I'm using "execmem" to refer to the
SELinux permission PROCESS__EXECMEM, which essentially controls
whether a process is allowed to create writable+executable mappings
that can contain anonymous pages. Additionally, it blocks creating
executable mappings of S_PRIVATE inodes. There are other SELinux
permissions for things like making a VMA containing anonymous pages
executable (FILE__EXECMOD and others) or mapping files as executable
(FILE__EXECUTE). FILE__EXECUTE is granular, it can be granted based on
the security labels of the process and the file that is mapped.

> The sharing a /proc/mem fd seems like that's a pretty dumb thing to do in
> general :) but I guess you have to protect against that.

Yeah, it's a kinda weird thing to do...
