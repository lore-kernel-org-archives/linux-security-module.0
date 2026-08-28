Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004653E1723
	for <linux-security-module@vger.kernel.org>; Fri, 28 Aug 2026 21:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787951070; cv=pass; b=fZi5jhy0SZ4GzQJHozCH95PUoPeWmDKKMTgWIiRdfo+ExxVs0sKuSM6fOp28NL9jMLVy9MAlo2tgiHcRwh+2tdRUQIa0rAvzh4qkF5VMHW+C2H0WZR/TGAZleIlVYVnjMGwwmtEwtogByg5mzKsECzuazQhf/xaGk2ZIntudLJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787951070; c=relaxed/simple;
	bh=f3w1hYLRyxFmXw4h6OezomSo5E54Q0cAFAcgqbErBXQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QQ2g+pORFoZhSqylCoGl9iFXOWR3mbelAwt059iiGehjlRU2VS414Kz7UrGi8ot5q5JzCxmVYrL1EeIcVb9CK7PCbLFau8bessOABW+0Mlh0t/b1id35G6YOuvzmhh0kxl9t9iAWom/kvpUjZl4eRYPuRsuYhmpnwMrJAxJoyKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=BLnbnlGH; arc=pass smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="BLnbnlGH"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-851cbd64814so654041b3a.1
        for <linux-security-module@vger.kernel.org>; Fri, 28 Aug 2026 14:04:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787951067; cv=none;
        d=google.com; s=arc-20260327;
        b=gOySovRA4GYo2nuRIuynxC7RVj7BQkLb28EyzeVHWY/3ELbGcATJekhfLunAS4UmYC
         3lCW7vEvVLbaFvUfu8yyiFv2FXtq4VmJnMrxjNvuR7w3XIaH9PeY6Vaa9T+JaeVTGXAB
         6BRoTfQgGTLgpoAxAKzulYVxX+qtuULiWkcXZ5xAXn71B4EfwE8kdX6/81g+hLAuwLeD
         l5cp1S/J717SvpWyoZXrjP/6Mc1gKPen3xmsXWKbGnb5+HNrTALJ6hFjwQTt8DFMQUas
         zOkEcGybJGEj42GaoenQhQiE7I21X8NZi0dBcu6UM2JjnqWmOgYD0OvxiFlEBdE5NzTS
         FUbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6rKm+GtqXHGkU+e3cRid3cEbHk6M59ahcc5GavJOWZg=;
        fh=TH9z7p8gOeXFsyXOXkhmZIH3VvXSGp6Wk5Y2u8sLDYw=;
        b=JfWEU8ntghkNAC4doC0ClfXko9fRMTlCWowF3T++nYPnO06OPdjdgFmYlm0VrAJJph
         Vul0I5Po5Qu3HqEzZy7PzKxbIabtP+poYIo+lK8MhqSiboP3J+l9oNpUFJ8xhJR9drff
         fYWxl5kFBzVXNTwOROJqnC2ZFUvG8SeGxXe9iUKGTvgQ4UjTcVIXWdAFj0XWk30SMBXB
         05a2cI75L00CaZAIAg1xMKx3O4gO05iC4BbepM9rNl09MqxjLPq122SQF7gD0C+DJOrX
         olY0kyRSuKOqKEMJ3Nr8YAl1GxDq+zNoG1EbE5RFQExBNXvPpLwgbYB+Kt73T8Y0+dhr
         j0cA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1787951067; x=1788555867; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6rKm+GtqXHGkU+e3cRid3cEbHk6M59ahcc5GavJOWZg=;
        b=BLnbnlGHFaymfa5q3WzMV5GGnEsKuBmv159wxJZHyf0Uolb+tCykyVH/h9Zu2Z29Mk
         CS701HZVFMlmcNMe6v1BHi08hC6HjJBeWXMV/0zr7r5JU+yHDOn6+f4Ci3gQmwGHSiRx
         ekxz9OAyuYde38s8R5gkawMX+9EJbhCqY5Q7piiofVBPhUiMZxzR9z+ZWFjaH8wL3Q/G
         aXHVrzZQANuSTV+G4fPrPXEFa1woijb1NIrpNmvQdyZAU0chv6DAMI7Ec+AzKUCpdaG7
         wWlaN/y5+L0LBYrlSSaJYIWj9JDjU0zgIk7yqQthGa1TVwtewlsnwmpdEIEtM1BQl/Pc
         eGDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787951067; x=1788555867;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6rKm+GtqXHGkU+e3cRid3cEbHk6M59ahcc5GavJOWZg=;
        b=dp/VJTAWGjdU8Q+mUUCQ9g4PSwgwjbgLQXcyB5Y4QPoegKRlxKICjpRyTx+Q/9zdG3
         j63AKw+/hpm4cVb1VodLgno6Vk1EoxXk6cZ4hg0mYN1z361/FCEPSVOqV21XvM3vBmPf
         iqol0qBgXdq5tN8zF0TDGF47KV9EkjqvCghdIpsYlOagkHTVJ3jNGCNQB7F6ZETM8N9g
         cPFCREw+hROCkt6RSegfemkcmbqVSa6RZUj38VHGJamBejDnW/VZcTT6L5Pl/5h+qYlY
         ZZYsTlCTfF9uqkOiq9g/YChkqbNS3S8YNTF71PsHPuzMt9L7ai0ef0TCwMRpkeY3U7gR
         Huew==
