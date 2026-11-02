Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793648379;
	b=EN24kWnMkG4zflT0XyBz6Mmdi8yCIMekEcdJIOm1VaWP0d32wvZAEAmoedWXwut3Kozf
	 2bhhwi31U1VvHGvotmx+K7ObkX0srz46QCzoW/+nzZlPrHyrl01jvM/2bthp/XrqyGDCS
	 Gd0oxeuLXBqBPQ0StwfYCg5O6+aRyeR1kSrgaaePEP4gSlUn75PZkRncetL8MlrusI2Gi
	 rrEyLIpMdHdcitjmnm/3zU8SuCyLicesVOs0NMeBk2bN645arAhYtbiJysw/MayWY3eYT
	 W7CIthiX8CysmjCe6A6A7mV/SOoH/au0p+BO98APO+lqvmKz3ZdmgqHvIkjObGKNvSQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793648379;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=fILK0wI2UqUr5itU/0Cq58lsYc1ISo7g+t7NVEUk9BU=;
	b=gBkFuc5VRlpWMIWiHYXHuwgyB2lJl7SKG7867fsy6JS62gL2Fcr4KmH7sEnz0diqBy7P
	 liZO0K6hJ2mF0OeBtMSdaK/MAJCKuI80C3RJevKOpcHQ74jV/1mBGLKD9EaXw4P0DGKu/
	 0mTexldh8ojTWDhuAAXnPbY1w0prSURi5yd19xn4bCowAfjbUxWKo1fxi9FBi969nJvNb
	 UJjDhet5eQZhQ1XS4wGB3CoHvtlBkciG6/nypponoKTaWrRlQ9V6qmtTbcQhMPY6Eabei
	 quLF27vg6Fhi47dkUYujIviz10OX4AeCyTT758r7wIzOvBb851Faanjuu5tGZsXOKaQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=NhlqvCEA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.178
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAB1606A329
	for <linux-security-module@vger.kernel.org>; Mon,  2 Nov 2026 19:39:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9DAB1606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=NhlqvCEA
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8a070781f63so1370748b3a.1
        for <linux-security-module@vger.kernel.org>; Mon, 02 Nov 2026 11:39:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793648378; cv=none;
        d=google.com; s=arc-20260327;
        b=h4feym2xkznRGw+5AQTJOja7Xvhws3AnmiZ0RZj1nN5JO+erXgaIw13Xr8N71vyMRl
         7rjvMgRymTIMUBnk1UqfOfoFHQ2xpeQeua95EaDjbyXgm+6N+/8lV+xLwUNY0NPujw1z
         uXMF1EC4mGcTI9nRwSMJ7Oi2aIU6ldkoZa4t4kP/PliDIzVZHV8zGErDubS0Niv6iEav
         y1h1WSBg4g1TcgI5dq/2S/aHRON+704lFDzCMrQJmwmmkAkc+1QYMIG+4IsMmIun0AnC
         6+7BoA1Bv66PHCi7U1z2rdYolVW7lkmLG+rIwgDa5/b/t7jCWa0AteOZrv/L09K8mEbq
         ZCPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fILK0wI2UqUr5itU/0Cq58lsYc1ISo7g+t7NVEUk9BU=;
        fh=bor6S8y0mRalz1wPTyFrOxjVT94whkaJElBHaIyYNt0=;
        b=kxXv66z1UkmOUt0J7pKuLXDLnnjyDESb3W6ZWItOOgJIz5C6ps0B9JEI/keHfU4JKP
         tCwIj+0qzfVbzlQutnTIFSGmAeUrqhi8apxqSb6vboJiIa6AItjLLWbBJ7oWUnfZe79X
         2ux3a8icTyWdlHOTgc31Sg2UDckB01Wf46cnt4dqC+bNGIDc2tRfk9YggJ1B9SXjaFQs
         WjUVtmWpb7BGC74QACxMP1qc4bDZ+wX8QHQ7Q6AMmOX7W+l8iXRy50cYpJek2WWEPo/o
         5FPAgog40jSZyqptzeFoVlxy1OGeiIrd1KBsqx6043ANP13LXK4krpdvOFhJ0foqBZR0
         HuPA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1793648378; x=1794253178; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fILK0wI2UqUr5itU/0Cq58lsYc1ISo7g+t7NVEUk9BU=;
        b=NhlqvCEAqNeQh82h66VjeQRCvmLs88bUiMN8vsKnqKJ9wOlSOkwk3pTRZNEo2Wk7dK
         HZv/BWl8uEe1rlLq4Esk4h0lNwnLc7ae2Ug4sIcT0bKI7VrNR03T1LZQUc4K6ZwzXmn6
         He3DDsns3zqXONgEkB7fjVVE0uQ4EfO58HLmbhylcYi+XV4OsEafFtSN66UNdGEqLvGf
         6+P0rp5Bbft2KMHvVeggiGD6wOnDjs5EEn+ovAV85fjamgZf+13AnKK26O49HqVD+JId
         Nx6Te9tI8mE+yrOdmnPFjh4Tt7FpFJqRk8cVNQb3naMOyfjmKyriiJkGVwtVtYKbw4fR
         FC6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793648378; x=1794253178;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fILK0wI2UqUr5itU/0Cq58lsYc1ISo7g+t7NVEUk9BU=;
        b=vWwEpU3w0tuKyzGFiQArKHVzfkbOnpMXHnTxQ3GQ0xUSGFWpDS6O3pf5k/hcWFVuq6
         XKvUGNJ1u8OO/Dzt1cM8zjF2Fy0hluDFhi2HQv+A1Wzc7splmcflL+QBkeujMA7CVZ0L
         Qg+i8nInKG9fFY8Kk2FIkDaLHXHjDRAaRTqbB0inL8e7kAh06P/20SVpBpHGFDj10kWy
         N9BCOQd9a0La3UGSwW5IAyBSQ2ArwW24D3ZYAPzbsWB6/cwWPnIWOzabXqY/oLbbojQe
         mmpo/FpYvB0klSrIFPQ/BLOD9fycCPgqYU+U+MjGX35HzlW0F8t6gz0Bk/fpyBi2DhK+
         2Kaw==
