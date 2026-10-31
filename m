Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793438255;
	b=SA2TDfvDFoWWoQZ7ztg/oKQf5Ux0vIslcoCKUDZyyVK61DMtfqbsgZQ5eovKHXRLS+MS
	 oG/XRUTXXKWn7FzhAbczOBbG+iKsjlYyWItq8Aws4HHYeMGFL+4+yrly7pces0B1Exf3k
	 8kPpDihgovW8RyT/oTFWApjcEDd2okn12XA7s0RvFnZDA0QlXnCbWNZFydXrsUYvfirld
	 2BU/sUDyWJtE5CPBt6vlUT7+N8A+CQCLxlUN3Pwc/eWPvF+ukqAKCe7pHZC8dQQR1cLBL
	 +l5qKmJIKbZOwqGNilGiZVUzmAbdhHxGXIFhvTv6GcoFx8C7fVM/mqzW/Nh5E0azK2A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793438255;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=wUwfLoqq8ouqS6uWpEPiPUNvLcV3QYpFgnEMX9XSBwI=;
	b=cgwa4hFmLeI93M72ZSvoMOl+CoIutXWLm/ca5GLWH38585GRVFNkvqmmo0/y03UNC1I/
	 kGdIO+W/TtJ9iQVRcA/1Lyo+IpTylAipVgurXmAP0WG6na44bw9WO84xeELjXCjNfE2v+
	 XDrFRXjyM+mqffdYw2IRwhR9GBAr7GCdCcBSf8BtZmTFw9jmm+YT0AsmiFQUFDy7uHgCc
	 8mElewwGBHzel1jcCzPwp5+kO2PNPlBMA940cviucn3l4ny1SheNNasP+QGh0rDf8pivv
	 RetaTRBXmaFQ2ZHSpNEPE9/kVanFTlkn3sG2cTzQ+z5SfaX9W66Jb4BgmQo+g4gZR6Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dHv1JGaS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.176
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F612606A31D
	for <linux-security-module@vger.kernel.org>; Sat, 31 Oct 2026 09:17:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F612606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dHv1JGaS
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-8b10ac6ab7bso13024177b3.1
        for <linux-security-module@vger.kernel.org>; Sat, 31 Oct 2026 02:17:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793438253; cv=none;
        d=google.com; s=arc-20260327;
        b=icBbojbTzjzAcnaBDMUScJmyrvMNzVnAwLum414tsFIWQ0aTa6y2T9ghJHJikg4S2p
         1U3B2CL/vZbXgS8qgA+SLJcntgDHgSdd9daiULGNotqtB9QYwGhO03a3AVybVpOVkzun
         rxneueRQcL0xrTYqn8mz75R6GPUZ5X2Ti6RatpP6Whwou4UtWseVNy2EzaBV9QFTvaXa
         l7eEW4QfbyeNQE13YYKGaSyMFUPJ/eVXM1nLSXsvoVJ+UdVuPsx7GzQuZuFDQd9n92vi
         GEn8Izn1MB/2M6xdi0R12hQJ3hK0z0DWpgF5JOzY9VemiXd8++aeKNUr8kie6ysGZita
         wceA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wUwfLoqq8ouqS6uWpEPiPUNvLcV3QYpFgnEMX9XSBwI=;
        fh=ARQOYz3tLaedQGrsmUbypFWIDzAqBo5Ej6sohTqG1Uk=;
        b=ALVoUaOFdPm5zH4bgPKKCkq4IAVK+ZgbozyPgi9fvpm/OaK+IuuahKtM2CieJ6xzA4
         1mgP9zZ9NqwB16xRMcyUpGLX8lPhaKZzvThOWRKL+qf4WQFQpBAhC3ZbFy3E4bi9x0zx
         oRs4l8pH0G7scW4W+xxEqn0QmYRnZLqEaWr+rSlF3o2xwEZd/dCRbA9LGwOFR/EiEW+E
         mLk6GljXbihONvXnhFZ+eKo4tiBCE/qmsqsOUTZrxhj7Ccgf+HqcB8RLnDmzVh6hvgQ7
         hNdBM1g3HSPpqhNCf3cPZOm0SxjzLOlM6rxK85uIg0P7jjEkjHbxx9sV6n6mif1KSaIC
         dL6A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793438253; x=1794043053; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wUwfLoqq8ouqS6uWpEPiPUNvLcV3QYpFgnEMX9XSBwI=;
        b=dHv1JGaSJQ0lIjgjdsJQ/T+jwvdktCHG6pzfrydTGu5Xw9fFXwYB7t2cR/CqgbFJP/
         46QpD/MoK1pCb5xlIOo/2w70imGPVCOXyTBtplXUfP6Wcdcb5HH/4+FFqahkonTd2Vtj
         TqyGVSTUh9YLVxsuljIHR9a/CfIHXmtsD4XpKbnegtLvAK3kuOAwYg/jArqITOz/KvQs
         DX1W/NIj5Wmbs9CZ4fHweR1xtOqx63eWR/2XJt99+yjEZ2KVQMRizLOFtDwdtkCfeAKX
         YZMfsSAXJ420MlzbNBB9Z8xpHlTaTu/3VDtNcICnEHMCD8hotHC04Ri/faE8HQnZjkeI
         ffog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793438253; x=1794043053;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wUwfLoqq8ouqS6uWpEPiPUNvLcV3QYpFgnEMX9XSBwI=;
        b=K59oaNPj5tuELG1Ey3hF2rPn3uQym0OthsEFFjUSkvtk7glv6Plj1r4iTd9l+f4fFj
         KiENx+O0l4KEznhPkhNX95vwiTflYvJyMPdECUZIW0jy5COV3ghoqDZZzs0KtkWwOpZ1
         n0L0dt16tTGZVpxarS50dOAUFoc2VWbT1eqn68+W5MqitOU8Dx8HRlWP3fvNS7mvJ6+H
         2eAIC2ZFe6gfbC+iHFPRpNAPjY6oNsVmprP4Y7fuMhVe5GIoEal2WJVkCoCl79s0g2Yx
         N14gwcWT7ULO8+iH9+2qeOJ7/gAN40yznPF8uKmy/pnp2uy5/WoSXRHcvDTaRIJBQbAH
         zaCQ==