X-Forwarded-Encrypted: i=1; AHgh+Rr+ghxwZy+SCpkXl9jTmTEoV/JeOKBlsg7p4BFUqpGOLQyscHZGIZAtFi8fE4lsy6SRlG8/olEtBUphViIZvFkDvWWbLmk=@vger.kernel.org
X-Gm-Message-State: AFuF++lYZ2TVFgzGO1Hc7BAz2kVzwr7ovQoaOnOXiXJKAJUUXblngi4F
	52VI5trMn9BWKHk7ICFU77aihoOJh4LlmVu79fYkMHUhi1z1WfhKtcwLOovWaSNUtiLqSoRrJSN
	Gou8NpyJJxL3/+BsJkCmSwwJcOzq9+7CgQ1G8PPav
X-Gm-Gg: AR+sD10atRaOqRQxhfAJdT/jH+VvrxPxs7QoMcuo+MuTr0QK5UzPEufoRrG3S/zhm4c
	7BJkrbyHyr7fbK7kN++emMVaUjXXTMwZzDssaDFrnNlErqPUMNeQhyseNod2TWgOmrX0jBzJZ0W
	BndiD10846jcOHBjqsOP149LwDpDs64nrzHIfzxJfqq1srfMSI8cdD7mO7cjJIasYb7tjD+W7BI
	h/TsKg0mncPbipwsPMinjtnCpoa4Ra+KOkxN/gegY1jXzEzNBKnd6XAGfATL5katjFBtKEAYZ1O
	yRL5y+yuPSo+ZJxiKaGA9EjHJFmJJA24e4hZPml9SFIm/5MJbPQ/f8g=
X-Received: by 2002:a05:6a00:2d82:b0:857:73e2:9106 with SMTP id
 d2e1a72fcca58-85773e29373mr3141018b3a.22.1787951066990; Fri, 28 Aug 2026
 14:04:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825-selinux-pokemem-v2-2-b46bc64916d8@google.com>
 <82929c994076d95f99560ecc67f6cfce@paul-moore.com> <CAG48ez1rd3cFhmGn7mWkaVvGqYg+cDiGUhuhH6r51dUm-QBXUA@mail.gmail.com>
In-Reply-To: <CAG48ez1rd3cFhmGn7mWkaVvGqYg+cDiGUhuhH6r51dUm-QBXUA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 28 Aug 2026 17:04:13 -0400
X-Gm-Features: AcwNN1XqU7CwGOxUd2wqJF7qUgFOnskAPT9XF2uIm2MO9atgOnmbTyVZNzUagTE
Message-ID: <CAHC9VhTmRsi7mLJM0Vak=aTj+NBO6piH-9YwVX5Kwh6yGPNsHg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] proc: query LSMs for introspective mem access (if PROC_MEM_FORCE_ALWAYS)
To: Jann Horn <jannh@google.com>
Cc: James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Jeff Xu <jeffxu@google.com>, 
	=?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, Pedro Falcato <pfalcato@suse.de>, 
	David Hildenbrand <david@kernel.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2026 at 9:04=E2=80=AFAM Jann Horn <jannh@google.com> wrote:
> On Fri, Aug 28, 2026 at 3:10=E2=80=AFAM Paul Moore <paul@paul-moore.com> =
wrote:
> > On Aug 25, 2026 Jann Horn <jannh@google.com> wrote:
> > > If the system is running with PROC_MEM_FORCE_ALWAYS, LSMs currently h=
ave no
> > > good opportunity to block a process from overwriting read-only code i=
n its
> > > own address space through FOLL_FORCE writes via /proc/self/mem.
> > > The security_ptrace_access_check() LSM hook is bypassed when a proces=
s
> > > opens /proc/self/mem because this is considered "introspection".
> > >
> > > This causes a hole in SELinux EXECMEM enforcement, which tries to ens=
ure
> > > that a process cannot create executable anonymous pages.
> > >
> > > PROC_MEM_FORCE_PTRACE prevents that and ensures that such FOLL_FORCE
> > > accesses are only possible when the LSM allows ptrace() attachment; b=
ut it
> > > is unclear how quickly PROC_MEM_FORCE_PTRACE can be deployed in
> > > environments running lots of third-party code, such as Android.
> > >
> > > So, introduce a new LSM hook that can forbid FOLL_FORCE specifically =
for
> > > such "introspective" accesses.
> > >
> > > Signed-off-by: Jann Horn <jannh@google.com>
> > > Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> > > Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> > > ---
> > >  fs/proc/base.c                |  9 +++++++++
> > >  include/linux/lsm_hook_defs.h |  1 +
> > >  include/linux/security.h      |  6 ++++++
> > >  security/security.c           | 20 ++++++++++++++++++++
> > >  4 files changed, 36 insertions(+)
> > >
> > > diff --git a/fs/proc/base.c b/fs/proc/base.c
> > > index bec6197329dc..dc6fdcb47b79 100644
> > > --- a/fs/proc/base.c
> > > +++ b/fs/proc/base.c
> > > @@ -851,6 +851,11 @@ static int __mem_open(struct inode *inode, struc=
t file *file, unsigned int mode)
> > >  /* private_data for proc_mem_operations */
> > >  struct mem_private {
> > >       struct mm_struct *mm;
> > > +     /*
> > > +      * Was the ptrace access check on open bypassed because the ope=
ner used
> > > +      * the same MM (introspection)?
> > > +      */
> > > +     bool opened_by_owner;
> > >  };
> > >
> > >  static int mem_open(struct inode *inode, struct file *file)
> > > @@ -864,12 +869,14 @@ static int mem_open(struct inode *inode, struct=
 file *file)
