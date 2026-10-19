Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815B55AB8F9
	for <linux-security-module@vger.kernel.org>; Mon, 19 Oct 2026 14:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792421426; cv=pass; b=olAZXT9dSub58IqjWBxu6krHfgaUALj1HnUU+nl7L4GcA4hwLM4KQd8dl6MBEpAD2/g96DhiJtI4UZnhDWds0KsS5B1JROsqf/kNF+cCCIG4FZ6cx1q4zS2E4jxtO0/8X2WatmNV7KuhuHvWtf/WFWWnAIKjZ76BUTf5VPVh9fI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792421426; c=relaxed/simple;
	bh=QZTYD4VC4MMxzG/Hk6cxHyh9FCv1097oPKUOL7W0TEs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NONs54/MOgueMmX8ezuYJIwHyrHN+amkZ5vHujz2fwS9Cf8eke5blTwXkpx6900cxGQpHo944ObOrbtDS9F9CN5SOj7WS6Tmvht7bx0MqFeUVchLK+YPudXL7fcfgfHOEWG3gNKFD54qYnxySbRVn+WOTcTbMPbRmtd5TnLiowo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nPxoN8ly; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nPxoN8ly"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-6798c43a3d6so1433074d50.1
        for <linux-security-module@vger.kernel.org>; Mon, 19 Oct 2026 07:50:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792421424; cv=none;
        d=google.com; s=arc-20260327;
        b=DMoTctYmQl76JaiNYU791BaXSvSQO1jQ/Vx9Ts1YLN2DRpkezbW441HnWaAmZ/tx+7
         XznguLpdnOnpwDt1D+wI15j4NFqYuCX/fc6fwWmHQqAyLuGrmIIcT9VCNMHgAWDwjHAk
         Mo1B7/K3f9l5jrVmiSmNsb43taQ1uIwbzfrYhdiDpxJp1Rj8+f9CrGgUF5oUVi2QotY8
         YjF9jpi3HhIvyWd22K6SanWKgFYtvgHqcEVcEoRUk8+wNnhjULqksN4x8HCvlmsQHtgr
         M41m26h9Hg4Vn2zUG1pvRdRJIfRIZsDE9uus7fJeDOMLdVZTlAmE6HX+8qhOKzzu9uyN
         5Oow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xyvF9c4MMy0Ucg8kS0Y0D2SUx9HcZ2jjX9N76ZwliVc=;
        fh=lmVX0jcU+5mpxW/15EWpXJbFY4Wwhg1vLvhaOmrunQA=;
        b=alOA8r+3HGNKUdWIJafdHTC65KvQkZ9OE00+63LdFaknRq9oYUUilPvvfgWKU48SzL
         gGHC4RJmgSpXBg2QHCKqZ0GvMKwvhsTlElJ6Ggozz8UFpZ44kV/jmUQtdU0yOCy3N9Vx
         DTzvGCo9JVUL/oFjbjFZLbBAwe2GJHrAojwNMGdhAehyNZ1gq1549vA65VV3gywlYDiz
         NK2DuVMqBldh28fqYoWFAlPGq8jUO8l0sAdbo3r+JgOc/3BMLCTjWs3NMwBi4ACbx5Na
         8U7MsVI7AI9JQ348k18ZZwXUzNucA0unaucoU4HHhKKUnjYeA1tmPw6JucTGj3JtNR58
         37Fw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792421424; x=1793026224; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xyvF9c4MMy0Ucg8kS0Y0D2SUx9HcZ2jjX9N76ZwliVc=;
        b=nPxoN8ly71+SbIFZQ1DiVEk0dHa2JdxzpEzRHmJ2wkEt16QHxHwRZbpto49UXGsjD3
         GnbkSdPj4UVStl+N5C8zidNjkE0fXzFsOq620Oypw2QZ8J2qG/bug2kZFaDILRHbQPZZ
         mYA677ZtdAvYuonfmt5SkmUkJPvN/jF7zvrwrC8JU1URKzjwncOc/zmKCGQyhT7r93P8
         fHP1xp7CbMKcC1xpF3+kKmXzSkK4CrhgxHyTU6IbiGuJvko7GdTJis3iEhZZbc5ZpUZt
         Ew50HxCPU4vbYrDwarEwzebXeTgchh8IMYMpb8h/xPGJwzGyaeGV4V0I+LDeVSWkVcOF
         pCIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792421424; x=1793026224;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xyvF9c4MMy0Ucg8kS0Y0D2SUx9HcZ2jjX9N76ZwliVc=;
        b=Jem3We1ZV5lRhmKieERquI9D+e/jlzL9/B9AqnIlURUivid96tHkaZQbRAakK+n5h4
         TsgZgGoNDP/IHY3YBjibvOk9Pa0PcDp2ICWlaapd2zY7gDcQG81Cs44O2xm125DEQ54x
         YpIvOCxxgem2Wn2x/6vvYdaabiSetxGBmuV1RM38x9TggnfL2VsL00GsQJrYxi7sSIAn
         j615i8Aasj0uFTTnUzMnGm2kc5KT8bg/yiGDjQIuYD3ZqhX+/3erSr9LaZrlofBv2BXy
         VOeE/vwOrp1gQgTJ4d3B2aM2hIhTjCvwjUkdvQxXGICxQrxAzyBO3y2EJiQMe5UqL5+D
         9XZQ==