X-Forwarded-Encrypted: i=1; AKwUvBxafldkWzbjDRnTr2huznPeYnblzSdZ4U5tKds+Q0yBfK1qwRKgrQzglKQWiPFQ74JUXt01cP4tlRrYecHTyvDGy5LKf3c=@vger.kernel.org
X-Gm-Message-State: APuU4Z+aGNGVc2mdna7zxfeFpwSlVmlEiJV+0dI70UfjvZ5lLCD85/j7
	JCXOKwm29grEM78/UICjYUtEX1w77IKbtc85FKXX6qTJVf6DFHF0QSb/KFFas7yY7yptOSlQiks
	pg3Wz2HQ78PqQjsZk3y8WVq6Ufr3t256kPGj6rgu+
X-Gm-Gg: AYBFou2D/LT88CeTUfwiD/AYaGx/9oYV8TQkKmmLnKfrymhwvOBJSRKMwOa2mou2Pvf
	l0XQKdY9d3ziWtxNlOqvN6O3pGh+UJBM2aePl8l6NZQXyRkuTDKhTZQgNszbIkJcXtraxVBslvs
	9atZEtnt4bUGf0S5ywyx0knlEIYJ61O5I99pWHB87UUL4E0Kd1uxa4IkIdHC4QcntHVJKmH8oTy
	w7Yd5Em3GXI91yLUQZi8kHnqkN2PGqJrJbd5LTo1DHzCark5/yy4M8wDkeJVbIoY1ylNtCIuAKa
	MpBKUNibEVoDO/pJcVWFAIQIJXT7EcqUvF0Q+rUyoW8eq0c+Rj7g/48xKJN1zqH5x2/IS2q34cb
	NLdD56JLA7aCCC5vysSf4x5AJteZOpZ7Lb3E0/cnnipziQ7WeohK4DU9zrA19mwf3/y+F
X-Received: by 2002:a05:6a00:3c89:b0:8a0:3307:c46c with SMTP id
 d2e1a72fcca58-8a9bea6b19cmr8445171b3a.36.1793648377853; Mon, 02 Nov 2026
 11:39:37 -0800 (PST)
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102130540.252894-1-omosnacek@gmail.com> <CAEjxPJ4hxdvV-r8chmF3RAi9RJX=-4AqntG01=fWUhh4-xP+ew@mail.gmail.com>
In-Reply-To: <CAEjxPJ4hxdvV-r8chmF3RAi9RJX=-4AqntG01=fWUhh4-xP+ew@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 2 Nov 2026 14:39:25 -0500
X-Gm-Features: AclHuK_N7t88qS7YSGZ1TxDpP4hXHc3j5T0g0RysETh1DoLdW5UuZOpzEfeNB98
Message-ID: <CAHC9VhRU1WZrsnw4q+vA_pKGGPs6kydHZsLbycWzbN27ygLXdg@mail.gmail.com>
Subject: Re: [RFC PATCH] af_unix: introduce MSG_CMSG_SEALED
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>, 
	Eric Dumazet <edumazet@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Jakub Kicinski <kuba@kernel.org>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Simon Horman <horms@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	netdev@vger.kernel.org, selinux@vger.kernel.org, 
	linux-security-module@vger.kernel.org, io-uring@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026 at 10:14=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Mon, Nov 2, 2026 at 8:05=E2=80=AFAM Ondrej Mosn=C3=A1=C4=8Dek <omosnac=