> > >       priv->mm =3D proc_mem_open(inode, PTRACE_MODE_ATTACH);
> > >       if (IS_ERR_OR_NULL(priv->mm))
> > >               return priv->mm ? PTR_ERR(priv->mm) : -ESRCH;
> > > +     priv->opened_by_owner =3D priv->mm =3D=3D current->mm;
> > >       file->private_data =3D no_free_ptr(priv);
> > >       return 0;
> > >  }
> > >
> > >  static bool proc_mem_foll_force(struct file *file, struct mm_struct =
*mm)
> > >  {
> > > +     struct mem_private *priv =3D file->private_data;
> > >       struct task_struct *task;
> > >       bool ptrace_active =3D false;
> > >
> > > @@ -886,6 +893,8 @@ static bool proc_mem_foll_force(struct file *file=
, struct mm_struct *mm)
> > >               }
> > >               return ptrace_active;
> > >       default:
> > > +             if (priv->opened_by_owner)
> > > +                     return security_mem_foll_force_opened_by_owner(=
file->f_cred) =3D=3D 0;
> > >               return true;
> > >       }
> > >  }
> >
> > First things first, we've got to shorten that hook name :)  What do you
> > think of security_proc_mem_foll_force()?
>
> If we move the "opened_by_owner" part into a flag then I guess that
> works... will do.
>
> > Beyond that, we really try to avoid making LSM hook calls conditional. =
 It
> > can limit what an LSM can enforce, it tends to be a bit more fragile, a=
nd
> > it adds some unnecessary work in the case where CONFIG_SECURITY is
> > disabled.  I would suggest passing 'opened_by_owner' flag as a second
> > parameter to the LSM hook and calling the hook unconditionally in the
> > default switch case as a replacement for the 'return true;' statement. =
 I
> > understand it may seem a bit odd, but we try to make the LSM interface =
as
> > generic as possible with respect to different models and this is one wa=
y
>
> I guess I can do that, but then the question becomes, what other modes
> of using the LSM hook that don't currently exist in the kernel should
> I be supporting with this? I can make this a parameter, but any LSM
> policy that actually uses the parameter in a different way would
> probably be buggy/inconsistent, unless other new LSM hooks are added.

Possibly.  People do all sorts of things with the LSM hooks, not all
of them relate to access control.

> If your intent is to make the hook work for any /proc/$pid/mem access,
> including when the caller is ptrace-attached, then I guess I have to
> move around the security hook call in proc_mem_foll_force() a little
> bit. I guess I'll do that in v3, though I really don't like trying to
> come up with a reasonable in-kernel API contract for a scenario that
> currently has zero users.

As I said, I don't really have a specific model/intent in mind other
than avoiding a conditional LSM hook call.

> > we do that.  It also ensures we don't have to process the 'opened_by_ow=
ner'
> > check in that case where the LSM is disabled.
>
> (I don't think that's an improvement - we have to do the comparison
> either way, but in the current version, we then use it to
> conditionally branch to a security hook, while the v3 patch will
> instead unconditionally call into the security hook.)

If we move the opened_by_owner check into the LSMs, in the
!CONFIG_SECURITY case we avoid the check entirely.  We try to do that
when we can to minimize impact of the LSM when it is disabled at build
time.

> > > +static inline int security_mem_foll_force_opened_by_owner(const stru=
ct cred *subject)
> > > +{
> > > +     return 0;
> > > +}
> >
> > With proc_mem_foll_force() currently returning true/1 in this case,
> > shouldn't the LSM hook return true/1 when disabled?
>
> No, I have proc_mem_foll_force() doing:
> "return security_mem_foll_force_opened_by_owner(file->f_cred) =3D=3D 0;"

Ah, forgive me, my mind stopped reading once it hit the closing
parenthesis!  That's not a common pattern for calling LSM hooks so my
brain wasn't expecting that :)

--=20
paul-moore.com