X-Forwarded-Encrypted: i=1; AKwUvBxmtLUb35xql1LEebZ2zME11BuPBIOXIGdIzSTOt72syEY8LmQ+qEocxaE5lT812GNW4roOYELox64CYNhM06M3spQ7sGY=@vger.kernel.org
X-Gm-Message-State: AFq9FYL0gRmtdBGI56Opy30GJm0YaUTJSqyIVNiVw0QVKG3qLCKwNc4A
	Si3J38Zu2ZOX4COWPyUPjRWbUwnou3KpK04E9h/pfy1Geg5+g5Up0Pf2bRP4z6CwtqH+mtQrNYv
	Fn3HtnnVR8006fEVK6rhpTPxaGqqRgmk=
X-Gm-Gg: AYBFou3mLsc9DM6+tCVYnlUelL/iUQ29/UFKS+Hm8xab8Gye+Xy+pxFFolKdFbWIvl1
	231SwnxPDnTUnmZnSwMWHXQdvUwD8HWn9kaMOSq0T4ZqMi9lwuKSaLHuRcTD91P3AtpJsJSaymo
	uB/Jt2clzBc8Le0AAbNLf/A54iQuWBKWgQ8Tqfomi+9SUnfxR1wSftFfx0CxVFL0HkbRVEJeXYp
	NfisnZV6lCeyYCbZOnle01pZva4RfhIWOT/mPlzK+yeLi9f2dEvVM9g5CqTa/wvxzzwMME0v4v0
	EYnAx3/fBt91/gBDSn7Ucko4UWosJI4UskXUkrYBNZ/efQ60Xsu8beMH6hAapyCJDIWPoSgM0Gc
	DL7lMfGzXoA==
X-Received: by 2002:a05:690e:43d3:b0:678:1568:ff75 with SMTP id
 956f58d0204a3-679ca7f98e9mr1259899d50.38.1792421424256; Mon, 19 Oct 2026
 07:50:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pm-key-management-objects-candidate-0010-v5-c6b7ca2813c6913e500a@gmail.com>
 <atQoKlA_JfF6JBmc@kernel.org> <atQr3xpmgJc5q_t4@kernel.org>
In-Reply-To: <atQr3xpmgJc5q_t4@kernel.org>
From: Cen Zhang <zzzccc427@gmail.com>
Date: Mon, 19 Oct 2026 22:50:12 +0800
X-Gm-Features: AclHuK_pJL6LZskaGhDN8QLw6mBkzOOtJBA2_QScnPzf5Ye1bpWgLIS-0K6qj_Y
Message-ID: <CAFRLqsX70QUKo5mmp-m3BdSr3q1YaqDw98VLQM=Eo72tditWmw@mail.gmail.com>
Subject: Re: [PATCH] keys: Protect the read method check against type removal
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: dhowells@redhat.com, paul@paul-moore.com, jmorris@namei.org, 
	serge@hallyn.com, keyrings@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	baijiaju1990@gmail.com, jjzuming@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jarkko,

Jarkko Sakkinen <jarkko@kernel.org> =E4=BA=8E2026=E5=B9=B410=E6=9C=8818=E6=
=97=A5=E5=91=A8=E6=97=A5 10:16=E5=86=99=E9=81=93=EF=BC=9A