ek@gmail.com> wrote:
> >
> > Currently, when a process receives a file through AF_UNIX's SCM_RIGHTS
> > mechanism, the security_file_receive() LSM hook is calledto allow LSMs
> > like SELinux to validate the receiver's access to the received file
> > (similarly to a process inheriting file descriptors through execve(2)).
> >
> > However, there are cases (such as dbus daemon/dbus-broker) where the
> > receiver doesn't intend to access the received file and merely wants to
> > forward it to a third process. In this case the forwarding process woul=
d
> > need to have the appropriate r/w access to the file in order to receive
> > it, even though it will never actually acess it. That leads to the
> > security policy having to grant the forwarder access to a potentially
> > wide range of files (in case of dbus-broker basically all files), which
> > is not ideal.
> >
> > This patch adds a new CMSG flag MSG_CMSG_SEALED that, when passed to
> > recvmsg(2), wraps any received files into an opaque anonymous inode wit=
h
> > the name "[envelope]", skipping the security_file_receive() LSM check.
> > The returned "[envelope]" file descriptor can't be used in any
> > meaningful way other than being passed forward via sendmsg(2) with the
> > MSG_CMSG_SEALED flag. In that case the original file is unwrapped and
> > sent via SCM_RIGHTS to the receiver. The receiver can then either
> > receive the file as normal (subject to the LSM check) or again "sealed"
> > in the "[envelope]" anon inode for further forwarding.
> >
> > Note that sending the "[envelope]" file is only allowed with the
> > MSG_CMSG_SEALED flag set, to make the unsealing explicit and avoid
> > unexpected behavior. Attempting to send it without this flag will fail
> > with an error. This also avoids recursive nesting of "[envelope]" files=
,
> > which would only make this feature harder to audit for possible issues.
> >
> > This patch also adds a simple read-only sockopt for UNIX sockets that
> > allows userspace to determine if this feature is present (passing
> > unknown CMSG flags unfortunately doesn't lead to an error currently).
> > The minimal code to do so can look like this:
> >
> >     #ifndef SO_RIGHTS_SEALED_SUPPORTED
> >     #define SO_RIGHTS_SEALED_SUPPORTED 88
> >     #endif
> >
> >     #include <sys/socket.h>
> >     #include <unistd.h>
> >     #include <stdbool.h>
> >
> >     bool MSG_CMSG_SEALED_supported(void)
> >     {
> >         int sock, ret;
> >         socklen_t optlen =3D 0;
> >
> >         sock =3D socket(AF_UNIX, SOCK_STREAM, 0);
> >         if (sock < 0) {
> >             /* handle error */
> >             /* ... */
> >         }
> >
> >         ret =3D getsockopt(sock, SOL_SOCKET, SO_RIGHTS_SEALED_SUPPORTED=
,
> >                          NULL, &optlen);
> >         close(sock);
> >
> >         return ret =3D=3D 0;
> >     }
> >
> > Related: https://github.com/fedora-selinux/selinux-policy/issues/3286
> > Related: https://github.com/fedora-selinux/selinux-policy/issues/3287
> > Signed-off-by: Ondrej Mosn=C3=A1=C4=8Dek <omosnacek@gmail.com>
> > ---
>
> > diff --git a/net/core/scm.c b/net/core/scm.c
> > index ae38f3c1165c..08822b2a1f22 100644
> > --- a/net/core/scm.c
> > +++ b/net/core/scm.c
> > @@ -114,10 +127,29 @@ static int scm_fp_copy(struct cmsghdr *cmsg, stru=
ct scm_fp_list **fplp)
> >
> >                 if (fd < 0 || !(file =3D fget_raw(fd)))
> >                         return -EBADF;
> > -               /* don't allow io_uring files */
> > -               if (io_is_uring_fops(file)) {
> > -                       fput(file);
> > -                       return -EINVAL;
> > +
> > +               if (sealed) {
> > +                       /* Only allow sealed files */
> > +                       if (file->f_op !=3D &envelope_ops)
> > +                               return -EINVAL;
>
> This leaks a file reference.
>
> > +
> > +                       file =3D (struct file *)file->private_data;
>
> This fails to take a reference to the underlying file but will later get =
fput().
>
> > +
> > +                       /*
> > +                        * No need to check for io_uring files here as =
the
> > +                        * underlying file had already successfully pas=
sed the
> > +                        * check when it was first sent.
> > +                        */
> > +               } else {
> > +                       /* Don't allow sealed files */
> > +                       if (file->f_op =3D=3D &envelope_ops)
> > +                               return -EINVAL;
>
> This also leaks a file reference.
>
> > @@ -365,18 +398,37 @@ static int scm_max_fds(struct msghdr *msg)
> >  }
> >
> >  int scm_recv_one_fd(struct file *f, int __user *ufd, unsigned int flag=
s,
> > -                   bool notrunc)
> > +                   bool notrunc, bool sealed)
> >  {
> > +       struct file *f_received;
> >         int error;
> >
> >         if (!ufd)
> >                 return -EFAULT;
> >
> > -       error =3D security_file_receive(f);
> > -       if (error)
> > -               return notrunc ? put_user(error, ufd) : error;
>
> Design point: I would suggest adding and using a new LSM hook that
> allows security modules (like SELinux) to still be able to check a
> (new) permission that governs whether a process can pass along these
> sealed fds so that we do not entirely lose control over their use.

I've only given this a quick look, but I'm also not excited about the
LSM hook being conditional on the "sealed" flag.  I'd prefer for the
security_file_receive() hook to catch all the files, but take an
additional bool argument indicating the sealed state; this would allow
individual LSMs to decide how best to handle this.

  security_file_receive(struct file *file, bool sealed)

--=20
paul-moore.com