X-Forwarded-Encrypted: i=1; AKwUvByy+ajWDCxc06BnPKFKjFemPBLVXinYDuCA0y0tg8190e/Te9i41Na68XHnf8khG0jR8kjl5glBWXdR8ygQh9dVMeTcA7c=@vger.kernel.org
X-Gm-Message-State: AFq9FYLtnBg4qrOOJjB9+LK1i6aQJJhBCm0KmqOzj4PcjlVo2ARLvhHz
	gBAbO0NXHu52ClcOLVtez0cTylaed9Yhi/Vc52Q43ekSzWwu4qoaGQhylK0KtUfg1buvXAkKSWn
	wA3l5BxuBAkupIUbmNe0MlWyKyXJuWEo=
X-Gm-Gg: AYBFou2zVfSJAtSm23e5aFiIQYBRHmEXlc/I7/m+lOCV3QcKqjWY4IqPCL41o4l7Qu1
	WErwVict+D8Rp6iTKb9+0DptHDmCYYRqU2+k6uzcz7s/jM+blAj6pFRXXUc2L1KloRps1Gf2gq+
	bdOUJS9mv/J+ZPatfxJC5jOmXdVIG6aMF5CGiFusfEAuEVct7meWqg6bN3Dawke87eqkl0M3JYN
	YOyOR5zAvjaaIrEdeeCbbrqv2GZS3F/ZPE1zxp1xIlCRqrhVmqVWQ9HxYk1YDEXM2F1v/X+g6Js
	4cP4w3V8NU6mmdNTcFtKBBhA1ARob7/hHzHQ/86AoY4hlbodR7PVQ/+uY1p2TPtHaaMvKNy6c5x
	Op+bkDmrKDlhRcxibJ0uRussrS1aM+Ys3CfdGo3I=
X-Received: by 2002:a05:690c:a213:10b0:8b0:b1dd:c096 with SMTP id
 00721157ae682-8b2b6766de7mr18897487b3.45.1793438253362; Sat, 31 Oct 2026
 02:17:33 -0700 (PDT)
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pm-keys-update-type-removal-20261029-v7-e79d113bcff91e140d04@gmail.com>
 <auOqlAt45H-tHL1m@kernel.org>
In-Reply-To: <auOqlAt45H-tHL1m@kernel.org>
From: Cen Zhang <zzzccc427@gmail.com>
Date: Sat, 31 Oct 2026 17:17:22 +0800
X-Gm-Features: AclHuK9IbevS4ctSbg7rvkeuu6J_gRz-ZgCQTTiC4oQDoaBTux9vs9KH2tGOkyY
Message-ID: <CAFRLqsUy5LcD6CFnqCfjhG=SL_9T=n0LvMMBZnsJXHVxmnLheQ@mail.gmail.com>
Subject: Re: [PATCH v2] keys: Protect the update method check against type removal
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: dhowells@redhat.com, paul@paul-moore.com, jmorris@namei.org, 
	serge@hallyn.com, keyrings@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	baijiaju1990@gmail.com, jjzuming@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jarkko,