>
> On Sun, Oct 18, 2026 at 05:00:14AM +0300, Jarkko Sakkinen wrote:
> > On Sat, Oct 17, 2026 at 03:30:56PM +0800, Cen Zhang wrote:
> > > The key type must remain alive while its read method is checked.
> > > keyctl_read_key() holds a reference to the key, but checks
> > > key->type->read without holding key->sem. The reference keeps the key
> > > alive, but does not pin the module containing its type.
> > >
> > > With AF_RXRPC built as a module, a positive RxRPC key can pass
> > > key_read_state() and the Read permission or possession checks while
> > > another task unloads the module. Unload is possible once the module
> > > refcount reaches zero, e.g. when no RxRPC socket remains open. The
> > > reader can be delayed between loading key->type and reading its read
> > > member, allowing this order:
> > >
> > >   KEYCTL_READ task                  Module unload and key GC
> > >   lookup_user_key()
> > >   key_read_state()
> > >   key_permission() / is_key_possessed()
> > >   load key->type
> > >                                     af_rxrpc_exit()
> > >                                     unregister_key_type()
> > >                                     key_gc_keytype() schedules the GC
> > >                                       pass and waits for it
> > >                                     GC takes key->sem for writing
> > >                                     GC retypes key to key_type_dead
> > >                                     GC releases key->sem
> > >                                     unregister_key_type() returns
> > >                                     free_module() frees type storage
> > >   read saved type's read member
> > >
> > > The last access reads freed module storage and can fault in
> > > keyctl_read_key(). The later read invocation is already protected by
> > > key->sem and key_validate() in __keyctl_read_key(), but neither cover=
s
> > > this earlier check.
> > >
> > > Take key->sem for reading around the read-method check. The garbage
> > > collector retypes the key under a write hold on key->sem, so it must
> > > wait for the check to finish; key_gc_keytype() in turn waits for that
> > > GC pass before unregister_key_type() returns, so the module text cann=
ot
> > > be freed until the check has completed. If retyping happens first, th=
e
> > > check sees key_type_dead, which has no read method. Release the
> > > semaphore before returning -EOPNOTSUPP or proceeding to buffer
> > > allocation, preserving the early unsupported-operation result and
> > > keeping user copies outside the semaphore.
> > >
> > > Oops report as below:
> > >
> > >     BUG: unable to handle page fault for address: fffffbfff8048bc5
> > >     #PF: supervisor read access in kernel mode
> > >     #PF: error_code(0x0000) - not-present page
> > >     RIP: 0010:keyctl_read_key+0x1aa/0x600
> > >     Call Trace:
> > >      __do_sys_keyctl+0x2a7/0x4f0
> > >
> > > Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
> > > Assisted-by: LLM
> >
> > Would be better to finish off the work unfinished and fix the patches
> > under circulation instead of spamming new ones while at it. I.e. fix
> > them first and don't starvate us with unfinished patches.
> >
> > If this was merge ready this would be acceptable, but in this even the
> > tags above are in the wrong order. This is not a lottery machine where
> > you dump whatever LLM gives you without your attention, so please don't
> > do that.
> >
> > >
> > > ---
> > > diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
> > > index 5a5efa26ed0e..756368422b7c 100644
> > > --- a/security/keys/keyctl.c
> > > +++ b/security/keys/keyctl.c
> > > @@ -863,10 +863,13 @@ long keyctl_read_key(key_serial_t keyid, char _=
_user *buffer, size_t buflen)
> > >
> > >     /* the key is probably readable - now try to read it */
> > >  can_read_key:
> > > -   if (!key->type->read) {
> > > -           ret =3D -EOPNOTSUPP;
> > > +   down_read(&key->sem);
> > > +   ret =3D -EOPNOTSUPP;
> > > +   if (key->type->read)
> > > +           ret =3D 0;
> > > +   up_read(&key->sem);
> > > +   if (ret)
> > >             goto key_put_out;
> > > -   }
> > >
> > >     if (!buffer || !buflen) {
> > >             /* Get the key length from the read method */
> >
> > Why did you chose this over embedding the check inside __keyctl_read_ke=
y()?
> >
> > I'm assuming you have considered both options.
>
> I.e. to reformalize: how does that change guarantee key->type->read
> validity for the __keyctl_read_key() that follow?
>
> My first idea would be put the check inside __keyctl_read_key()
> while key->sem is taken.
>
> Please explain because I'm not fully following with that change.
> I could get something wrong but it is against the assumed most
> common sense fix imaginable.
>
> Br, Jarkko

Sadly, I focused too narrowly on protecting the early dereference
and overlooked the approach you suggested. It does make more
sense.

I've removed the outer check in v2 and moved it into __keyctl_read_key(),
after key_validate() succeeds and while key->sem remains held. The check
and call now run under the same read hold on key->sem, so GC cannot
replace key->type between them.

I've also corrected the trailer order.

Best regards,
Cen Zhang