Jarkko Sakkinen <jarkko@kernel.org> =E4=BA=8E2026=E5=B9=B410=E6=9C=8830=E6=
=97=A5=E5=91=A8=E4=BA=94 04:20=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, Oct 30, 2026 at 12:07:08AM +0800, Cen Zhang wrote:
> > key_update() reads key->type->update, ->def_datalen and ->preparse
> > before it takes key->sem. A reference on the key does not pin the
> > module that provides its type, so KEYCTL_UPDATE can race with the
> > unloading of that module, for example dns_resolver:
> >
> >   KEYCTL_UPDATE task                  Module unload and key GC
> >   ------------------                  ------------------------
> >   keyctl_update_key()
> >     key_update()
> >       key_permission()
> >       load key->type
> >                                       exit_dns_resolver()
> >                                         unregister_key_type()
> >                                           GC: down_write(&key->sem)
> >                                           GC: retype to key_type_dead
> >                                           GC: up_write(&key->sem)
> >                                         unregister_key_type() returns
> >                                       free_module()
> >       read saved type's update member
> >
> > The final access reads freed module memory. With the updating task
> > held after the key->type load, it faults:
> >
> >   BUG: unable to handle page fault for address: fffffbfff804107f
> >   #PF: supervisor read access in kernel mode
> >   RIP: 0010:key_update+0x12d/0x550
> >   Call Trace:
> >    keyctl_update_key+0x6b/0x110
> >    __do_sys_keyctl+0x21d/0x4f0
> >
> > This is the same problem that commit 925c84e3cc21 ("keys: Protect the
> > read method check against type removal") fixed for KEYCTL_READ.
> >
> > For dns_resolver, which has no update method, key_update() returns at
> > the check, so doing the check with key->sem held would be enough. A
> > key type that is built as a module and has an update method, like
> > encrypted or trusted, gets past the check. If its module is unloaded
> > after the check and before key_update() takes key->sem, the GC has
> > already moved the key to key_type_dead, and key_update() calls the
> > update method of key_type_dead, which is NULL. So key->sem has to stay
> > held from the check until the update is done.
> >
> > Take key->sem before the first access to key->type and hold it until
> > the preparsed payload has been freed. Once a key exists, only the GC
> > changes key->type, and it does so with key->sem held for writing.
> >
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
> > ---
> > Changes in v2:
> > - Refine the commit message.
> > - Remove the code comment in key_update().
> > - Drop the Assisted-by tag.
> >
> > Link to v1: https://lore.kernel.org/r/pm-keys-update-type-removal-20261=
029-v6-3d92b2f9693854230a02@gmail.com
> >
> >  security/keys/key.c | 11 ++++++-----
> >  1 file changed, 6 insertions(+), 5 deletions(-)
> >
> > diff --git a/security/keys/key.c b/security/keys/key.c
> > index e88548f1a704..994a34a80c29 100644
> > --- a/security/keys/key.c
> > +++ b/security/keys/key.c
> > @@ -1101,9 +1101,12 @@ int key_update(key_ref_t key_ref, const void *pa=
yload, size_t plen)
> >       if (ret < 0)
> >               return ret;
> >
> > +     down_write(&key->sem);
> > +
> >       /* attempt to update it if supported */
> > +     ret =3D -EOPNOTSUPP;
> >       if (!key->type->update)
> > -             return -EOPNOTSUPP;
> > +             goto out;
> >
> >       memset(&prep, 0, sizeof(prep));
> >       prep.data =3D payload;
> > @@ -1116,8 +1119,6 @@ int key_update(key_ref_t key_ref, const void *pay=
load, size_t plen)
> >                       goto error;
> >       }
> >
> > -     down_write(&key->sem);
> > -
> >       ret =3D key->type->update(key, &prep);
> >       if (ret =3D=3D 0) {
> >               /* Updating a negative key positively instantiates it */
> > @@ -1125,11 +1126,11 @@ int key_update(key_ref_t key_ref, const void *p=
ayload, size_t plen)
> >               notify_key(key, NOTIFY_KEY_UPDATED, 0);
> >       }
> >
> > -     up_write(&key->sem);
> > -
> >  error:
> >       if (key->type->preparse)
> >               key->type->free_preparse(&prep);
>
> Hmm.. a nitpick but here should be empty line, or at is least common
> to have that before the next label.
>
> > +out:
> > +     up_write(&key->sem);
>
> And also these labels don't have coherency in naming. Not claiming
> there is overall but it would be good to start improving the
> situation.
>
> So I think this would add more clarity:
>
> out_free_preparse:
>         if (key->type->preparse)
>                 key->type->free_preparse(&prep);
>
> out:
>         up_write(&key->sem);
>         return ret;
> }
> EXPORT_SYMBOL(key_update);
>
> And is more aligned with our defacto conventions.
>

Thanks. I'll refine them in v3.

Best regards,
Cen Zhang
